module 0x241a2768e6ab4873db664e1ccc96355d556d9300532a6865e963e8c3f94eb3e::errors {
    public fun insufficient_stake() : u64 {
        2
    }

    public fun insufficient_vault_balance() : u64 {
        4
    }

    public fun invalid_apy_bps() : u64 {
        6
    }

    public fun invalid_duration() : u64 {
        7
    }

    public fun invalid_fee_bps() : u64 {
        5
    }

    public fun not_authorized() : u64 {
        1
    }

    public fun still_locked() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

