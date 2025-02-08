module 0x1279128b85d0cb1b6f861204b61b87f4b9b2e5afa03175bb73094883b9110126::error {
    public fun acl_invalid_permission() : u64 {
        257
    }

    public fun acl_role_already_exists() : u64 {
        258
    }

    public fun acl_role_not_exists() : u64 {
        259
    }

    public fun acl_role_number_too_large() : u64 {
        260
    }

    public fun emission_exceeds_total_reward() : u64 {
        534
    }

    public fun invalid_argument(arg0: u64) : u64 {
        arg0
    }

    public fun invalid_end_time() : u64 {
        267
    }

    public fun invalid_market_position() : u64 {
        531
    }

    public fun invalid_reward_amount() : u64 {
        266
    }

    public fun market_expired() : u64 {
        265
    }

    public fun mismatched_market_position() : u64 {
        532
    }

    public fun permission_denied() : u64 {
        262
    }

    public fun pool_already_exists() : u64 {
        263
    }

    public fun pool_not_active() : u64 {
        264
    }

    public fun pool_rewarder_already_active() : u64 {
        530
    }

    public fun pool_rewarder_not_active() : u64 {
        529
    }

    public fun reward_not_harvested() : u64 {
        528
    }

    public fun reward_token_type_mismatch() : u64 {
        533
    }

    public fun version_mismatch_error() : u64 {
        261
    }

    // decompiled from Move bytecode v6
}

