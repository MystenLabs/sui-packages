module 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::scallop {
    fun pre(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::OperatorCap, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::assert_can_strike(arg0, arg1);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_deadline(arg5, arg4);
        0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::adapters::scallop_precheck_unlocked(arg2);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_positive_repay(arg3);
    }

    fun race(arg0: u64, arg1: u64) {
        assert!(arg1 < arg0, 160);
    }

    public fun scallop_cetus_flash_a<T0, T1>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::OperatorCap, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: u64, arg10: u128, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        pre(arg0, arg1, arg3, arg9, arg12, arg13);
        let (v0, v1, v2) = 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::cdex::cetus_flash_a<T0, T1>(arg7, arg8, arg9, arg10, arg13);
        let (v3, v4) = 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::adapters::scallop_liquidate<T0, T1>(arg2, arg3, arg4, v0, arg5, arg6, arg13, arg14);
        let v5 = v4;
        let v6 = v3;
        race(arg9, 0x2::balance::value<T0>(&v5));
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_cover(0x2::balance::value<T1>(&v6), v1, arg11);
        0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::cdex::cetus_repay_b<T0, T1>(arg7, arg8, 0x2::balance::split<T1>(&mut v6, v1), v2);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::payout::pay<T0>(arg0, v5, arg14);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::payout::pay<T1>(arg0, v6, arg14);
    }

    public fun scallop_cetus_flash_b<T0, T1>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::OperatorCap, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg9: u64, arg10: u128, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        pre(arg0, arg1, arg3, arg9, arg12, arg13);
        let (v0, v1, v2) = 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::cdex::cetus_flash_b<T0, T1>(arg7, arg8, arg9, arg10, arg13);
        let (v3, v4) = 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::adapters::scallop_liquidate<T1, T0>(arg2, arg3, arg4, v0, arg5, arg6, arg13, arg14);
        let v5 = v4;
        let v6 = v3;
        race(arg9, 0x2::balance::value<T1>(&v5));
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_cover(0x2::balance::value<T0>(&v6), v1, arg11);
        0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::cdex::cetus_repay_a<T0, T1>(arg7, arg8, 0x2::balance::split<T0>(&mut v6, v1), v2);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::payout::pay<T1>(arg0, v5, arg14);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::payout::pay<T0>(arg0, v6, arg14);
    }

    public fun scallop_own<T0, T1>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::OperatorCap, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: 0x2::balance::Balance<T0>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg7);
        pre(arg0, arg1, arg3, v0, arg9, arg10);
        let (v1, v2) = 0x98af87f6911c90c1dad70056e5332d9949661beef7008b35f1da4152dadaede::adapters::scallop_liquidate<T0, T1>(arg2, arg3, arg4, arg7, arg5, arg6, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        race(v0, 0x2::balance::value<T0>(&v3));
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_min_profit<T1>(&v4, arg8);
        (v4, v3)
    }

    // decompiled from Move bytecode v7
}

