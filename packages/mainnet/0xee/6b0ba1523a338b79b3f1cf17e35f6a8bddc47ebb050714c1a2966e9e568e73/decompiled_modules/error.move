module 0x81d517bd4f52196dad796208491daf0b6614080759acb36a612a354a19d2bcdc::error {
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

