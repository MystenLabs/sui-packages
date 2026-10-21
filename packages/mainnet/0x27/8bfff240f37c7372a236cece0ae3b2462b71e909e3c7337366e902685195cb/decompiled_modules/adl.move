module 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::adl {
    public fun execute_adl<T0>(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ADL>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u64, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg9: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg10: &0x2::clock::Clock) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ADL>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::assert_market_is_not_closed<T0>(arg0);
        let v0 = 0x2::object::id<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::ClearingHouse<T0>>(arg0);
        let v1 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::book_price<T0>(arg0);
        let (v2, v3) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::borrow_mut_market_objects<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_funding(v2, v3, arg8, arg10, &v0, v1);
        let (v4, v5) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_oracle_price_and_twap_price(v2, arg8, arg10);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_index_twap_divergence_within_limit(v2, v4, v5);
        let v6 = if (0x1::option::is_none<u256>(&v1)) {
            v4
        } else {
            *0x1::option::borrow<u256>(&v1)
        };
        execute_adl_<T0>(arg0, arg3, arg4, arg5, arg6, arg7, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::calculate_mark_price(v3, v2, v5, v6, 0x2::clock::timestamp_ms(arg10)), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_oracle_price(v2, arg9, arg10));
    }

    fun execute_adl_<T0>(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::ClearingHouse<T0>, arg1: u64, arg2: vector<u128>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u256, arg7: u256) {
        let v0 = 0x1::vector::length<u64>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 6001);
        assert!(v0 == 0x1::vector::length<u64>(&arg5), 6001);
        let v1 = 0x2::object::id<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::ClearingHouse<T0>>(arg0);
        let (v2, v3) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::market_objects<T0>(arg0);
        let v4 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::lot_size(v2);
        let (v5, v6) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v3);
        let v7 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(arg6, 1000000000);
        let v8 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::borrow_mut_position<T0>(arg0, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::settle_position_funding_and_emit(v8, arg7, v5, v6, &v1, arg1);
        let v9 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::is_long_or_flat(v8);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(v8), arg7), 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::unrealized_pnl(v8, arg6)), 0)) {
            return
        };
        assert!(v0 > 0, 6001);
        let (v10, v11, v12) = if (0x1::vector::length<u128>(&arg2) != 0) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::force_cancel_orders(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::borrow_mut_orderbook<T0>(arg0), arg1, &arg2, v1, 2)
        } else {
            (0, 0, 0)
        };
        let v13 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::borrow_mut_position<T0>(arg0, arg1);
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v13, true, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(v10, 1000000000));
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v13, false, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(v11, 1000000000));
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::update_pending_orders(v13, false, v12);
        let (v14, v15) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_base_amounts_by_side(v13);
        let v16 = if (v14 == 0) {
            if (v15 == 0) {
                0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_order_count(v13) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v16, 6003);
        let (v17, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v13);
        let v19 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_u128balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v17), 1000000000);
        let v20 = if (v19 != 0) {
            let (v21, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_base_to_position(v13, v9, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(v19, 1000000000), (v19 as u256) * (v7 as u256));
            v21
        } else {
            0
        };
        let (v23, v24) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v13);
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral_usd(v13, v20, arg7);
        assert!(v23 == 0 && v24 == 0, 6003);
        let v25 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(v13);
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::reset_collateral(v13);
        let v26 = v0 - 1;
        let v27 = 0;
        let v28 = 0;
        loop {
            let v29 = (*0x1::vector::borrow<u64>(&arg5, v26) as u256);
            v28 = v28 + v29;
            let v30 = *0x1::vector::borrow<u64>(&arg3, v26);
            let v31 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::borrow_mut_position<T0>(arg0, v30);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::settle_position_funding_and_emit(v31, arg7, v5, v6, &v1, v30);
            let (v32, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v31);
            let v34 = *0x1::vector::borrow<u64>(&arg4, v26);
            assert!(v34 % v4 == 0, 6000);
            assert!((v17 == 0 || 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::is_long_or_flat(v31) != v9) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v34, 1000000000), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v32)), 6002);
            v27 = v27 + (v34 as u128);
            let (v35, v36) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::fill_base_and_quote_deltas(v7, v34);
            let (v37, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_base_to_position(v31, !v9, v35, v36);
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral_usd(v31, v37, arg7);
            let v39 = if (v26 == 0) {
                v25
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v25, v29)
            };
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral(v31, v39);
            v25 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v25, v39);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::performed_adl(v1, arg1, v34, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(v37, arg7), v39), v7, v30, v9);
            if (v26 == 0) {
                break
            };
            v26 = v26 - 1;
        };
        assert!(v27 == v19, 6003);
        assert!(v28 == 1000000000000000000, 6004);
        if (v27 != 0) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::add_to_open_interest(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::borrow_mut_market_state<T0>(arg0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(v27, 1000000000)));
        };
    }

    public fun execute_closed_market_adl<T0>(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ADL>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u64, arg4: vector<u128>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ADL>(arg2, arg1);
        let (v0, v1) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house::closed_market_adl_prices<T0>(arg0);
        execute_adl_<T0>(arg0, arg3, arg4, arg5, arg6, arg7, v0, v1);
    }

    // decompiled from Move bytecode v7
}

