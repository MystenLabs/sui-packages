module 0x45aedcc59ccff925217b076c097501506a68e876432668ff0e516c0d8165879d::spot_guard {
    struct ExecutableGuard has copy, drop {
        highest_sell_proceeds: u64,
        lowest_buy_cost: u64,
        venue_mask: u8,
    }

    struct TakerQuote has copy, drop {
        route: u8,
        taker_side: u8,
        amount_in: u64,
        amount_out: u64,
        fee_amount_input: u64,
        sqrt_price_limit: u128,
        complete: bool,
    }

    struct TakerSelection has copy, drop {
        quote: TakerQuote,
        quote_surplus: u64,
    }

    public fun apply_to_ask_floor(arg0: u64, arg1: &ExecutableGuard, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1.highest_sell_proceeds > 0) {
                arg2 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        max(arg0, mul_bps_up(arg1.highest_sell_proceeds, 10000 + arg2))
    }

    public fun apply_to_bid_ceiling(arg0: u64, arg1: &ExecutableGuard, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1.lowest_buy_cost > 0) {
                arg2 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        min(arg0, mul_bps_down(arg1.lowest_buy_cost, 10000 - arg2))
    }

    public fun apply_to_envelope(arg0: u64, arg1: u64, arg2: &ExecutableGuard, arg3: u64) : (u64, u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 > arg0) {
                if (arg2.highest_sell_proceeds > 0) {
                    if (arg2.lowest_buy_cost > 0) {
                        arg3 < 10000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        (min(arg0, mul_bps_down(arg2.lowest_buy_cost, 10000 - arg3)), max(arg1, mul_bps_up(arg2.highest_sell_proceeds, 10000 + arg3)))
    }

    fun basic_quote_is_safe(arg0: &TakerQuote, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = if (arg5 > arg6) {
            arg5 - arg6
        } else {
            0
        };
        if (arg0.taker_side == 1) {
            if (arg0.amount_out == arg1) {
                if (arg0.amount_in <= arg3) {
                    (arg4 as u128) + (arg1 as u128) <= (arg5 as u128) + (arg6 as u128)
                } else {
                    false
                }
            } else {
                false
            }
        } else if (arg0.taker_side == 2) {
            if (arg0.amount_in >= arg1) {
                if (arg0.amount_in <= arg2) {
                    if (arg4 >= arg0.amount_in) {
                        arg4 - arg0.amount_in >= v0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun better_selection(arg0: &TakerQuote, arg1: u64, arg2: &TakerSelection) : bool {
        let v0 = &arg2.quote;
        if (v0.route == 0) {
            true
        } else if (arg1 > arg2.quote_surplus) {
            true
        } else {
            arg1 == arg2.quote_surplus && (arg0.route < v0.route || arg0.route == v0.route && arg0.taker_side < v0.taker_side)
        }
    }

    public(friend) fun bluefin_route() : u8 {
        4
    }

    public(friend) fun both_taker_sides() : u8 {
        3
    }

    public(friend) fun buy_base_side() : u8 {
        1
    }

    public(friend) fun cetus_execution_sqrt_limit(arg0: u128, arg1: bool) : u128 {
        assert!(arg0 > 0, 0);
        if (arg1) {
            if (arg0 > 1) {
                arg0 - 1
            } else {
                arg0
            }
        } else if (arg0 < 340282366920938463463374607431768211455) {
            arg0 + 1
        } else {
            arg0
        }
    }

    public(friend) fun cetus_high_route() : u8 {
        3
    }

    public(friend) fun cetus_low_route() : u8 {
        2
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    fun complete_taker_quote(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u128) : TakerQuote {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 > arg2) {
            true
        } else {
            arg5 == 0
        };
        if (v0) {
            return invalid_taker_quote(arg0, arg1)
        };
        TakerQuote{
            route            : arg0,
            taker_side       : arg1,
            amount_in        : arg2,
            amount_out       : arg3,
            fee_amount_input : arg4,
            sqrt_price_limit : arg5,
            complete         : true,
        }
    }

    public(friend) fun deepbook_buy_limit_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = (arg0 as u128) * 1000000000 / (1000000000 + (mul_float(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()) as u128)) * 1000000000 / (arg1 as u128);
        if (v1 == 0 || v1 > 18446744073709551615) {
            return 0
        };
        let v2 = (v1 as u64);
        v2 - v2 % arg3
    }

    fun deepbook_input_fee(arg0: u64, arg1: u64) : u64 {
        mul_float(mul_float(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()), arg1)
    }

    public(friend) fun deepbook_route() : u8 {
        5
    }

    public(friend) fun deepbook_sell_limit_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = ((sell_required_quote(arg0, arg1, checked_add(arg1, arg2)) as u128) * 1000000000 + (arg1 as u128) - 1) / (arg1 as u128);
        if (v1 == 0 || v1 > 18446744073709551615) {
            return 0
        };
        let v2 = (v1 as u64);
        let v3 = v2 % arg3;
        if (v3 == 0) {
            v2
        } else {
            checked_add(v2, arg3 - v3)
        }
    }

    public(friend) fun exact_input_reconciles(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 <= arg2 && arg1 == arg2 - arg0
    }

    public(friend) fun from_quote_amounts(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : ExecutableGuard {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return invalid_guard()
        };
        let v1 = quote_amount_to_price(arg0, arg2, false);
        let v2 = quote_amount_to_price(arg1, arg2, true);
        if (v1 == 0 || v2 < v1) {
            return invalid_guard()
        };
        ExecutableGuard{
            highest_sell_proceeds : v1,
            lowest_buy_cost       : v2,
            venue_mask            : arg3,
        }
    }

    public fun highest_sell_proceeds(arg0: &ExecutableGuard) : u64 {
        arg0.highest_sell_proceeds
    }

    public(friend) fun input_plus_fee(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 18446744073709551615 - arg0, 0);
        arg0 + arg1
    }

    fun invalid_guard() : ExecutableGuard {
        ExecutableGuard{
            highest_sell_proceeds : 0,
            lowest_buy_cost       : 0,
            venue_mask            : 0,
        }
    }

    fun invalid_taker_quote(arg0: u8, arg1: u8) : TakerQuote {
        TakerQuote{
            route            : arg0,
            taker_side       : arg1,
            amount_in        : 0,
            amount_out       : 0,
            fee_amount_input : 0,
            sqrt_price_limit : 0,
            complete         : false,
        }
    }

    public fun is_complete(arg0: &ExecutableGuard) : bool {
        if (arg0.highest_sell_proceeds > 0) {
            if (arg0.lowest_buy_cost >= arg0.highest_sell_proceeds) {
                arg0.venue_mask > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun lowest_buy_cost(arg0: &ExecutableGuard) : u64 {
        arg0.lowest_buy_cost
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun merge(arg0: ExecutableGuard, arg1: ExecutableGuard) : ExecutableGuard {
        if (!is_complete(&arg0)) {
            return arg1
        };
        if (!is_complete(&arg1)) {
            return arg0
        };
        ExecutableGuard{
            highest_sell_proceeds : max(arg0.highest_sell_proceeds, arg1.highest_sell_proceeds),
            lowest_buy_cost       : min_nonzero(arg0.lowest_buy_cost, arg1.lowest_buy_cost),
            venue_mask            : arg0.venue_mask | arg1.venue_mask,
        }
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min_nonzero(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            arg1
        } else if (arg1 == 0) {
            arg0
        } else {
            min(arg0, arg1)
        }
    }

    public(friend) fun momentum_route() : u8 {
        1
    }

    fun mul_bps_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun mul_bps_up(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 10000 - 1) / 10000) as u64)
    }

    fun mul_float(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / 1000000000;
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    fun no_taker_selection() : TakerSelection {
        TakerSelection{
            quote         : invalid_taker_quote(0, 0),
            quote_surplus : 0,
        }
    }

    fun quote_amount_to_price(arg0: u64, arg1: u64, arg2: bool) : u64 {
        let v0 = (arg1 as u128);
        let v1 = if (arg2) {
            ((arg0 as u128) * 1000000000 + v0 - 1) / v0
        } else {
            (arg0 as u128) * 1000000000 / v0
        };
        assert!(v1 <= 18446744073709551615, 0);
        (v1 as u64)
    }

    public fun quote_bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: u128) : ExecutableGuard {
        assert!(arg1 > 0, 0);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v1 = if (arg2 == 0) {
            true
        } else if (arg2 >= v0) {
            true
        } else {
            arg3 <= v0
        };
        if (v1) {
            return invalid_guard()
        };
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, true, true, arg1, arg2);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, false, false, arg1, arg3);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v2) != 0 || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v3) != 0) {
            return invalid_guard()
        };
        from_quote_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3), arg1, 4)
    }

    public(friend) fun quote_bluefin_buy_exact_base<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u128) : TakerQuote {
        assert!(arg1 > 0, 0);
        if (arg2 <= 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)) {
            return invalid_taker_quote(4, 1)
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, false, false, arg1, arg2);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) != 0 || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0)) {
            return invalid_taker_quote(4, 1)
        };
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0);
        complete_taker_quote(4, 1, v1, arg1, total_input_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v0), v1), arg2)
    }

    public(friend) fun quote_bluefin_sell_exact_base<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u64, arg2: u128) : TakerQuote {
        assert!(arg1 > 0, 0);
        if (arg2 == 0 || arg2 >= 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0)) {
            return invalid_taker_quote(4, 2)
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, true, true, arg1, arg2);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) != 0 || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0)) {
            return invalid_taker_quote(4, 2)
        };
        complete_taker_quote(4, 2, arg1, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0), total_input_fee(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_fee_amount(&v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_protocol_fee(&v0), arg1), arg2)
    }

    public fun quote_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64) : ExecutableGuard {
        assert!(arg2 > 0, 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, false, true, arg2);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, true, false, arg2);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, false, true, arg2);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, true, false, arg2);
        let v4 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v1)) {
            true
        } else if (!exact_input_reconciles(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), arg2)) {
            true
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v1) != arg2
        };
        let v5 = if (v4) {
            invalid_guard()
        } else {
            from_quote_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), input_plus_fee(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v1)), arg2, 2)
        };
        let v6 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v2)) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v3)) {
            true
        } else if (!exact_input_reconciles(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v2), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v2), arg2)) {
            true
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3) != arg2
        };
        let v7 = if (v6) {
            invalid_guard()
        } else {
            from_quote_amounts(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2), input_plus_fee(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v3)), arg2, 2)
        };
        merge(v5, v7)
    }

    public(friend) fun quote_cetus_buy_exact_base<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: u64, arg2: u8) : TakerQuote {
        assert!(arg1 > 0 && (arg2 == 2 || arg2 == 3), 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, true, false, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v0);
        let v3 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) != arg1) {
            true
        } else {
            v2 >= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg0)
        };
        if (v3) {
            return invalid_taker_quote(arg2, 1)
        };
        complete_taker_quote(arg2, 1, input_plus_fee(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0), v1), arg1, v1, cetus_execution_sqrt_limit(v2, true))
    }

    public(friend) fun quote_cetus_sell_exact_base<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: u64, arg2: u8) : TakerQuote {
        assert!(arg1 > 0 && (arg2 == 2 || arg2 == 3), 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg0, false, true, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v0);
        let v3 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            true
        } else if (!exact_input_reconciles(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0), v1, arg1)) {
            true
        } else {
            v2 <= 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg0)
        };
        if (v3) {
            return invalid_taker_quote(arg2, 2)
        };
        complete_taker_quote(arg2, 2, arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), v1, cetus_execution_sqrt_limit(v2, false))
    }

    public(friend) fun quote_deepbook_buy_exact_base<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : TakerQuote {
        assert!(arg2 > 0 && arg3 > 0, 0);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v6 = deepbook_buy_limit_price(arg3, arg2, v3, v0);
        if (v6 == 0) {
            return invalid_taker_quote(5, 1)
        };
        let (v7, v8) = quote_deepbook_orders<T0, T1>(arg0, arg1, arg2, v6, true, arg4);
        if (v7 != arg2 || v8 == 0) {
            return invalid_taker_quote(5, 1)
        };
        let v9 = deepbook_input_fee(v8, v3);
        complete_taker_quote(5, 1, checked_add(v8, v9), arg2, v9, (v6 as u128))
    }

    fun quote_deepbook_orders<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::iter_orders<T0, T1>(arg0, 0x1::option::none<u128>(), 0x1::option::none<u128>(), 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg5)), 64, !arg4);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_query::orders(&v0);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1) && v2 < arg2) {
            let v5 = 0x1::vector::borrow<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::Order>(v1, v4);
            let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::price(v5);
            if (arg4 && v6 > arg3 || !arg4 && v6 < arg3) {
                break
            };
            if (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::balance_manager_id(v5) != 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(arg1)) {
                let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::quantity(v5);
                let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order::filled_quantity(v5);
                let v9 = if (v7 > v8) {
                    v7 - v8
                } else {
                    0
                };
                let v10 = min(v9, arg2 - v2);
                if (v10 > 0) {
                    v2 = checked_add(v2, v10);
                    let v11 = v3 + (v10 as u128) * (v6 as u128) / 1000000000;
                    v3 = v11;
                    assert!(v11 <= 18446744073709551615, 0);
                };
            };
            v4 = v4 + 1;
        };
        (v2, (v3 as u64))
    }

    public(friend) fun quote_deepbook_sell_exact_base<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : TakerQuote {
        assert!(arg2 > 0 && arg3 > 0, 0);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v6 = deepbook_input_fee(arg2, v3);
        let v7 = deepbook_sell_limit_price(arg3, arg2, v6, v0);
        if (v7 == 0) {
            return invalid_taker_quote(5, 2)
        };
        let (v8, v9) = quote_deepbook_orders<T0, T1>(arg0, arg1, arg2, v7, false, arg4);
        if (v8 != arg2 || v9 == 0) {
            return invalid_taker_quote(5, 2)
        };
        complete_taker_quote(5, 2, checked_add(arg2, v6), v9, v6, (v7 as u128))
    }

    public fun quote_momentum<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: u128) : ExecutableGuard {
        assert!(arg1 > 0, 0);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        let v1 = if (arg2 == 0) {
            true
        } else if (arg2 >= v0) {
            true
        } else {
            arg3 <= v0
        };
        if (v1) {
            return invalid_guard()
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, true, true, arg2, arg1);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, false, false, arg3, arg1);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v2) != 0 || 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v3) != 0) {
            return invalid_guard()
        };
        from_quote_amounts(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v3), arg1, 1)
    }

    public(friend) fun quote_momentum_buy_exact_base<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128) : TakerQuote {
        assert!(arg1 > 0, 0);
        if (arg2 <= 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0)) {
            return invalid_taker_quote(1, 1)
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, false, false, arg2, arg1);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) != 0) {
            return invalid_taker_quote(1, 1)
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0);
        complete_taker_quote(1, 1, v1, arg1, total_input_fee(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_protocol_fee(&v0), v1), arg2)
    }

    public(friend) fun quote_momentum_sell_exact_base<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128) : TakerQuote {
        assert!(arg1 > 0, 0);
        if (arg2 == 0 || arg2 >= 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0)) {
            return invalid_taker_quote(1, 2)
        };
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, true, true, arg2, arg1);
        if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v0) != 0) {
            return invalid_taker_quote(1, 2)
        };
        complete_taker_quote(1, 2, arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v0), total_input_fee(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_fee_amount(&v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_protocol_fee(&v0), arg1), arg2)
    }

    fun quote_surplus_if_safe(arg0: &TakerQuote, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : (bool, u64) {
        let v0 = if (!arg0.complete) {
            true
        } else if (arg0.route == 0) {
            true
        } else if (arg0.fee_amount_input > arg0.amount_in) {
            true
        } else if (arg0.sqrt_price_limit == 0) {
            true
        } else {
            !basic_quote_is_safe(arg0, arg4, arg5, arg6, arg7, arg8, arg9)
        };
        if (v0) {
            return (false, 0)
        };
        if (arg0.taker_side == 1) {
            let v3 = if (arg1 & 1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else {
                arg0.amount_in >= arg2
            };
            if (v3) {
                return (false, 0)
            };
            (true, arg2 - arg0.amount_in)
        } else if (arg0.taker_side == 2) {
            let v4 = sell_required_quote(arg3, arg4, arg0.amount_in);
            let v5 = if (arg1 & 2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else {
                arg0.amount_out <= v4
            };
            if (v5) {
                return (false, 0)
            };
            (true, arg0.amount_out - v4)
        } else {
            (false, 0)
        }
    }

    public(friend) fun select_best_taker(arg0: vector<TakerQuote>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : TakerSelection {
        let v0 = if (arg1 <= 3) {
            if (arg4 > 0) {
                arg9 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = no_taker_selection();
        let v2 = 0;
        while (v2 < 0x1::vector::length<TakerQuote>(&arg0)) {
            let v3 = 0x1::vector::borrow<TakerQuote>(&arg0, v2);
            let (v4, v5) = quote_surplus_if_safe(v3, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
            if (v4 && better_selection(v3, v5, &v1)) {
                v1 = TakerSelection{quote: *v3, quote_surplus: v5};
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun selected_taker_is_safe(arg0: &TakerSelection, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        let v0 = &arg0.quote;
        if (v0.route == 0) {
            return true
        };
        basic_quote_is_safe(v0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun sell_base_side() : u8 {
        2
    }

    fun sell_required_quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 >= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = arg2 - arg1;
        if (v1 == 0) {
            return arg0
        };
        let v2 = ((arg0 as u128) * (v1 as u128) + (arg1 as u128) - 1) / (arg1 as u128);
        assert!(v2 <= 18446744073709551615, 0);
        checked_add(arg0, (v2 as u64))
    }

    public(friend) fun taker_quote_values(arg0: &TakerQuote) : (u8, u8, u64, u64, u64, u128, bool) {
        (arg0.route, arg0.taker_side, arg0.amount_in, arg0.amount_out, arg0.fee_amount_input, arg0.sqrt_price_limit, arg0.complete)
    }

    public(friend) fun taker_selection_values(arg0: &TakerSelection) : (u8, u8, u64, u64, u64, u128, u64) {
        (arg0.quote.route, arg0.quote.taker_side, arg0.quote.amount_in, arg0.quote.amount_out, arg0.quote.fee_amount_input, arg0.quote.sqrt_price_limit, arg0.quote_surplus)
    }

    fun total_input_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg2 && arg1 <= arg2 - arg0, 0);
        arg0 + arg1
    }

    public fun venue_mask(arg0: &ExecutableGuard) : u8 {
        arg0.venue_mask
    }

    // decompiled from Move bytecode v7
}

