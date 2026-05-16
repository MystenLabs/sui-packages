module 0xe13396db07ebae7389f427089bf0c5b8a585be5eb5d63b67372ad9fa042f41d8::errors {
    public fun already_claimed() : u64 {
        4
    }

    public fun insufficient_lots() : u64 {
        2
    }

    public fun invalid_params() : u64 {
        5
    }

    public fun mint_locked() : u64 {
        6
    }

    public fun no_lots() : u64 {
        0
    }

    public fun wrong_round() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

