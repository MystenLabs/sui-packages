module 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error {
    public fun actuator_not_found() : u64 {
        34
    }

    public fun actuators_full() : u64 {
        25
    }

    public fun cast_overflow() : u64 {
        18
    }

    public fun circuit_breaked() : u64 {
        12
    }

    public fun clock_went_backwards() : u64 {
        4
    }

    public fun deposit_paused() : u64 {
        21
    }

    public fun deposit_too_small() : u64 {
        13
    }

    public fun interest_overflow() : u64 {
        26
    }

    public fun interest_rate_too_high() : u64 {
        31
    }

    public fun invalid_fee() : u64 {
        1
    }

    public fun invalid_pause_kind() : u64 {
        19
    }

    public fun invalid_timelock() : u64 {
        9
    }

    public fun invalid_vault_params() : u64 {
        17
    }

    public fun max_total_deposit_exceeded() : u64 {
        14
    }

    public fun no_pending_wish() : u64 {
        33
    }

    public fun no_zero_share_redeem() : u64 {
        27
    }

    public fun not_allowed() : u64 {
        6
    }

    public fun not_coin_type() : u64 {
        11
    }

    public fun not_enough_amount() : u64 {
        5
    }

    public fun rate_update_too_frequent() : u64 {
        16
    }

    public fun redeem_paused() : u64 {
        22
    }

    public fun redeem_too_small() : u64 {
        15
    }

    public fun request_not_match() : u64 {
        3
    }

    public fun timelock_expired() : u64 {
        10
    }

    public fun timelock_not_matured() : u64 {
        8
    }

    public fun upgrade_cap_not_injected() : u64 {
        29
    }

    public fun vault_already_exists() : u64 {
        2
    }

    public fun version_mismatch() : u64 {
        20
    }

    public fun wish_already_pending() : u64 {
        32
    }

    public fun withdraw_paused() : u64 {
        23
    }

    public fun wrong_target_wish_object() : u64 {
        7
    }

    public fun wrong_upgrade_cap() : u64 {
        30
    }

    public fun wrong_vault() : u64 {
        28
    }

    public fun zero_shares_not_allowed() : u64 {
        24
    }

    // decompiled from Move bytecode v7
}

