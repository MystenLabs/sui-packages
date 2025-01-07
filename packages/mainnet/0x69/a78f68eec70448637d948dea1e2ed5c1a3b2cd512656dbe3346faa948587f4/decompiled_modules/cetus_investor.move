module 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::cetus_investor {
    struct Investor<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        lower_tick: u32,
        upper_tick: u32,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        free_balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        free_balance_cetus: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        performance_fee: u64,
        performance_fee_max_cap: u64,
    }

    struct RebalanceEvent has copy, drop {
        a: u64,
        b: u64,
    }

    struct FreeBalanceEvent has copy, drop {
        free_balance_a: u64,
        free_balance_b: u64,
        balance_a: u64,
        balance_b: u64,
    }

    fun close_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg0, arg1);
    }

    public fun autocompound<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = autocompound_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg7, arg8);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) > 0 || 0x2::balance::value<T1>(&v2) > 0) {
            deposit<T0, T1>(arg0, arg2, arg6, v3, v2, arg7);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
            0x2::balance::destroy_zero<T1>(v2);
        };
    }

    fun autocompound_internal<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg6, v0, arg3, true, arg9);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut v1, 0x2::balance::withdraw_all<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.free_balance_cetus));
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x2::sui::SUI>(arg2, arg6, v0, arg3, true, arg9), arg10);
        if (0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v1) >= 100000) {
            let (v3, v4) = 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::converter::swap_a2b<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg2, arg5, 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v1, arg10), true, 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v1), arg9, arg10);
            0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v3);
            0x2::coin::join<0x2::sui::SUI>(&mut v2, v4);
        } else {
            0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.free_balance_cetus, v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, (((0x2::coin::value<0x2::sui::SUI>(&v2) as u128) * (arg0.performance_fee as u128) / 10000) as u64), arg10), 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::get_fee_wallet_address(arg1));
        0x2::coin::join<0x2::sui::SUI>(&mut v2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.free_balance_sui), arg10));
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        if (v5 >= 100000) {
            let (v6, v7) = 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::converter::swap_b2a<T1, 0x2::sui::SUI>(arg2, arg4, v2, true, v5, arg9, arg10);
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::coin::into_balance<T1>(v6));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.free_balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(v2));
        };
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg6, v0, true);
        let v10 = v9;
        let v11 = v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, (((0x2::balance::value<T0>(&v11) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg10), 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v10, (((0x2::balance::value<T1>(&v10) as u128) * (arg0.performance_fee as u128) / 10000) as u64)), arg10), 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T0>(&mut v11, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v10, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        let (v12, v13) = get_total_balance_in_ratio<T0, T1>(arg0, arg1, arg2, v11, v10, arg6, arg9, arg10);
        let v14 = v13;
        let v15 = v12;
        let v16 = FreeBalanceEvent{
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            balance_a      : 0x2::balance::value<T0>(&v15),
            balance_b      : 0x2::balance::value<T1>(&v14),
        };
        0x2::event::emit<FreeBalanceEvent>(v16);
        0x2::balance::join<T0>(&mut v15, arg7);
        0x2::balance::join<T1>(&mut v14, arg8);
        let (_, v18, v19) = get_balances_in_ratio<T0, T1>(arg0, v15, v14, arg6, true);
        let v20 = v19;
        let v21 = v18;
        let v22 = FreeBalanceEvent{
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            balance_a      : 0x2::balance::value<T0>(&v21),
            balance_b      : 0x2::balance::value<T1>(&v20),
        };
        0x2::event::emit<FreeBalanceEvent>(v22);
        (v21, v20)
    }

    public fun create_investor<T0, T1>(arg0: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::AdminCap, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::Version, arg2: u32, arg3: u32, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::assert_current_version(arg1);
        let v0 = 0x2::object::new(arg6);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v0, b"Position", 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg4, arg2, arg3, arg6));
        let v1 = Investor<T0, T1>{
            id                      : v0,
            lower_tick              : arg2,
            upper_tick              : arg3,
            free_balance_a          : 0x2::balance::zero<T0>(),
            free_balance_b          : 0x2::balance::zero<T1>(),
            free_balance_sui        : 0x2::balance::zero<0x2::sui::SUI>(),
            free_balance_cetus      : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            performance_fee         : 2000,
            performance_fee_max_cap : 5000,
        };
        0x2::transfer::public_share_object<Investor<T0, T1>>(v1);
    }

    fun create_position<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"Position") == false, 2);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg1, arg0.lower_tick, arg0.upper_tick, arg3));
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock) {
        let v0 = if (0x2::balance::value<T0>(&arg3) == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x2::balance::value<T1>(&arg4), false, arg5)
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x2::balance::value<T0>(&arg3), true, arg5)
        };
        let v1 = v0;
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        let v4 = FreeBalanceEvent{
            free_balance_a : v2,
            free_balance_b : v3,
            balance_a      : 0x2::balance::value<T0>(&arg3),
            balance_b      : 0x2::balance::value<T1>(&arg4),
        };
        0x2::event::emit<FreeBalanceEvent>(v4);
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg3);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg4);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::split<T1>(&mut arg4, v3), v1);
    }

    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        if (0x2::balance::value<T0>(&arg1) == 0) {
            (0, arg1, arg2)
        } else {
            let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T0>(&arg1), true);
            let v8 = FreeBalanceEvent{
                free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
                free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
                balance_a      : v6,
                balance_b      : v7,
            };
            0x2::event::emit<FreeBalanceEvent>(v8);
            let v9 = 0x2::balance::value<T1>(&arg2);
            if (v7 <= v9) {
                if (arg4 == false) {
                    assert!(((v9 - v7) as u128) * 1000000000 / (v9 as u128) <= 1000000, 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::error::difference_too_high());
                };
                0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
                (v5, arg1, 0x2::balance::split<T1>(&mut arg2, v7))
            } else {
                let (v10, v11, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
                let v13 = v11;
                let v14 = 0x2::balance::value<T0>(&arg1);
                assert!(v11 <= v14, 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::error::insufficient_balance_to_add_liquidity());
                if (arg4 == false) {
                    assert!(((v14 - v11) as u128) * 1000000000 / (v14 as u128) <= 1000000, 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::error::difference_too_high());
                };
                if (v11 != 0) {
                    v13 = v11 - 1;
                };
                0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
                (v10, 0x2::balance::split<T0>(&mut arg1, v13), arg2)
            }
        }
    }

    fun get_total_balance_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg3) == 0 || 0x2::balance::value<T1>(&arg4) == 0) {
            0x2::balance::join<T0>(&mut arg0.free_balance_a, 0x2::balance::withdraw_all<T0>(&mut arg3));
            0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::balance::withdraw_all<T1>(&mut arg4));
        };
        let (_, v1, v2) = get_balances_in_ratio<T0, T1>(arg0, arg3, arg4, arg5, true);
        let v3 = v2;
        let v4 = v1;
        let v5 = FreeBalanceEvent{
            free_balance_a : 0x2::balance::value<T0>(&arg0.free_balance_a),
            free_balance_b : 0x2::balance::value<T1>(&arg0.free_balance_b),
            balance_a      : 0x2::balance::value<T0>(&v4),
            balance_b      : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<FreeBalanceEvent>(v5);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let v8 = if ((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7) as u256) >= (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5) as u256)) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7) as u256) - (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5) as u256)
        } else {
            0
        };
        let v9 = if ((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5) as u256) >= (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6) as u256)) {
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v7) as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5) as u256) * ((0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5) as u256) - (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(v6) as u256))
        } else {
            0
        };
        let v10 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v11 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v10 > 0) {
            let v12 = (v10 as u256) * v9 / (v8 + v9);
            if (v12 >= 100000) {
                let (v13, v14) = 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::converter::swap_a2b<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v12 as u64)), arg7), true, (v12 as u64), arg6, arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v13, 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v14));
                0x2::balance::join<T0>(&mut v4, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
            };
        } else if (v11 > 0) {
            let v15 = (v11 as u256) * v8 / (v8 + v9);
            if (v15 >= 100000) {
                let (v16, v17) = 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::converter::swap_b2a<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v15 as u64)), arg7), true, (v15 as u64), arg6, arg7);
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v17, 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::get_dust_wallet_address(arg1));
                0x2::balance::join<T0>(&mut v4, 0x2::coin::into_balance<T0>(v16));
                0x2::balance::join<T1>(&mut v3, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
            };
        };
        (v4, v3)
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"))
    }

    public fun rebalance<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::RebalanceCap, arg2: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::Version, arg3: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg8: u32, arg9: u32, arg10: u32, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::assert_current_version(arg2);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg4, arg11, arg8, arg9, arg13);
        autocompound<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg11, arg12, arg13);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), v2, false);
        let v5 = RebalanceEvent{
            a : 0x2::balance::value<T0>(&arg0.free_balance_a) + v3,
            b : 0x2::balance::value<T1>(&arg0.free_balance_b) + v4,
        };
        0x2::event::emit<RebalanceEvent>(v5);
        arg0.lower_tick = arg8;
        arg0.upper_tick = arg9;
        let v6 = v2 / (arg10 as u128);
        let v7 = 0;
        while (v7 < arg10 + 1) {
            if (v7 == arg10) {
                v6 = v2 % (arg10 as u128);
            };
            let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg4, arg11, &mut v0, v6, arg12);
            let (v10, v11) = get_total_balance_in_ratio<T0, T1>(arg0, arg3, arg4, v8, v9, arg11, arg12, arg13);
            let (_, v13, v14) = get_balances_in_ratio<T0, T1>(arg0, v10, v11, arg11, true);
            let v15 = v13;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg4, arg11, v15, v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg4, arg11, &mut v1, 0x2::balance::value<T0>(&v15), true, arg12));
            v7 = v7 + 1;
        };
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v0);
        let (v16, v17) = autocompound_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg11, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg12, arg13);
        close_position<T0, T1>(arg11, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), arg4);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v1);
        deposit<T0, T1>(arg0, arg4, arg11, v16, v17, arg12);
        let (v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_amount_by_liquidity(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg11), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position")), false);
        let v20 = RebalanceEvent{
            a : 0x2::balance::value<T0>(&arg0.free_balance_a) + v18,
            b : 0x2::balance::value<T1>(&arg0.free_balance_b) + v19,
        };
        0x2::event::emit<RebalanceEvent>(v20);
    }

    public fun reposition<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::AdminCap, arg2: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::Version, arg3: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::Distributor, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg8: u32, arg9: u32, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::assert_current_version(arg2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"));
        let (v1, v2) = withdraw<T0, T1>(arg0, v0, arg4, arg10, arg11);
        let (v3, v4) = autocompound_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg10, v1, v2, arg11, arg12);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg4, arg10, 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"));
        arg0.lower_tick = arg8;
        arg0.upper_tick = arg9;
        create_position<T0, T1>(arg0, arg10, arg4, arg12);
        deposit<T0, T1>(arg0, arg4, arg10, v3, v4, arg11);
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::distributor::AdminCap, arg1: &0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.performance_fee_max_cap, 0xadc68a25c487095ddf94b9d5a5811d9f266eb296b583dd553dd119539fd3d462::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

