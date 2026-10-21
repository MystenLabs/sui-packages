module 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position {
    struct Position has store {
        collateral: u256,
        base_asset_amount: u256,
        quote_asset_notional_amount: u256,
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
        asks_quantity: u256,
        bids_quantity: u256,
        pending_orders: u64,
        initial_margin_ratio: u256,
    }

    public fun abs_net_base(arg0: &Position) : u256 {
        let v0 = arg0.base_asset_amount;
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v0, arg0.bids_quantity)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v0, arg0.asks_quantity)))
    }

    public fun add_base_to_position(arg0: &mut Position, arg1: bool, arg2: u256, arg3: u256) : (u256, u256) {
        let v0 = arg0.base_asset_amount;
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v0);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v0);
        let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg0.quote_asset_notional_amount);
        if (arg1 == v1) {
            let v4 = if (v1) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v2, arg2))
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v2, arg2)
            };
            arg0.base_asset_amount = v4;
            let v5 = if (v1) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v3, arg3))
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v3, arg3)
            };
            arg0.quote_asset_notional_amount = v5;
            return (0, arg0.base_asset_amount)
        };
        if (arg2 <= v2) {
            let v6 = if (v1) {
                mul_div(v3, arg2, v2)
            } else {
                mul_div_up(v3, arg2, v2)
            };
            let v7 = if (v1) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(v2 - arg2)
            } else {
                v2 - arg2
            };
            arg0.base_asset_amount = v7;
            let v8 = if (v1) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(v3 - v6)
            } else {
                v3 - v6
            };
            arg0.quote_asset_notional_amount = v8;
            let v9 = if (v1) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v6, arg3)
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg3, v6)
            };
            return (v9, arg0.base_asset_amount)
        };
        let v10 = if (v1) {
            mul_div_up(arg3, v2, arg2)
        } else {
            mul_div(arg3, v2, arg2)
        };
        let v11 = if (v1) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v3, v10)
        } else {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v10, v3)
        };
        let v12 = if (arg1) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(arg2 - v2)
        } else {
            arg2 - v2
        };
        arg0.base_asset_amount = v12;
        let v13 = if (arg1) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(arg3 - v10)
        } else {
            arg3 - v10
        };
        arg0.quote_asset_notional_amount = v13;
        (v11, arg0.base_asset_amount)
    }

    public fun add_to_collateral(arg0: &mut Position, arg1: u256) {
        arg0.collateral = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.collateral, arg1);
    }

    public fun add_to_collateral_usd(arg0: &mut Position, arg1: u256, arg2: u256) : u256 {
        arg0.collateral = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.collateral, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(arg1, arg2));
        arg0.collateral
    }

    public fun add_to_pending_amount(arg0: &mut Position, arg1: bool, arg2: u256) {
        if (arg1) {
            arg0.asks_quantity = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.asks_quantity, arg2);
        } else {
            arg0.bids_quantity = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.bids_quantity, arg2);
        };
    }

    public fun apply_maker_fill_or_restore_if_bad_debt(arg0: &mut Position, arg1: bool, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: 0x1::option::Option<u256>) : (bool, u256, u256) {
        let v0 = arg0.collateral;
        let v1 = arg0.base_asset_amount;
        let v2 = arg0.quote_asset_notional_amount;
        let (v3, v4) = add_base_to_position(arg0, arg1, arg2, arg3);
        add_to_collateral_usd(arg0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v3, arg4), arg6);
        let v5 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(effective_collateral_usd_value(arg0, arg6, arg8), unrealized_pnl(arg0, arg7));
        let v6 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v4);
        let v7 = if (0x1::option::is_some<u256>(&arg9)) {
            if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v6, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v1))) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v6, *0x1::option::borrow<u256>(&arg9))
            } else {
                false
            }
        } else {
            false
        };
        let v8 = if (!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v5)) {
            if (!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v6, arg7), arg5), v5)) {
                !v7
            } else {
                false
            }
        } else {
            false
        };
        if (v8) {
            return (true, v3, v4)
        };
        arg0.collateral = v0;
        arg0.base_asset_amount = v1;
        arg0.quote_asset_notional_amount = v2;
        (false, 0, v1)
    }

    public fun apply_taker_fills_and_settle(arg0: &mut Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) : (u256, u256, u256, u256) {
        let v0 = arg0.base_asset_amount;
        let (v1, v2) = if (arg2 != 0) {
            add_base_to_position(arg0, true, arg2, arg3)
        } else {
            (0, v0)
        };
        let v3 = if (arg4 != 0) {
            let (v4, v5) = add_base_to_position(arg0, false, arg4, arg5);
            v2 = v5;
            v4
        } else {
            0
        };
        let v6 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v1, v3);
        let v7 = arg3 + arg5;
        let v8 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_toward_zero(arg6, v7);
        let v9 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_toward_zero(arg7, v7);
        add_to_collateral_usd(arg0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v6, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v8, v9)), arg1);
        (v6, v8, v9, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v2, 0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v0, 0)))
    }

    public fun base_and_quote_amounts(arg0: &Position) : (u256, u256) {
        (arg0.base_asset_amount, arg0.quote_asset_notional_amount)
    }

    public fun calculate_bankruptcy_price(arg0: &Position, arg1: u256, arg2: u64) : u64 {
        let v0 = arg0.base_asset_amount;
        if (v0 == 0) {
            return 0
        };
        let v1 = !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v0);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.quote_asset_notional_amount, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg1, arg0.collateral));
        let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(v2, v0);
        let v4 = v3;
        if (v1 && v2 != 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v3, v0)) {
            v4 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v3, 1);
        };
        let v5 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v4, 0);
        let v6 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v5, 1000000000);
        let v7 = v6;
        if (v1 && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v6, 1000000000) != v5) {
            v7 = v6 + 1;
        };
        let v8 = v7 % arg2;
        if (v8 != 0) {
            if (v1) {
                let v9 = v7 + arg2;
                v7 = v9 - v8;
            } else {
                v7 = v7 - v8;
            };
        };
        v7
    }

    public fun calculate_position_funding_internal(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg0.base_asset_amount)) {
            unrealized_funding(arg2, arg0.cum_funding_rate_short, arg0.base_asset_amount)
        } else {
            unrealized_funding(arg1, arg0.cum_funding_rate_long, arg0.base_asset_amount)
        }
    }

    public fun collateral(arg0: &Position) : u256 {
        arg0.collateral
    }

    public fun compute_free_collateral(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(0, arg0.collateral)
        };
        let v0 = unrealized_pnl(arg0, arg2);
        let v1 = margin_requirement(arg0, arg2, arg3);
        let v2 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v0, 0)) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(effective_collateral_usd_value(arg0, arg1, arg4), v0)
        } else {
            effective_collateral_usd_value(arg0, arg1, arg4)
        };
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v2, v1)) {
            if (arg4 != 0) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v2, v1), arg1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg4))
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v2, v1), arg1)
            }
        } else {
            0
        }
    }

    public fun compute_free_collateral_with_fundings(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : u256 {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(0, arg0.collateral)
        };
        let v0 = unrealized_pnl(arg0, arg2);
        let v1 = margin_requirement(arg0, arg2, arg3);
        let v2 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v0, 0)) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(effective_collateral_usd_value_with_funding(arg0, arg1, arg6, calculate_position_funding_internal(arg0, arg4, arg5)), v0)
        } else {
            effective_collateral_usd_value_with_funding(arg0, arg1, arg6, calculate_position_funding_internal(arg0, arg4, arg5))
        };
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v2, v1)) {
            if (arg6 != 0) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v2, v1), arg1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg6))
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v2, v1), arg1)
            }
        } else {
            0
        }
    }

    public fun compute_margin_and_free_collateral(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256, u256) {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return (effective_collateral_usd_value(arg0, arg1, arg4), 0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(0, arg0.collateral))
        };
        let v0 = unrealized_pnl(arg0, arg2);
        let v1 = margin_requirement(arg0, arg2, arg3);
        let v2 = effective_collateral_usd_value(arg0, arg1, arg4);
        let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v2, v0);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v1, v3)) {
            return (v3, v1, 0)
        };
        let v4 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v0, 0)) {
            v3
        } else {
            v2
        };
        let v5 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v4, v1)) {
            if (arg4 != 0) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v4, v1), arg1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg4))
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v4, v1), arg1)
            }
        } else {
            0
        };
        (v3, v1, v5)
    }

    public fun compute_margin_and_requirement(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256) {
        (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(effective_collateral_usd_value(arg0, arg1, arg4), unrealized_pnl(arg0, arg2)), margin_requirement(arg0, arg2, arg3))
    }

    public fun compute_margin_with_fundings(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : (u256, u256) {
        (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(effective_collateral_usd_value_with_funding(arg0, arg1, arg6, calculate_position_funding_internal(arg0, arg4, arg5)), unrealized_pnl(arg0, arg2)), margin_requirement(arg0, arg2, arg3))
    }

    public fun create_position(arg0: u256, arg1: u256) : Position {
        Position{
            collateral                  : 0,
            base_asset_amount           : 0,
            quote_asset_notional_amount : 0,
            cum_funding_rate_long       : arg0,
            cum_funding_rate_short      : arg1,
            asks_quantity               : 0,
            bids_quantity               : 0,
            pending_orders              : 0,
            initial_margin_ratio        : 1000000000000000000,
        }
    }

    fun effective_collateral_usd_value(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        if (arg2 != 0 && !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg0.collateral)) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0.collateral, arg1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg2))
        } else {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0.collateral, arg1)
        }
    }

    fun effective_collateral_usd_value_with_funding(arg0: &Position, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0.collateral, arg1), arg3);
        if (arg2 != 0 && !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v0)) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg2))
        } else {
            v0
        }
    }

    public fun effective_initial_margin_ratio(arg0: &Position, arg1: u256) : u256 {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(arg0.initial_margin_ratio, arg1)
    }

    public fun ensure_margin_requirements(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg2, arg3)) {
            return
        };
        assert!(arg1 != 0, 2001);
        assert!(!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg2) && !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg0), 2002);
        let v0 = if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg4) == 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg5)
        };
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg3, arg1) && v0, 2001);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg2, arg0)) {
            return
        };
        assert!(arg3 != arg1, 2001);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg2, arg1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0, arg3)), 2001);
    }

    public fun funding_rate_snapshots(arg0: &Position) : (u256, u256) {
        (arg0.cum_funding_rate_long, arg0.cum_funding_rate_short)
    }

    public fun initial_margin_ratio(arg0: &Position) : u256 {
        arg0.initial_margin_ratio
    }

    public fun is_long_or_flat(arg0: &Position) : bool {
        !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg0.base_asset_amount)
    }

    public fun margin_requirement(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(abs_net_base(arg0), arg1), arg2)
    }

    fun mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        arg0 * arg1 / arg2
    }

    fun mul_div_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        (arg0 * arg1 + arg2 - 1) / arg2
    }

    public fun pending_base_amounts_by_side(arg0: &Position) : (u256, u256) {
        (arg0.asks_quantity, arg0.bids_quantity)
    }

    public fun pending_order_count(arg0: &Position) : u64 {
        arg0.pending_orders
    }

    public fun reset_collateral(arg0: &mut Position) : u256 {
        arg0.collateral = 0;
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg0.collateral)
    }

    public fun set_initial_margin_ratio(arg0: &mut Position, arg1: u256, arg2: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg1, arg2) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg1, 1000000000000000000), 2003);
        arg0.initial_margin_ratio = arg1;
    }

    public fun settle_position_funding(arg0: &mut Position, arg1: u256, arg2: u256, arg3: u256) : (bool, u256, u256) {
        let v0 = arg0.base_asset_amount;
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v0);
        let (v2, v3) = if (v1) {
            (arg3, arg0.cum_funding_rate_short)
        } else {
            (arg2, arg0.cum_funding_rate_long)
        };
        let v4 = if (v2 != v3 && v0 != 0) {
            let v5 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v2, v3);
            let v6 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v5);
            let v7 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v0);
            if (v1 != 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v5)) {
                arg0.collateral = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.collateral, mul_div(v6, v7, arg1));
                mul_div(v6, v7, 1000000000000000000)
            } else {
                arg0.collateral = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.collateral, mul_div_up(v6, v7, arg1));
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(mul_div_up(v6, v7, 1000000000000000000))
            }
        } else {
            0
        };
        let v8 = if (v4 != 0) {
            true
        } else if (arg0.cum_funding_rate_long != arg2) {
            true
        } else {
            arg0.cum_funding_rate_short != arg3
        };
        arg0.cum_funding_rate_long = arg2;
        arg0.cum_funding_rate_short = arg3;
        (v8, v4, arg0.collateral)
    }

    public fun sub_from_collateral(arg0: &mut Position, arg1: u256) {
        arg0.collateral = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.collateral, arg1);
    }

    public fun sub_from_pending_amount(arg0: &mut Position, arg1: bool, arg2: u256) {
        if (arg1) {
            arg0.asks_quantity = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.asks_quantity, arg2);
        } else {
            arg0.bids_quantity = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.bids_quantity, arg2);
        };
    }

    public fun unrealized_funding(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == arg1) {
            return 0
        };
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0, arg1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(arg2))
    }

    public fun unrealized_pnl(arg0: &Position, arg1: u256) : u256 {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0.base_asset_amount, arg1), arg0.quote_asset_notional_amount)
    }

    public fun update_pending_orders(arg0: &mut Position, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.pending_orders = arg0.pending_orders + arg2;
        } else {
            arg0.pending_orders = arg0.pending_orders - arg2;
        };
    }

    // decompiled from Move bytecode v7
}

