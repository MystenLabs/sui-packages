module 0x23d18a39f444ff429d5189fa0c5ea635a3afc1a9e2112f103a7349d96e975794::errors {
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

