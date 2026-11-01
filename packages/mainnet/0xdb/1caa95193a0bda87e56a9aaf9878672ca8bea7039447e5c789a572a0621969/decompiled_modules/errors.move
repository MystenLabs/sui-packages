module 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::errors {
    public fun bn_error() : u64 {
        14006
    }

    public fun division_by_zero() : u64 {
        14002
    }

    public fun invalid_public_key() : u64 {
        15001
    }

    public fun multisig_duplicate_public_key() : u64 {
        15007
    }

    public fun multisig_empty() : u64 {
        15009
    }

    public fun multisig_lengths_mismatch() : u64 {
        15002
    }

    public fun multisig_not_enough_participants() : u64 {
        15005
    }

    public fun multisig_single_signer_meets_threshold() : u64 {
        15004
    }

    public fun multisig_threshold_out_of_bounds() : u64 {
        15003
    }

    public fun multisig_too_many_participants() : u64 {
        15006
    }

    public fun multisig_zero_weight() : u64 {
        15008
    }

    public fun overflow() : u64 {
        14001
    }

    public fun tick_invalid_perfect_ratio() : u64 {
        14005
    }

    public fun tick_out_of_bounds() : u64 {
        14003
    }

    public fun tick_ratio_out_of_bounds() : u64 {
        14004
    }

    // decompiled from Move bytecode v7
}

