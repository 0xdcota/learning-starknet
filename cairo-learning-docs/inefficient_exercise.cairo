# Cairo has a technical requirement that memory addresses accessed by a program must be continuous.
# For example, if addresses 7 and 9 are accessed, then 8 must also be accessed before the end of the program (the order of access doesn’t matter).
# If small gaps in the address range are present, the prover will automatically fill those addresses with arbitrary values.
# Generally, having such gaps is inefficient, as it means memory is being consumed without being used.
# Introducing too many holes could make the generation of a proof too expensive for an honest prover to perform.
# However, this still does not violate the soundness guarantee – a false proof cannot be generated regardless.

func main():
    [ap] = 100
    [ap + 2] = 200
    ret
end
