module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors {
    public fun already_have_role() : u64 {
        18
    }

    public fun err_already_executed() : u64 {
        15
    }

    public fun err_already_initialized() : u64 {
        1
    }

    public fun err_incorrect_checkpoint() : u64 {
        13
    }

    public fun err_insufficient_balance() : u64 {
        21
    }

    public fun err_insufficient_power() : u64 {
        2
    }

    public fun err_invalid_dst_chain_id() : u64 {
        16
    }

    public fun err_invalid_fee() : u64 {
        17
    }

    public fun err_invalid_signature() : u64 {
        14
    }

    public fun err_invalid_valset_nonce() : u64 {
        11
    }

    public fun err_malformed_new_validator_set() : u64 {
        12
    }

    public fun err_metadata_not_set() : u64 {
        22
    }

    public fun err_not_paused() : u64 {
        9
    }

    public fun err_only_admin() : u64 {
        5
    }

    public fun err_only_admin_role() : u64 {
        20
    }

    public fun err_only_pauser() : u64 {
        7
    }

    public fun err_only_resource_setter() : u64 {
        6
    }

    public fun err_paused() : u64 {
        8
    }

    public fun err_route_treasury_cap() : u64 {
        10
    }

    public fun err_unequal_length() : u64 {
        3
    }

    public fun err_unknown_role() : u64 {
        4
    }

    public fun not_have_role() : u64 {
        19
    }

    // decompiled from Move bytecode v6
}

