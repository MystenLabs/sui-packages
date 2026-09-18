module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::cetus_adapter {
    struct CetusPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        farm_id: u64,
        settlement_route: u8,
        cetus_position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
    }

    struct LumiCreditKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LumiCredit has store {
        user_units: u64,
        operations_units: u64,
    }

    struct PositionOpened has copy, drop {
        farm_id: u64,
        cetus_position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct PositionClosed has copy, drop {
        farm_id: u64,
        principal_a: u64,
        principal_b: u64,
        fee_a: u64,
        fee_b: u64,
    }

    struct NativeRewardClaimed has copy, drop {
        farm_id: u64,
        reward_amount: u64,
        operations_fee: u64,
        protocol_fee: u64,
    }

    public entry fun open_position<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u8, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_route(arg4);
        let v0 = 0x2::coin::value<T0>(&arg7);
        let v1 = 0x2::coin::value<T1>(&arg8);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg10);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v2, v0, true, arg9);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        assert!(v4 <= v0 && v5 <= v1, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v4, arg10)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg8, v5, arg10)), v3);
        let v6 = 0x2::tx_context::sender(arg10);
        if (0x2::coin::value<T0>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, v6);
        } else {
            0x2::coin::destroy_zero<T0>(arg7);
        };
        if (0x2::coin::value<T1>(&arg8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg8, v6);
        } else {
            0x2::coin::destroy_zero<T1>(arg8);
        };
        let v7 = CetusPosition<T0, T1>{
            id               : 0x2::object::new(arg10),
            farm_id          : arg3,
            settlement_route : arg4,
            cetus_position   : v2,
        };
        0x2::transfer::public_transfer<CetusPosition<T0, T1>>(v7, v6);
        let v8 = PositionOpened{
            farm_id           : arg3,
            cetus_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v2),
            amount_a          : v4,
            amount_b          : v5,
        };
        0x2::event::emit<PositionOpened>(v8);
    }

    public entry fun accrue_lumi_reward_or_native_for_test<T0, T1, T2>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CetusPosition<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T2>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3.farm_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        assert!(arg3.settlement_route == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_lumi_claim(), 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &arg3.cetus_position, arg4, true, arg7);
        if (arg6 == 0) {
            let v1 = 0x2::balance::value<T2>(&v0);
            let (v2, v3) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v1);
            0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T2>(arg5, 0x2::balance::split<T2>(&mut v0, v3));
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg8), 0x2::tx_context::sender(arg8));
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v0, v2), arg8), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
            } else {
                0x2::balance::destroy_zero<T2>(0x2::balance::split<T2>(&mut v0, v2));
            };
            let v4 = NativeRewardClaimed{
                farm_id        : arg3.farm_id,
                reward_amount  : v1,
                operations_fee : v2,
                protocol_fee   : v3,
            };
            0x2::event::emit<NativeRewardClaimed>(v4);
        } else {
            0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T2>(arg5, v0);
            add_lumi_credit<T0, T1>(arg3, arg6);
        };
    }

    public entry fun add_liquidity<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CetusPosition<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3.farm_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        let v0 = 0x2::coin::value<T0>(&arg4);
        let v1 = 0x2::coin::value<T1>(&arg5);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut arg3.cetus_position, v0, true, arg6);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v2);
        assert!(v3 <= v0 && v4 <= v1, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v3, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v4, arg7)), v2);
        let v5 = 0x2::tx_context::sender(arg7);
        if (0x2::coin::value<T0>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v5);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
        if (0x2::coin::value<T1>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v5);
        } else {
            0x2::coin::destroy_zero<T1>(arg5);
        };
    }

    fun add_lumi_credit<T0, T1>(arg0: &mut CetusPosition<T0, T1>, arg1: u64) {
        let v0 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::lumi_claim_fee(arg1);
        let v1 = LumiCreditKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<LumiCreditKey>(&arg0.id, v1)) {
            let v2 = LumiCreditKey{dummy_field: false};
            let v3 = LumiCredit{
                user_units       : arg1 - v0,
                operations_units : v0,
            };
            0x2::dynamic_field::add<LumiCreditKey, LumiCredit>(&mut arg0.id, v2, v3);
        } else {
            let v4 = LumiCreditKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow_mut<LumiCreditKey, LumiCredit>(&mut arg0.id, v4);
            v5.user_units = v5.user_units + arg1 - v0;
            v5.operations_units = v5.operations_units + v0;
        };
    }

    fun borrow_lumi_credit_mut<T0, T1>(arg0: &mut CetusPosition<T0, T1>) : &mut LumiCredit {
        let v0 = LumiCreditKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<LumiCreditKey>(&arg0.id, v0)) {
            let v1 = LumiCreditKey{dummy_field: false};
            let v2 = LumiCredit{
                user_units       : 0,
                operations_units : 0,
            };
            0x2::dynamic_field::add<LumiCreditKey, LumiCredit>(&mut arg0.id, v1, v2);
        };
        let v3 = LumiCreditKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<LumiCreditKey, LumiCredit>(&mut arg0.id, v3)
    }

    public entry fun claim_lumi_reward_for_test<T0, T1, T2>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut CetusPosition<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T2>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg5.farm_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4));
        assert!(arg5.settlement_route == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_lumi_claim(), 2);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T2>(arg7, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, &arg5.cetus_position, arg6, true, arg10));
        let v0 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_reserve(arg2, arg1, arg8, arg11);
        let v1 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::lumi_claim_fee(arg8);
        assert!(0x2::coin::value<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&v0) >= arg9, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(v0, 0x2::tx_context::sender(arg11));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v0, v1, arg11), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::coin::destroy_zero<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v0, v1, arg11));
        };
    }

    public entry fun claim_native_reward<T0, T1, T2>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CetusPosition<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg3.farm_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &arg3.cetus_position, arg4, true, arg6);
        let v1 = 0x2::balance::value<T2>(&v0);
        let (v2, v3) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v1);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T2>(arg5, 0x2::balance::split<T2>(&mut v0, v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v0, arg7), 0x2::tx_context::sender(arg7));
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v0, v2), arg7), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::balance::destroy_zero<T2>(0x2::balance::split<T2>(&mut v0, v2));
        };
        let v4 = NativeRewardClaimed{
            farm_id        : arg3.farm_id,
            reward_amount  : v1,
            operations_fee : v2,
            protocol_fee   : v3,
        };
        0x2::event::emit<NativeRewardClaimed>(v4);
    }

    public entry fun close_native<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: CetusPosition<T0, T1>, arg4: u64, arg5: u64, arg6: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg7: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let CetusPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : _,
            cetus_position   : v3,
        } = arg3;
        let v4 = v3;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v6, v7) = if (v5 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, T1>(arg1, arg2, &mut v4, v5, arg4, arg5, arg8)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v8 = v7;
        let v9 = v6;
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v4, false);
        let v12 = v11;
        let v13 = v10;
        let v14 = &mut v13;
        let (v15, v16) = split_native_fees<T0>(v14);
        let v17 = v15;
        let v18 = &mut v12;
        let (v19, v20) = split_native_fees<T1>(v18);
        let v21 = v19;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg6, v16);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg7, v20);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v4);
        0x2::object::delete(v0);
        let v22 = 0x2::tx_context::sender(arg9);
        let v23 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg9), v22);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg9), v22);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg9), v22);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v12, arg9), v22);
        if (0x2::balance::value<T0>(&v17) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v17, arg9), v23);
        } else {
            0x2::balance::destroy_zero<T0>(v17);
        };
        if (0x2::balance::value<T1>(&v21) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v21, arg9), v23);
        } else {
            0x2::balance::destroy_zero<T1>(v21);
        };
        let v24 = PositionClosed{
            farm_id     : v1,
            principal_a : 0x2::balance::value<T0>(&v9),
            principal_b : 0x2::balance::value<T1>(&v8),
            fee_a       : 0x2::balance::value<T0>(&v13),
            fee_b       : 0x2::balance::value<T1>(&v12),
        };
        0x2::event::emit<PositionClosed>(v24);
    }

    public entry fun close_with_native_rewards<T0, T1, T2>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: CetusPosition<T0, T1>, arg4: u64, arg5: u64, arg6: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg7: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let CetusPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : _,
            cetus_position   : v3,
        } = arg3;
        let v4 = v3;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v4, arg8, true, arg10);
        let v6 = 0x2::balance::value<T2>(&v5);
        let (v7, v8) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v6);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T2>(arg9, 0x2::balance::split<T2>(&mut v5, v8));
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg2, &v4, arg8, true, arg10);
        let v10 = 0x2::balance::value<T1>(&v9);
        let (v11, v12) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v10);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg7, 0x2::balance::split<T1>(&mut v9, v12));
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v14, v15) = if (v13 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, T1>(arg1, arg2, &mut v4, v13, arg4, arg5, arg10)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v16 = v15;
        let v17 = v14;
        let (v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v4, false);
        let v20 = v19;
        let v21 = v18;
        let v22 = &mut v21;
        let (v23, v24) = split_native_fees<T0>(v22);
        let v25 = v23;
        let v26 = &mut v20;
        let (v27, v28) = split_native_fees<T1>(v26);
        let v29 = v27;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg6, v24);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg7, v28);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v4);
        0x2::object::delete(v0);
        let v30 = 0x2::tx_context::sender(arg11);
        let v31 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v17, arg11), v30);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v16, arg11), v30);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg11), v30);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v20, arg11), v30);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v5, arg11), v30);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg11), v30);
        if (0x2::balance::value<T0>(&v25) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v25, arg11), v31);
        } else {
            0x2::balance::destroy_zero<T0>(v25);
        };
        if (0x2::balance::value<T1>(&v29) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v29, arg11), v31);
        } else {
            0x2::balance::destroy_zero<T1>(v29);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v5, v7), arg11), v31);
        } else {
            0x2::balance::destroy_zero<T2>(0x2::balance::split<T2>(&mut v5, v7));
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v9, v11), arg11), v31);
        } else {
            0x2::balance::destroy_zero<T1>(0x2::balance::split<T1>(&mut v9, v11));
        };
        let v32 = PositionClosed{
            farm_id     : v1,
            principal_a : 0x2::balance::value<T0>(&v17),
            principal_b : 0x2::balance::value<T1>(&v16),
            fee_a       : 0x2::balance::value<T0>(&v21),
            fee_b       : 0x2::balance::value<T1>(&v20),
        };
        0x2::event::emit<PositionClosed>(v32);
        let v33 = NativeRewardClaimed{
            farm_id        : v1,
            reward_amount  : v6,
            operations_fee : v7,
            protocol_fee   : v8,
        };
        0x2::event::emit<NativeRewardClaimed>(v33);
        let v34 = NativeRewardClaimed{
            farm_id        : v1,
            reward_amount  : v10,
            operations_fee : v11,
            protocol_fee   : v12,
        };
        0x2::event::emit<NativeRewardClaimed>(v34);
    }

    public fun pending_lumi_credit<T0, T1>(arg0: &CetusPosition<T0, T1>) : (u64, u64) {
        let v0 = LumiCreditKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<LumiCreditKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = LumiCreditKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<LumiCreditKey, LumiCredit>(&arg0.id, v1);
        (v2.user_units, v2.operations_units)
    }

    public entry fun settle_lumi_credit_for_test<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg3: &mut CetusPosition<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.settlement_route == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_lumi_claim(), 2);
        let v0 = borrow_lumi_credit_mut<T0, T1>(arg3);
        let v1 = v0.user_units / 1000000;
        let v2 = v0.operations_units / 1000000;
        assert!(v1 >= arg4, 2);
        if (v1 > 0) {
            v0.user_units = v0.user_units - v1 * 1000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_reserve(arg2, arg1, v1, arg5), 0x2::tx_context::sender(arg5));
        };
        if (v2 > 0) {
            v0.operations_units = v0.operations_units - v2 * 1000000;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_reserve(arg2, arg1, v2, arg5), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        };
    }

    fun split_native_fees<T0>(arg0: &mut 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(0x2::balance::value<T0>(arg0));
        (0x2::balance::split<T0>(arg0, v0), 0x2::balance::split<T0>(arg0, v1))
    }

    // decompiled from Move bytecode v7
}

