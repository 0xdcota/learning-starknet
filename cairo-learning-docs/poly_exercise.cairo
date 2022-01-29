# Write a program poly.cairo that computes the expression:
# x^3 + 23x^2 + 45x + 67
# 1.- After the program ends, the value should be at [ap - 1].
# 2.- For this exercise, you may assume that the fp register is constant and initialized to the same value as ap.
# 3.- Your code shouldn’t depend on the value of x.
# 4.- Bonus: This can be done using 5 instructions, not counting the ones given in the template.

func main():
    [ap] = 100; ap++
    # << our code here >>
    [ap] = [ap - 1] * 45
    [ap + 1] = [ap] + 67
    [ap + 2] = [ap - 1] * [ap - 1]
    [ap + 3] = [ap + 2] * 23
    [ap + 4] = [ap + 3] + [ap + 1]
    [ap + 5] = [ap + 2] * [ap - 1]
    [ap + 6] = [ap + 5] + [ap + 4]; ap++
    ret
end
