module 0x19a65a80e335048057d10462b4d75ae31ac414fc2a0880cbf0eb4aac57d64a08::steamm {
    struct BankRate has copy, drop {
        funds: u256,
        supply: u256,
        burn_cap: u64,
    }

    struct PreparedBanks has drop {
        a: BankRate,
        b: BankRate,
    }

    fun bank_rates<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : (u256, u256) {
        if (0x1::option::is_none<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Lending<T0>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::lending<T0, T1, T2>(arg0))) {
            return (18446744073709551616, 18446744073709551616)
        };
        let v0 = supply<T0, T1, T2>(arg0);
        if (v0 == 0) {
            return (18446744073709551616, 18446744073709551616)
        };
        let v1 = (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T2>(arg0, arg1, v0, arg2) as u256);
        if (v1 == 0) {
            return (115792089237316195423570985008687907853269984665640564039457584007913129639935, 115792089237316195423570985008687907853269984665640564039457584007913129639935)
        };
        (ceil((v0 as u256) * 18446744073709551616, v1), ceil((v1 + 1) * 18446744073709551616, (v0 as u256)))
    }

    fun cached_input(arg0: &PreparedBanks, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            &arg0.a
        } else {
            &arg0.b
        };
        convert(arg1, v0.supply, v0.funds)
    }

    fun cached_output(arg0: &PreparedBanks, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            &arg0.b
        } else {
            &arg0.a
        };
        let v1 = if (arg1 < v0.burn_cap) {
            arg1
        } else {
            v0.burn_cap
        };
        convert(v1, v0.funds, v0.supply)
    }

    fun ceil(arg0: u256, arg1: u256) : u256 {
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public(friend) fun convert(arg0: u64, arg1: u256, arg2: u256) : u64 {
        (((arg0 as u256) * arg1 / arg2) as u64)
    }

    public(friend) fun mul_up(arg0: u256, arg1: u256) : u256 {
        let v0 = if (arg0 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
            true
        } else if (arg1 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
            true
        } else {
            arg1 != 0 && arg0 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1
        };
        if (v0) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            ceil(arg0 * arg1, 18446744073709551616)
        }
    }

    fun output<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = redeemable(supply<T0, T1, T2>(arg0), arg2, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::minimum_liquidity());
        if (v0 == 0) {
            0
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::from_btokens<T0, T1, T2>(arg0, arg1, v0, arg3)
        }
    }

    fun prepare_bank<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : BankRate {
        let v0 = supply<T0, T1, T2>(arg0);
        if (v0 == 0 || 0x1::option::is_none<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Lending<T0>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::lending<T0, T1, T2>(arg0))) {
            return BankRate{
                funds    : 1,
                supply   : 1,
                burn_cap : redeemable(v0, v0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::minimum_liquidity()),
            }
        };
        let v1 = 0x2::bcs::new(0x2::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Lending<T0>>(0x1::option::borrow<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Lending<T0>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::lending<T0, T1, T2>(arg0))));
        0x2::bcs::peel_u16(&mut v1);
        0x2::bcs::peel_u16(&mut v1);
        BankRate{
            funds    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x2::bcs::peel_u64(&mut v1)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), 0x2::bcs::peel_u64(&mut v1)), arg2)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x2::balance::value<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T1, T2>(arg0))))),
            supply   : (v0 as u256) * 1000000000000000000,
            burn_cap : redeemable(v0, v0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::minimum_liquidity()),
        }
    }

    public fun prepare_banks<T0, T1, T2, T3, T4>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock) : PreparedBanks {
        PreparedBanks{
            a : prepare_bank<T0, T1, T3>(arg0, arg2, arg3),
            b : prepare_bank<T0, T2, T4>(arg1, arg2, arg3),
        }
    }

    public fun quote_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        let v0 = if (arg5) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg4, arg6)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg4, arg6)
        };
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<T3, T4, T5>(arg0, v0, arg5);
        let v2 = if (arg5) {
            output<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg6)
        } else {
            output<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg6)
        };
        (arg4, v2)
    }

    public fun quote_cpmm_prepared<T0, T1, T2: drop>(arg0: &PreparedBanks, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg2: u64, arg3: bool) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let v0 = cached_input(arg0, arg2, arg3);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::quote_swap<T0, T1, T2>(arg1, v0, arg3);
        (arg2, cached_output(arg0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg3))
    }

    public fun quote_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock) : (u64, u64) {
        if (arg6 == 0) {
            return (0, 0)
        };
        let v0 = if (arg7) {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T1, T3>(arg1, arg3, arg6, arg8)
        } else {
            0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::to_btokens<T0, T2, T4>(arg2, arg3, arg6, arg8)
        };
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7, arg8);
        let v2 = if (arg7) {
            output<T0, T2, T4>(arg2, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8)
        } else {
            output<T0, T1, T3>(arg1, arg3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8)
        };
        (arg6, v2)
    }

    public fun quote_omm_v2_prepared<T0, T1, T2, T3, T4, T5: drop>(arg0: &PreparedBanks, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock) : (u64, u64) {
        if (arg7 == 0) {
            return (0, 0)
        };
        let v0 = cached_input(arg0, arg7, arg8);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::quote_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8, arg9);
        (arg7, cached_output(arg0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1), arg8))
    }

    public(friend) fun redeemable(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            0
        };
        if (arg1 < v0) {
            arg1
        } else {
            v0
        }
    }

    fun supply<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>) : u64 {
        let v0 = 0x2::bcs::to_bytes<0x1::option::Option<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Lending<T0>>>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::lending<T0, T1, T2>(arg0));
        supply_bytes(0x2::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>>(arg0), 0x1::vector::length<u8>(&v0))
    }

    public(friend) fun supply_bytes(arg0: vector<u8>, arg1: u64) : u64 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0;
        while (v1 < arg1) {
            0x2::bcs::peel_u8(&mut v0);
            v1 = v1 + 1;
        };
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0)
    }

    public fun upper_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: bool, arg5: &0x2::clock::Clock) : (u256, u256) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0);
        let v2 = 0x2::bcs::new(0x2::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0)));
        0x2::bcs::peel_u16(&mut v2);
        let (v3, v4) = if (arg4) {
            ((v0 as u256), (v1 as u256) + (0x2::bcs::peel_u64(&mut v2) as u256))
        } else {
            ((v1 as u256) + (0x2::bcs::peel_u64(&mut v2) as u256), (v0 as u256))
        };
        let (v5, v6) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fees::fee_ratio_(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pool_fee_config<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0));
        if (v3 == 0 || v6 == 0) {
            return (1, 0)
        };
        let (v7, v8) = bank_rates<T0, T1, T3>(arg1, arg3, arg5);
        let (v9, v10) = bank_rates<T0, T2, T4>(arg2, arg3, arg5);
        let v11 = if (arg4) {
            mul_up(mul_up(v7, ceil(v4 * ((v6 - v5) as u256) * 18446744073709551616, v3 * (v6 as u256))), v10)
        } else {
            mul_up(mul_up(v9, ceil(v4 * ((v6 - v5) as u256) * 18446744073709551616, v3 * (v6 as u256))), v8)
        };
        if (v11 == 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
            (1, 0)
        } else {
            (v11, 18446744073709551616)
        }
    }

    public fun upper_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: bool, arg5: &0x2::clock::Clock) : (u256, u256) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>(arg0);
        let v2 = if (arg4) {
            v1
        } else {
            v0
        };
        let (v3, v4) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fees::fee_ratio_(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pool_fee_config<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>(arg0));
        if (v4 == 0) {
            return (1, 0)
        };
        let v5 = if (arg4) {
            output<T0, T2, T4>(arg2, arg3, (ceil((v2 as u256) * ((v4 - v3) as u256), (v4 as u256)) as u64), arg5)
        } else {
            output<T0, T1, T3>(arg1, arg3, (ceil((v2 as u256) * ((v4 - v3) as u256), (v4 as u256)) as u64), arg5)
        };
        ((v5 as u256), 1)
    }

    // decompiled from Move bytecode v7
}

