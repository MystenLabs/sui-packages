module 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors {
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

