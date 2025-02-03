module 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::turbos {
    struct TurbosWrappedPosition has store {
        inner: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT,
        tick_a: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_b: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        liquidity: u128,
    }

    public fun borrow_for_position_x<T0, T1, T2>(arg0: &mut 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>, arg1: &0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig, arg2: &mut 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::SupplyPool<T0, T2>, arg3: &0x2::clock::Clock) {
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::cpt_config_id<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig>(arg1), 9223373080531828735);
        if (0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::dx<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::balance::value<T0>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::borrowed_x<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0))) {
        } else {
            let (v0, v1) = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::borrow<T0, T2>(arg2, 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::lend_facil_cap(arg1), 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::dx<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), arg3);
            0x2::balance::join<T0>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::borrowed_x_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v0);
            0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::fdb_add<T0, T2>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::cpt_debt_bag_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v1);
        };
    }

    public fun borrow_for_position_y<T0, T1, T2>(arg0: &mut 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>, arg1: &0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig, arg2: &mut 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::SupplyPool<T1, T2>, arg3: &0x2::clock::Clock) {
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::cpt_config_id<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig>(arg1), 9223373110596599807);
        if (0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::dy<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0) == 0x2::balance::value<T0>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::borrowed_x<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0))) {
        } else {
            let (v0, v1) = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::borrow<T1, T2>(arg2, 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::lend_facil_cap(arg1), 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::dy<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), arg3);
            0x2::balance::join<T1>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::borrowed_y_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v0);
            0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::fdb_add<T1, T2>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::cpt_debt_bag_mut<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg0), v1);
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

    public fun create_position<T0, T1, T2>(arg0: &0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig, arg1: 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: 0x2::balance::Balance<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionCap {
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::cpt_config_id<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1) == 0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig>(arg0), 9223373166431174655);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2) == 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::pool_object_id(arg0), 9223373166431174655);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg5) == 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::position_creation_fee_sui(arg0), 9223373166431174655);
        assert!(0x2::balance::value<T0>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::borrowed_x<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1)) == 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::dx<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1), 9223373166431174655);
        assert!(0x2::balance::value<T1>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::borrowed_y<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1)) == 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::dy<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(&arg1), 9223373166431174655);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::destroy_create_position_ticket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(arg1);
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
        let v18 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::balance_bag::empty(arg7);
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::balance_bag::add<0x2::sui::SUI>(&mut v18, arg5);
        let v19 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::position_constructor<T0, T1, TurbosWrappedPosition>(0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig>(arg0), v17, v12, v11, v10, v18, arg7);
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::emit_position_creation_info(0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(&v19), v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), v5, v13, v14, 0x2::balance::value<T0>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::col_x<T0, T1, TurbosWrappedPosition>(&v19)), 0x2::balance::value<T1>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::col_y<T0, T1, TurbosWrappedPosition>(&v19)), v3, v4, 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::position_creation_fee_sui(arg0));
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::position_share_object<T0, T1, TurbosWrappedPosition>(v19);
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::position_cap_constructor(0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::Position<T0, T1, TurbosWrappedPosition>>(&v19), arg7)
    }

    public fun create_position_ticket<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u128, arg7: &0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::pyth::PythPriceInfo, arg8: &mut 0x2::tx_context::TxContext) : 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::CreatePositionTicket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32> {
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::check_config_version(arg1);
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::allow_new_positions(arg1), 9223373041877123071);
        assert!(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0) == 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::pool_object_id(arg1), 9223373041877123071);
        let v0 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::validate_price_info(arg1, arg7);
        assert!(arg6 <= 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::max_position_l(arg1), 9223373041877123071);
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::current_global_l(arg1) + arg6 <= 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::max_global_l(arg1), 9223373041877123071);
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::increase_current_global_l(arg1, arg6);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg2, v1), 9223373041877123071);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(v1, arg3), 9223373041877123071);
        let v3 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::pyth::div_price_numeric_x128(&v0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>());
        let v4 = (v2 as u256) * (v2 as u256);
        let v5 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::util::min_u256(v3, v4);
        let v6 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::util::max_u256(v3, v4);
        let (v7, v8) = calc_deposit_amounts_by_liquidity<T0, T1, T2>(arg0, arg2, arg3, arg6);
        let (v9, v10) = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::calc_borrow_amt(0x2::balance::value<T0>(&arg4), v7);
        let (v11, v12) = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::calc_borrow_amt(0x2::balance::value<T1>(&arg5), v8);
        let v13 = 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_model_clmm::create(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg3), arg6, v10, v12, v9, v11);
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::liq_margin_is_valid(arg1, &v13, v5, v6), 9223373041877123071);
        assert!(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::init_margin_is_valid(arg1, &v13, v5, v6), 9223373041877123071);
        0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::new_create_position_ticket<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32>(0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::PositionConfig>(arg1), arg2, arg3, 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_model_clmm::dx(&v13), 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_model_clmm::dy(&v13), arg6, arg4, arg5, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), 0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::empty_facil_debt_bag(0x2::object::id<0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::supply_pool::LendFacilCap>(0x42a9d7cee5c1aefba9af456703330f4ea883a01094b58bdc0584f1e85cadb7e8::position_core_clmm::lend_facil_cap(arg1)), arg8))
    }

    public fun slippage_tolerance_assertion<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u256, arg2: u16) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        let v1 = (v0 as u256) * (v0 as u256) >> 64;
        let v2 = arg1 >> 64;
        let v3 = v2 + v2 * (arg2 as u256) / 10000;
        let v4 = v2 - v2 * (arg2 as u256) / 10000;
        if (v1 < v4) {
        };
        assert!(v1 >= v4 && v1 <= v3, 9223372831423725567);
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

