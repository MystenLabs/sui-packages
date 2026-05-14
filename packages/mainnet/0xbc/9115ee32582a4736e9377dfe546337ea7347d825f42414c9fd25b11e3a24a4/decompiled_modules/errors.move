module 0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::errors {
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

    // decompiled from Move bytecode v7
}

