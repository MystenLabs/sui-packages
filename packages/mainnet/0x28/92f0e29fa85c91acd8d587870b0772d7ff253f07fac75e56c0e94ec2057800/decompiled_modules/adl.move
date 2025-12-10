module 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::adl {
    public(friend) fun execute_adl<T0>(arg0: &mut 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: vector<u128>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg7: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::price_feed_storage::PriceFeedStorage, arg8: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::config::Config, arg9: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::adl_counterparties_mismatch());
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::adl_counterparties_mismatch());
        let v1 = 0x2::object::id<0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::ClearingHouse<T0>>(arg0);
        let (v2, v3) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_market_objects<T0>(arg0);
        let v4 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_lot_size(v2);
        let v5 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_collateral_haircut(v2);
        let v6 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_collateral_oracle_price(v2, arg7, arg8, arg9);
        let v7 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_base_oracle_price(v2, arg6, arg8, arg9);
        let (v8, v9) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::market::get_cum_funding_rates(v3);
        let v10 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::calculate_mark_price(v3, v2, v7, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::book_price_or_index(0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_orderbook<T0>(arg0), v7), 0x2::clock::timestamp_ms(arg9));
        let v11 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(v10, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling());
        let v12 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position<T0>(arg0, arg1);
        let v13 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::is_long(v12);
        let (v14, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::compute_margin_with_fundings(v12, v6, v10, 0, v8, v9, v5);
        if (0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::greater_than(v14, 0)) {
            return
        };
        let v16 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_orderbook_mut<T0>(arg0);
        let v17 = 0x1::vector::length<u128>(&arg2);
        let (v18, v19) = if (v17 != 0) {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::force_cancel_orders(v16, arg1, &arg2, v1)
        } else {
            (0, 0)
        };
        let v20 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position_mut<T0>(arg0, arg1);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::settle_position_funding(v20, v6, v8, v9, &v1, arg1);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::sub_from_pending_amount(v20, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::ask(), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v18, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling()));
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::sub_from_pending_amount(v20, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::bid(), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v19, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling()));
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::update_pending_orders(v20, false, v17);
        let (v21, _) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v20);
        let v23 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(v21), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling());
        let (v24, v25) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_base_and_quote_deltas(v11, v23);
        if (v13) {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::add_short_to_position(v20, v24, v25);
        } else {
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::add_long_to_position(v20, v24, v25);
        };
        let (v26, v27) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v20);
        assert!(v26 == 0 && v27 == 0, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::adl_bad_debt_position_not_closed());
        let v28 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_collateral(v20);
        0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::reset_collateral(v20);
        let v29 = v0 - 1;
        let v30 = 0;
        let v31 = 0;
        loop {
            let v32 = (*0x1::vector::borrow<u64>(&arg5, v29) as u256);
            v31 = v31 + v32;
            let v33 = *0x1::vector::borrow<u64>(&arg3, v29);
            let v34 = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_position_mut<T0>(arg0, v33);
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::settle_position_funding(v34, v6, v8, v9, &v1, v33);
            let (v35, v36) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::get_amounts(v34);
            let v37 = *0x1::vector::borrow<u64>(&arg4, v29);
            assert!(v37 % v4 == 0, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::size_not_multiple_of_lot_size());
            assert!((v21 == 0 || 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::is_long(v34) != v13) && v37 <= 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::abs(v35), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling()), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::adl_counterparty_insufficient());
            v30 = v30 + v37;
            let (v38, v39) = 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::clearing_house::get_base_and_quote_deltas(v11, v37);
            if (v13) {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::add_long_to_position(v34, v38, v39);
            } else {
                0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::add_short_to_position(v34, v38, v39);
            };
            let v40 = if (v29 == 0) {
                v28
            } else {
                0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(v28, v32)
            };
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::position::add_to_collateral(v34, v40);
            v28 = 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(v28, v40);
            let v41 = if (v37 == 0) {
                0
            } else {
                let v42 = if (v13) {
                    0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::sub(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(v36, v35), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(v40, v6), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v37, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling())))
                } else {
                    0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::add(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(v36, v35), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::div(0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::mul(v40, v6), 0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::from_balance(v37, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling())))
                };
                0x715b6f9c215d4bad96e71be2f07c7aa699bc720300613f1d882dce6b2a355afb::ifixed::to_balance(v42, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::b9_scaling())
            };
            0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::events::emit_performed_adl(v1, arg1, v37, v40, v41, v33, v13);
            if (v29 == 0) {
                break
            };
            v29 = v29 - 1;
        };
        assert!(v30 == v23, 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::adl_bad_debt_position_not_closed());
        assert!(v31 == 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::constants::one_fixed(), 0x2892f0e29fa85c91acd8d587870b0772d7ff253f07fac75e56c0e94ec2057800::errors::adl_weights_do_not_sum_to_one());
    }

    // decompiled from Move bytecode v6
}

