# What does the following code do? (run with --no_end --step=16 to avoid the End of program was not reached error)

func main():
    [ap] = 2; ap++

    my_loop:
    [ap] = [ap - 1] * [ap - 1]; ap++
    [ap] = [ap - 1] + 1; ap++
    jmp my_loop
end
