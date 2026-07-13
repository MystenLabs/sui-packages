module 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::adl {
    public fun execute_adl<T0>(arg0: &mut 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>, arg1: &0x139b50f0b6b549674ab79a0e1f3cb1be6aefa100c30f02f802770c73a753e51f::authority::AuthorityCap<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::PACKAGE, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ADL>, arg2: &0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::Registry, arg3: u64, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg9: &0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock) {
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::assert_package_version<T0>(arg0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_package_version(arg2);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::registry::assert_multiton_authority_cap_is_authorized<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::PACKAGE, 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::authority::ADL>(arg2, arg1);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::assert_market_is_not_closed<T0>(arg0);
        let v0 = 0x1::vector::length<u64>(&arg5);
        assert!(v0 == 0x1::vector::length<u64>(&arg6), 6001);
        assert!(v0 == 0x1::vector::length<u64>(&arg7), 6001);
        let v1 = 0x2::object::id<0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::ClearingHouse<T0>>(arg0);
        let v2 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::book_price<T0>(arg0);
        let (v3, v4) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_market_objects<T0>(arg0);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::try_update_funding(v3, v4, arg8, arg10, &v1, v2);
        let v5 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::lot_size(v3);
        let v6 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::collateral_oracle_price(v3, arg9, arg10);
        let (v7, v8) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::base_oracle_price_and_twap_price(v3, arg8, arg10);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::assert_index_twap_divergence_within_limit(v3, v7, v8);
        let v9 = if (0x1::option::is_none<u256>(&v2)) {
            v7
        } else {
            *0x1::option::borrow<u256>(&v2)
        };
        let (v10, v11) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::cum_funding_rates(v4);
        let v12 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::calculate_mark_price(v4, v3, v8, v9, 0x2::clock::timestamp_ms(arg10));
        let v13 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v12, 1000000000);
        let v14 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_position<T0>(arg0, arg3);
        0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::settle_position_funding_and_emit(v14, v6, v10, v11, &v1, arg3);
        let v15 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v14);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v14), v6), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v14, v12)), 0)) {
            return
        };
        assert!(v0 > 0, 6001);
        let v16 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_orderbook<T0>(arg0);
        let v17 = 0x1::vector::length<u128>(&arg4);
        let (v18, v19) = if (v17 != 0) {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::force_cancel_orders(v16, arg3, &arg4, v1, 2)
        } else {
            (0, 0)
        };
        let v20 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_position<T0>(arg0, arg3);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v20, true, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v18, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v20, false, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v19, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(v20, false, v17);
        let (v21, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v20);
        let v23 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v21), 1000000000);
        let (v24, v25) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::fill_base_and_quote_deltas(v13, v23);
        let v26 = if (v23 != 0) {
            let (v27, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(v20, v15, v24, v25);
            v27
        } else {
            0
        };
        let (v29, v30) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v20);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(v20, v26, v6);
        assert!(v29 == 0 && v30 == 0, 6003);
        let v31 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v20);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::reset_collateral(v20);
        let v32 = v0 - 1;
        let v33 = 0;
        let v34 = 0;
        loop {
            let v35 = (*0x1::vector::borrow<u64>(&arg7, v32) as u256);
            v34 = v34 + v35;
            let v36 = *0x1::vector::borrow<u64>(&arg5, v32);
            let v37 = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_position<T0>(arg0, v36);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::settle_position_funding_and_emit(v37, v6, v10, v11, &v1, v36);
            let (v38, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v37);
            let v40 = *0x1::vector::borrow<u64>(&arg6, v32);
            assert!(v40 % v5 == 0, 6000);
            assert!((v21 == 0 || 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v37) != v15) && v40 <= 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v38), 1000000000), 6002);
            v33 = v33 + v40;
            let (v41, v42) = 0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::fill_base_and_quote_deltas(v13, v40);
            let (v43, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(v37, !v15, v41, v42);
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(v37, v43, v6);
            let v45 = if (v32 == 0) {
                v31
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v31, v35)
            };
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral(v37, v45);
            v31 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v31, v45);
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::events::emit_performed_adl(v1, arg3, v40, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v43, v6), v45), v13, v36, v15);
            if (v32 == 0) {
                break
            };
            v32 = v32 - 1;
        };
        assert!(v33 == v23, 6003);
        assert!(v34 == 1000000000000000000, 6004);
        if (v33 != 0) {
            0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::market::add_to_open_interest(0x8cb9f9914a114c832f516249fa6decc55d859cbc44d84b901dd4de872914b27e::clearing_house::borrow_mut_market_state<T0>(arg0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v33, 1000000000)));
        };
    }

    // decompiled from Move bytecode v7
}

