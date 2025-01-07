module 0x283e426c6a944ec357724079450f7398729d9fafad7d4c725a59ea66703b9c4::router {
    public entry fun add_liquidity_to_2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>(0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::add_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), arg6), v2, arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v3, arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v1, v4, arg7);
    }

    public entry fun add_liquidity_to_2pool_only_x<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_2pool<T0, T1, T2>(arg0, arg1, arg2, arg3, v0, 0, arg4, arg5);
    }

    public entry fun add_liquidity_to_2pool_only_y<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        add_liquidity_to_2pool<T0, T1, T2>(arg0, arg1, v0, 0, arg2, arg3, arg4, arg5);
    }

    public entry fun add_liquidity_to_3pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: 0x2::coin::Coin<T2>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = 0x2::coin::into_balance<T2>(arg6);
        let v3 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>(0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::add_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0x2::balance::split<T1>(&mut v1, arg5), 0x2::balance::split<T2>(&mut v2, arg7), arg8), v3, arg9);
        let v4 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T0>(v0, v4, arg9);
        let v5 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T1>(v1, v5, arg9);
        let v6 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<T2>(v2, v6, arg9);
    }

    public entry fun add_liquidity_to_3pool_only_x<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5);
        add_liquidity_to_3pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, v0, 0, v1, 0, arg4, arg5);
    }

    public entry fun add_liquidity_to_3pool_only_y<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let v1 = 0x2::coin::from_balance<T2>(0x2::balance::zero<T2>(), arg5);
        add_liquidity_to_3pool<T0, T1, T2, T3>(arg0, arg1, v0, 0, arg2, arg3, v1, 0, arg4, arg5);
    }

    public entry fun add_liquidity_to_3pool_only_z<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T2>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg5);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg5);
        add_liquidity_to_3pool<T0, T1, T2, T3>(arg0, arg1, v0, 0, v1, 0, arg2, arg3, arg4, arg5);
    }

    public entry fun collect_fee_for_three_pool<T0, T1, T2, T3>(arg0: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg1: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::FeeCollector<T0>, arg2: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::FeeCollector<T1>, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::FeeCollector<T2>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::collect_fee_for_pool<T0, T1, T2, T3>(arg0, arg1, arg2, arg3);
    }

    public entry fun collect_fee_for_two_pool<T0, T1, T2>(arg0: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg1: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::FeeCollector<T0>, arg2: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::FeeCollector<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::collect_fee_for_pool<T0, T1, T2>(arg0, arg1, arg2);
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

    public fun deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg4: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg5: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::coin::CoinMetadata<T1>, arg10: vector<u64>, arg11: vector<u256>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg4);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::deployer_register_pool_both_coin_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, arg10, 0x1::option::some<vector<u256>>(arg11), 0x1::option::some<vector<u64>>(arg12), arg13)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg11, arg12);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::deployer_register_pool_both_coin_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg9, arg8, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
        };
        let v4 = 0x2::tx_context::sender(arg13);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg13);
    }

    public fun deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg4: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg5: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg4);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::deployer_register_pool_x_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg10, arg11);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::deployer_register_pool_y_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::DegenHiveDeployerCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg4: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg5: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg6: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg4);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::deployer_register_pool_y_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg10, arg11);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::deployer_register_pool_x_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_sorted_order_three_coin<T0, T1, T2, T3>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg1: u8, arg2: u8, arg3: u8) : vector<u8> {
        if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::is_curved<T3>()) {
            if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T0, T1>()) {
                get_sorted_order_three_coin<T1, T0, T2, T3>(arg0, arg2, arg1, arg3)
            } else if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T1, T2>()) {
                get_sorted_order_three_coin<T0, T2, T1, T3>(arg0, arg1, arg3, arg2)
            } else {
                create_three_coin_vector(arg1, arg2, arg3)
            }
        } else if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::is_stable_identifier<T0>(arg0)) {
            if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T1, T2>()) {
                create_three_coin_vector(arg1, arg3, arg2)
            } else {
                create_three_coin_vector(arg1, arg2, arg3)
            }
        } else if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::is_stable_identifier<T1>(arg0)) {
            if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T0, T2>()) {
                create_three_coin_vector(arg2, arg3, arg1)
            } else {
                create_three_coin_vector(arg2, arg1, arg3)
            }
        } else if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::is_stable_identifier<T2>(arg0)) {
            if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T0, T1>()) {
                create_three_coin_vector(arg3, arg2, arg1)
            } else {
                create_three_coin_vector(arg3, arg1, arg2)
            }
        } else if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T0, T1>()) {
            get_sorted_order_three_coin<T1, T0, T2, T3>(arg0, arg2, arg1, arg3)
        } else if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T1, T2>()) {
            get_sorted_order_three_coin<T0, T2, T1, T3>(arg0, arg1, arg3, arg2)
        } else {
            create_three_coin_vector(arg1, arg2, arg3)
        }
    }

    public fun get_sorted_order_two_coin<T0, T1, T2>(arg0: &0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config) : vector<u8> {
        if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::is_curved<T2>()) {
            if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T0, T1>()) {
                create_two_coin_vector(1, 0)
            } else {
                create_two_coin_vector(0, 1)
            }
        } else if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::is_stable_identifier<T0>(arg0)) {
            create_two_coin_vector(0, 1)
        } else if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::is_stable_identifier<T1>(arg0)) {
            create_two_coin_vector(1, 0)
        } else if (!0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::coin_helper::is_sorted<T0, T1>()) {
            create_two_coin_vector(1, 0)
        } else {
            create_two_coin_vector(0, 1)
        }
    }

    fun get_three_coin_ordered_weights_and_prices<T0>(arg0: vector<u256>, arg1: vector<u64>, arg2: vector<u8>) : (vector<u256>, vector<u64>) {
        let v0 = (*0x1::vector::borrow<u8>(&arg2, 0) as u64);
        let v1 = (*0x1::vector::borrow<u8>(&arg2, 1) as u64);
        let v2 = (*0x1::vector::borrow<u8>(&arg2, 2) as u64);
        let v3 = if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::is_weighted<T0>()) {
            let v4 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&mut arg1, v0));
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&mut arg1, v1));
            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&mut arg1, v2));
            v4
        } else {
            arg1
        };
        let v5 = if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::is_curved<T0>()) {
            let v6 = 0x1::vector::empty<u256>();
            0x1::vector::push_back<u256>(&mut v6, *0x1::vector::borrow<u256>(&mut arg0, v0));
            0x1::vector::push_back<u256>(&mut v6, *0x1::vector::borrow<u256>(&mut arg0, v1));
            0x1::vector::push_back<u256>(&mut v6, *0x1::vector::borrow<u256>(&mut arg0, v2));
            v6
        } else {
            arg0
        };
        (v5, v3)
    }

    fun get_two_coin_ordered_weights_and_prices<T0>(arg0: vector<u256>, arg1: vector<u64>) : (vector<u256>, vector<u64>) {
        let v0 = if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::is_weighted<T0>()) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&mut arg1, 1));
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&mut arg1, 0));
            v1
        } else {
            arg1
        };
        let v2 = if (0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::curves::is_curved<T0>()) {
            let v3 = 0x1::vector::empty<u256>();
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&mut arg0, 1));
            0x1::vector::push_back<u256>(&mut v3, *0x1::vector::borrow<u256>(&mut arg0, 0));
            v3
        } else {
            arg0
        };
        (v2, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun register_three_pool_all_coin_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: &0x2::coin::CoinMetadata<T2>, arg10: vector<u64>, arg11: vector<u256>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_all_coin_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, arg10, 0x1::option::some<vector<u256>>(arg11), 0x1::option::some<vector<u64>>(arg12), arg13)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg11, arg12, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_all_coin_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg9, arg8, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_all_coin_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_all_coin_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg9, arg7, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_all_coin_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg9, arg7, arg8, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_all_coin_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg9, arg8, arg7, arg10, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg13)
            }
        };
        let v4 = 0x2::tx_context::sender(arg13);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg13);
    }

    public fun register_three_pool_no_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_no_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg8, arg9, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_no_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_no_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_no_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_no_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_no_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
            }
        };
        let v4 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg10);
    }

    public fun register_three_pool_x_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg9, arg10, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_z_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_z_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            }
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_three_pool_x_y_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_y_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg10, arg11, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_z_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_y_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_z_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_z_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_z_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            }
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_three_pool_x_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_z_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg10, arg11, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_y_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_z_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_z_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_y_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_z_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            }
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_three_pool_y_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg9, arg10, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_z_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_z_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            }
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_three_pool_y_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: &0x2::coin::CoinMetadata<T2>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_z_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg10, arg11, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_z_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_z_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_y_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_z_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_y_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
            }
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_three_pool_z_metadata_available<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T2>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_three_coin<T0, T1, T2, T3>(arg3, 0, 1, 2);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 1) {
            0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_z_metadata_available<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_three_coin_ordered_weights_and_prices<T3>(arg9, arg10, v0);
            if (*0x1::vector::borrow<u8>(&v0, 0) == 0 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_metadata_available<T0, T2, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_z_metadata_available<T1, T0, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 1 && *0x1::vector::borrow<u8>(&v0, 1) == 2) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_y_metadata_available<T1, T2, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else if (*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 0) {
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_metadata_available<T2, T0, T1, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, 0) == 2 && *0x1::vector::borrow<u8>(&v0, 1) == 1, 2);
                0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::register_pool_x_metadata_available<T2, T1, T0, T3>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
            }
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_two_pool_both_coin_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::coin::CoinMetadata<T1>, arg9: vector<u64>, arg10: vector<u256>, arg11: vector<u64>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_both_coin_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, arg9, 0x1::option::some<vector<u256>>(arg10), 0x1::option::some<vector<u64>>(arg11), arg12)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg10, arg11);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_both_coin_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg8, arg7, arg9, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg12)
        };
        let v4 = 0x2::tx_context::sender(arg12);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg12);
    }

    public fun register_two_pool_no_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u64>, arg8: vector<u256>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_no_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(arg8), 0x1::option::some<vector<u64>>(arg9), arg10)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg8, arg9);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_no_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg10)
        };
        let v4 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg10);
    }

    public fun register_two_pool_x_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T0>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_x_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg9, arg10);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_y_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public fun register_two_pool_y_metadata_available<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xb64dfb9fda533f2db8feeeb67dd2fd95ce188c20efca9322e64c106218e2efad::hsui_vault::HSuiVault, arg3: &mut 0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::config::Config, arg4: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::PoolRegistry, arg5: &mut 0x8fe8110530c0e58b0003276f4fc026ca3f58c0285e90a6994092b983231581ee::hive_profile::HSuiDisperser<0xdf1c75d8d389d064d8cc0a3c2578aac4441b3bcd9da63751cb581ccbd3b6d27::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<T1>, arg8: vector<u64>, arg9: vector<u256>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = get_sorted_order_two_coin<T0, T1, T2>(arg3);
        let v1 = if (*0x1::vector::borrow<u8>(&v0, 0) == 0) {
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_y_metadata_available<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(arg9), 0x1::option::some<vector<u64>>(arg10), arg11)
        } else {
            let (v2, v3) = get_two_coin_ordered_weights_and_prices<T2>(arg9, arg10);
            0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::register_pool_x_metadata_available<T1, T0, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg7, arg8, 0x1::option::some<vector<u256>>(v2), 0x1::option::some<vector<u64>>(v3), arg11)
        };
        let v4 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v1, v4, arg11);
    }

    public entry fun remove_liquidity_from_2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>(arg2);
        if (arg3 == 0) {
            let (v1, v2, v3) = 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::remove_liquidity<T0, T1, T2>(arg0, arg1, v0, arg4, arg5, arg6);
            let v4 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T0>(v1, v4, arg7);
            let v5 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T1>(v2, v5, arg7);
            let v6 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>(v3, v6, arg7);
        } else {
            let (v7, v8, v9) = 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::remove_liquidity<T0, T1, T2>(arg0, arg1, 0x2::balance::split<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>(&mut v0, arg3), arg4, arg5, arg6);
            0x2::balance::join<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>(&mut v0, v9);
            let v10 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T0>(v7, v10, arg7);
            let v11 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<T1>(v8, v11, arg7);
            let v12 = 0x2::tx_context::sender(arg7);
            destroy_or_transfer_balance<0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LP<T0, T1, T2>>(v0, v12, arg7);
        };
    }

    public entry fun remove_liquidity_from_3pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>(arg2);
        if (arg3 == 0) {
            let (v1, v2, v3, v4) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::remove_liquidity<T0, T1, T2, T3>(arg0, arg1, v0, arg4, arg5, arg6, arg7);
            let v5 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T0>(v1, v5, arg8);
            let v6 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T1>(v2, v6, arg8);
            let v7 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T2>(v3, v7, arg8);
            let v8 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>(v4, v8, arg8);
        } else {
            let (v9, v10, v11, v12) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::remove_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>(&mut v0, arg3), arg4, arg5, arg6, arg7);
            0x2::balance::join<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>(&mut v0, v12);
            let v13 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T0>(v9, v13, arg8);
            let v14 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T1>(v10, v14, arg8);
            let v15 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<T2>(v11, v15, arg8);
            let v16 = 0x2::tx_context::sender(arg8);
            destroy_or_transfer_balance<0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LP<T0, T1, T2, T3>>(v0, v16, arg8);
        };
    }

    public entry fun swap2pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        if (arg3 > 0) {
            let (v2, v3) = 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), arg4, 0x2::balance::zero<T1>(), arg7, arg8);
            0x2::balance::join<T0>(&mut v0, v2);
            0x2::balance::join<T1>(&mut v1, v3);
            let v4 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T0>(v0, v4, arg9);
            let v5 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T1>(v1, v5, arg9);
        } else {
            let (v6, v7) = 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::split<T1>(&mut v1, arg6), arg7, arg8);
            0x2::balance::join<T0>(&mut v0, v6);
            0x2::balance::join<T1>(&mut v1, v7);
            let v8 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T0>(v0, v8, arg9);
            let v9 = 0x2::tx_context::sender(arg9);
            destroy_or_transfer_balance<T1>(v1, v9, arg9);
        };
    }

    public entry fun swap2pool_provide_x<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2) = 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0, 0x2::balance::zero<T1>(), arg4, arg5);
        0x2::balance::join<T0>(&mut v0, v1);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T0>(v0, v3, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v2, v4, arg6);
    }

    public entry fun swap2pool_provide_y<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::LiquidityPool<T0, T1, T2>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2) = 0x96ab5fd8a6c2502d56fc276f52d13f37977042b6c2d83c8fd96ea2fb94f25262::two_pool::swap<T0, T1, T2>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::split<T1>(&mut v0, arg4), 0, arg5);
        0x2::balance::join<T1>(&mut v0, v2);
        let v3 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T1>(v0, v3, arg6);
        let v4 = 0x2::tx_context::sender(arg6);
        destroy_or_transfer_balance<T0>(v1, v4, arg6);
    }

    public entry fun swap3pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T2>, arg9: u64, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg5);
        let v2 = 0x2::coin::into_balance<T2>(arg8);
        if (arg3 > 0) {
            let (v3, v4, v5) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), arg4, 0x2::balance::zero<T1>(), arg7, 0x2::balance::zero<T2>(), arg10, arg11);
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
            let (v9, v10, v11) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::split<T1>(&mut v1, arg6), arg7, 0x2::balance::zero<T2>(), arg10, arg11);
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
            let (v15, v16, v17) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg4, 0x2::balance::zero<T1>(), arg7, 0x2::balance::split<T2>(&mut v2, arg9), arg10, arg11);
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

    public entry fun swap3pool_provideX<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let (v1, v2, v3) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::split<T0>(&mut v0, arg3), 0, 0x2::balance::zero<T1>(), arg4, 0x2::balance::zero<T2>(), arg5, arg6);
        0x2::balance::join<T0>(&mut v0, v1);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v3, v6, arg7);
    }

    public entry fun swap3pool_provideY<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let (v1, v2, v3) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::split<T1>(&mut v0, arg4), 0, 0x2::balance::zero<T2>(), arg5, arg6);
        0x2::balance::join<T1>(&mut v0, v2);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v1, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v3, v6, arg7);
    }

    public entry fun swap3pool_provideZ<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        let (v1, v2, v3) = 0x2bce43335a7071446260931d679d4809e551d04f8600c6b1505e20b00b0dfe1::three_pool::swap<T0, T1, T2, T3>(arg0, arg1, 0x2::balance::zero<T0>(), arg2, 0x2::balance::zero<T1>(), arg3, 0x2::balance::split<T2>(&mut v0, arg5), 0, arg6);
        0x2::balance::join<T2>(&mut v0, v3);
        let v4 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T2>(v0, v4, arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T0>(v1, v5, arg7);
        let v6 = 0x2::tx_context::sender(arg7);
        destroy_or_transfer_balance<T1>(v2, v6, arg7);
    }

    // decompiled from Move bytecode v6
}

