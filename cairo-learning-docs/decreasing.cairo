# Edit the loop my_loop in the exercise above so that it starts by writing 10 to [ap],
# continues by writing the decreasing sequence  and then returns.
# Don’t forget the ret instruction. Verify that your code works as expected by looking at the memory.

func main():
    [ap] = 10; ap++

    my_loop:
    [ap] = [ap - 1] - 1; ap++
    jmp my_loop if [ap - 1] != 0
    ret
end
