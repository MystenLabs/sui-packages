module 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::turbos {
    struct TurbosWrappedPosition has store {
        inner: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT,
        tick_a: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_b: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        liquidity: u128,
    }

    public fun repay_debt_x<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionCap, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T0, T2>, arg4: &0x2::clock::Clock) {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::repay_debt_x<T0, T1, T2, TurbosWrappedPosition>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun repay_debt_y<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionCap, arg2: &mut 0x2::balance::Balance<T1>, arg3: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T1, T2>, arg4: &0x2::clock::Clock) {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::repay_debt_y<T0, T1, T2, TurbosWrappedPosition>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun calc_liquidate_col_x<T0, T1>(arg0: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg4: u64) : (u64, u64) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223374386201886719);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223374386201886719);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg3);
        let v2 = &v1;
        let (v3, v4) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0));
        let v5 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0));
        let v6 = if (v5 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), v5)
        } else {
            0
        };
        let v7 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0));
        let v8 = if (v7 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), v7)
        } else {
            0
        };
        let v9 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)), v6, v8);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_liquidate_col_x(&v9, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>()), arg4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_bonus_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_liq_factor_bps(arg1))
    }

    public fun calc_liquidate_col_y<T0, T1>(arg0: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg4: u64) : (u64, u64) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223374429151559679);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223374429151559679);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg3);
        let v2 = &v1;
        let (v3, v4) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0));
        let v5 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0));
        let v6 = if (v5 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), v5)
        } else {
            0
        };
        let v7 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0));
        let v8 = if (v7 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), v7)
        } else {
            0
        };
        let v9 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)), v6, v8);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_liquidate_col_y(&v9, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>()), arg4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_bonus_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_liq_factor_bps(arg1))
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionCap, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg4: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pc_position_id(arg2) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), 9223373870805811199);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373870805811199);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg5), 9223373870805811199);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg3);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg4);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg5);
        let v3 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
        let (v4, v5, v6) = wrapped_increase_liquidity<T0, T1, T2>(v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_current_global_l(arg1, v4);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::current_global_l(arg1) <= 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::max_global_l(arg1), 9223373870805811199);
        assert!(wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0)) <= 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::max_position_l(arg1), 9223373870805811199);
        let v7 = arg0;
        let v8 = &v1;
        let (v9, v10) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v7));
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7));
        let v12 = if (v11 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v8, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7)), v11)
        } else {
            0
        };
        let v13 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7));
        let v14 = if (v13 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v8, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7)), v13)
        } else {
            0
        };
        let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v9), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v10), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v7)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v7)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v7)), v12, v14);
        assert!(!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v15, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>()), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1)), 9223373870805811199);
        let v16 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::add_liquidity_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v2, v4, v5, v6);
        if (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ali_delta_l(&v16) > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ali_emit(v16);
        };
    }

    public fun borrow_for_position_x<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T0, T2>, arg3: &0x2::clock::Clock) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::cpt_config_id<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373084826796031);
        if (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::dx<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::borrowed_x<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0))) {
        } else {
            let (v0, v1) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::borrow<T0, T2>(arg2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lend_facil_cap(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::dx<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), arg3);
            0x2::balance::join<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::borrowed_x_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v0);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_add<T0, T2>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::cpt_debt_bag_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v1);
        };
    }

    public fun borrow_for_position_y<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T1, T2>, arg3: &0x2::clock::Clock) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::cpt_config_id<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373114891567103);
        if (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::dy<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::borrowed_y<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0))) {
        } else {
            let (v0, v1) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::borrow<T1, T2>(arg2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lend_facil_cap(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::dy<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), arg3);
            0x2::balance::join<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::borrowed_y_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v0);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_add<T1, T2>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::cpt_debt_bag_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v1);
        };
    }

    public fun calc_deposit_amounts_by_liquidity<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: u128) : (u64, u64) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        if (arg3 == 0) {
            return (0, 0)
        };
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0), arg1)) {
            return ((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta_(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), arg3, true) as u64), 0)
        };
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0), arg2)) {
            return (0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta_(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), arg3, true) as u64))
        };
        ((0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_a_delta_(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), arg3, true) as u64), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_sqrt_price::get_amount_b_delta_(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg1), arg3, true) as u64))
    }

    public fun create_deleverage_ticket<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::DeleverageTicket, 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest) {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373265215422463);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg4), 9223373265215422463);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373265215422463);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_ticket_active<T0, T1, TurbosWrappedPosition>(arg0, true);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg3);
        let v2 = arg0;
        let v3 = &v1;
        let (v4, v5) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2));
        let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v7 = if (v6 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v6)
        } else {
            0
        };
        let v8 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v9 = if (v8 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v8)
        } else {
            0
        };
        let v10 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v2)), v7, v9);
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v12 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v10, v11, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg4), 0, 0, 0, 0, 0);
        let v13 = if (!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v10, v11, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1))) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), false, false, v12)
        } else {
            let v14 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::min_u128(arg7, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_max_deleverage_delta_l(&v10, v11, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_deleverage_factor_bps(arg1)));
            let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
            let (v16, v17) = wrapped_decrease_liquidity<T0, T1, T2>(arg4, arg5, arg6, v15, v14, arg8, arg9);
            let v18 = v17;
            let v19 = v16;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_l(&mut v12, v14);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_x(&mut v12, 0x2::balance::value<T0>(&v19));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_y(&mut v12, 0x2::balance::value<T1>(&v18));
            0x2::balance::join<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x_mut<T0, T1, TurbosWrappedPosition>(arg0), v19);
            0x2::balance::join<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y_mut<T0, T1, TurbosWrappedPosition>(arg0), v18);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::decrease_current_global_l(arg1, v14);
            let v20 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            let v21 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v20, v21, v12)
        };
        (v13, 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ADeleverage>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::a_deleverage(), arg9))
    }

    public fun create_deleverage_ticket_for_liquidation<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::DeleverageTicket {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373351114768383);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg4), 9223373351114768383);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373351114768383);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_ticket_active<T0, T1, TurbosWrappedPosition>(arg0, true);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg3);
        let v2 = arg0;
        let v3 = &v1;
        let (v4, v5) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2));
        let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v7 = if (v6 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v6)
        } else {
            0
        };
        let v8 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v9 = if (v8 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v8)
        } else {
            0
        };
        let v10 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v2)), v7, v9);
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v12 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v10, v11, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg4), 0, 0, 0, 0, 0);
        if (!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v10, v11, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1))) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), false, false, v12)
        } else {
            let v14 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::min_u128(340282366920938463463374607431768211455, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_max_deleverage_delta_l(&v10, v11, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_deleverage_factor_bps(arg1)));
            let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
            let (v16, v17) = wrapped_decrease_liquidity<T0, T1, T2>(arg4, arg5, arg6, v15, v14, arg7, arg8);
            let v18 = v17;
            let v19 = v16;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_l(&mut v12, v14);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_x(&mut v12, 0x2::balance::value<T0>(&v19));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_y(&mut v12, 0x2::balance::value<T1>(&v18));
            0x2::balance::join<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x_mut<T0, T1, TurbosWrappedPosition>(arg0), v19);
            0x2::balance::join<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y_mut<T0, T1, TurbosWrappedPosition>(arg0), v18);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::decrease_current_global_l(arg1, v14);
            let v20 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            let v21 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v20, v21, v12)
        }
    }

    public fun create_position<T0, T1, T2>(arg0: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg1: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionCap {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::cpt_config_id<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg0), 9223373170726141951);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2) == 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg0), 9223373170726141951);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg5) == 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_creation_fee_sui(arg0), 9223373170726141951);
        assert!(0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::borrowed_x<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1)) == 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::dx<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1), 9223373170726141951);
        assert!(0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::borrowed_y<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1)) == 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::dy<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1), 9223373170726141951);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::destroy_create_position_ticket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg1);
        let v11 = v7;
        let v12 = v6;
        let (v13, v14) = calc_deposit_amounts_by_liquidity<T0, T1, T2>(arg2, v1, v2, v5);
        let v15 = v8;
        if (0x2::balance::value<T0>(&v15) < v13) {
            0x2::balance::join<T0>(&mut v15, 0x2::balance::split<T0>(&mut v12, v13 - 0x2::balance::value<T0>(&v15)));
        };
        let v16 = v9;
        if (0x2::balance::value<T1>(&v16) < v14) {
            0x2::balance::join<T1>(&mut v16, 0x2::balance::split<T1>(&mut v11, v14 - 0x2::balance::value<T1>(&v16)));
        };
        let v17 = wrapped_open_position<T0, T1, T2>(arg2, arg3, arg4, v1, v2, v15, v16, arg6, arg7);
        let v18 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::balance_bag::empty(arg7);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::balance_bag::add<0x2::sui::SUI>(&mut v18, arg5);
        let v19 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_constructor<T0, T1, TurbosWrappedPosition>(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg0), v17, v12, v11, v10, v18, arg7);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::emit_position_creation_info(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(&v19), v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), v5, v13, v14, 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(&v19)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(&v19)), v3, v4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_creation_fee_sui(arg0));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_share_object<T0, T1, TurbosWrappedPosition>(v19);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_cap_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(&v19), arg7)
    }

    public fun create_position_ticket<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg8: &mut 0x2::tx_context::TxContext) : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32> {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_config_version(arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::allow_new_positions(arg1), 9223373046172090367);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1), 9223373046172090367);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg7);
        assert!(arg6 <= 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::max_position_l(arg1), 9223373046172090367);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::current_global_l(arg1) + arg6 <= 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::max_global_l(arg1), 9223373046172090367);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_current_global_l(arg1, arg6);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg2, v1), 9223373046172090367);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(v1, arg3), 9223373046172090367);
        let v3 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v4 = (v2 as u256) * (v2 as u256);
        let v5 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::min_u256(v3, v4);
        let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::max_u256(v3, v4);
        let (v7, v8) = calc_deposit_amounts_by_liquidity<T0, T1, T2>(arg0, arg2, arg3, arg6);
        let (v9, v10) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::calc_borrow_amt(0x2::balance::value<T0>(&arg4), v7);
        let (v11, v12) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::calc_borrow_amt(0x2::balance::value<T1>(&arg5), v8);
        let v13 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg3), arg6, v10, v12, v9, v11);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_is_valid(arg1, &v13, v5, v6), 9223373046172090367);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::init_margin_is_valid(arg1, &v13, v5, v6), 9223373046172090367);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::new_create_position_ticket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), arg2, arg3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::dx(&v13), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::dy(&v13), arg6, arg4, arg5, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::empty_facil_debt_bag(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::LendFacilCap>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lend_facil_cap(arg1)), arg8))
    }

    public fun deleverage<T0, T1, T2, T3, T4>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T0, T3>, arg4: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T1, T4>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373445604048895);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::empty(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::LendFacilCap>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lend_facil_cap(arg1)));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::add_from_supply_pool<T0, T3>(&mut v0, arg3, arg9);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::add_from_supply_pool<T1, T4>(&mut v0, arg4, arg9);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373445604048895);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg5), 9223373445604048895);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373445604048895);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_ticket_active<T0, T1, TurbosWrappedPosition>(arg0, true);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v2 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, &v0);
        let v3 = arg0;
        let v4 = &v2;
        let (v5, v6) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v3));
        let v7 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3));
        let v8 = if (v7 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3)), v7)
        } else {
            0
        };
        let v9 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3));
        let v10 = if (v9 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3)), v9)
        } else {
            0
        };
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v6), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v3)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v3)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v3)), v8, v10);
        let v12 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v13 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v11, v12, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg5), 0, 0, 0, 0, 0);
        let v14 = if (!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v11, v12, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1))) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), false, false, v13)
        } else {
            let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::min_u128(arg8, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_max_deleverage_delta_l(&v11, v12, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_deleverage_factor_bps(arg1)));
            let v16 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
            let (v17, v18) = wrapped_decrease_liquidity<T0, T1, T2>(arg5, arg6, arg7, v16, v15, arg9, arg10);
            let v19 = v18;
            let v20 = v17;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_l(&mut v13, v15);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_x(&mut v13, 0x2::balance::value<T0>(&v20));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_y(&mut v13, 0x2::balance::value<T1>(&v19));
            0x2::balance::join<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x_mut<T0, T1, TurbosWrappedPosition>(arg0), v20);
            0x2::balance::join<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y_mut<T0, T1, TurbosWrappedPosition>(arg0), v19);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::decrease_current_global_l(arg1, v15);
            let v21 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            let v22 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v21, v22, v13)
        };
        let v23 = v14;
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_repay_x<T0, T1, T3, TurbosWrappedPosition>(arg0, arg1, &mut v23, arg3, arg9);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_repay_y<T0, T1, T4, TurbosWrappedPosition>(arg0, arg1, &mut v23, arg4, arg9);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::destroy_deleverage_ticket<T0, T1, TurbosWrappedPosition>(arg0, v23);
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ADeleverage>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::a_deleverage(), arg10)
    }

    public fun deleverage_for_liquidation<T0, T1, T2, T3, T4>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T0, T3>, arg4: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T1, T4>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373540093329407);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::empty(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::LendFacilCap>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lend_facil_cap(arg1)));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::add_from_supply_pool<T0, T3>(&mut v0, arg3, arg8);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::add_from_supply_pool<T1, T4>(&mut v0, arg4, arg8);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373540093329407);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg5), 9223373540093329407);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373540093329407);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_ticket_active<T0, T1, TurbosWrappedPosition>(arg0, true);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v2 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, &v0);
        let v3 = arg0;
        let v4 = &v2;
        let (v5, v6) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v3));
        let v7 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3));
        let v8 = if (v7 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3)), v7)
        } else {
            0
        };
        let v9 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3));
        let v10 = if (v9 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v4, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v3)), v9)
        } else {
            0
        };
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v6), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v3)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v3)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v3)), v8, v10);
        let v12 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v1, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v13 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v11, v12, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg5), 0, 0, 0, 0, 0);
        let v14 = if (!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v11, v12, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1))) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), false, false, v13)
        } else {
            let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::min_u128(340282366920938463463374607431768211455, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_max_deleverage_delta_l(&v11, v12, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_deleverage_factor_bps(arg1)));
            let v16 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
            let (v17, v18) = wrapped_decrease_liquidity<T0, T1, T2>(arg5, arg6, arg7, v16, v15, arg8, arg9);
            let v19 = v18;
            let v20 = v17;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_l(&mut v13, v15);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_x(&mut v13, 0x2::balance::value<T0>(&v20));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::set_delta_y(&mut v13, 0x2::balance::value<T1>(&v19));
            0x2::balance::join<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x_mut<T0, T1, TurbosWrappedPosition>(arg0), v20);
            0x2::balance::join<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y_mut<T0, T1, TurbosWrappedPosition>(arg0), v19);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::decrease_current_global_l(arg1, v15);
            let v21 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            let v22 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)) > 0 && 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)) > 0;
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v21, v22, v13)
        };
        let v23 = v14;
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_repay_x<T0, T1, T3, TurbosWrappedPosition>(arg0, arg1, &mut v23, arg3, arg8);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_ticket_repay_y<T0, T1, T4, TurbosWrappedPosition>(arg0, arg1, &mut v23, arg4, arg8);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::destroy_deleverage_ticket<T0, T1, TurbosWrappedPosition>(arg0, v23);
    }

    public fun liquidate_col_x<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg4: &mut 0x2::balance::Balance<T1>, arg5: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T1, T2>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373617402740735);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373617402740735);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg3);
        let v2 = arg0;
        let v3 = &v1;
        let (v4, v5) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2));
        let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v7 = if (v6 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v6)
        } else {
            0
        };
        let v8 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v9 = if (v8 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v8)
        } else {
            0
        };
        let v10 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v2)), v7, v9);
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let (v12, v13) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_liquidate_col_x(&v10, v11, 0x2::balance::value<T1>(arg4), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_bonus_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_liq_factor_bps(arg1));
        if (v12 == 0) {
            0x2::balance::zero<T0>()
        } else {
            let v15 = 0x2::balance::split<T1>(arg4, v12);
            let v16 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_take_all<T2>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag_mut<T0, T1, TurbosWrappedPosition>(arg0));
            let (_, v18) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::repay_max_possible<T1, T2>(arg5, &mut v16, &mut v15, arg6);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_add<T1, T2>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag_mut<T0, T1, TurbosWrappedPosition>(arg0), v16);
            0x2::balance::join<T1>(arg4, v15);
            let v19 = 0x2::balance::split<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x_mut<T0, T1, TurbosWrappedPosition>(arg0), v13);
            let v20 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::calc_liq_fee_from_reward(arg1, v13);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::balance_bag::add<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::collected_fees_mut<T0, T1, TurbosWrappedPosition>(arg0), 0x2::balance::split<T0>(&mut v19, v20));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::emit_liquidation_info(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v10, v11, 0, v18, 0x2::balance::value<T0>(&v19), 0, v20, 0);
            v19
        }
    }

    public fun liquidate_col_y<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T0, T2>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373677532282879);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373677532282879);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg2);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg3);
        let v2 = arg0;
        let v3 = &v1;
        let (v4, v5) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2));
        let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v7 = if (v6 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v6)
        } else {
            0
        };
        let v8 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2));
        let v9 = if (v8 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v3, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v2)), v8)
        } else {
            0
        };
        let v10 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v5), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v2)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v2)), v7, v9);
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let (v12, v13) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::calc_liquidate_col_y(&v10, v11, 0x2::balance::value<T0>(arg4), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_bonus_bps(arg1), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::base_liq_factor_bps(arg1));
        if (v12 == 0) {
            0x2::balance::zero<T1>()
        } else {
            let v15 = 0x2::balance::split<T0>(arg4, v12);
            let v16 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_take_all<T2>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag_mut<T0, T1, TurbosWrappedPosition>(arg0));
            let (_, v18) = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::repay_max_possible<T0, T2>(arg5, &mut v16, &mut v15, arg6);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_add<T0, T2>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag_mut<T0, T1, TurbosWrappedPosition>(arg0), v16);
            0x2::balance::join<T0>(arg4, v15);
            let v19 = 0x2::balance::split<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y_mut<T0, T1, TurbosWrappedPosition>(arg0), v13);
            let v20 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::calc_liq_fee_from_reward(arg1, v13);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::balance_bag::add<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::collected_fees_mut<T0, T1, TurbosWrappedPosition>(arg0), 0x2::balance::split<T1>(&mut v19, v20));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::emit_liquidation_info(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v10, v11, v18, 0, 0, 0x2::balance::value<T1>(&v19), 0, v20);
            v19
        }
    }

    public fun position_model<T0, T1>(arg0: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo) : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::PositionModel {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223374343252213759);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223374343252213759);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg2);
        let v1 = &v0;
        let (v2, v3) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0));
        let v4 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0));
        let v5 = if (v4 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v1, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), v4)
        } else {
            0
        };
        let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0));
        let v7 = if (v6 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v1, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), v6)
        } else {
            0
        };
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v3), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)), v5, v7)
    }

    public fun rebalance_add_liquidity<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::RebalanceReceipt, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg4: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::DebtInfo, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::rr_position_id(arg2) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), 9223374265942802431);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223374265942802431);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg5), 9223374265942802431);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg3);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, arg4);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg5);
        let v3 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
        let (v4, v5, v6) = wrapped_increase_liquidity<T0, T1, T2>(v3, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_current_global_l(arg1, v4);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::current_global_l(arg1) <= 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::max_global_l(arg1), 9223374265942802431);
        assert!(wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0)) <= 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::max_position_l(arg1), 9223374265942802431);
        let v7 = arg0;
        let v8 = &v1;
        let (v9, v10) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v7));
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7));
        let v12 = if (v11 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v8, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7)), v11)
        } else {
            0
        };
        let v13 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7));
        let v14 = if (v13 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v8, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v7)), v13)
        } else {
            0
        };
        let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v9), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v10), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v7)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v7)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v7)), v12, v14);
        assert!(!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v15, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>()), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::deleverage_margin_bps(arg1)), 9223374265942802431);
        let v16 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::add_liquidity_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v2, v4, v5, v6);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_delta_l(arg2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ali_delta_l(&v16));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_delta_x(arg2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ali_delta_x(&v16));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_delta_y(arg2, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ali_delta_y(&v16));
    }

    public fun rebalance_collect_fee<T0, T1, T2>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::RebalanceReceipt, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223374046899470335);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::rr_position_id(arg2) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), 9223374046899470335);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg3, arg4, &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0).inner, 18446744073709551615, 18446744073709551615, @0x0, 18446744073709551615, arg6, arg5, arg7);
        let v2 = 0x2::coin::into_balance<T1>(v1);
        let v3 = 0x2::coin::into_balance<T0>(v0);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_collected_amm_fee_x(arg2, 0x2::balance::value<T0>(&v3));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::increase_collected_amm_fee_y(arg2, 0x2::balance::value<T1>(&v2));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::take_rebalance_fee<T0, T1, TurbosWrappedPosition, T0>(arg0, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::rebalance_fee_bps(arg1), &mut v3, arg2);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::take_rebalance_fee<T0, T1, TurbosWrappedPosition, T1>(arg0, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::rebalance_fee_bps(arg1), &mut v2, arg2);
        (v3, v2)
    }

    public(friend) fun rebalance_collect_reward<T0, T1, T2, T3>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::RebalanceReceipt, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223374149978685439);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::rr_position_id(arg2) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), 9223374149978685439);
        let v0 = 0x2::coin::into_balance<T3>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg3, arg4, &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0).inner, arg6, arg7, 18446744073709551615, @0x0, 18446744073709551615, arg8, arg5, arg9));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::add_amount_to_map<T3>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::collected_amm_rewards_mut(arg2), 0x2::balance::value<T3>(&v0));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::take_rebalance_fee<T0, T1, TurbosWrappedPosition, T3>(arg0, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::rebalance_fee_bps(arg1), &mut v0, arg2);
        v0
    }

    public fun reduce<T0, T1, T2, T3, T4>(arg0: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>, arg1: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig, arg2: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionCap, arg3: &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::PythPriceInfo, arg4: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T0, T3>, arg5: &mut 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::SupplyPool<T1, T4>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg7: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ReductionRepaymentTicket<T3, T4>) {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::check_versions<T0, T1, TurbosWrappedPosition>(arg0, arg1);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_config_id<T0, T1, TurbosWrappedPosition>(arg0) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::PositionConfig>(arg1), 9223373767726596095);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pool_object_id(arg1) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg6), 9223373767726596095);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::ticket_active<T0, T1, TurbosWrappedPosition>(arg0) == false, 9223373767726596095);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::pc_position_id(arg2) == 0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), 9223373767726596095);
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_price_info(arg1, arg3);
        let v1 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg6);
        let v3 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::empty(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::LendFacilCap>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lend_facil_cap(arg1)));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::add_from_supply_pool<T0, T3>(&mut v3, arg4, arg10);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::add_from_supply_pool<T1, T4>(&mut v3, arg5, arg10);
        let v4 = arg0;
        let v5 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::validate_debt_info(arg1, &v3);
        let v6 = &v5;
        let (v7, v8) = wrapped_tick_range(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v4));
        let v9 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v4));
        let v10 = if (v9 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v6, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v4)), v9)
        } else {
            0
        };
        let v11 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v4));
        let v12 = if (v11 > 0) {
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_info::calc_repay_by_shares(v6, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_type_for_asset<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(v4)), v11)
        } else {
            0
        };
        let v13 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v7), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v8), wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(v4)), 0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(v4)), 0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(v4)), v10, v12);
        assert!(!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v13, v1, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1)), 9223373767726596095);
        assert!(!0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_model_clmm::margin_below_threshold(&v13, (v2 as u256) * (v2 as u256), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::liq_margin_bps(arg1)), 9223373767726596095);
        let v14 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(arg9, wrapped_liquidity(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position<T0, T1, TurbosWrappedPosition>(arg0)), 18446744073709551616);
        let v15 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::lp_position_mut<T0, T1, TurbosWrappedPosition>(arg0);
        let (v16, v17) = wrapped_decrease_liquidity<T0, T1, T2>(arg6, arg7, arg8, v15, v14, arg10, arg11);
        let v18 = v17;
        let v19 = v16;
        0x2::balance::join<T0>(&mut v19, 0x2::balance::split<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x_mut<T0, T1, TurbosWrappedPosition>(arg0), (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(arg9, (0x2::balance::value<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(arg0)) as u128), 18446744073709551616) as u64)));
        0x2::balance::join<T1>(&mut v18, 0x2::balance::split<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y_mut<T0, T1, TurbosWrappedPosition>(arg0), (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(arg9, (0x2::balance::value<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(arg0)) as u128), 18446744073709551616) as u64)));
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::decrease_current_global_l(arg1, v14);
        (v19, v18, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::reduction_repayment_ticket_constructor<T3, T4>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_take_amt<T3>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag_mut<T0, T1, TurbosWrappedPosition>(arg0), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(arg9, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T0>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), 18446744073709551616)), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_take_amt<T4>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag_mut<T0, T1, TurbosWrappedPosition>(arg0), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(arg9, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool::fdb_get_share_amount_by_asset_type<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::position_debt_bag<T0, T1, TurbosWrappedPosition>(arg0)), 18446744073709551616)), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::reduction_info_constructor(0x2::object::id<0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(arg0), v13, v1, v2, v14, 0x2::balance::value<T0>(&v19), 0x2::balance::value<T1>(&v18), 0x2::balance::value<T0>(&v19), 0x2::balance::value<T1>(&v18), 0, 0)))
    }

    public fun slippage_tolerance_assertion<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u256, arg2: u16) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = (v0 as u256) * (v0 as u256) >> 64;
        let v2 = arg1 >> 64;
        let v3 = v2 + v2 * (arg2 as u256) / 10000;
        let v4 = v2 - v2 * (arg2 as u256) / 10000;
        if (v1 < v4) {
        };
        assert!(v1 >= v4 && v1 <= v3, 9223372835718692863);
    }

    fun turbos_wrapped_update_values(arg0: &mut TurbosWrappedPosition, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0.inner));
        arg0.tick_a = v0;
        arg0.tick_b = v1;
        arg0.liquidity = v2;
    }

    fun wrapped_decrease_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut TurbosWrappedPosition, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg0, arg1, &mut arg3.inner, arg4, 0, 0, 18446744073709551615, arg5, arg2, arg6);
        turbos_wrapped_update_values(arg3, arg1);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
    }

    fun wrapped_increase_liquidity<T0, T1, T2>(arg0: &mut TurbosWrappedPosition, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u128, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        let (_, _, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg2, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg0.inner));
        let (v5, v6) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg1, arg2, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg4, arg7)), 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg5, arg7)), &mut arg0.inner, v0, v1, v0, v1, 18446744073709551615, arg6, arg3, arg7);
        0x2::coin::destroy_zero<T0>(v5);
        0x2::coin::destroy_zero<T1>(v6);
        turbos_wrapped_update_values(arg0, arg2);
        (arg0.liquidity - v4, v0, v1)
    }

    fun wrapped_liquidity(arg0: &TurbosWrappedPosition) : u128 {
        arg0.liquidity
    }

    fun wrapped_open_position<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : TurbosWrappedPosition {
        let v0 = 0x2::balance::value<T0>(&arg5);
        let v1 = 0x2::balance::value<T1>(&arg6);
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg0, arg1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg5, arg8)), 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg6, arg8)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg4), v0, v1, v0, v1, 18446744073709551615, arg7, arg2, arg8);
        let v5 = v2;
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        let (v6, v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg1, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v5));
        TurbosWrappedPosition{
            inner     : v5,
            tick_a    : v6,
            tick_b    : v7,
            liquidity : v8,
        }
    }

    fun wrapped_tick_range(arg0: &TurbosWrappedPosition) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        (arg0.tick_a, arg0.tick_b)
    }

    // decompiled from Move bytecode v6
}

