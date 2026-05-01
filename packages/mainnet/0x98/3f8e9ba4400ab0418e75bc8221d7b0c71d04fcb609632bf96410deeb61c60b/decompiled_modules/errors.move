module 0x983f8e9ba4400ab0418e75bc8221d7b0c71d04fcb609632bf96410deeb61c60b::errors {
    public fun account_not_found() : u64 {
        16
    }

    public fun action_not_found() : u64 {
        21
    }

    public fun cannot_cancel_active_bin() : u64 {
        18
    }

    public fun exceeds_max_lock() : u64 {
        19
    }

    public fun force_unlock_too_early() : u64 {
        24
    }

    public fun gas_reserved_not_withdrawable() : u64 {
        27
    }

    public fun insufficient_balance() : u64 {
        4
    }

    public fun insufficient_gas_escrow() : u64 {
        17
    }

    public fun insufficient_unlocked_balance() : u64 {
        5
    }

    public fun invalid_limit_side() : u64 {
        15
    }

    public fun invalid_op_kind() : u64 {
        30
    }

    public fun invalid_receipt() : u64 {
        11
    }

    public fun max_limit_orders_reached() : u64 {
        9
    }

    public fun max_operators_reached() : u64 {
        22
    }

    public fun max_positions_reached() : u64 {
        8
    }

    public fun not_admin() : u64 {
        2
    }

    public fun not_operator() : u64 {
        1
    }

    public fun not_treasurer() : u64 {
        29
    }

    public fun open_limit_orders_exist() : u64 {
        28
    }

    public fun order_cooldown() : u64 {
        25
    }

    public fun position_not_found() : u64 {
        6
    }

    public fun position_not_owned_by_user() : u64 {
        7
    }

    public fun rate_limit_exceeded() : u64 {
        26
    }

    public fun target_not_allowed() : u64 {
        13
    }

    public fun timelock_not_elapsed() : u64 {
        20
    }

    public fun vault_not_paused() : u64 {
        23
    }

    public fun vault_paused() : u64 {
        3
    }

    public fun version_mismatch() : u64 {
        14
    }

    public fun withdrawal_cooldown() : u64 {
        10
    }

    public fun zero_amount() : u64 {
        12
    }

    // decompiled from Move bytecode v7
}

