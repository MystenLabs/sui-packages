module 0x6d33d017b4a461809c5281011fbec0a09f7f74b99649b7d3bcb11b465d9fc72e::errors {
    public fun add_conditional_order_denied() : u64 {
        120
    }

    public fun admin_cap_required() : u64 {
        102
    }

    public fun borrow_denied() : u64 {
        113
    }

    public fun cancel_order_denied() : u64 {
        118
    }

    public fun collateral_locked() : u64 {
        503
    }

    public fun collateral_not_found() : u64 {
        501
    }

    public fun conditional_order_denied() : u64 {
        125
    }

    public fun conditional_order_not_triggered() : u64 {
        420
    }

    public fun context_already_consumed() : u64 {
        701
    }

    public fun context_not_found() : u64 {
        702
    }

    public fun context_operation_mismatch() : u64 {
        700
    }

    public fun create_margin_manager_denied() : u64 {
        110
    }

    public fun deposit_denied() : u64 {
        111
    }

    public fun execute_conditional_order_denied() : u64 {
        121
    }

    public fun insufficient_collateral() : u64 {
        500
    }

    public fun insufficient_funds() : u64 {
        3
    }

    public fun invalid_collateral_type() : u64 {
        502
    }

    public fun invalid_conditional_order() : u64 {
        421
    }

    public fun invalid_context_state() : u64 {
        703
    }

    public fun invalid_liquidation_amount() : u64 {
        602
    }

    public fun invalid_margin_manager_owner() : u64 {
        302
    }

    public fun invalid_order_price() : u64 {
        402
    }

    public fun invalid_order_quantity() : u64 {
        403
    }

    public fun invalid_order_type() : u64 {
        407
    }

    public fun invalid_parameter() : u64 {
        1
    }

    public fun invalid_state() : u64 {
        7
    }

    public fun invalid_version() : u64 {
        201
    }

    public fun liquidate_denied() : u64 {
        115
    }

    public fun liquidation_in_progress() : u64 {
        601
    }

    public fun margin_manager_exists() : u64 {
        301
    }

    public fun margin_manager_frozen() : u64 {
        303
    }

    public fun margin_manager_not_found() : u64 {
        300
    }

    public fun modify_order_denied() : u64 {
        119
    }

    public fun not_allowed() : u64 {
        2
    }

    public fun not_authorized() : u64 {
        101
    }

    public fun not_implemented() : u64 {
        6
    }

    public fun order_already_cancelled() : u64 {
        405
    }

    public fun order_already_filled() : u64 {
        404
    }

    public fun order_cannot_be_modified() : u64 {
        408
    }

    public fun order_exists() : u64 {
        401
    }

    public fun order_expired() : u64 {
        406
    }

    public fun order_not_found() : u64 {
        400
    }

    public fun overflow() : u64 {
        5
    }

    public fun permission_denied() : u64 {
        100
    }

    public fun place_limit_order_denied() : u64 {
        116
    }

    public fun place_market_order_denied() : u64 {
        117
    }

    public fun position_not_liquidatable() : u64 {
        600
    }

    public fun protocol_already_emergency_pause() : u64 {
        130
    }

    public fun protocol_not_emergency_pause() : u64 {
        131
    }

    public fun repay_denied() : u64 {
        114
    }

    public fun self_liquidation_not_allowed() : u64 {
        603
    }

    public fun supplier_withdraw_denied() : u64 {
        123
    }

    public fun supply_denied() : u64 {
        122
    }

    public fun trade_denied() : u64 {
        124
    }

    public fun version_deprecated() : u64 {
        200
    }

    public fun version_mismatch() : u64 {
        202
    }

    public fun withdraw_denied() : u64 {
        112
    }

    public fun withdrawal_would_undercollateralize() : u64 {
        504
    }

    public fun zero_amount() : u64 {
        4
    }

    // decompiled from Move bytecode v6
}

