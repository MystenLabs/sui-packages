module 0x630641b556344352136cf51cd9347b941494d5bc19d6784840acea2880f24ca1::lending_venues {
    struct Witness has drop {
        dummy_field: bool,
    }

    public fun quote_state_steamm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock) : (u64, bool) {
        if (arg5 == 0) {
            return (0, false)
        };
        let v0 = if (arg4) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg5, arg6)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg5, arg6)
        };
        if (v0 == 0) {
            return (0, false)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<T3, T4, T5>(arg0, v0, arg4);
        let v2 = if (arg4) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg6)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg6)
        };
        (v2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_in(&v1) == v0)
    }

    public fun quote_state_steamm_omm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock) : (u64, bool) {
        if (arg7 == 0) {
            return (0, false)
        };
        let v0 = if (arg6) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg7, arg8)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg7, arg8)
        };
        if (v0 == 0) {
            return (0, false)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8);
        let v2 = if (arg6) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8)
        };
        (v2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_in(&v1) == v0)
    }

    public fun quote_state_steamm_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock) : (u64, bool) {
        if (arg7 == 0) {
            return (0, false)
        };
        let v0 = if (arg6) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg7, arg8)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg7, arg8)
        };
        if (v0 == 0) {
            return (0, false)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg8);
        let v2 = if (arg6) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8)
        };
        (v2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_in(&v1) == v0)
    }

    public fun quote_steamm<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: bool, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>>(arg2);
        let v1 = if (arg6) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v2, v0, arg7, arg8)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T4, Witness>(arg0, arg1, &v3, v0, arg7, arg8)
        };
        let (v4, v5) = quote_state_steamm<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, v1, arg9);
        if (arg6) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T4, Witness>(arg0, arg1, &v6, 9, v0, arg6, v1, v4, v5);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T4, T3, Witness>(arg0, arg1, &v7, 9, v0, arg6, v1, v4, v5);
        };
    }

    public fun quote_steamm_omm<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: bool, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>>(arg2);
        let v1 = if (arg8) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v2, v0, arg9, arg10)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T4, Witness>(arg0, arg1, &v3, v0, arg9, arg10)
        };
        let (v4, v5) = quote_state_steamm_omm<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg11);
        if (arg8) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T4, Witness>(arg0, arg1, &v6, 9, v0, arg8, v1, v4, v5);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T4, T3, Witness>(arg0, arg1, &v7, 9, v0, arg8, v1, v4, v5);
        };
    }

    public fun quote_steamm_omm_v2<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: bool, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>>(arg2);
        let v1 = if (arg8) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v2, v0, arg9, arg10)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T4, Witness>(arg0, arg1, &v3, v0, arg9, arg10)
        };
        let (v4, v5) = quote_state_steamm_omm_v2<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, arg11);
        if (arg8) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T4, Witness>(arg0, arg1, &v6, 9, v0, arg8, v1, v4, v5);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T4, T3, Witness>(arg0, arg1, &v7, 9, v0, arg8, v1, v4, v5);
        };
    }

    public fun swap_steamm<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg6) {
            let v2 = Witness{dummy_field: false};
            let v3 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T4, Witness>(arg0, arg1, &v2, 9, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>>(arg2), true, arg8);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v3)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v3);
                return
            };
            let v4 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v3);
            0x2::coin::destroy_zero<T3>(v4);
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T3, T5>(arg3, arg5, &mut v4, 0x2::coin::value<T3>(&v4), arg7, arg8), 0x2::coin::zero<T6>(arg8))
        } else {
            let v5 = Witness{dummy_field: false};
            let v6 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T4, T3, Witness>(arg0, arg1, &v5, 9, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>>(arg2), false, arg8);
            if (0x1::option::is_none<0x2::coin::Coin<T4>>(&v6)) {
                0x1::option::destroy_none<0x2::coin::Coin<T4>>(v6);
                return
            };
            let v7 = 0x1::option::destroy_some<0x2::coin::Coin<T4>>(v6);
            0x2::coin::destroy_zero<T4>(v7);
            (0x2::coin::zero<T5>(arg8), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T4, T6>(arg4, arg5, &mut v7, 0x2::coin::value<T4>(&v7), arg7, arg8))
        };
        let v8 = v1;
        let v9 = v0;
        let v10 = if (arg6) {
            0x2::coin::value<T5>(&v9)
        } else {
            0x2::coin::value<T6>(&v8)
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::swap<T5, T6, T7>(arg2, &mut v9, &mut v8, arg6, v10, 0, arg8);
        if (arg6) {
            let v11 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T4, Witness>(arg0, arg1, &v11, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T4, T6>(arg4, arg5, &mut v8, 0x2::coin::value<T6>(&v8), arg7, arg8));
        } else {
            let v12 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v12, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T3, T5>(arg3, arg5, &mut v9, 0x2::coin::value<T5>(&v9), arg7, arg8));
        };
        0x2::coin::destroy_zero<T5>(v9);
        0x2::coin::destroy_zero<T6>(v8);
    }

    public fun swap_steamm_omm<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg8) {
            let v2 = Witness{dummy_field: false};
            let v3 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T4, Witness>(arg0, arg1, &v2, 9, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>>(arg2), true, arg10);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v3)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v3);
                return
            };
            let v4 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v3);
            0x2::coin::destroy_zero<T3>(v4);
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T3, T5>(arg3, arg5, &mut v4, 0x2::coin::value<T3>(&v4), arg9, arg10), 0x2::coin::zero<T6>(arg10))
        } else {
            let v5 = Witness{dummy_field: false};
            let v6 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T4, T3, Witness>(arg0, arg1, &v5, 9, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T7>>(arg2), false, arg10);
            if (0x1::option::is_none<0x2::coin::Coin<T4>>(&v6)) {
                0x1::option::destroy_none<0x2::coin::Coin<T4>>(v6);
                return
            };
            let v7 = 0x1::option::destroy_some<0x2::coin::Coin<T4>>(v6);
            0x2::coin::destroy_zero<T4>(v7);
            (0x2::coin::zero<T5>(arg10), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T4, T6>(arg4, arg5, &mut v7, 0x2::coin::value<T4>(&v7), arg9, arg10))
        };
        let v8 = v1;
        let v9 = v0;
        let v10 = if (arg8) {
            0x2::coin::value<T5>(&v9)
        } else {
            0x2::coin::value<T6>(&v8)
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::swap<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, &mut v9, &mut v8, arg8, v10, 0, arg9, arg10);
        if (arg8) {
            let v11 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T4, Witness>(arg0, arg1, &v11, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T4, T6>(arg4, arg5, &mut v8, 0x2::coin::value<T6>(&v8), arg9, arg10));
        } else {
            let v12 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v12, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T3, T5>(arg3, arg5, &mut v9, 0x2::coin::value<T5>(&v9), arg9, arg10));
        };
        0x2::coin::destroy_zero<T5>(v9);
        0x2::coin::destroy_zero<T6>(v8);
    }

    public fun swap_steamm_omm_v2<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg8) {
            let v2 = Witness{dummy_field: false};
            let v3 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T4, Witness>(arg0, arg1, &v2, 9, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>>(arg2), true, arg10);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v3)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v3);
                return
            };
            let v4 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v3);
            0x2::coin::destroy_zero<T3>(v4);
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T3, T5>(arg3, arg5, &mut v4, 0x2::coin::value<T3>(&v4), arg9, arg10), 0x2::coin::zero<T6>(arg10))
        } else {
            let v5 = Witness{dummy_field: false};
            let v6 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T4, T3, Witness>(arg0, arg1, &v5, 9, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T7>>(arg2), false, arg10);
            if (0x1::option::is_none<0x2::coin::Coin<T4>>(&v6)) {
                0x1::option::destroy_none<0x2::coin::Coin<T4>>(v6);
                return
            };
            let v7 = 0x1::option::destroy_some<0x2::coin::Coin<T4>>(v6);
            0x2::coin::destroy_zero<T4>(v7);
            (0x2::coin::zero<T5>(arg10), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btokens<T2, T4, T6>(arg4, arg5, &mut v7, 0x2::coin::value<T4>(&v7), arg9, arg10))
        };
        let v8 = v1;
        let v9 = v0;
        let v10 = if (arg8) {
            0x2::coin::value<T5>(&v9)
        } else {
            0x2::coin::value<T6>(&v8)
        };
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T2, T3, T4, T5, T6, T7>(arg2, arg3, arg4, arg5, arg6, arg7, &mut v9, &mut v8, arg8, v10, 0, arg9, arg10);
        if (arg8) {
            let v11 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T4, Witness>(arg0, arg1, &v11, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T4, T6>(arg4, arg5, &mut v8, 0x2::coin::value<T6>(&v8), arg9, arg10));
        } else {
            let v12 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v12, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btokens<T2, T3, T5>(arg3, arg5, &mut v9, 0x2::coin::value<T5>(&v9), arg9, arg10));
        };
        0x2::coin::destroy_zero<T5>(v9);
        0x2::coin::destroy_zero<T6>(v8);
    }

    // decompiled from Move bytecode v7
}

