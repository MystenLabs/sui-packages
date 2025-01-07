module 0xeea07b18244ad47ce6da0490c526919b6643d4023f3147b0875734d9019ac1f6::dex_get_amount_interface {
    public fun get_best_amount<T0, T1>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64, arg2: u64) : u64 {
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

    public fun get_one_hop_swap_amount_out<T0, T1, T2>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T0, T1>()) {
            if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T1, T2>()) {
                get_swap_token_x_amount_out<T1, T2>(arg0, get_swap_token_x_amount_out<T0, T1>(arg0, arg1))
            } else {
                get_swap_token_y_amount_out<T2, T1>(arg0, get_swap_token_x_amount_out<T0, T1>(arg0, arg1))
            }
        } else if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T1, T2>()) {
            get_swap_token_x_amount_out<T1, T2>(arg0, get_swap_token_y_amount_out<T1, T0>(arg0, arg1))
        } else {
            get_swap_token_y_amount_out<T2, T1>(arg0, get_swap_token_y_amount_out<T1, T0>(arg0, arg1))
        }
    }

    public fun get_swap_token_x_amount_out<T0, T1>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        get_best_amount<T0, T1>(arg0, arg1, 0)
    }

    public fun get_swap_token_y_amount_out<T0, T1>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        get_best_amount<T0, T1>(arg0, 0, arg1)
    }

    public fun get_two_hop_swap_amount_out<T0, T1, T2, T3>(arg0: &0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: u64) : u64 {
        if (0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::are_coins_sorted<T0, T1>()) {
            get_one_hop_swap_amount_out<T1, T2, T3>(arg0, get_swap_token_x_amount_out<T0, T1>(arg0, arg1))
        } else {
            get_one_hop_swap_amount_out<T1, T2, T3>(arg0, get_swap_token_y_amount_out<T1, T0>(arg0, arg1))
        }
    }

    // decompiled from Move bytecode v6
}

