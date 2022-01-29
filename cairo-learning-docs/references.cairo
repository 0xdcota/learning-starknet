# Run the following code, with --steps=32 --print_memory and explain what happens.

func main():
    let x = [ap]
    [ap] = 1; ap++
    [ap] = 2; ap++

    [ap] = x; ap++
    jmp rel -1  # Jump to the previous instruction.
end
