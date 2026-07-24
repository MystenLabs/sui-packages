module 0xe3cb28dd9612ad102c71ba32fce2e347410e3c995f184ced83f4038cba24b6c7::spot_guard {
    struct ExecutableGuard has copy, drop {
        highest_sell_proceeds: u64,
        lowest_buy_cost: u64,
        venue_mask: u8,
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

    fun mul_bps_down(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun mul_bps_up(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 10000 - 1) / 10000) as u64)
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

    public fun venue_mask(arg0: &ExecutableGuard) : u8 {
        arg0.venue_mask
    }

    // decompiled from Move bytecode v7
}

