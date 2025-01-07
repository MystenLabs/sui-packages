module 0x5d54aeee2b81120584e2738f49c59a2effc93c27cde6c9651d8aacc5465ca908::error {
    public fun invalid_flow_id() : u64 {
        1
    }

    public fun invalid_leverage() : u64 {
        2
    }

    public fun invalid_obligation() : u64 {
        4
    }

    public fun invalid_vault_cap() : u64 {
        3
    }

    // decompiled from Move bytecode v6
}

