module 0xe5af20264fcf89875363057efed4b30671833230e19ea9ff86d06d033fb4e928::errorcodes {
    public fun e_bucket_locked() : u64 {
        200
    }

    public fun e_bucket_not_found() : u64 {
        202
    }

    public fun e_bucket_unauthorized() : u64 {
        204
    }

    public fun e_deal_expired() : u64 {
        101
    }

    public fun e_deal_not_active() : u64 {
        100
    }

    public fun e_deal_unauthorized() : u64 {
        103
    }

    public fun e_funding_deal_not_active() : u64 {
        301
    }

    public fun e_funding_insufficient_amount() : u64 {
        300
    }

    public fun e_funding_unauthorized() : u64 {
        302
    }

    public fun e_insufficient_capacity() : u64 {
        1
    }

    public fun e_insufficient_funds() : u64 {
        201
    }

    public fun e_insufficient_payment() : u64 {
        102
    }

    public fun e_invalid_pricing() : u64 {
        3
    }

    public fun e_key_already_exists() : u64 {
        402
    }

    public fun e_key_not_found() : u64 {
        400
    }

    public fun e_key_unauthorized() : u64 {
        401
    }

    public fun e_liquidation_not_allowed() : u64 {
        203
    }

    public fun e_provider_not_active() : u64 {
        2
    }

    public fun e_qos_invalid_metrics() : u64 {
        500
    }

    public fun e_qos_unauthorized() : u64 {
        501
    }

    public fun e_test_invalid_state() : u64 {
        901
    }

    public fun e_test_mode_only() : u64 {
        900
    }

    public fun e_unauthorized() : u64 {
        4
    }

    // decompiled from Move bytecode v6
}

