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

    struct PositionRebalanced has copy, drop {
        farm_id: u64,
        old_receipt_id: 0x2::object::ID,
        new_receipt_id: 0x2::object::ID,
        old_cetus_position_id: 0x2::object::ID,
        new_cetus_position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        amount_a: u64,
        amount_b: u64,
    }

    struct NativeRewardClaimed has copy, drop {
        farm_id: u64,
        reward_amount: u64,
        operations_fee: u64,
        protocol_fee: u64,
    }

    struct LumiRewardSettled has copy, drop {
        farm_id: u64,
        native_reward: u64,
        gross_lumi: u64,
        user_lumi: u64,
        operations_lumi: u64,
        used_native_fallback: bool,
    }

    struct PositionSettledInLumi has copy, drop {
        farm_id: u64,
        retained_a: u64,
        retained_sui: u64,
        gross_lumi: u64,
        user_lumi: u64,
        operations_lumi: u64,
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

    public entry fun claim_lumi_sui_reward<T0>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg2: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::PriceOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg6: &mut CetusPosition<T0, 0x2::sui::SUI>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, arg6.farm_id, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg5));
        assert!(arg6.settlement_route == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_lumi_claim(), 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, 0x2::sui::SUI, 0x2::sui::SUI>(arg4, arg5, &arg6.cetus_position, arg7, true, arg10);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        if (!0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_twap_ready(arg2, 300, arg10)) {
            settle_native_sui_fallback(arg0, arg6.farm_id, v0, arg8, arg11);
            let v2 = LumiRewardSettled{
                farm_id              : arg6.farm_id,
                native_reward        : v1,
                gross_lumi           : 0,
                user_lumi            : 0,
                operations_lumi      : 0,
                used_native_fallback : true,
            };
            0x2::event::emit<LumiRewardSettled>(v2);
            return
        };
        let v3 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::twap_sqrt_price(arg2, 300, arg10);
        if (!0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_spot_within_twap_deviation(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg3), v3)) {
            settle_native_sui_fallback(arg0, arg6.farm_id, v0, arg8, arg11);
            let v4 = LumiRewardSettled{
                farm_id              : arg6.farm_id,
                native_reward        : v1,
                gross_lumi           : 0,
                user_lumi            : 0,
                operations_lumi      : 0,
                used_native_fallback : true,
            };
            0x2::event::emit<LumiRewardSettled>(v4);
            return
        };
        let v5 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_b_to_a(v1, v3);
        if (v5 == 0) {
            settle_native_sui_fallback(arg0, arg6.farm_id, v0, arg8, arg11);
            let v6 = LumiRewardSettled{
                farm_id              : arg6.farm_id,
                native_reward        : v1,
                gross_lumi           : 0,
                user_lumi            : 0,
                operations_lumi      : 0,
                used_native_fallback : true,
            };
            0x2::event::emit<LumiRewardSettled>(v6);
            return
        };
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg8, v0);
        let v7 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::lumi_claim_fee(v5);
        let v8 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_for_settlement(arg1, v5, arg11);
        let v9 = 0x2::coin::value<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&v8);
        assert!(v9 >= arg9, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(v8, 0x2::tx_context::sender(arg11));
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v8, v7, arg11), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::coin::destroy_zero<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v8, v7, arg11));
        };
        let v10 = LumiRewardSettled{
            farm_id              : arg6.farm_id,
            native_reward        : v1,
            gross_lumi           : v5,
            user_lumi            : v9,
            operations_lumi      : v7,
            used_native_fallback : false,
        };
        0x2::event::emit<LumiRewardSettled>(v10);
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

    public entry fun close_position_and_rewards_for_lumi<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg2: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::PriceOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg4: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::CetusPairOracle<T0, 0x2::sui::SUI>, arg5: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::CetusPairOracle<T1, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg8: CetusPosition<T0, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg10: u64, arg11: u64, arg12: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg13: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg14: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T1>, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let CetusPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : v2,
            cetus_position   : v3,
        } = arg8;
        let v4 = v3;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg7));
        assert!(v2 == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_lumi_claim(), 2);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_twap_ready(arg2, 300, arg16), 2);
        let v5 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::twap_sqrt_price(arg2, 300, arg16);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_spot_within_twap_deviation(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg3), v5), 2);
        let v6 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::cetus_pair_twap_sqrt_price<T0, 0x2::sui::SUI>(arg4, 300, arg16);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_spot_within_twap_deviation(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg7), v6), 2);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, 0x2::sui::SUI, T1>(arg6, arg7, &v4, arg9, true, arg16);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, 0x2::sui::SUI, 0x2::sui::SUI>(arg6, arg7, &v4, arg9, true, arg16);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v10, v11) = if (v9 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, 0x2::sui::SUI>(arg6, arg7, &mut v4, v9, arg10, arg11, arg16)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v12 = v11;
        let v13 = v10;
        let (v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0x2::sui::SUI>(arg6, arg7, &v4, false);
        let v16 = v15;
        let v17 = v14;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, 0x2::sui::SUI>(arg6, arg7, v4);
        0x2::object::delete(v0);
        let v18 = 0x2::balance::value<T0>(&v13) + 0x2::balance::value<T0>(&v17);
        let v19 = 0x2::balance::value<0x2::sui::SUI>(&v12) + 0x2::balance::value<0x2::sui::SUI>(&v16) + 0x2::balance::value<0x2::sui::SUI>(&v8);
        let v20 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_b_to_a(v19 + 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_a_to_b(v18, v6) + 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_a_to_b(0x2::balance::value<T1>(&v7), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::cetus_pair_twap_sqrt_price<T1, 0x2::sui::SUI>(arg5, 300, arg16)), v5);
        assert!(v20 > 0, 1);
        let v21 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::lumi_claim_fee(v20);
        let v22 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_for_settlement(arg1, v20, arg17);
        let v23 = 0x2::coin::value<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&v22);
        assert!(v23 >= arg15, 2);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg12, v13);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg12, v17);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg13, v12);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg13, v16);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg13, v8);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg14, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(v22, 0x2::tx_context::sender(arg17));
        if (v21 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v22, v21, arg17), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::coin::destroy_zero<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v22, v21, arg17));
        };
        let v24 = PositionSettledInLumi{
            farm_id         : v1,
            retained_a      : v18,
            retained_sui    : v19,
            gross_lumi      : v20,
            user_lumi       : v23,
            operations_lumi : v21,
        };
        0x2::event::emit<PositionSettledInLumi>(v24);
    }

    public entry fun close_position_for_lumi<T0>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg2: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::PriceOracle, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg4: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::CetusPairOracle<T0, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg7: CetusPosition<T0, 0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg11: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let CetusPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : v2,
            cetus_position   : v3,
        } = arg7;
        let v4 = v3;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg6));
        assert!(v2 == 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::route_lumi_claim(), 2);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_twap_ready(arg2, 300, arg13), 2);
        let v5 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::twap_sqrt_price(arg2, 300, arg13);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_spot_within_twap_deviation(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg3), v5), 2);
        let v6 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::cetus_pair_twap_sqrt_price<T0, 0x2::sui::SUI>(arg4, 300, arg13);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_spot_within_twap_deviation(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg6), v6), 2);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v8, v9) = if (v7 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, 0x2::sui::SUI>(arg5, arg6, &mut v4, v7, arg8, arg9, arg13)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, 0x2::sui::SUI>(arg5, arg6, &v4, false);
        let v14 = v13;
        let v15 = v12;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, 0x2::sui::SUI>(arg5, arg6, v4);
        0x2::object::delete(v0);
        let v16 = 0x2::balance::value<T0>(&v11) + 0x2::balance::value<T0>(&v15);
        let v17 = 0x2::balance::value<0x2::sui::SUI>(&v10) + 0x2::balance::value<0x2::sui::SUI>(&v14);
        let v18 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_b_to_a(v17 + 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_a_to_b(v16, v6), v5);
        assert!(v18 > 0, 1);
        let v19 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::lumi_claim_fee(v18);
        let v20 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_for_settlement(arg1, v18, arg14);
        let v21 = 0x2::coin::value<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&v20);
        assert!(v21 >= arg12, 2);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg10, v11);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg10, v15);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg11, v10);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg11, v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(v20, 0x2::tx_context::sender(arg14));
        if (v19 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v20, v19, arg14), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::coin::destroy_zero<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v20, v19, arg14));
        };
        let v22 = PositionSettledInLumi{
            farm_id         : v1,
            retained_a      : v16,
            retained_sui    : v17,
            gross_lumi      : v18,
            user_lumi       : v21,
            operations_lumi : v19,
        };
        0x2::event::emit<PositionSettledInLumi>(v22);
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

    public entry fun close_with_three_native_rewards<T0, T1, T2>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: CetusPosition<T0, T1>, arg4: u64, arg5: u64, arg6: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg7: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T1>, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg9: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T2>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let CetusPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : _,
            cetus_position   : v3,
        } = arg3;
        let v4 = v3;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T0>(arg1, arg2, &v4, arg8, true, arg10);
        let v6 = 0x2::balance::value<T0>(&v5);
        let (v7, v8) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v6);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg6, 0x2::balance::split<T0>(&mut v5, v8));
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T1>(arg1, arg2, &v4, arg8, true, arg10);
        let v10 = 0x2::balance::value<T1>(&v9);
        let (v11, v12) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v10);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg7, 0x2::balance::split<T1>(&mut v9, v12));
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, &v4, arg8, true, arg10);
        let v14 = 0x2::balance::value<T2>(&v13);
        let (v15, v16) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v14);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T2>(arg9, 0x2::balance::split<T2>(&mut v13, v16));
        let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v18, v19) = if (v17 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, T1>(arg1, arg2, &mut v4, v17, arg4, arg5, arg10)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v20 = v19;
        let v21 = v18;
        let (v22, v23) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v4, false);
        let v24 = v23;
        let v25 = v22;
        let v26 = &mut v25;
        let (v27, v28) = split_native_fees<T0>(v26);
        let v29 = v27;
        let v30 = &mut v24;
        let (v31, v32) = split_native_fees<T1>(v30);
        let v33 = v31;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg6, v28);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg7, v32);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v4);
        0x2::object::delete(v0);
        let v34 = 0x2::tx_context::sender(arg11);
        let v35 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg11), v34);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v20, arg11), v34);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v25, arg11), v34);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v24, arg11), v34);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg11), v34);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v9, arg11), v34);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v13, arg11), v34);
        if (0x2::balance::value<T0>(&v29) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v29, arg11), v35);
        } else {
            0x2::balance::destroy_zero<T0>(v29);
        };
        if (0x2::balance::value<T1>(&v33) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v33, arg11), v35);
        } else {
            0x2::balance::destroy_zero<T1>(v33);
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5, v7), arg11), v35);
        } else {
            0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut v5, v7));
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v9, v11), arg11), v35);
        } else {
            0x2::balance::destroy_zero<T1>(0x2::balance::split<T1>(&mut v9, v11));
        };
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v13, v15), arg11), v35);
        } else {
            0x2::balance::destroy_zero<T2>(0x2::balance::split<T2>(&mut v13, v15));
        };
        let v36 = PositionClosed{
            farm_id     : v1,
            principal_a : 0x2::balance::value<T0>(&v21),
            principal_b : 0x2::balance::value<T1>(&v20),
            fee_a       : 0x2::balance::value<T0>(&v25),
            fee_b       : 0x2::balance::value<T1>(&v24),
        };
        0x2::event::emit<PositionClosed>(v36);
        let v37 = NativeRewardClaimed{
            farm_id        : v1,
            reward_amount  : v6,
            operations_fee : v7,
            protocol_fee   : v8,
        };
        0x2::event::emit<NativeRewardClaimed>(v37);
        let v38 = NativeRewardClaimed{
            farm_id        : v1,
            reward_amount  : v10,
            operations_fee : v11,
            protocol_fee   : v12,
        };
        0x2::event::emit<NativeRewardClaimed>(v38);
        let v39 = NativeRewardClaimed{
            farm_id        : v1,
            reward_amount  : v14,
            operations_fee : v15,
            protocol_fee   : v16,
        };
        0x2::event::emit<NativeRewardClaimed>(v39);
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

    public entry fun rebalance<T0, T1>(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: CetusPosition<T0, T1>, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T0>, arg11: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<T1>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < arg5, 2);
        let CetusPosition {
            id               : v0,
            farm_id          : v1,
            settlement_route : v2,
            cetus_position   : v3,
        } = arg3;
        let v4 = v3;
        let v5 = v0;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::assert_active_farm_pool(arg0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2));
        let v6 = LumiCreditKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LumiCreditKey>(&v5, v6)) {
            let v7 = LumiCreditKey{dummy_field: false};
            let LumiCredit {
                user_units       : v8,
                operations_units : v9,
            } = 0x2::dynamic_field::remove<LumiCreditKey, LumiCredit>(&mut v5, v7);
            assert!(v8 == 0 && v9 == 0, 2);
        };
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v4);
        let (v11, v12) = if (v10 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity_with_slippage<T0, T1>(arg1, arg2, &mut v4, v10, arg8, arg9, arg12)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &v4, false);
        let v15 = v14;
        let v16 = v13;
        let v17 = &mut v16;
        let (v18, v19) = split_native_fees<T0>(v17);
        let v20 = v18;
        let v21 = &mut v15;
        let (v22, v23) = split_native_fees<T1>(v21);
        let v24 = v22;
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T0>(arg10, v19);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<T1>(arg11, v23);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, v4);
        0x2::coin::join<T0>(&mut arg6, 0x2::coin::from_balance<T0>(v11, arg13));
        0x2::coin::join<T1>(&mut arg7, 0x2::coin::from_balance<T1>(v12, arg13));
        let v25 = 0x2::coin::value<T0>(&arg6);
        let v26 = 0x2::coin::value<T1>(&arg7);
        assert!(v25 > 0 && v26 > 0, 1);
        let v27 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg13);
        let v28 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut v27, v25, true, arg12);
        let (v29, v30) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v28);
        assert!(v29 <= v25 && v30 <= v26, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg6, v29, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg7, v30, arg13)), v28);
        let v31 = 0x2::tx_context::sender(arg13);
        let v32 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0);
        if (0x2::coin::value<T0>(&arg6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg6, v31);
        } else {
            0x2::coin::destroy_zero<T0>(arg6);
        };
        if (0x2::coin::value<T1>(&arg7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, v31);
        } else {
            0x2::coin::destroy_zero<T1>(arg7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg13), v31);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v15, arg13), v31);
        if (0x2::balance::value<T0>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v20, arg13), v32);
        } else {
            0x2::balance::destroy_zero<T0>(v20);
        };
        if (0x2::balance::value<T1>(&v24) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v24, arg13), v32);
        } else {
            0x2::balance::destroy_zero<T1>(v24);
        };
        0x2::object::delete(v5);
        let v33 = CetusPosition<T0, T1>{
            id               : 0x2::object::new(arg13),
            farm_id          : v1,
            settlement_route : v2,
            cetus_position   : v27,
        };
        let v34 = PositionRebalanced{
            farm_id               : v1,
            old_receipt_id        : 0x2::object::uid_to_inner(&v5),
            new_receipt_id        : 0x2::object::id<CetusPosition<T0, T1>>(&v33),
            old_cetus_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4),
            new_cetus_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v27),
            tick_lower            : arg4,
            tick_upper            : arg5,
            amount_a              : v29,
            amount_b              : v30,
        };
        0x2::event::emit<PositionRebalanced>(v34);
        0x2::transfer::public_transfer<CetusPosition<T0, T1>>(v33, v31);
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

    fun settle_native_sui_fallback(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let (v1, v2) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(v0);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit<0x2::sui::SUI>(arg3, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg4), 0x2::tx_context::sender(arg4));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, v1), arg4), 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::operations_wallet(arg0));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2, v1));
        };
        let v3 = NativeRewardClaimed{
            farm_id        : arg1,
            reward_amount  : v0,
            operations_fee : v1,
            protocol_fee   : v2,
        };
        0x2::event::emit<NativeRewardClaimed>(v3);
    }

    fun split_native_fees<T0>(arg0: &mut 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::native_reward_fees(0x2::balance::value<T0>(arg0));
        (0x2::balance::split<T0>(arg0, v0), 0x2::balance::split<T0>(arg0, v1))
    }

    // decompiled from Move bytecode v7
}

