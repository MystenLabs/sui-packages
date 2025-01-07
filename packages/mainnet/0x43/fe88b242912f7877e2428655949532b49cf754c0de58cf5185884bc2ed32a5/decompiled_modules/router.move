module 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::router {
    public fun swap_token_x<T0, T1>(arg0: &mut 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (is_volatile_better<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), 0)) {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::swap_token_x<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Volatile, T0, T1>(arg0, arg1, arg2, arg3, arg4)
        } else {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::swap_token_x<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(arg0, arg1, arg2, arg3, arg4)
        }
    }

    public fun swap_token_y<T0, T1>(arg0: &mut 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (is_volatile_better<T0, T1>(arg0, 0, 0x2::coin::value<T1>(&arg2))) {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::swap_token_y<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Volatile, T0, T1>(arg0, arg1, arg2, arg3, arg4)
        } else {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::swap_token_y<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(arg0, arg1, arg2, arg3, arg4)
        }
    }

    public fun is_volatile_better<T0, T1>(arg0: &0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::DEXStorage, arg1: u64, arg2: u64) : bool {
        let v0 = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::is_pool_deployed<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(arg0);
        let v1 = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::is_pool_deployed<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Volatile, T0, T1>(arg0);
        if (v1 && !v0) {
            return true
        };
        if (v0 && !v1) {
            return false
        };
        assert!(v0 && v1, 2);
        let v2 = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::borrow_pool<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(arg0);
        let (v3, v4, _) = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::get_amounts<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Volatile, T0, T1>(0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::borrow_pool<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Volatile, T0, T1>(arg0));
        let (v6, v7, _) = 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::get_amounts<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(v2);
        let v9 = if (arg1 == 0) {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::calculate_v_value_out(arg2, v4, v3)
        } else {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::calculate_v_value_out(arg1, v3, v4)
        };
        let v10 = if (arg1 == 0) {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::calculate_s_value_out<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(v2, arg2, v6, v7, false)
        } else {
            0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::calculate_s_value_out<0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::curve::Stable, T0, T1>(v2, arg1, v6, v7, true)
        };
        v9 >= v10
    }

    public fun one_hop_swap<T0, T1, T2>(arg0: &mut 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T0>(&arg2) != 0, 1);
        if (0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_coins_sorted<T0, T1>()) {
            let v1 = swap_token_x<T0, T1>(arg0, arg1, arg2, 0, arg4);
            if (0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_coins_sorted<T1, T2>()) {
                swap_token_x<T1, T2>(arg0, arg1, v1, arg3, arg4)
            } else {
                swap_token_y<T2, T1>(arg0, arg1, v1, arg3, arg4)
            }
        } else {
            let v2 = swap_token_y<T1, T0>(arg0, arg1, arg2, 0, arg4);
            if (0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_coins_sorted<T1, T2>()) {
                swap_token_x<T1, T2>(arg0, arg1, v2, arg3, arg4)
            } else {
                swap_token_y<T2, T1>(arg0, arg1, v2, arg3, arg4)
            }
        }
    }

    public fun two_hop_swap<T0, T1, T2, T3>(arg0: &mut 0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        if (0x43fe88b242912f7877e2428655949532b49cf754c0de58cf5185884bc2ed32a5::utils::are_coins_sorted<T0, T1>()) {
            let v1 = swap_token_x<T0, T1>(arg0, arg1, arg2, 0, arg4);
            one_hop_swap<T1, T2, T3>(arg0, arg1, v1, arg3, arg4)
        } else {
            let v2 = swap_token_y<T1, T0>(arg0, arg1, arg2, 0, arg4);
            one_hop_swap<T1, T2, T3>(arg0, arg1, v2, arg3, arg4)
        }
    }

    // decompiled from Move bytecode v6
}

