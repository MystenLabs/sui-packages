module 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::pool_script {
    fun swap<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::stats::Stats, arg10: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T1>(arg3, arg12);
        let v1 = 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg2, arg12);
        let (v2, v3, v4) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9, arg10, arg11);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::swap_pay_amount<T0, T1>(&v5);
        let v9 = if (arg4) {
            0x2::balance::value<T1>(&v6)
        } else {
            0x2::balance::value<T0>(&v7)
        };
        if (arg5) {
            assert!(v8 == arg6, 2);
            assert!(v9 >= arg7, 1);
        } else {
            assert!(v9 == arg6, 2);
            assert!(v8 <= arg7, 0);
        };
        let (v10, v11) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, v8, arg12)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v0, v8, arg12)))
        };
        0x2::coin::join<T1>(&mut v0, 0x2::coin::from_balance<T1>(v6, arg12));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v7, arg12));
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v10, v11, v5);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg12));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(v0, 0x2::tx_context::sender(arg12));
    }

    public entry fun create_pool<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: address, arg6: address, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::create_pool<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun close_position<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::liquidity(&arg2);
        if (v0 > 0) {
            let v1 = &mut arg2;
            remove_liquidity<T0, T1>(arg0, arg1, v1, v0, arg3, arg4, arg5, arg6);
        };
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::close_position<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun collect_protocol_fee<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::collect_protocol_fee<T0, T1>(arg0, arg1, arg2);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v0, arg2), 0x2::tx_context::sender(arg2));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T2>(0x2::coin::from_balance<T2>(0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg4), arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun initialize_rewarder<T0, T1, T2>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::initialize_rewarder<T0, T1, T2>(arg0, arg1, arg2);
    }

    public entry fun open_position<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg4, 1);
        assert!(0x2::balance::value<T1>(&v2) >= arg5, 1);
        let (v4, v5) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::collect_fee<T0, T1>(arg0, arg1, arg2, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v3, arg7), 0x2::tx_context::sender(arg7));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v2, arg7), 0x2::tx_context::sender(arg7));
    }

    fun repay_add_liquidity<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::AddLiquidityReceipt<T0, T1>, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg3, arg7);
        let v1 = 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T1>(arg4, arg7);
        let (v2, v3) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v2 <= arg5, 0);
        assert!(v3 <= arg6, 0);
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v2, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v3, arg7)), arg2);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg7));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(v1, 0x2::tx_context::sender(arg7));
    }

    public entry fun set_display<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::set_display<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun update_fee_rate<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::update_fee_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_position_url<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::update_position_url<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun add_liquidity_fix_coin_only_a<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg4, true, arg5);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, arg3, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg4, 0, arg6);
    }

    public entry fun add_liquidity_fix_coin_only_b<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, arg4, false, arg5);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg3, 0, arg4, arg6);
    }

    public entry fun add_liquidity_fix_coin_with_all<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        let v1 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v0, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, arg3, arg4, arg5, arg6, arg9);
    }

    public entry fun add_liquidity_only_a<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: vector<0x2::coin::Coin<T0>>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, arg3, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg4, 0, arg7);
    }

    public entry fun add_liquidity_only_b<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg5, arg6);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg3, 0, arg4, arg7);
    }

    public entry fun add_liquidity_with_all<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg9);
    }

    public entry fun create_pool_with_liquidity_only_a<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: vector<0x2::coin::Coin<T0>>, arg6: u32, arg7: u32, arg8: u64, arg9: address, arg10: address, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::create_pool_with_liquidity<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg6, arg7, 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg5, arg13), 0x2::coin::zero<T1>(arg13), arg8, 0, true, arg9, arg10, arg11, arg12, arg13);
        0x2::coin::destroy_zero<T1>(v2);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(v0, 0x2::tx_context::sender(arg13));
    }

    public entry fun create_pool_with_liquidity_only_b<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: vector<0x2::coin::Coin<T1>>, arg6: u32, arg7: u32, arg8: u64, arg9: address, arg10: address, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::create_pool_with_liquidity<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg6, arg7, 0x2::coin::zero<T0>(arg13), 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T1>(arg5, arg13), 0, arg8, false, arg9, arg10, arg11, arg12, arg13);
        0x2::coin::destroy_zero<T0>(v1);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(v2, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(v0, 0x2::tx_context::sender(arg13));
    }

    public entry fun create_pool_with_liquidity_with_all<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: vector<0x2::coin::Coin<T0>>, arg6: vector<0x2::coin::Coin<T1>>, arg7: u32, arg8: u32, arg9: u64, arg10: u64, arg11: bool, arg12: address, arg13: address, arg14: bool, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::factory::create_pool_with_liquidity<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg7, arg8, 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg5, arg16), 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T1>(arg6, arg16), arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg16));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(v2, 0x2::tx_context::sender(arg16));
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(v0, 0x2::tx_context::sender(arg16));
    }

    public entry fun open_position_with_liquidity_only_a<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        let v1 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, arg5, true, arg6);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, arg4, 0x1::vector::empty<0x2::coin::Coin<T1>>(), arg5, 0, arg7);
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun open_position_with_liquidity_only_b<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: vector<0x2::coin::Coin<T1>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        let v1 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, arg5, false, arg6);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg4, 0, arg5, arg7);
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(v0, 0x2::tx_context::sender(arg7));
    }

    public entry fun open_position_with_liquidity_with_all<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg10);
        let v1 = if (arg8) {
            arg6
        } else {
            arg7
        };
        let v2 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, v1, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg1, v2, arg4, arg5, arg6, arg7, arg10);
        0x2::transfer::public_transfer<0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::position::Position>(v0, 0x2::tx_context::sender(arg10));
    }

    public entry fun pause_pool<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun swap_a2b<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::stats::Stats, arg8: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun swap_a2b_with_partner<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::partner::Partner, arg3: vector<0x2::coin::Coin<T0>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::stats::Stats, arg9: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun swap_b2a<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T1>>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::stats::Stats, arg8: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg2, false, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun swap_b2a_with_partner<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::partner::Partner, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::stats::Stats, arg9: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        swap_with_partner<T0, T1>(arg0, arg1, arg2, 0x1::vector::empty<0x2::coin::Coin<T0>>(), arg3, false, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    fun swap_with_partner<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::partner::Partner, arg3: vector<0x2::coin::Coin<T0>>, arg4: vector<0x2::coin::Coin<T1>>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::stats::Stats, arg11: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T0>(arg3, arg13);
        let v1 = 0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::merge_coins<T1>(arg4, arg13);
        let (v2, v3, v4) = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg9, arg10, arg11, arg12);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::swap_pay_amount<T0, T1>(&v5);
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
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v8, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v8, arg13)))
        };
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v7, arg13));
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v6, arg13));
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v10, v11, v5);
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg13));
        0xacc8732610118a1ffe900849190b3b33fb1f632855f4287f5e9fcbfa3f1ae43d::utils::send_coin<T1>(v1, 0x2::tx_context::sender(arg13));
    }

    public entry fun unpause_pool<T0, T1>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::unpause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::config::GlobalConfig, arg1: &mut 0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::Pool<T0, T1>, arg2: &0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x79b7f2019ff976cdd7830fbb3f3dedf569d027cd349977846bb6822aaaf03f7d::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

