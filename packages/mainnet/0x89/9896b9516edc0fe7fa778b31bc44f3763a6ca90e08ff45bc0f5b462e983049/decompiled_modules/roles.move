module 0x899896b9516edc0fe7fa778b31bc44f3763a6ca90e08ff45bc0f5b462e983049::roles {
    public fun acl_fee_collector() : u8 {
        4
    }

    public fun acl_fee_manager() : u8 {
        3
    }

    public fun acl_mm_registrar() : u8 {
        2
    }

    public fun acl_param_manager() : u8 {
        0
    }

    public fun acl_pauser() : u8 {
        1
    }

    public fun mm_role_pause_recovery() : u8 {
        5
    }

    public fun mm_role_pauser() : u8 {
        4
    }

    public fun mm_role_pool_operator() : u8 {
        2
    }

    public fun mm_role_pool_pauser() : u8 {
        3
    }

    public fun mm_role_quote_signer() : u8 {
        0
    }

    public fun mm_role_treasury() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

