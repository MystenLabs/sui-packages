module 0x3257f7f5bdbc239f102a39375bfd10691067fbe74e01d97297725c0ea51b2133::roles {
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

    public fun mm_role_rebalancer() : u8 {
        6
    }

    public fun mm_role_treasury() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

