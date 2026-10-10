module 0x465755c56052611df9360a80c8dc435e05d3a979d6b2e613072df6be7694fa8a::steamm {
    fun candidate<T0, T1, T2, T3, T4, T5: drop>(arg0: u64, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg11) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg2, arg4, arg0, arg10)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg3, arg4, arg0, arg10)
        };
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg6, arg8, arg10), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg7, arg9, arg10), v0, arg11, arg10);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1);
        if (v2 == 0) {
            return 0
        };
        let (v3, v4) = if (arg11) {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T2, T4>(arg3, arg4, v2, arg10), 0x2::balance::value<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T2, T4>(arg3)))
        } else {
            (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T3>(arg2, arg4, v2, arg10), 0x2::balance::value<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T1, T3>(arg2)))
        };
        if (v3 > v4) {
            0
        } else {
            v3
        }
    }

    fun check_bank(arg0: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        if (0x2::bcs::peel_bool(&mut v0)) {
            0x2::bcs::peel_u64(&mut v0);
            0x2::bcs::peel_u16(&mut v0);
            0x2::bcs::peel_u16(&mut v0);
            0x2::bcs::peel_u64(&mut v0);
            0x2::bcs::peel_address(&mut v0);
            0x2::bcs::peel_address(&mut v0);
        };
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 1);
        assert!(0x2::bcs::peel_u16(&mut v0) == 1, 2);
    }

    fun checked<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>) : (u64, u64) {
        check_bank(0x2::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>>(arg1));
        check_bank(0x2::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>>(arg2));
        gate(0x2::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>>(arg0))
    }

    fun gate(arg0: vector<u8>) : (u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0;
        while (v1 < 11) {
            0x2::bcs::peel_u64(&mut v0);
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 4) {
            0x2::bcs::peel_u128(&mut v0);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 4) {
            0x2::bcs::peel_u64(&mut v0);
            v3 = v3 + 1;
        };
        let v4 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v4), 1);
        assert!(0x2::bcs::peel_u16(&mut v0) == 5 && 0x2::bcs::peel_u16(&mut v0) == 1, 2);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun quote<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: bool) {
        let (v0, v1) = checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v2 = vector[];
        let v3 = 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v3)) {
            0x1::vector::push_back<u64>(&mut v2, candidate<T1, T2, T3, T4, T5, T6>(0x1::vector::pop_back<u64>(&mut v3), arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, v1, arg8, arg9));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_quote<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>>(arg1), arg9, v2, vector[], vector[]);
    }

    public fun swap_a2b<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: 0x2::balance::Balance<T2>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T3>, 0x2::balance::Balance<T2>) {
        let (v0, v1) = checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v2 = 0x2::coin::from_balance<T2>(arg9, arg10);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T2, T4>(arg2, arg4, &mut v2, 0x2::coin::value<T2>(&v2), arg8, arg10);
        0x2::coin::destroy_zero<T2>(v2);
        let v4 = 0x2::coin::zero<T5>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg6, v0, arg8), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg7, v1, arg8), &mut v3, &mut v4, true, 0x2::coin::value<T4>(&v3), 0, arg8, arg10);
        0x2::coin::destroy_zero<T4>(v3);
        let v5 = 0x2::coin::into_balance<T3>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T1, T3, T5>(arg3, arg4, &mut v4, 0x2::coin::value<T5>(&v4), arg8, arg10));
        0x2::coin::destroy_zero<T5>(v4);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>>(arg1), true, 0x2::balance::value<T3>(&v5));
        (v5, 0x2::balance::zero<T2>())
    }

    public fun swap_b2a<T0, T1, T2, T3, T4, T5, T6: drop>(arg0: &mut 0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::Session<T0>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T2, T4>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T1, T3, T5>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OracleRegistry, arg6: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg7: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: 0x2::balance::Balance<T3>, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        let (v0, v1) = checked<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3);
        let v2 = 0x2::coin::from_balance<T3>(arg9, arg10);
        let v3 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T1, T3, T5>(arg3, arg4, &mut v2, 0x2::coin::value<T3>(&v2), arg8, arg10);
        0x2::coin::destroy_zero<T3>(v2);
        let v4 = 0x2::coin::zero<T4>(arg10);
        0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::swap<T1, T2, T3, T4, T5, T6>(arg1, arg2, arg3, arg4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg6, v0, arg8), 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::get_pyth_price_pro_compatible(arg5, arg7, v1, arg8), &mut v4, &mut v3, false, 0x2::coin::value<T5>(&v3), 0, arg8, arg10);
        0x2::coin::destroy_zero<T5>(v3);
        let v5 = 0x2::coin::into_balance<T2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T1, T2, T4>(arg2, arg4, &mut v4, 0x2::coin::value<T4>(&v4), arg8, arg10));
        0x2::coin::destroy_zero<T4>(v4);
        0x2b7fcb0b9c562da0597fb65b3c137a9c076012faf245584812a63f9e9ddd2e29::session::record_leg<T0>(arg0, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T4, T5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T6>>(arg1), false, 0x2::balance::value<T2>(&v5));
        (v5, 0x2::balance::zero<T3>())
    }

    // decompiled from Move bytecode v7
}

