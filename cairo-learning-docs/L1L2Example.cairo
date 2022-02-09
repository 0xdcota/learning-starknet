# Pracctice L1<>L2 communication
# Author: daigaro.eth.
# December 12, 2021.
# Deployed on goerli.voyager.online
# address -> 0x02bd2662e4bfa343f258225a82df9acadc8d7d4d614161943aac4ac25f2b6169
%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn
from starkware.starknet.common.messages import send_message_to_l1

const MESSAGE_WITHDRAW = 0

# Storage variables.

@storage_var
func L1_CONTRACT_ADDRESS() -> (address : felt):
end

@storage_var
func balance(user : felt) -> (res : felt):
end

# Getter functions.

@view
func get_balance{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(user : felt) -> (balance : felt):
    let (res) = balance.read(user=user)
    return (res)
end

@view
func get_L1_CONTRACT_ADDRESS{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}() -> (address : felt):
    let (res) = L1_CONTRACT_ADDRESS.read()
    return (res)
end

# ABI functions.
@external
func set_L1_contract{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(address : felt):
    L1_CONTRACT_ADDRESS.write(address)
    return ()
end

@external
func increase_balance{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(user : felt, amount : felt):
    let (res) = balance.read(user=user)
    balance.write(user, res + amount)
    return ()
end

@external
func withdraw{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(user : felt, amount : felt):
    # Make sure 'amount' is positive.
    assert_nn(amount)

    let (res) = balance.read(user=user)
    tempvar new_balance = res - amount

    # Make sure the new balance will be positive.
    assert_nn(new_balance)

    # Update the new balance.
    balance.write(user, new_balance)

    # Send the withdrawal message.
    let (message_payload : felt*) = alloc()
    assert message_payload[0] = MESSAGE_WITHDRAW
    assert message_payload[1] = user
    assert message_payload[2] = amount

    let (L1_address) = L1_CONTRACT_ADDRESS.read()

    send_message_to_l1(
        to_address=L1_address,
        payload_size=3,
        payload=message_payload)

    return ()
end

@l1_handler
func deposit{
        syscall_ptr : felt*, pedersen_ptr : HashBuiltin*,
        range_check_ptr}(
        from_address : felt, user : felt, amount : felt):
    # Make sure the message was sent by the intended L1 contract.
    let (L1_address) = L1_CONTRACT_ADDRESS.read()
    assert from_address = L1_address

    # Read the current balance.
    let (res) = balance.read(user=user)

    # Compute and update the new balance.
    tempvar new_balance = res + amount
    balance.write(user, new_balance)

    return ()
end