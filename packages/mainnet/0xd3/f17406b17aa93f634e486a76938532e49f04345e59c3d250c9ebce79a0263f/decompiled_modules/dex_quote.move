module 0xd3f17406b17aa93f634e486a76938532e49f04345e59c3d250c9ebce79a0263f::dex_quote {
    fun calculate_optimal_add_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 == 0 && arg3 == 0) {
            return (arg0, arg1)
        };
        let v0 = 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::quote_liquidity(arg0, arg2, arg3);
        if (arg1 >= v0) {
            return (arg0, v0)
        };
        (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::quote_liquidity(arg1, arg3, arg2), arg1)
    }

    public fun quote_add_liquidity<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let (v0, v1, v2) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<T0, T1, T2>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<T0, T1, T2>(arg0));
        let (v3, v4) = calculate_optimal_add_liquidity(arg1, arg2, v0, v1);
        (0x2::math::min(0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::math::mul_div(v3, v2, v0), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::math::mul_div(v4, v2, v1)), v3, v4)
    }

    public fun quote_one_hop_swap<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T0, T1>()) {
            if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T1, T2>()) {
                quote_swap_x<T1, T2>(arg0, quote_swap_x<T0, T1>(arg0, arg1))
            } else {
                quote_swap_y<T2, T1>(arg0, quote_swap_x<T0, T1>(arg0, arg1))
            }
        } else if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T1, T2>()) {
            quote_swap_x<T1, T2>(arg0, quote_swap_y<T1, T0>(arg0, arg1))
        } else {
            quote_swap_y<T2, T1>(arg0, quote_swap_y<T1, T0>(arg0, arg1))
        }
    }

    public fun quote_remove_liquidity<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : (u64, u64) {
        let (v0, v1, v2) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<T0, T1, T2>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<T0, T1, T2>(arg0));
        (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::math::mul_div(arg1, v0, v2), 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::math::mul_div(arg1, v1, v2))
    }

    fun quote_swap<T0, T1>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::is_pool_deployed<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(arg0);
        let v1 = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::is_pool_deployed<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(arg0);
        if (v1 && !v0) {
            let (v2, v3, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(arg0));
            if (arg1 == 0) {
                return 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_v_value_out(arg2, v3, v2)
            };
            return 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_v_value_out(arg1, v2, v3)
        };
        if (v0 && !v1) {
            let v5 = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(arg0);
            let (v6, v7, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(v5);
            if (arg1 == 0) {
                return 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_s_value_out<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(v5, arg2, v6, v7, false)
            };
            return 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_s_value_out<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(v5, arg1, v6, v7, true)
        };
        let v9 = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(arg0);
        let (v10, v11, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::borrow_pool<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(arg0));
        let (v13, v14, _) = 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::get_amounts<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(v9);
        let v16 = if (arg1 == 0) {
            0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_v_value_out(arg2, v11, v10)
        } else {
            0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_v_value_out(arg1, v10, v11)
        };
        let v17 = if (arg1 == 0) {
            0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_s_value_out<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(v9, arg2, v13, v14, false)
        } else {
            0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::calculate_s_value_out<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(v9, arg1, v13, v14, true)
        };
        if (v16 >= v17) {
            v16
        } else {
            v17
        }
    }

    public fun quote_swap_x<T0, T1>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        quote_swap<T0, T1>(arg0, arg1, 0)
    }

    public fun quote_swap_y<T0, T1>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        quote_swap<T0, T1>(arg0, 0, arg1)
    }

    public fun quote_two_hop_swap<T0, T1, T2, T3>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T0, T1>()) {
            quote_one_hop_swap<T1, T2, T3>(arg0, quote_swap_x<T0, T1>(arg0, arg1))
        } else {
            quote_one_hop_swap<T1, T2, T3>(arg0, quote_swap_y<T1, T0>(arg0, arg1))
        }
    }

    // decompiled from Move bytecode v6
}

