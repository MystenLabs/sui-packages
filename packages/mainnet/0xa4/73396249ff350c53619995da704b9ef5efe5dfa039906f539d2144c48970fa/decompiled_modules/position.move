module 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::position {
    struct Position has store {
        collateral: u256,
        base_asset_amount: u256,
        quote_asset_notional_amount: u256,
        cum_funding_rate_long: u256,
        cum_funding_rate_short: u256,
        asks_quantity: u256,
        bids_quantity: u256,
        pending_orders: u64,
        maker_fee: u256,
        taker_fee: u256,
        initial_margin_ratio: u256,
    }

    public fun abs_net_base(arg0: &Position) : u256 {
        let v0 = arg0.base_asset_amount;
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v0, arg0.bids_quantity)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v0, arg0.asks_quantity)))
    }

    public(friend) fun add_long_to_position(arg0: &mut Position, arg1: u256, arg2: u256) : u256 {
        if (!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0.base_asset_amount)) {
            arg0.base_asset_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.base_asset_amount, arg1);
            arg0.quote_asset_notional_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.quote_asset_notional_amount, arg2);
            0
        } else {
            let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0.base_asset_amount);
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg1, v1)) {
                let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.quote_asset_notional_amount, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg1, v1));
                arg0.base_asset_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.base_asset_amount, arg1);
                arg0.quote_asset_notional_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.quote_asset_notional_amount, v2);
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(v2), arg2)
            } else {
                let v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v1, arg1));
                arg0.base_asset_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.base_asset_amount, arg1);
                arg0.quote_asset_notional_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg2, v3);
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(arg0.quote_asset_notional_amount), v3)
            }
        }
    }

    public(friend) fun add_short_to_position(arg0: &mut Position, arg1: u256, arg2: u256) : u256 {
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg0.base_asset_amount, 0)) {
            arg0.base_asset_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.base_asset_amount, arg1);
            arg0.quote_asset_notional_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.quote_asset_notional_amount, arg2);
            0
        } else {
            let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0.base_asset_amount);
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg1, v1)) {
                let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.quote_asset_notional_amount, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg1, v1));
                arg0.base_asset_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.base_asset_amount, arg1);
                arg0.quote_asset_notional_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.quote_asset_notional_amount, v2);
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg2, v2)
            } else {
                let v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v1, arg1));
                arg0.base_asset_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.base_asset_amount, arg1);
                arg0.quote_asset_notional_amount = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg2, v3));
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v3, arg0.quote_asset_notional_amount)
            }
        }
    }

    public(friend) fun add_to_collateral(arg0: &mut Position, arg1: u256) {
        arg0.collateral = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.collateral, arg1);
    }

    public(friend) fun add_to_collateral_usd(arg0: &mut Position, arg1: u256, arg2: u256) : u256 {
        arg0.collateral = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.collateral, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg1, arg2));
        arg0.collateral
    }

    public(friend) fun add_to_pending_amount(arg0: &mut Position, arg1: bool, arg2: u256) {
        if (arg1) {
            arg0.asks_quantity = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.asks_quantity, arg2);
        } else {
            arg0.bids_quantity = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.bids_quantity, arg2);
        };
    }

    public fun calculate_bankruptcy_price(arg0: &Position, arg1: u256, arg2: u64) : u64 {
        let v0 = arg0.base_asset_amount;
        if (v0 == 0) {
            return 0
        };
        let v1 = !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v0);
        let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.quote_asset_notional_amount, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg1, arg0.collateral));
        let v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v2, v0);
        let v4 = v3;
        if (v1 && v2 != 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v3, v0)) {
            v4 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v3, 1);
        };
        let v5 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v4, 0);
        let v6 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(v5, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::b9_scaling());
        let v7 = v6;
        if (v1 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v6, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::b9_scaling()) != v5) {
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
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0.base_asset_amount)) {
            unrealized_funding(arg2, arg0.cum_funding_rate_short, arg0.base_asset_amount)
        } else {
            unrealized_funding(arg1, arg0.cum_funding_rate_long, arg0.base_asset_amount)
        }
    }

    public fun compute_free_collateral(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0, arg0.collateral)
        };
        let v0 = get_position_upnl(arg0, arg2);
        let v1 = get_position_margin_requirements(arg0, arg2, arg3);
        let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.collateral, arg1);
        let v3 = v2;
        if (arg4 != 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()) {
            v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v2, arg4);
        };
        let v4 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than(v0, 0)) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v3, v0)
        } else {
            v3
        };
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v4, v1)) {
            if (arg4 != 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v4, v1), arg1), arg4)
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v4, v1), arg1)
            }
        } else {
            0
        }
    }

    public fun compute_free_collateral_with_fundings(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : u256 {
        if (arg0.pending_orders == 0 && arg0.base_asset_amount == 0) {
            return 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0, arg0.collateral)
        };
        let v0 = get_position_upnl(arg0, arg2);
        let v1 = get_position_margin_requirements(arg0, arg2, arg3);
        let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.collateral, arg1);
        let v3 = v2;
        if (arg6 != 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()) {
            v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v2, arg6);
        };
        let v4 = if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than(v0, 0)) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v3, calculate_position_funding_internal(arg0, arg4, arg5)), v0)
        } else {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v3, calculate_position_funding_internal(arg0, arg4, arg5))
        };
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v4, v1)) {
            if (arg6 != 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()) {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v4, v1), arg1), arg6)
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v4, v1), arg1)
            }
        } else {
            0
        }
    }

    public fun compute_margin(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256) {
        let v0 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.collateral, arg1);
        let v1 = v0;
        if (arg4 != 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()) {
            v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v0, arg4);
        };
        (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v1, get_position_upnl(arg0, arg2)), get_position_margin_requirements(arg0, arg2, arg3))
    }

    public fun compute_margin_with_fundings(arg0: &Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : (u256, u256) {
        let v0 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.collateral, arg1);
        let v1 = v0;
        if (arg6 != 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()) {
            v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v0, arg6);
        };
        (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v1, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(get_position_upnl(arg0, arg2), calculate_position_funding_internal(arg0, arg4, arg5))), get_position_margin_requirements(arg0, arg2, arg3))
    }

    public(friend) fun create_position(arg0: u256, arg1: u256) : Position {
        Position{
            collateral                  : 0,
            base_asset_amount           : 0,
            quote_asset_notional_amount : 0,
            cum_funding_rate_long       : arg0,
            cum_funding_rate_short      : arg1,
            asks_quantity               : 0,
            bids_quantity               : 0,
            pending_orders              : 0,
            maker_fee                   : 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::null_fee(),
            taker_fee                   : 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::null_fee(),
            initial_margin_ratio        : 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed(),
        }
    }

    public fun ensure_margin_requirements(arg0: u256, arg1: u256, arg2: u256, arg3: u256) {
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg2, arg3)) {
            return
        };
        assert!(arg1 != 0, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::errors::initial_margin_requirements_violated());
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg2) && !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0), 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::errors::position_bad_debt());
        let v0 = if (arg3 != 0) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg2, arg3)
        } else {
            0
        };
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v0, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg0, arg1)), 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::errors::initial_margin_requirements_violated());
    }

    public fun get_amounts(arg0: &Position) : (u256, u256) {
        (arg0.base_asset_amount, arg0.quote_asset_notional_amount)
    }

    public fun get_collateral(arg0: &Position) : u256 {
        arg0.collateral
    }

    public fun get_initial_margin_ratio(arg0: &Position) : u256 {
        arg0.initial_margin_ratio
    }

    public fun get_maker_fee(arg0: &Position) : u256 {
        arg0.maker_fee
    }

    public fun get_pending_amounts(arg0: &Position) : (u256, u256) {
        (arg0.asks_quantity, arg0.bids_quantity)
    }

    public fun get_pending_orders_counter(arg0: &Position) : u64 {
        arg0.pending_orders
    }

    public fun get_pos_funding_rates(arg0: &Position) : (u256, u256) {
        (arg0.cum_funding_rate_long, arg0.cum_funding_rate_short)
    }

    public fun get_position_margin_requirements(arg0: &Position, arg1: u256, arg2: u256) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(abs_net_base(arg0), arg1), arg2)
    }

    public fun get_position_upnl(arg0: &Position, arg1: u256) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg0.base_asset_amount, arg1), arg0.quote_asset_notional_amount)
    }

    public fun get_taker_fee(arg0: &Position) : u256 {
        arg0.taker_fee
    }

    public fun is_long(arg0: &Position) : bool {
        !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(arg0.base_asset_amount)
    }

    public(friend) fun reset_collateral(arg0: &mut Position) : u256 {
        arg0.collateral = 0;
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0.collateral)
    }

    public(friend) fun set_initial_margin_ratio(arg0: &mut Position, arg1: u256, arg2: u256, arg3: 0x2::object::ID, arg4: u64) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(arg1, arg2) && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg1, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::constants::one_fixed()), 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::errors::invalid_position_imr());
        arg0.initial_margin_ratio = arg1;
        0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::set_position_initial_margin_ratio(arg3, arg4, arg1);
    }

    public(friend) fun settle_position_funding(arg0: &mut Position, arg1: u256, arg2: u256, arg3: u256, arg4: &0x2::object::ID, arg5: u64) {
        let v0 = calculate_position_funding_internal(arg0, arg2, arg3);
        let v1 = if (v0 != 0) {
            add_to_collateral_usd(arg0, v0, arg1)
        } else {
            arg0.collateral
        };
        let v2 = if (v0 != 0) {
            true
        } else if (arg0.cum_funding_rate_long != arg2) {
            true
        } else {
            arg0.cum_funding_rate_short != arg3
        };
        if (v2) {
            0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::emit_settled_funding(*arg4, arg5, v0, v1, arg2, arg3);
        };
        arg0.cum_funding_rate_long = arg2;
        arg0.cum_funding_rate_short = arg3;
    }

    public(friend) fun sub_from_collateral(arg0: &mut Position, arg1: u256) {
        arg0.collateral = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.collateral, arg1);
    }

    public(friend) fun sub_from_collateral_usd(arg0: &mut Position, arg1: u256, arg2: u256) {
        arg0.collateral = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.collateral, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg1, arg2));
    }

    public(friend) fun sub_from_pending_amount(arg0: &mut Position, arg1: bool, arg2: u256) {
        if (arg1) {
            arg0.asks_quantity = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.asks_quantity, arg2);
        } else {
            arg0.bids_quantity = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.bids_quantity, arg2);
        };
    }

    public fun unrealized_funding(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 == arg1) {
            return 0
        };
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0, arg1), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(arg2))
    }

    public(friend) fun update_pending_orders(arg0: &mut Position, arg1: bool, arg2: u64) {
        if (arg1) {
            arg0.pending_orders = arg0.pending_orders + arg2;
        } else {
            arg0.pending_orders = arg0.pending_orders - arg2;
        };
    }

    public(friend) fun update_position_fees(arg0: &mut Position, arg1: u256, arg2: u256) {
        arg0.maker_fee = arg1;
        arg0.taker_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

