module 0xbeb7ffc0e2baed9f67484720daa64b4ba4929e9e9d6d957d74faf31d0835b8c::error_codes {
    public fun deprecated() : u64 {
        0
    }

    public fun domain_exists() : u64 {
        2
    }

    public fun domain_not_exists() : u64 {
        3
    }

    public fun global_mint_access_denied() : u64 {
        1
    }

    public fun protocol_downgrade_not_allowed() : u64 {
        8
    }

    public fun user_not_in_mint_records() : u64 {
        5
    }

    public fun ve_sca_amount_threshold_not_met() : u64 {
        4
    }

    public fun ve_sca_key_already_used_for_minting() : u64 {
        6
    }

    public fun version_mismatch() : u64 {
        7
    }

    // decompiled from Move bytecode v6
}

