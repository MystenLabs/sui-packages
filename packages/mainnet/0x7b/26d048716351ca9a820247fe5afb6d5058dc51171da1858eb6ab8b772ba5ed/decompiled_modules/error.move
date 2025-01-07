module 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::error {
    public fun deposits_disabled() : u64 {
        4
    }

    public fun invalid_flow_id() : u64 {
        1
    }

    public fun invalid_harvest_cap() : u64 {
        6
    }

    public fun invalid_leverage() : u64 {
        2
    }

    public fun invalid_vault() : u64 {
        5
    }

    public fun invalid_vault_cap() : u64 {
        3
    }

    public fun sender_not_whitelisted() : u64 {
        7
    }

    // decompiled from Move bytecode v6
}

