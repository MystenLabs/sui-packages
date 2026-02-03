module 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::adl {
    public(friend) fun execute_adl<T0>(arg0: &mut 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: vector<u128>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg7: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg8: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg9: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::adl_counterparties_mismatch());
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::adl_counterparties_mismatch());
        let v1 = 0x2::object::id<0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::ClearingHouse<T0>>(arg0);
        let (v2, v3) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_market_objects<T0>(arg0);
        let v4 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::market::get_lot_size(v2);
        let v5 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::market::get_collateral_haircut(v2);
        let v6 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::market::get_collateral_oracle_price(v2, arg7, arg8, arg9);
        let v7 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::market::get_base_oracle_price(v2, arg6, arg8, arg9);
        let (v8, v9) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::market::get_cum_funding_rates(v3);
        let v10 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::calculate_mark_price(v3, v2, v7, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::book_price_or_index(0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_orderbook<T0>(arg0), v7), 0x2::clock::timestamp_ms(arg9));
        let v11 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(v10, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::b9_scaling());
        let v12 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_position<T0>(arg0, arg1);
        let v13 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::is_long(v12);
        let (v14, _) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::compute_margin_with_fundings(v12, v6, v10, 0, v8, v9, v5);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v14, 0)) {
            return
        };
        let v16 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_orderbook_mut<T0>(arg0);
        let v17 = 0x1::vector::length<u128>(&arg2);
        let (v18, v19) = if (v17 != 0) {
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::force_cancel_orders(v16, arg1, &arg2, v1)
        } else {
            (0, 0)
        };
        let v20 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_position_mut<T0>(arg0, arg1);
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::settle_position_funding(v20, v6, v8, v9, &v1, arg1);
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::sub_from_pending_amount(v20, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::ask(), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v18, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::b9_scaling()));
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::sub_from_pending_amount(v20, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::bid(), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v19, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::b9_scaling()));
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::update_pending_orders(v20, false, v17);
        let (v21, _) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::get_amounts(v20);
        let v23 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v21), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::b9_scaling());
        let (v24, v25) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_base_and_quote_deltas(v11, v23);
        let v26 = if (v13) {
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_short_to_position(v20, v24, v25)
        } else {
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_long_to_position(v20, v24, v25)
        };
        let (v27, v28) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::get_amounts(v20);
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_to_collateral_usd(v20, v26, v6);
        assert!(v27 == 0 && v28 == 0, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::adl_bad_debt_position_not_closed());
        let v29 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::get_collateral(v20);
        0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::reset_collateral(v20);
        let v30 = v0 - 1;
        let v31 = 0;
        let v32 = 0;
        loop {
            let v33 = (*0x1::vector::borrow<u64>(&arg5, v30) as u256);
            v32 = v32 + v33;
            let v34 = *0x1::vector::borrow<u64>(&arg3, v30);
            let v35 = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_position_mut<T0>(arg0, v34);
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::settle_position_funding(v35, v6, v8, v9, &v1, v34);
            let (v36, _) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::get_amounts(v35);
            let v38 = *0x1::vector::borrow<u64>(&arg4, v30);
            assert!(v38 % v4 == 0, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::size_not_multiple_of_lot_size());
            assert!((v21 == 0 || 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::is_long(v35) != v13) && v38 <= 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v36), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::b9_scaling()), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::adl_counterparty_insufficient());
            v31 = v31 + v38;
            let (v39, v40) = 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::clearing_house::get_base_and_quote_deltas(v11, v38);
            let v41 = if (v13) {
                0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_long_to_position(v35, v39, v40)
            } else {
                0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_short_to_position(v35, v39, v40)
            };
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_to_collateral_usd(v35, v41, v6);
            let v42 = if (v30 == 0) {
                v29
            } else {
                0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v29, v33)
            };
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::position::add_to_collateral(v35, v42);
            v29 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v29, v42);
            0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::events::emit_performed_adl(v1, arg1, v38, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v41, v6), v42), v11, v34, v13);
            if (v30 == 0) {
                break
            };
            v30 = v30 - 1;
        };
        assert!(v31 == v23, 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::adl_bad_debt_position_not_closed());
        assert!(v32 == 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::constants::one_fixed(), 0x9cb65a24f22da5ca3e68c60c4db31002dfa25e50da2ea9957f06c2f78c253cd2::errors::adl_weights_do_not_sum_to_one());
    }

    // decompiled from Move bytecode v6
}

