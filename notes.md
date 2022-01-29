## Cheat Sheet for Cairo commands

The testnet (Goerli-voyager) explorer can be found [here](https://goerli.voyager.online/).

#### Environment variables required
> export STARKNET_NETWORK=alpha-goerli
> export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

#### To transact with the blockchain require to deploy EOA contract
> starknet deploy_account

#### Compile a file
> cairo-compile <file name> --output <file_name.json>

#### Run a script /program
You can check the debugging flags [here](https://www.cairo-lang.org/docs/how_cairo_works/debugging_tricks.html).
> cairo-run --program=<file_name.json> --print_memory --print_info --trace_file=<file_name_trace.bin> --memory_file=<file_name_memory.bin> --relocate_print



cairo-run --program=decreasing_compiled.json --print_memory --print_info --trace_file=decreasing_trace.bin --memory_file=decreasing_memory.bin --relocate_print