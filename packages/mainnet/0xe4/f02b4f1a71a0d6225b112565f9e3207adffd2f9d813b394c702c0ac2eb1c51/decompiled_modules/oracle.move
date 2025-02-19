module 0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::oracle {
    struct PriceOracleConfig has store, key {
        id: 0x2::object::UID,
        price_fluctuation_threshold: 0x2::table::Table<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>,
        last_fetched_price: 0x2::table::Table<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>,
    }

    struct PriceVoucher<phantom T0: drop> {
        underlying_price: u128,
    }

    fun calc_scoin_to_coin(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        let (v0, v1, v2, v3) = get_reserve_stats(arg0, arg1, arg2, arg3);
        0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(arg4, v0 + v1 - v2, v3)
    }

    public fun get_price<T0: drop>(arg0: PriceVoucher<T0>, arg1: &0x2::tx_context::TxContext) : u128 {
        let PriceVoucher { underlying_price: v0 } = arg0;
        v0
    }

    public fun get_price_fluctuation_threshold<T0: drop>(arg0: &PriceOracleConfig) : 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg0.price_fluctuation_threshold, v0)) {
            0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::value(0x2::table::borrow<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg0.price_fluctuation_threshold, v0)))
        } else {
            0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational(1, 100)
        }
    }

    public fun get_price_voucher_from_spring<T0: drop, T1: drop>(arg0: &mut PriceOracleConfig, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg2: &0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::sy::State, arg3: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        assert!(0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::sy::is_sy_bind<T1, T0>(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T1>(arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T1>(arg1) as u128), (v0 as u128));
        assert!(is_price_fluctuation_within_threshold<T0>(arg0, v1), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::price_fluctuation_too_large());
        PriceVoucher<T0>{underlying_price: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(v1)}
    }

    public fun get_price_voucher_from_ssbuck<T0: drop, T1: drop>(arg0: &mut PriceOracleConfig, arg1: &0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::Vault<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_available_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1, arg2) as u128), (0x2a721777dc1fcf7cda19492ad7c2272ee284214652bde3e9740e2f49c3bff457::vault::total_yt_supply<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(arg1) as u128));
        assert!(is_price_fluctuation_within_threshold<T0>(arg0, v0), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::price_fluctuation_too_large());
        PriceVoucher<T0>{underlying_price: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(v0)}
    }

    public fun get_price_voucher_from_volo<T0: drop>(arg0: &mut PriceOracleConfig, arg1: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::NativePool, arg2: &0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg3: &0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::sy::State, arg4: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        assert!(0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::sy::is_sy_bind<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT, T0>(arg3), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::native_pool::get_ratio(arg1, arg2) as u128), 1000000000000000000);
        assert!(is_price_fluctuation_within_threshold<T0>(arg0, v0), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::price_fluctuation_too_large());
        PriceVoucher<T0>{underlying_price: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(v0)}
    }

    public fun get_price_voucher_from_x_oracle<T0: drop, T1: drop>(arg0: &mut PriceOracleConfig, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::sy::State, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : PriceVoucher<T0> {
        assert!(0xe4f02b4f1a71a0d6225b112565f9e3207adffd2f9d813b394c702c0ac2eb1c51::sy::is_sy_bind_with_underlying_token<T1, T0>(arg3), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::sy_not_supported());
        let v0 = 1000000000;
        let v1 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_rational((calc_scoin_to_coin(arg1, arg2, 0x1::type_name::get<T1>(), arg4, v0) as u128), (v0 as u128));
        assert!(is_price_fluctuation_within_threshold<T0>(arg0, v1), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::price_fluctuation_too_large());
        PriceVoucher<T0>{underlying_price: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(v1)}
    }

    fun get_reserve_stats(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg0, arg1, arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg1)), arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracleConfig{
            id                          : 0x2::object::new(arg0),
            price_fluctuation_threshold : 0x2::table::new<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(arg0),
            last_fetched_price          : 0x2::table::new<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(arg0),
        };
        0x2::transfer::share_object<PriceOracleConfig>(v0);
    }

    public fun is_price_fluctuation_within_threshold<T0: drop>(arg0: &mut PriceOracleConfig, arg1: 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64) : bool {
        let v0 = get_price_fluctuation_threshold<T0>(arg0);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg0.last_fetched_price, 0x1::type_name::get<T0>())) {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&mut arg0.last_fetched_price, 0x1::type_name::get<T0>());
            let v2 = 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::value(v1));
            if (0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::greater(arg1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(v2, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::add(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one(), v0))) || 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::less(arg1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::multiply(v2, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::sub(0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::one(), v0)))) {
                return false
            };
            0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::set_value(v1, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::get_raw_value(arg1));
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&mut arg0.last_fetched_price, 0x1::type_name::get<T0>(), arg1);
        };
        true
    }

    public fun set_price_fluctuation_threshold<T0: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg1: &mut PriceOracleConfig, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg0, 0x2::tx_context::sender(arg3), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::admin_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&arg1.price_fluctuation_threshold, v0)) {
            0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::set_value(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&mut arg1.price_fluctuation_threshold, v0), arg2);
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::FixedPoint64>(&mut arg1.price_fluctuation_threshold, v0, 0x36eca5eec2712ed9cbd7a5cdf3d6de9d2be513c433546a3bba12e5d87fd31d5b::fixed_point64::create_from_raw_value(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

