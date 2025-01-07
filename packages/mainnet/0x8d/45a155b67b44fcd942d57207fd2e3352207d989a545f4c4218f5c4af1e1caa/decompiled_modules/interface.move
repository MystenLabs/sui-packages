module 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::interface {
    public entry fun add_liquidity<T0, T1, T2>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T1>>, arg3: vector<0x2::coin::Coin<T2>>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_coins_sorted<T1, T2>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<T0, T1, T2>>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::add_liquidity<T0, T1, T2>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg2, arg4, arg7), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T2>(arg3, arg5, arg7), arg6, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<T0, T2, T1>>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::add_liquidity<T0, T2, T1>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T2>(arg3, arg5, arg7), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg2, arg4, arg7), arg6, arg7), 0x2::tx_context::sender(arg7));
        };
    }

    public entry fun create_s_pool<T0, T1>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_coins_sorted<T0, T1>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Stable, T0, T1>>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::create_s_pool<T0, T1>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg4, arg8), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg3, arg5, arg8), arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Stable, T1, T0>>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::create_s_pool<T1, T0>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg3, arg5, arg8), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg4, arg8), arg7, arg6, arg8), 0x2::tx_context::sender(arg8));
        };
    }

    public entry fun create_v_pool<T0, T1>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_coins_sorted<T0, T1>()) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Volatile, T0, T1>>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::create_v_pool<T0, T1>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg4, arg6), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg3, arg5, arg6), arg6), 0x2::tx_context::sender(arg6));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::curve::Volatile, T1, T0>>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::create_v_pool<T1, T0>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg3, arg5, arg6), 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg4, arg6), arg6), 0x2::tx_context::sender(arg6));
        };
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage) : 0x2::object::ID {
        if (0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::are_coins_sorted<T1, T2>()) {
            0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::get_pool_id<T0, T1, T2>(arg0)
        } else {
            0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::get_pool_id<T0, T2, T1>(arg0)
        }
    }

    public entry fun remove_liquidity<T0, T1, T2>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<T0, T1, T2>>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::remove_liquidity<T0, T1, T2>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::LPCoin<T0, T1, T2>>(arg2, arg3, arg6), arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, v0);
    }

    public entry fun one_hop_swap<T0, T1, T2>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::router::one_hop_swap<T0, T1, T2>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun swap_x<T0, T1>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::router::swap_token_x<T0, T1>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun swap_y<T0, T1>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::router::swap_token_y<T0, T1>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T1>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun two_hop_swap<T0, T1, T2, T3>(arg0: &mut 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::core::DEXStorage, arg1: &0x2::clock::Clock, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::router::two_hop_swap<T0, T1, T2, T3>(arg0, arg1, 0x8d45a155b67b44fcd942d57207fd2e3352207d989a545f4c4218f5c4af1e1caa::utils::handle_coin_vector<T0>(arg2, arg3, arg6), arg4, arg6), 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v6
}

