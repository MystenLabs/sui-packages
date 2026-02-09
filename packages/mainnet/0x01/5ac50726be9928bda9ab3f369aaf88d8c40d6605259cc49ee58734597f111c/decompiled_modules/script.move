module 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::script {
    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::AmmAdminCap, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg6, arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg9, arg10);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::deployer_register_pool_both_coin_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg7, arg6, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::AmmAdminCap, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg6, arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg8, arg9);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::deployer_register_pool_y_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg6, arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg10), arg10);
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::AmmAdminCap, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg3: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg4: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg6, arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg8, arg9);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::deployer_register_pool_x_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg6, arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg10), arg10);
    }

    public fun add_liquidity_to_2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>(0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::add_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), arg6), 0x2::tx_context::sender(arg7), arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public fun add_liquidity_to_2pool_only_x<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_2pool<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, 0, arg4, arg5);
    }

    public fun add_liquidity_to_2pool_only_x_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>> {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_2pool_return_balance<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, 0, arg4, arg5)
    }

    public fun add_liquidity_to_2pool_only_y<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        add_liquidity_to_2pool<T0, T1, T2>(arg0, arg1, v0, 0, arg2, arg3, arg4, arg5);
    }

    public fun add_liquidity_to_2pool_only_y_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>> {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        add_liquidity_to_2pool_return_balance<T0, T1, T2>(arg0, arg1, v0, 0, arg2, arg3, arg4, arg5)
    }

    public fun add_liquidity_to_2pool_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg7), arg7);
        0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::add_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), arg6)
    }

    fun create_two_coin_vector(arg0: u8, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, arg1);
        v0
    }

    public fun get_sorted_order_two_coin<T0, T1>() : vector<u8> {
        if (!0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::is_sorted<T0, T1>()) {
            create_two_coin_vector(1, 0)
        } else {
            create_two_coin_vector(0, 1)
        }
    }

    fun get_two_coin_ordered_weights_and_prices<T0>(arg0: vector<u256>, arg1: vector<u64>) : (vector<u256>, vector<u64>) {
        let v0 = if (0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::curves::is_weighted<T0>()) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg1, 1));
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg1, 0));
            v1
        } else {
            arg1
        };
        let v2 = if (0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::curves::is_curved<T0>()) {
            let v3 = 0x1::vector::empty<u256>();
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&arg0, 1));
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&arg0, 0));
            v3
        } else {
            arg0
        };
        (v2, v0)
    }

    public fun register_amm_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_both_coin_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, arg6, arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg8, arg9);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_both_coin_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg6, arg5, arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg10), arg10);
    }

    public fun register_amm_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: vector<u64>, arg6: vector<u256>, arg7: vector<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_no_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, 0x1::option::some<vector<u256>>(arg6), 0x1::option::some<vector<u64>>(arg7), arg8)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg6, arg7);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_no_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg8)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg8), arg8);
    }

    public fun register_amm_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: vector<u64>, arg7: vector<u256>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_x_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, arg6, 0x1::option::some<vector<u256>>(arg7), 0x1::option::some<vector<u64>>(arg8), arg9)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg7, arg8);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_y_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, arg6, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg9)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun register_amm_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::HoneyYield, arg2: &mut 0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::honey_yield::FeeCollector<0x2::sui::SUI>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: vector<u64>, arg7: vector<u256>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1>();
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_y_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, arg6, 0x1::option::some<vector<u256>>(arg7), 0x1::option::some<vector<u64>>(arg8), arg9)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg7, arg8);
            0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::register_pool_x_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg4), arg5, arg6, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg9)
        };
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun remove_liquidity_from_2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: 0x2::coin::Coin<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>(arg3);
        if (arg4 == 0) {
            let (v1, v2, v3) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::remove_liquidity<T0, T1, T2>(arg1, arg0, arg2, v0, arg5, arg6, arg7);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg8), arg8);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg8), arg8);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>(v3, 0x2::tx_context::sender(arg8), arg8);
        } else {
            let (v4, v5, v6) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::remove_liquidity<T0, T1, T2>(arg1, arg0, arg2, 0x2::balance::split<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>(&mut v0, arg4), arg5, arg6, arg7);
            0x2::balance::join<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>(&mut v0, v6);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v4, 0x2::tx_context::sender(arg8), arg8);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v5, 0x2::tx_context::sender(arg8), arg8);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg8), arg8);
        };
    }

    public fun swap2pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg6);
        if (arg4 > 0) {
            let (v2, v3) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5, 0x2::balance::zero<T1>(), arg8, arg9);
            0x2::balance::join<T0>(&mut v0, v2);
            0x2::balance::join<T1>(&mut v1, v3);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg10), arg10);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg10), arg10);
        } else {
            let (v4, v5) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), arg5, 0x2::balance::split<T1>(&mut v1, arg7), arg8, arg9);
            0x2::balance::join<T0>(&mut v0, v4);
            0x2::balance::join<T1>(&mut v1, v5);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg10), arg10);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg10), arg10);
        };
    }

    public fun swap2pool_provide_x<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let (v1, v2) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), 0, 0x2::balance::zero<T1>(), arg5, arg6);
        0x2::balance::join<T0>(&mut v0, v1);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg7), arg7);
    }

    public fun swap2pool_provide_x_return_balance<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let (v1, v2) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), 0, 0x2::balance::zero<T1>(), arg5, arg6);
        0x2::balance::join<T0>(&mut v0, v1);
        (v0, v2)
    }

    public fun swap2pool_provide_y<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg4);
        let (v1, v2) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), arg3, 0x2::balance::split<T1>(&mut v0, arg5), 0, arg6);
        0x2::balance::join<T1>(&mut v0, v2);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v0, 0x2::tx_context::sender(arg7), arg7);
        0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg7), arg7);
    }

    public fun swap2pool_provide_y_return_balance<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T1>(arg4);
        let (v1, v2) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), arg3, 0x2::balance::split<T1>(&mut v0, arg5), 0, arg6);
        0x2::balance::join<T1>(&mut v0, v2);
        (v1, v0)
    }

    public fun swap2pool_return_balance<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg6);
        if (arg4 > 0) {
            let (v2, v3) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::split<T0>(&mut v0, arg4), arg5, 0x2::balance::zero<T1>(), arg8, arg9);
            0x2::balance::join<T0>(&mut v0, v2);
            0x2::balance::join<T1>(&mut v1, v3);
        } else {
            let (v4, v5) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap<T0, T1, T2, T3, T4>(arg0, arg1, arg2, 0x2::balance::zero<T0>(), arg5, 0x2::balance::split<T1>(&mut v1, arg7), arg8, arg9);
            0x2::balance::join<T0>(&mut v0, v4);
            0x2::balance::join<T1>(&mut v1, v5);
        };
        (v0, v1)
    }

    public fun swap2pool_with_rewards<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::PoolRegistry, arg2: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::LiquidityPool<T0, T1, T2>, arg3: &mut 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::honeyjar::HoneyJar, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: bool, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg4);
        let v1 = 0x2::coin::into_balance<T1>(arg7);
        if (arg5 > 0) {
            let (v2, v3) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap_with_rewards<T0, T1, T2, T3, T4>(arg0, arg1, arg3, arg2, 0x2::balance::split<T0>(&mut v0, arg5), arg6, 0x2::balance::zero<T1>(), arg9, arg10);
            0x2::balance::join<T0>(&mut v0, v2);
            0x2::balance::join<T1>(&mut v1, v3);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg11), arg11);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg11), arg11);
        } else {
            let (v4, v5) = 0x15ac50726be9928bda9ab3f369aaf88d8c40d6605259cc49ee58734597f111c::amm::swap_with_rewards<T0, T1, T2, T3, T4>(arg0, arg1, arg3, arg2, 0x2::balance::zero<T0>(), arg6, 0x2::balance::split<T1>(&mut v1, arg8), arg9, arg10);
            0x2::balance::join<T0>(&mut v0, v4);
            0x2::balance::join<T1>(&mut v1, v5);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T0>(v0, 0x2::tx_context::sender(arg11), arg11);
            0x403f5ab973aa723635e07e8b98b1008a09ab4a8452c8af3c04e04e8142e53aa::coin_helper::destroy_or_transfer_balance<T1>(v1, 0x2::tx_context::sender(arg11), arg11);
        };
    }

    // decompiled from Move bytecode v6
}

