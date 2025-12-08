module 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::pool_script {
    fun swap<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::stats::Stats, arg11: &0x8bb9f5926f9464cd033391d05e077ddf9aab3a80fa17cce40d81ac6ad2b66ecb::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T1>(arg4, arg13);
        let v1 = 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T0>(arg3, arg13);
        let (v2, v3, v4) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg9, arg10, arg11, arg12);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::swap_pay_amount<T0, T1>(&v5);
        let v9 = if (arg5) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        if (arg6) {
            assert!(v8 == arg7, 2);
            assert!(v9 >= arg8, 1);
        } else {
            assert!(v9 == arg7, 2);
            assert!(v8 <= arg8, 0);
        };
        let (v10, v11) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, v8, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, v8, arg13)))
        };
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v6, arg13));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v7, arg13));
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::repay_flash_swap<T0, T1>(arg0, arg2, v10, v11, v5);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg13));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(v0, 0x2::tx_context::sender(arg13));
    }

    public entry fun add_liquidity_fix_coin_only_a<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg3, arg5, true, arg6);
        repay_add_liquidity<T0, T1>(arg0, arg2, v0, arg4, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg5, 0, arg7);
    }

    public entry fun add_liquidity_fix_coin_only_b<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg3, arg5, false, arg6);
        repay_add_liquidity<T0, T1>(arg0, arg2, v0, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg4, 0, arg5, arg7);
    }

    public entry fun add_liquidity_fix_coin_with_all<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg8) {
            arg6
        } else {
            arg7
        };
        let v1 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg3, v0, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg2, v1, arg4, arg5, arg6, arg7, arg10);
    }

    public entry fun add_liquidity_only_a<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7);
        repay_add_liquidity<T0, T1>(arg0, arg2, v0, arg4, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg5, 0, arg8);
    }

    public entry fun add_liquidity_only_b<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7);
        repay_add_liquidity<T0, T1>(arg0, arg2, v0, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg4, 0, arg5, arg8);
    }

    public entry fun add_liquidity_with_all<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg2, v0, arg4, arg5, arg6, arg7, arg10);
    }

    public entry fun close_position<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(&arg3);
        if (v0 > 0) {
            let v1 = &mut arg3;
            remove_liquidity<T0, T1>(arg0, arg1, arg2, v1, v0, arg4, arg5, arg6, arg7);
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::close_position<T0, T1>(arg0, arg2, arg3);
    }

    public entry fun collect_fee<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun collect_protocol_fee<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_protocol_fee<T0, T1>(arg0, arg1, arg2);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg2), 0x2::tx_context::sender(arg2));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T2>(0x2::coin::from_balance<T2>(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg4), arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun create_pool<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: address, arg6: address, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::create_pool<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun create_pool_with_liquidity_only_a<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::Pools, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: vector<0x2::coin::Coin<T0>>, arg7: u32, arg8: u32, arg9: u64, arg10: address, arg11: address, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::create_pool_with_liquidity<T0, T1>(arg2, arg0, arg1, arg3, arg4, arg5, arg7, arg8, 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T0>(arg6, arg14), 0x2::coin::zero<T1>(arg14), arg9, 0, true, arg10, arg11, arg12, arg13, arg14);
        0x2::coin::destroy_zero<T1>(v2);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(v0, 0x2::tx_context::sender(arg14));
    }

    public entry fun create_pool_with_liquidity_only_b<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::Pools, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: vector<0x2::coin::Coin<T1>>, arg7: u32, arg8: u32, arg9: u64, arg10: address, arg11: address, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::create_pool_with_liquidity<T0, T1>(arg2, arg0, arg1, arg3, arg4, arg5, arg7, arg8, 0x2::coin::zero<T0>(arg14), 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T1>(arg6, arg14), 0, arg9, false, arg10, arg11, arg12, arg13, arg14);
        0x2::coin::destroy_zero<T0>(v1);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(v2, 0x2::tx_context::sender(arg14));
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(v0, 0x2::tx_context::sender(arg14));
    }

    public entry fun create_pool_with_liquidity_with_all<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::Pools, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: vector<0x2::coin::Coin<T0>>, arg7: vector<0x2::coin::Coin<T1>>, arg8: u32, arg9: u32, arg10: u64, arg11: u64, arg12: bool, arg13: address, arg14: address, arg15: bool, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::factory::create_pool_with_liquidity<T0, T1>(arg2, arg0, arg1, arg3, arg4, arg5, arg8, arg9, 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T0>(arg6, arg17), 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T1>(arg7, arg17), arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg17));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(v2, 0x2::tx_context::sender(arg17));
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(v0, 0x2::tx_context::sender(arg17));
    }

    public entry fun initialize_rewarder<T0, T1, T2>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::initialize_rewarder<T0, T1, T2>(arg0, arg1, arg2);
    }

    public entry fun open_position<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun open_position_with_liquidity_only_a<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: vector<0x2::coin::Coin<T0>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg8);
        let v1 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, arg6, true, arg7);
        repay_add_liquidity<T0, T1>(arg0, arg2, v1, arg5, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg6, 0, arg8);
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun open_position_with_liquidity_only_b<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg8);
        let v1 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, arg6, false, arg7);
        repay_add_liquidity<T0, T1>(arg0, arg2, v1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg5, 0, arg6, arg8);
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(v0, 0x2::tx_context::sender(arg8));
    }

    public entry fun open_position_with_liquidity_with_all<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: vector<0x2::coin::Coin<T0>>, arg6: vector<0x2::coin::Coin<T1>>, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::open_position<T0, T1>(arg0, arg2, arg3, arg4, arg11);
        let v1 = if (arg9) {
            arg7
        } else {
            arg8
        };
        let v2 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, &mut v0, v1, arg9, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg2, v2, arg5, arg6, arg7, arg8, arg11);
        0x2::transfer::public_transfer<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public entry fun pause_pool<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: u128, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg5, 1);
        assert!(0x2::balance::value<T1>(&v2) >= arg6, 1);
        let (v4, v5) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_fee<T0, T1>(arg0, arg2, arg3, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v3, arg8), 0x2::tx_context::sender(arg8));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v2, arg8), 0x2::tx_context::sender(arg8));
    }

    fun repay_add_liquidity<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::AddLiquidityReceipt<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T0>(arg3, arg7);
        let v1 = 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T1>(arg4, arg7);
        let (v2, v3) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v2 <= arg5, 0);
        assert!(v3 <= arg6, 0);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v2, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v3, arg7)), arg2);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg7));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun set_display<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::set_display<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun swap_a2b<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::stats::Stats, arg9: &0x8bb9f5926f9464cd033391d05e077ddf9aab3a80fa17cce40d81ac6ad2b66ecb::price_provider::PriceProvider, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun swap_a2b_with_partner<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::partner::Partner, arg4: vector<0x2::coin::Coin<T0>>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::stats::Stats, arg10: &0x8bb9f5926f9464cd033391d05e077ddf9aab3a80fa17cce40d81ac6ad2b66ecb::price_provider::PriceProvider, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun swap_b2a<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::stats::Stats, arg9: &0x8bb9f5926f9464cd033391d05e077ddf9aab3a80fa17cce40d81ac6ad2b66ecb::price_provider::PriceProvider, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg3, false, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun swap_b2a_with_partner<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::partner::Partner, arg4: vector<0x2::coin::Coin<T1>>, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::stats::Stats, arg10: &0x8bb9f5926f9464cd033391d05e077ddf9aab3a80fa17cce40d81ac6ad2b66ecb::price_provider::PriceProvider, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg4, false, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    fun swap_with_partner<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::partner::Partner, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::stats::Stats, arg12: &0x8bb9f5926f9464cd033391d05e077ddf9aab3a80fa17cce40d81ac6ad2b66ecb::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T0>(arg4, arg14);
        let v1 = 0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::merge_coins<T1>(arg5, arg14);
        let (v2, v3, v4) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg10, arg11, arg12, arg13);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::swap_pay_amount<T0, T1>(&v5);
        let v9 = if (arg6) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        if (arg7) {
            assert!(v8 == arg8, 2);
            assert!(v9 >= arg9, 1);
        } else {
            assert!(v9 == arg8, 2);
            assert!(v8 <= arg9, 0);
        };
        let (v10, v11) = if (arg6) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v8, arg14)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v8, arg14)))
        };
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v7, arg14));
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v6, arg14));
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg2, arg3, v10, v11, v5);
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg14));
        0x9ec8246eca896aebbf457d441741344679edf07d8650a066182097a69eb23f1b::utils::send_coin<T1>(v1, 0x2::tx_context::sender(arg14));
    }

    public entry fun unpause_pool<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::unpause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun update_fee_rate<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_fee_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_pool_url<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_pool_url<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

