module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::errors {
    public fun error_code_amount_too_large() : u64 {
        7
    }

    public fun error_code_amount_too_small() : u64 {
        8
    }

    public fun error_code_contract_paused() : u64 {
        12
    }

    public fun error_code_cooldown_not_over() : u64 {
        1
    }

    public fun error_code_durability_not_initialized() : u64 {
        24
    }

    public fun error_code_function_not_ready() : u64 {
        23
    }

    public fun error_code_invalid_numeric_string() : u64 {
        25
    }

    public fun error_code_item_already_in_cooldown() : u64 {
        15
    }

    public fun error_code_item_insufficient_payment() : u64 {
        18
    }

    public fun error_code_item_insufficient_resources() : u64 {
        20
    }

    public fun error_code_item_invalid_tier() : u64 {
        21
    }

    public fun error_code_item_nft_not_found() : u64 {
        14
    }

    public fun error_code_item_not_ready_for_withdrawal() : u64 {
        16
    }

    public fun error_code_item_supply_limit_reached() : u64 {
        19
    }

    public fun error_code_item_unauthorized() : u64 {
        17
    }

    public fun error_code_item_unknown_type() : u64 {
        22
    }

    public fun error_code_job_not_found() : u64 {
        29
    }

    public fun error_code_job_not_ready_yet() : u64 {
        28
    }

    public fun error_code_land_not_found() : u64 {
        2
    }

    public fun error_code_land_not_unstaked() : u64 {
        3
    }

    public fun error_code_land_unstaking() : u64 {
        4
    }

    public fun error_code_numeric_overflow() : u64 {
        26
    }

    public fun error_code_slot_limit_exceeded() : u64 {
        27
    }

    public fun error_code_staked_item_limit_reached() : u64 {
        13
    }

    public fun error_code_treasury_cap_not_found() : u64 {
        10
    }

    public fun error_code_unauthorized_pool_to_mint() : u64 {
        9
    }

    public fun error_code_unsupported_function() : u64 {
        5
    }

    public fun error_code_user_not_found() : u64 {
        6
    }

    public fun error_code_version_mismatch() : u64 {
        11
    }

    // decompiled from Move bytecode v6
}

