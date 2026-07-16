module 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::adl {
    public fun execute_adl<T0>(arg0: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::PACKAGE, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::ADL>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: u64, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg9: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock) {
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::assert_package_version<T0>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::assert_package_version(arg2);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::assert_authority_cap_is_authorized<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::PACKAGE, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::ADL>(arg2, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::assert_market_is_not_closed<T0>(arg0);
        let v0 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T0>>(arg0);
        let v1 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::book_price<T0>(arg0);
        let (v2, v3) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::borrow_mut_market_objects<T0>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::try_update_funding(v2, v3, arg8, arg10, &v0, v1);
        let (v4, v5) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::base_oracle_price_and_twap_price(v2, arg8, arg10);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::assert_index_twap_divergence_within_limit(v2, v4, v5);
        let v6 = if (0x1::option::is_none<u256>(&v1)) {
            v4
        } else {
            *0x1::option::borrow<u256>(&v1)
        };
        execute_adl_<T0>(arg0, arg3, arg4, arg5, arg6, arg7, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::calculate_mark_price(v3, v2, v5, v6, 0x2::clock::timestamp_ms(arg10)), 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::collateral_oracle_price(v2, arg9, arg10));
    }

    fun execute_adl_<T0>(arg0: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: vector<u128>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u256, arg7: u256) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 6001);
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 6001);
        let v1 = 0x2::object::id<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T0>>(arg0);
        let (v2, v3) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::market_objects<T0>(arg0);
        let v4 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::lot_size(v2);
        let (v5, v6) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::cum_funding_rates(v3);
        let v7 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(arg6, 1000000000);
        let v8 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::borrow_mut_position<T0>(arg0, arg1);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::settle_position_funding_and_emit(v8, arg7, v5, v6, &v1, arg1);
        let v9 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v8);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v8), arg7), 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(v8, arg6)), 0)) {
            return
        };
        assert!(v0 > 0, 6001);
        let v10 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::borrow_mut_orderbook<T0>(arg0);
        let v11 = 0x1::vector::length<u128>(&arg2);
        let (v12, v13) = if (v11 != 0) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::force_cancel_orders(v10, arg1, &arg2, v1, 2)
        } else {
            (0, 0)
        };
        let v14 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::borrow_mut_position<T0>(arg0, arg1);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v14, true, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v12, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v14, false, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v13, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(v14, false, v11);
        let (v15, v16) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_base_amounts_by_side(v14);
        let v17 = if (v15 == 0) {
            if (v16 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v14) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 6003);
        let (v18, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v14);
        let v20 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v18), 1000000000);
        let (v21, v22) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::fill_base_and_quote_deltas(v7, v20);
        let v23 = if (v20 != 0) {
            let (v24, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(v14, v9, v21, v22);
            v24
        } else {
            0
        };
        let (v26, v27) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v14);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(v14, v23, arg7);
        assert!(v26 == 0 && v27 == 0, 6003);
        let v28 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v14);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::reset_collateral(v14);
        let v29 = v0 - 1;
        let v30 = 0;
        let v31 = 0;
        loop {
            let v32 = (*0x1::vector::borrow<u64>(&arg5, v29) as u256);
            v31 = v31 + v32;
            let v33 = *0x1::vector::borrow<u64>(&arg3, v29);
            let v34 = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::borrow_mut_position<T0>(arg0, v33);
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::settle_position_funding_and_emit(v34, arg7, v5, v6, &v1, v33);
            let (v35, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v34);
            let v37 = *0x1::vector::borrow<u64>(&arg4, v29);
            assert!(v37 % v4 == 0, 6000);
            assert!((v18 == 0 || 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::is_long_or_flat(v34) != v9) && v37 <= 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v35), 1000000000), 6002);
            v30 = v30 + v37;
            let (v38, v39) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::fill_base_and_quote_deltas(v7, v37);
            let (v40, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(v34, !v9, v38, v39);
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(v34, v40, arg7);
            let v42 = if (v29 == 0) {
                v28
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v28, v32)
            };
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral(v34, v42);
            v28 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v28, v42);
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::events::e25(v1, arg1, v37, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v40, arg7), v42), v7, v33, v9);
            if (v29 == 0) {
                break
            };
            v29 = v29 - 1;
        };
        assert!(v30 == v20, 6003);
        assert!(v31 == 1000000000000000000, 6004);
        if (v30 != 0) {
            0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::market::add_to_open_interest(0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::borrow_mut_market_state<T0>(arg0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v30, 1000000000)));
        };
    }

    public fun execute_closed_market_adl<T0>(arg0: &mut 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::PACKAGE, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::ADL>, arg2: &0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::Registry, arg3: u64, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>) {
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::assert_package_version<T0>(arg0);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::assert_package_version(arg2);
        0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::registry::assert_authority_cap_is_authorized<0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::PACKAGE, 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::authority::ADL>(arg2, arg1);
        let (v0, v1) = 0xfaf02e5570d673f36d10418b06b501e354ee66f25c13e3ec3a35c96e1814102e::clearing_house::closed_market_adl_prices<T0>(arg0);
        execute_adl_<T0>(arg0, arg3, arg4, arg5, arg6, arg7, v0, v1);
    }

    // decompiled from Move bytecode v7
}

