module 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::cetus_investor {
    struct Investor<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        lower_tick: u32,
        upper_tick: u32,
        free_balance_a: 0x2::balance::Balance<T0>,
        free_balance_b: 0x2::balance::Balance<T1>,
        performance_fee: u64,
        performance_fee_max_cap: u64,
    }

    public(friend) fun close_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg2, arg0, arg1);
    }

    public(friend) fun get_liquidity_from_amount<T0, T1>(arg0: &Investor<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : (u128, u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2, true)
    }

    public fun add_free_balance<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
    }

    public fun autocompound<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(arg2, arg6, v0, arg3, true, arg7);
        let (v2, v3) = 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::converter::swap_a2b<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS, 0x2::sui::SUI>(arg2, arg5, 0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v1, arg8), true, 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v1), arg7, arg8);
        let v4 = v3;
        0x2::coin::destroy_zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v2);
        0x2::coin::join<0x2::sui::SUI>(&mut v4, 0x2::coin::from_balance<0x2::sui::SUI>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, 0x2::sui::SUI>(arg2, arg6, v0, arg3, true, arg7), arg8));
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v5 * arg0.performance_fee / 10000, arg8), 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::get_fee_wallet_address(arg1));
        let (v6, v7) = 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::converter::swap_a2b<0x2::sui::SUI, T1>(arg2, arg4, v4, true, v5, arg7, arg8);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        0x2::balance::join<T1>(&mut arg0.free_balance_b, 0x2::coin::into_balance<T1>(v7));
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg6, v0, true);
        let v10 = v9;
        let v11 = v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, 0x2::balance::value<T0>(&v11) * arg0.performance_fee / 10000), arg8), 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::get_fee_wallet_address(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v10, 0x2::balance::value<T1>(&v10) * arg0.performance_fee / 10000), arg8), 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::get_fee_wallet_address(arg1));
        0x2::balance::join<T0>(&mut v11, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        0x2::balance::join<T1>(&mut v10, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        let (v12, v13) = get_total_balance_in_ratio<T0, T1>(arg0, arg1, arg2, v11, v10, arg6, arg7, arg8);
        deposit<T0, T1>(arg0, arg2, arg6, v12, v13, arg7);
    }

    public fun create_investor<T0: store, T1: store>(arg0: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::AdminCap, arg1: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::Version, arg2: u32, arg3: u32, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x2::tx_context::TxContext) {
        0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::assert_current_version(arg1);
        let v0 = 0x2::object::new(arg6);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v0, b"Position", 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg5, arg4, arg2, arg3, arg6));
        let v1 = Investor<T0, T1>{
            id                      : v0,
            lower_tick              : arg2,
            upper_tick              : arg3,
            free_balance_a          : 0x2::balance::zero<T0>(),
            free_balance_b          : 0x2::balance::zero<T1>(),
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
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, arg3, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), 0x2::balance::value<T0>(&arg3), true, arg5));
    }

    public(friend) fun get_balances_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool) : (u128, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick);
        let (v2, _, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T0>(&arg1), true);
        let v5 = 0x2::balance::value<T1>(&arg2);
        if (v4 <= v5) {
            if (arg4 == false) {
                assert!(((v5 - v4) as u128) * 1000000000 / (v5 as u128) <= 1000000, 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::error::difference_too_high());
            };
            0x2::balance::join<T1>(&mut arg0.free_balance_b, arg2);
            (v2, arg1, 0x2::balance::split<T1>(&mut arg2, v4))
        } else {
            let (v9, v10, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg3), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3), 0x2::balance::value<T1>(&arg2), false);
            let v12 = 0x2::balance::value<T0>(&arg1);
            assert!(v10 <= v12, 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::error::insufficient_balance_to_add_liquidity());
            if (arg4 == false) {
                assert!(((v12 - v10) as u128) * 1000000000 / (v12 as u128) <= 1000000, 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::error::difference_too_high());
            };
            0x2::balance::join<T0>(&mut arg0.free_balance_a, arg1);
            (v9, 0x2::balance::split<T0>(&mut arg1, v10), arg2)
        }
    }

    public(friend) fun get_total_balance_in_ratio<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::Distributor, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (_, v1, v2) = get_balances_in_ratio<T0, T1>(arg0, arg3, arg4, arg5, true);
        let v3 = v2;
        let v4 = v1;
        let v5 = (0x2::balance::value<T0>(&v4) as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.lower_tick)) as u256) * (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_sqrt_price_at_tick(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg0.upper_tick)) as u256);
        let v6 = (0x2::balance::value<T1>(&v3) as u256);
        let v7 = 0x2::balance::value<T0>(&arg0.free_balance_a);
        let v8 = 0x2::balance::value<T1>(&arg0.free_balance_b);
        if (v7 > 0) {
            let v9 = (v7 as u256) * v6 / (v5 + v6);
            let (v10, v11) = 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::converter::swap_a2b<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.free_balance_a, (v9 as u64)), arg7), true, (v9 as u64), arg6, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::get_dust_wallet_address(arg1));
            0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v11));
            0x2::balance::join<T0>(&mut v4, 0x2::balance::withdraw_all<T0>(&mut arg0.free_balance_a));
        } else if (v8 > 0) {
            let v12 = (v8 as u256) * v5 / (v5 + v6);
            let (v13, v14) = 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::converter::swap_b2a<T0, T1>(arg2, arg5, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.free_balance_b, (v12 as u64)), arg7), true, (v12 as u64), arg6, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::get_dust_wallet_address(arg1));
            0x2::balance::join<T0>(&mut v4, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut v3, 0x2::balance::withdraw_all<T1>(&mut arg0.free_balance_b));
        };
        (v4, v3)
    }

    public(friend) fun get_total_liquidity<T0, T1>(arg0: &Investor<T0, T1>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x2::dynamic_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.id, b"Position"))
    }

    public fun rebalance<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::RebalanceCap, arg2: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::Version, arg3: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::Distributor, arg4: u32, arg5: u32, arg6: u32, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::assert_current_version(arg2);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg7, arg8, arg4, arg5, arg10);
        arg0.lower_tick = arg4;
        arg0.upper_tick = arg5;
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let v3 = v2 / (arg6 as u128);
        let v4 = 0;
        while (v4 < arg6 + 1) {
            if (v4 == arg6) {
                v3 = v2 % (arg6 as u128);
            };
            let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg7, arg8, &mut v0, v3, arg9);
            let (v7, v8) = get_total_balance_in_ratio<T0, T1>(arg0, arg3, arg7, v5, v6, arg8, arg9, arg10);
            let v9 = v7;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg7, arg8, v9, v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg7, arg8, &mut v1, 0x2::balance::value<T0>(&v9), true, arg9));
            v4 = v4 + 1;
        };
        close_position<T0, T1>(arg8, v0, arg7);
        0x2::dynamic_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position", v1);
    }

    public fun reposition<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::AdminCap, arg2: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::Version, arg3: u32, arg4: u32, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::assert_current_version(arg2);
        let v0 = 0x2::dynamic_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position");
        let (v1, v2) = withdraw<T0, T1>(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0), arg5, arg6, arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg5, arg6, v0);
        arg0.lower_tick = arg3;
        arg0.upper_tick = arg4;
        create_position<T0, T1>(arg0, arg6, arg5, arg8);
        deposit<T0, T1>(arg0, arg5, arg6, v1, v2, arg7);
    }

    entry fun set_performance_fee<T0, T1>(arg0: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::distributor::AdminCap, arg1: &0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::Version, arg2: &mut Investor<T0, T1>, arg3: u64) {
        0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.performance_fee_max_cap, 0x2800f61bdea6b6efc632781c41fe7134abf766a2f05b6abc858706aebf1db59d::error::fee_too_high_error());
        arg2.performance_fee = arg3;
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Investor<T0, T1>, arg1: u128, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, 0x2::dynamic_field::borrow_mut<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.id, b"Position"), arg1, arg4)
    }

    // decompiled from Move bytecode v6
}

