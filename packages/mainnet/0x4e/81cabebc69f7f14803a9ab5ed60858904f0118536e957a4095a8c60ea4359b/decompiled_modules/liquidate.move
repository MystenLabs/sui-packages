module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::liquidate {
    struct LiquidationReceipt<phantom T0, phantom T1> has drop {
        seized_shares: u128,
    }

    public fun liquidate<T0, T1, T2>(arg0: &mut 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::LendingPool<T0>, arg1: &mut 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::OracleRegistry, arg3: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg4: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg5: &0x2::clock::Clock, arg6: &mut 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::Obligation<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x2::coin::Coin<T1>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, LiquidationReceipt<T0, T2>) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::assert_pool_config<T0>(arg0, arg1);
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::get_price<T1>(arg2, arg7, arg5);
        let v1 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::get_price<T2>(arg2, arg8, arg5);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::accrue<T0, T1>(arg0, arg3, arg5);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::accrue<T0, T2>(arg0, arg4, arg5);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::refresh_reserve_price<T0, T1>(arg0, &v0, arg5);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::refresh_reserve_price<T0, T2>(arg0, &v1, arg5);
        assert!(!0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_refresh_in_progress<T0>(arg6) && 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_last_refresh_s<T0>(arg6) == 0x2::clock::timestamp_ms(arg5) / 1000, 6);
        assert!(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::is_liquidatable<T0>(arg6), 0);
        let v2 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::high_1e18(&v0);
        let v3 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::low_1e18(&v1);
        let v4 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_debt_amount<T0, T1>(arg0, arg6);
        assert!(!0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::is_zero(&v4), 3);
        let v5 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::reserve_coin_decimals<T0, T1>(arg0);
        let v6 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::reserve_coin_decimals<T0, T2>(arg0);
        let v7 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd_ceil(v2, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v4), v5);
        let v8 = if (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::health_factor_bps<T0>(arg6) < 9500 || 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v7) < 100000000000000000000) {
            10000
        } else {
            2000
        };
        let v9 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(v4, v8);
        let v10 = min_u64(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v9), 0x2::coin::value<T1>(arg9));
        let v11 = v10;
        assert!(v10 > 0, 1);
        let v12 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::reserve_config<T0, T2>(arg0);
        let v13 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::rc_liquidation_bonus_bps(&v12);
        let v14 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_collateral_shares<T0, T2>(arg6);
        assert!(v14 > 0, 4);
        let v15 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::share_ratio<T0, T2>(arg0);
        let v16 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd_ceil(v2, v10, v5);
        let v17 = underlying_to_shares(seize_underlying_from_usd(&v16, v13, v3, v6), &v15);
        let v18 = v17;
        if (v17 > v14) {
            v18 = v14;
            let v19 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd(v3, shares_to_underlying(v14, &v15), v6);
            let v20 = min_u64(debt_amount_from_seized_usd(&v19, v13, v2, v5), 0x2::coin::value<T1>(arg9));
            v11 = v20;
            assert!(v20 > 0, 1);
        };
        let v21 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::deduct_protocol_fee_shares<T0, T2>(arg0, v18, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::rc_protocol_liquidation_fee_bps(&v12));
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::seize_collateral_shares<T0, T2>(arg0, arg6, v18);
        if (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_collateral_shares_total<T0>(arg6) == 0 && 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_has_debt<T0>(arg6)) {
            let v22 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::obligation_debt_amount<T0, T1>(arg0, arg6);
            let v23 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd_ceil(v2, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v22), v5);
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::record_bad_debt<T0, T1>(arg0, arg6, arg1, v23);
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_bad_debt(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::pool_id_of<T0>(arg0), 0x2::object::id<0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::Obligation<T0>>(arg6), 0x1::type_name::with_defining_ids<T1>(), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v23));
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_liquidation(0x2::object::id<0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::Obligation<T0>>(arg6), 0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T2>(), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::apply_repay<T0, T1>(arg0, arg6, 0x2::coin::split<T1>(arg9, v11, arg10)), v18, v13, v21, 0x2::tx_context::sender(arg10));
        let v24 = LiquidationReceipt<T0, T2>{seized_shares: v18};
        (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool::take_collateral_underlying<T0, T2>(arg0, v18 - v21, arg10), v24)
    }

    fun debt_amount_from_seized_usd(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg1: u64, arg2: u128, arg3: u8) : u64 {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_scaled(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(arg0) * 10000 / ((10000 + arg1) as u256));
        usd_to_underlying_ceil(&v0, arg2, arg3)
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 <= arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun narrow_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 1);
        (arg0 as u64)
    }

    fun pow10_u256(arg0: u8) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun seize_underlying_from_usd(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg1: u64, arg2: u128, arg3: u8) : u64 {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(*arg0, 10000 + arg1);
        usd_to_underlying(&v0, arg2, arg3)
    }

    public fun seized_shares<T0, T1>(arg0: &LiquidationReceipt<T0, T1>) : u128 {
        arg0.seized_shares
    }

    fun shares_to_underlying(arg0: u128, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) : u64 {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u128(*arg1, arg0);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor(&v0)
    }

    fun underlying_to_shares(arg0: u64, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) : u128 {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(arg0), *arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v0)
    }

    fun usd_to_underlying(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg1: u128, arg2: u8) : u64 {
        if (arg1 == 0) {
            return 0
        };
        narrow_u64(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(arg0) * pow10_u256(arg2) / (arg1 as u256))
    }

    fun usd_to_underlying_ceil(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg1: u128, arg2: u8) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(arg0) * pow10_u256(arg2);
        let v1 = (arg1 as u256);
        let v2 = if (v0 == 0) {
            0
        } else {
            (v0 + v1 - 1) / v1
        };
        narrow_u64(v2)
    }

    // decompiled from Move bytecode v7
}

