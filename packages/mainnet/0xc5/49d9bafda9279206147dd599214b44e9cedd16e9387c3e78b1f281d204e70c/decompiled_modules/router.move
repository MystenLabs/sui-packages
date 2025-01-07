module 0xc549d9bafda9279206147dd599214b44e9cedd16e9387c3e78b1f281d204e70c::router {
    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg4: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg5: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg6: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: vector<u64>, arg11: vector<u256>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg4);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, arg10, 0x1::option::some<vector<u256>>(arg11), 0x1::option::some<vector<u64>>(arg12), arg13)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg11, arg12);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::deployer_register_pool_both_coin_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg9, arg8, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
        };
        let v4 = 0x2::tx_context::sender(arg13);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg13);
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg4: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg5: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg6: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg4);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg10, arg11);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::deployer_register_pool_y_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg4: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg5: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg6: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg4);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg10, arg11);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::deployer_register_pool_x_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public entry fun add_liquidity_to_2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>(0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), arg6), v2, arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v3, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v1, v4, arg7);
    }

    public entry fun add_liquidity_to_2pool_only_x<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_2pool<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, 0, arg4, arg5);
    }

    public fun add_liquidity_to_2pool_only_x_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>> {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_2pool_return_balance<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, 0, arg4, arg5)
    }

    public entry fun add_liquidity_to_2pool_only_y<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        add_liquidity_to_2pool<T0, T1, T2>(arg0, arg1, v0, 0, arg2, arg3, arg4, arg5);
    }

    public fun add_liquidity_to_2pool_only_y_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>> {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        add_liquidity_to_2pool_return_balance<T0, T1, T2>(arg0, arg1, v0, 0, arg2, arg3, arg4, arg5)
    }

    public fun add_liquidity_to_2pool_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v2, arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v1, v3, arg7);
        0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), arg6)
    }

    public entry fun add_liquidity_to_3pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: 0x2::coin::Coin<T2>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = 0x2::coin::into_balance<T2>(arg6);
        let v3 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>(0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::add_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), 0x2::balance::split<T2>(&mut v2, arg7), arg8), v3, arg9);
        let v4 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T0>(v0, v4, arg9);
        let v5 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T1>(v1, v5, arg9);
        let v6 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T2>(v2, v6, arg9);
    }

    public entry fun add_liquidity_to_3pool_only_x<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5);
        add_liquidity_to_3pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, v0, 0, v1, 0, arg4, arg5);
    }

    public fun add_liquidity_to_3pool_only_x_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>> {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5);
        add_liquidity_to_3pool_return_balance<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, v0, 0, v1, 0, arg4, arg5)
    }

    public entry fun add_liquidity_to_3pool_only_y<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5);
        add_liquidity_to_3pool<T0, T1, T2, T3>(arg0, arg1, v0, 0, arg2, arg3, v1, 0, arg4, arg5);
    }

    public fun add_liquidity_to_3pool_only_y_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>> {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5);
        add_liquidity_to_3pool_return_balance<T0, T1, T2, T3>(arg0, arg1, v0, 0, arg2, arg3, v1, 0, arg4, arg5)
    }

    public entry fun add_liquidity_to_3pool_only_z<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_3pool<T0, T1, T2, T3>(arg0, arg1, v0, 0, v1, 0, arg2, arg3, arg4, arg5);
    }

    public fun add_liquidity_to_3pool_only_z_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>> {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_3pool_return_balance<T0, T1, T2, T3>(arg0, arg1, v0, 0, v1, 0, arg2, arg3, arg4, arg5)
    }

    public fun add_liquidity_to_3pool_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: 0x2::coin::Coin<T2>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>> {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = 0x2::coin::into_balance<T2>(arg6);
        let v3 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T0>(v0, v3, arg9);
        let v4 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T1>(v1, v4, arg9);
        let v5 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T2>(v2, v5, arg9);
        0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::add_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), 0x2::balance::split<T2>(&mut v2, arg7), arg8)
    }

    fun create_three_coin_vector(arg0: u8, arg1: u8, arg2: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x1::vector::push_back<u8>(&mut v0, arg2);
        v0
    }

    fun create_two_coin_vector(arg0: u8, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, arg0);
        0x1::vector::push_back<u8>(&mut v0, arg1);
        v0
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_sorted_order_three_coin<T0, T1, T2, T3>(arg0: &0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg1: u8, arg2: u8, arg3: u8) : vector<u8> {
        if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::curves::is_curved<T3>()) {
            if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T0, T1>()) {
                get_sorted_order_three_coin<T1, T0, T2, T3>(arg0, arg2, arg1, arg3)
            } else if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T1, T2>()) {
                get_sorted_order_three_coin<T0, T2, T1, T3>(arg0, arg1, arg3, arg2)
            } else {
                create_three_coin_vector(arg1, arg2, arg3)
            }
        } else if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::is_stable_identifier<T0>(arg0)) {
            if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T1, T2>()) {
                create_three_coin_vector(arg1, arg3, arg2)
            } else {
                create_three_coin_vector(arg1, arg2, arg3)
            }
        } else if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::is_stable_identifier<T1>(arg0)) {
            if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T0, T2>()) {
                create_three_coin_vector(arg2, arg3, arg1)
            } else {
                create_three_coin_vector(arg2, arg1, arg3)
            }
        } else if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::is_stable_identifier<T2>(arg0)) {
            if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T0, T1>()) {
                create_three_coin_vector(arg3, arg2, arg1)
            } else {
                create_three_coin_vector(arg3, arg1, arg2)
            }
        } else if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T0, T1>()) {
            get_sorted_order_three_coin<T1, T0, T2, T3>(arg0, arg2, arg1, arg3)
        } else if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T1, T2>()) {
            get_sorted_order_three_coin<T0, T2, T1, T3>(arg0, arg1, arg3, arg2)
        } else {
            create_three_coin_vector(arg1, arg2, arg3)
        }
    }

    public fun get_sorted_order_two_coin<T0, T1, T2>(arg0: &0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config) : vector<u8> {
        if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::curves::is_curved<T2>()) {
            if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T0, T1>()) {
                create_two_coin_vector(1, 0)
            } else {
                create_two_coin_vector(0, 1)
            }
        } else if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::is_stable_identifier<T0>(arg0)) {
            create_two_coin_vector(0, 1)
        } else if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::is_stable_identifier<T1>(arg0)) {
            create_two_coin_vector(1, 0)
        } else if (!0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::coin_helper::is_sorted<T0, T1>()) {
            create_two_coin_vector(1, 0)
        } else {
            create_two_coin_vector(0, 1)
        }
    }

    fun get_three_coin_ordered_weights_and_prices<T0>(arg0: vector<u256>, arg1: vector<u64>, arg2: vector<u8>) : (vector<u256>, vector<u64>) {
        let v0 = (*0x1::vector::borrow<u8>(&arg2, 0) as u64);
        let v1 = (*0x1::vector::borrow<u8>(&arg2, 1) as u64);
        let v2 = (*0x1::vector::borrow<u8>(&arg2, 2) as u64);
        let v3 = if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::curves::is_weighted<T0>()) {
            let v4 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&arg1, v0));
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&arg1, v1));
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&arg1, v2));
            v4
        } else {
            arg1
        };
        let v5 = if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::curves::is_curved<T0>()) {
            let v6 = 0x1::vector::empty<u256>();
            0x1::vector::push_back<u256>(&mut v6, *0x1::vector::borrow<u256>(&arg0, v0));
            0x1::vector::push_back<u256>(&mut v6, *0x1::vector::borrow<u256>(&arg0, v1));
            0x1::vector::push_back<u256>(&mut v6, *0x1::vector::borrow<u256>(&arg0, v2));
            v6
        } else {
            arg0
        };
        (v5, v3)
    }

    fun get_two_coin_ordered_weights_and_prices<T0>(arg0: vector<u256>, arg1: vector<u64>) : (vector<u256>, vector<u64>) {
        let v0 = if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::curves::is_weighted<T0>()) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg1, 1));
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&arg1, 0));
            v1
        } else {
            arg1
        };
        let v2 = if (0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::curves::is_curved<T0>()) {
            let v3 = 0x1::vector::empty<u256>();
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&arg0, 1));
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&arg0, 0));
            v3
        } else {
            arg0
        };
        (v2, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun register_three_pool_all_coin_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: &0x2::coin::CoinMetadata<T2>, arg10: vector<u64>, arg11: vector<u256>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_all_coin_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, arg10, 0x1::option::some<vector<u256>>(arg11), 0x1::option::some<vector<u64>>(arg12), arg13)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg11, arg12, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_all_coin_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg9, arg8, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_all_coin_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_all_coin_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg9, arg7, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_all_coin_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg9, arg7, arg8, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_all_coin_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg9, arg8, arg7, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            }
        };
        let v4 = 0x2::tx_context::sender(arg13);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg13);
    }

    public fun register_three_pool_no_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_no_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg8, arg9, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_no_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_no_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_no_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_no_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_no_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            }
        };
        let v4 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg10);
    }

    public fun register_three_pool_x_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg9, arg10, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_z_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_z_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            }
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_three_pool_x_y_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_y_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg10, arg11, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_z_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_y_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_z_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_z_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_z_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            }
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_three_pool_x_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_z_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg10, arg11, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_y_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_z_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_z_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_y_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_z_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            }
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_three_pool_y_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg9, arg10, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_z_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_z_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            }
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_three_pool_y_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_z_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg10, arg11, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_z_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_z_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_y_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_z_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_y_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            }
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_three_pool_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T2>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_z_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg9, arg10, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_z_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_y_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::register_pool_x_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            }
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_two_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_both_coin_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg10, arg11);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_both_coin_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_two_pool_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_no_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg8, arg9);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_no_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
        };
        let v4 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg10);
    }

    public fun register_two_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_x_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg9, arg10);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_y_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_two_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x15e885fafd862469b64c04a7e0da9d46e06429283e51d7fae0981a8a9d68ba5c::hsui_vault::HSuiVault, arg3: &mut 0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::config::Config, arg4: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::PoolRegistry, arg5: &mut 0x4b5d50178f0510ba6e1f13f7a104c7213adc4542f9d0511c483a9575546b2190::hive_profile::HSuiDisperser<0x37a0fdbfe809f23fe6f8a5e4b7f350b77019823e8f5c54b9382508578ff573c3::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_y_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg9, arg10);
            0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::register_pool_x_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public entry fun remove_liquidity_from_2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>(arg2);
        if (arg3 == 0) {
            let (v1, v2, v3) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::remove_liquidity<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg6);
            let v4 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T0>(v1, v4, arg7);
            let v5 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T1>(v2, v5, arg7);
            let v6 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>(v3, v6, arg7);
        } else {
            let (v7, v8, v9) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::remove_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>(&mut v0, arg3), arg4, arg5, arg6);
            0x2::balance::join<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>(&mut v0, v9);
            let v10 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T0>(v7, v10, arg7);
            let v11 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T1>(v8, v11, arg7);
            let v12 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LP<T0, T1, T2>>(v0, v12, arg7);
        };
    }

    public entry fun remove_liquidity_from_3pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>(arg2);
        if (arg3 == 0) {
            let (v1, v2, v3, v4) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::remove_liquidity<T0, T1, T2, T3>(arg0, arg1, v0, arg4, arg5, arg6, arg7);
            let v5 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T0>(v1, v5, arg8);
            let v6 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T1>(v2, v6, arg8);
            let v7 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T2>(v3, v7, arg8);
            let v8 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>(v4, v8, arg8);
        } else {
            let (v9, v10, v11, v12) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::remove_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>(&mut v0, arg3), arg4, arg5, arg6, arg7);
            0x2::balance::join<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>(&mut v0, v12);
            let v13 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T0>(v9, v13, arg8);
            let v14 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T1>(v10, v14, arg8);
            let v15 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T2>(v11, v15, arg8);
            let v16 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LP<T0, T1, T2, T3>>(v0, v16, arg8);
        };
    }

    public entry fun swap2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        if (arg3 > 0) {
            let (v2, v3) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), arg4, 0x2::balance::zero<T1>(), arg7, arg8);
            0x2::balance::join<T0>(&mut v0, v2);
            0x2::balance::join<T1>(&mut v1, v3);
            let v4 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T0>(v0, v4, arg9);
            let v5 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T1>(v1, v5, arg9);
        } else {
            let (v6, v7) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::split<T1>(&mut v1, arg6), arg7, arg8);
            0x2::balance::join<T0>(&mut v0, v6);
            0x2::balance::join<T1>(&mut v1, v7);
            let v8 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T0>(v0, v8, arg9);
            let v9 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T1>(v1, v9, arg9);
        };
    }

    public entry fun swap2pool_provide_x<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0, 0x2::balance::zero<T1>(), arg4, arg5);
        0x2::balance::join<T0>(&mut v0, v1);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T0>(v0, v3, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v2, v4, arg6);
    }

    public fun swap2pool_provide_x_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0, 0x2::balance::zero<T1>(), arg4, arg5);
        0x2::balance::join<T0>(&mut v0, v1);
        (v0, v2)
    }

    public entry fun swap2pool_provide_y<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::split<T1>(&mut v0, arg4), 0, arg5);
        0x2::balance::join<T1>(&mut v0, v2);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v0, v3, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T0>(v1, v4, arg6);
    }

    public fun swap2pool_provide_y_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::split<T1>(&mut v0, arg4), 0, arg5);
        0x2::balance::join<T1>(&mut v0, v2);
        (v1, v0)
    }

    public fun swap2pool_return_balance<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        if (arg3 > 0) {
            let (v2, v3) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), arg4, 0x2::balance::zero<T1>(), arg7, arg8);
            0x2::balance::join<T0>(&mut v0, v2);
            0x2::balance::join<T1>(&mut v1, v3);
        } else {
            let (v4, v5) = 0xab8d514de87aaf42bb089daa4ff846c220f6ba97d889bbe0e88f338e84bc4202::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::split<T1>(&mut v1, arg6), arg7, arg8);
            0x2::balance::join<T0>(&mut v0, v4);
            0x2::balance::join<T1>(&mut v1, v5);
        };
        (v0, v1)
    }

    public entry fun swap3pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let v2 = 0x2::coin::into_balance<T2>(arg8);
        if (arg3 > 0) {
            let (v3, v4, v5) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), arg4, 0x2::balance::zero<T1>(), arg7, 0x2::balance::zero<T2>(), arg10, arg11);
            0x2::balance::join<T0>(&mut v0, v3);
            0x2::balance::join<T1>(&mut v1, v4);
            0x2::balance::join<T2>(&mut v2, v5);
            let v6 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T0>(v0, v6, arg12);
            let v7 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T1>(v1, v7, arg12);
            let v8 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T2>(v2, v8, arg12);
        } else if (arg6 > 0) {
            let (v9, v10, v11) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::split<T1>(&mut v1, arg6), arg7, 0x2::balance::zero<T2>(), arg10, arg11);
            0x2::balance::join<T0>(&mut v0, v9);
            0x2::balance::join<T1>(&mut v1, v10);
            0x2::balance::join<T2>(&mut v2, v11);
            let v12 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T0>(v0, v12, arg12);
            let v13 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T1>(v1, v13, arg12);
            let v14 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T2>(v2, v14, arg12);
        } else {
            let (v15, v16, v17) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::zero<T1>(), arg7, 0x2::balance::split<T2>(&mut v2, arg9), arg10, arg11);
            0x2::balance::join<T0>(&mut v0, v15);
            0x2::balance::join<T1>(&mut v1, v16);
            0x2::balance::join<T2>(&mut v2, v17);
            let v18 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T0>(v0, v18, arg12);
            let v19 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T1>(v1, v19, arg12);
            let v20 = 0x2::tx_context::sender(arg12);
            destroy_or_transfer_balance<T2>(v2, v20, arg12);
        };
    }

    public entry fun swap3pool_provideX<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2, v3) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0, 0x2::balance::zero<T1>(), arg4, 0x2::balance::zero<T2>(), arg5, arg6);
        0x2::balance::join<T0>(&mut v0, v1);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v3, v6, arg7);
    }

    public fun swap3pool_provideX_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2, v3) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0, 0x2::balance::zero<T1>(), arg4, 0x2::balance::zero<T2>(), arg5, arg6);
        0x2::balance::join<T0>(&mut v0, v1);
        (v0, v2, v3)
    }

    public entry fun swap3pool_provideY<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2, v3) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::split<T1>(&mut v0, arg4), 0, 0x2::balance::zero<T2>(), arg5, arg6);
        0x2::balance::join<T1>(&mut v0, v2);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v1, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v3, v6, arg7);
    }

    public fun swap3pool_provideY_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2, v3) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::split<T1>(&mut v0, arg4), 0, 0x2::balance::zero<T2>(), arg5, arg6);
        0x2::balance::join<T1>(&mut v0, v2);
        (v1, v0, v3)
    }

    public entry fun swap3pool_provideZ<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        let (v1, v2, v3) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::zero<T1>(), arg3, 0x2::balance::split<T2>(&mut v0, arg5), 0, arg6);
        0x2::balance::join<T2>(&mut v0, v3);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v1, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v6, arg7);
    }

    public fun swap3pool_provideZ_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: bool, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        let (v1, v2, v3) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::zero<T1>(), arg3, 0x2::balance::split<T2>(&mut v0, arg5), 0, arg6);
        0x2::balance::join<T2>(&mut v0, v3);
        (v1, v2, v0)
    }

    public fun swap3pool_return_balance<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let v2 = 0x2::coin::into_balance<T2>(arg8);
        if (arg3 > 0) {
            let (v3, v4, v5) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), arg4, 0x2::balance::zero<T1>(), arg7, 0x2::balance::zero<T2>(), arg10, arg11);
            0x2::balance::join<T0>(&mut v0, v3);
            0x2::balance::join<T1>(&mut v1, v4);
            0x2::balance::join<T2>(&mut v2, v5);
        } else if (arg6 > 0) {
            let (v6, v7, v8) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::split<T1>(&mut v1, arg6), arg7, 0x2::balance::zero<T2>(), arg10, arg11);
            0x2::balance::join<T0>(&mut v0, v6);
            0x2::balance::join<T1>(&mut v1, v7);
            0x2::balance::join<T2>(&mut v2, v8);
        } else {
            let (v9, v10, v11) = 0x3e57ad73202188fc5aae42a1d2be522e913a301fbb08e6e735bce22564f348b9::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::zero<T1>(), arg7, 0x2::balance::split<T2>(&mut v2, arg9), arg10, arg11);
            0x2::balance::join<T0>(&mut v0, v9);
            0x2::balance::join<T1>(&mut v1, v10);
            0x2::balance::join<T2>(&mut v2, v11);
        };
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

