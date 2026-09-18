module 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::liquidity_support {
    struct LumiSuiLiquidityPosition has key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct LiquiditySupported has copy, drop {
        position_id: 0x2::object::ID,
        lumi_deployed: u64,
        sui_deployed: u64,
        lumi_returned: u64,
        sui_returned: u64,
    }

    public entry fun add_lumi_sui_support(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: &mut LumiSuiLiquidityPosition, arg3: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg4: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg5: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::PriceOracle, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(!0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::is_paused(arg0), 1);
        assert!(arg8 > 0, 4);
        let v0 = &mut arg2.position;
        let (v1, v2, v3, v4) = deploy(arg1, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12);
        let v5 = LiquiditySupported{
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position),
            lumi_deployed : v1,
            sui_deployed  : v2,
            lumi_returned : v3,
            sui_returned  : v4,
        };
        0x2::event::emit<LiquiditySupported>(v5);
    }

    public entry fun create_lumi_sui_support(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::Router, arg1: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg2: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg3: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg4: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::PriceOracle, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: u64, arg8: u32, arg9: u32, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::router::is_paused(arg0), 1);
        assert!(arg7 > 0, 4);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg6, arg5, arg8, arg9, arg13);
        let v1 = &mut v0;
        let (v2, v3, v4, v5) = deploy(arg1, arg2, arg3, arg4, arg5, arg6, v1, arg7, arg10, arg11, arg12, arg13);
        let v6 = LumiSuiLiquidityPosition{
            id         : 0x2::object::new(arg13),
            position   : v0,
            tick_lower : arg8,
            tick_upper : arg9,
        };
        0x2::transfer::share_object<LumiSuiLiquidityPosition>(v6);
        let v7 = LiquiditySupported{
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            lumi_deployed : v2,
            sui_deployed  : v3,
            lumi_returned : v4,
            sui_returned  : v5,
        };
        0x2::event::emit<LiquiditySupported>(v7);
    }

    fun deploy(arg0: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::AdminCap, arg1: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::Vault, arg2: &mut 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::RevenueVault<0x2::sui::SUI>, arg3: &0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::PriceOracle, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_twap_ready(arg3, 300, arg10), 2);
        let v0 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::twap_sqrt_price(arg3, 300, arg10);
        assert!(0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::is_spot_within_twap_deviation(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg4), v0), 2);
        let v1 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::price_oracle::quote_b_to_a(arg7, v0);
        assert!(v1 > 0, 4);
        let v2 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::withdraw_lumi_for_settlement(arg1, with_cap(v1), arg11);
        let v3 = 0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::withdraw<0x2::sui::SUI>(arg2, arg0, arg7, arg11);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg5, arg4, arg6, arg7, false, arg10);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(&v4);
        assert!(v5 <= 0x2::coin::value<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&v2) && v6 <= 0x2::coin::value<0x2::sui::SUI>(&v3), 2);
        assert!(v5 >= arg8 && v6 >= arg9, 3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI, 0x2::sui::SUI>(arg5, arg4, 0x2::coin::into_balance<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(0x2::coin::split<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&mut v2, v5, arg11)), 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v3, v6, arg11)), v4);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::return_lumi_from_liquidity(arg1, v2);
        0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::revenue::deposit_coin<0x2::sui::SUI>(arg2, v3);
        (v5, v6, 0x2::coin::value<0xabb438fbd62e6b2df5954fdf251027c9f939a694c1baa4ffc38cbc3eddabfeb7::lumi::LUMI>(&v2), 0x2::coin::value<0x2::sui::SUI>(&v3))
    }

    fun with_cap(arg0: u64) : u64 {
        arg0 / 10000 * 10250 + arg0 % 10000 * 10250 / 10000
    }

    // decompiled from Move bytecode v7
}

