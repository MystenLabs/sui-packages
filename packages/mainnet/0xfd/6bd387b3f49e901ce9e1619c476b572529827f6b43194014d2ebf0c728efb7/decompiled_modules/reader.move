module 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::reader {
    struct BankState has copy, drop {
        funds: u128,
        supply: u64,
        available: u64,
        ready: bool,
    }

    public fun current_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: bool) : (u64, u64, u64, u64, u128, u64, u64, u128, u64, u64, bool) {
        let v0 = prepare_bank<T0, T1, T3>(arg1, arg3, arg4);
        let v1 = prepare_bank<T0, T2, T4>(arg2, arg3, arg4);
        current_cpmm_prepared<T0, T1, T2, T3, T4, T5>(arg0, &v0, &v1, arg5)
    }

    public fun current_cpmm_prepared<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &BankState, arg2: &BankState, arg3: bool) : (u64, u64, u64, u64, u128, u64, u64, u128, u64, u64, bool) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10) = if (arg3) {
            let v11 = arg1.ready && arg2.ready;
            (v0, v1, arg1.funds, arg1.supply, arg1.available, arg2.funds, arg2.supply, arg2.available, v11)
        } else {
            let v12 = arg1.ready && arg2.ready;
            (v1, v0, arg2.funds, arg2.supply, arg2.available, arg1.funds, arg1.supply, arg1.available, v12)
        };
        (v2, v3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::offset<T3, T4, T5>(arg0), 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fees::fee_numerator(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pool_fee_config<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0)), v4, v5, v6, v7, v8, v9, v10)
    }

    public fun current_omm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &0x2::clock::Clock, arg7: bool) : (u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, bool) {
        let v0 = prepare_bank<T0, T1, T3>(arg1, arg3, arg6);
        let v1 = prepare_bank<T0, T2, T4>(arg2, arg3, arg6);
        current_omm_prepared<T0, T1, T2, T3, T4, T5>(arg0, &v0, &v1, arg4, arg5, arg7)
    }

    public fun current_omm_prepared<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &BankState, arg2: &BankState, arg3: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: bool) : (u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, bool) {
        let v0 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::new(0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>(arg0)));
        0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::skip(&mut v0, 50);
        let (v1, v2) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>(arg0);
        let v3 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(arg3);
        let v4 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(arg4);
        let v5 = oracle_price_wad(&v3, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v3));
        let v6 = oracle_price_wad(&v4, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v4));
        let v7 = if (v5 > 0) {
            if (v6 > 0) {
                if (arg1.ready) {
                    arg2.ready
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = if (arg5) {
            (v6, 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u8(&mut v0), 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u8(&mut v0), v2, arg1.funds, arg1.supply, arg2.funds, arg2.supply, arg2.available, v5)
        } else {
            (v5, 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u8(&mut v0), 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u8(&mut v0), v1, arg2.funds, arg2.supply, arg1.funds, arg1.supply, arg1.available, v6)
        };
        (v11, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fees::fee_numerator(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pool_fee_config<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>(arg0)), v12, v13, v14, v15, v16, v17, v8, v9, v10, v7)
    }

    public fun current_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &0x2::clock::Clock, arg7: bool) : (u64, u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, u64, u64, bool) {
        current_omm_v2_impl<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, false)
    }

    fun current_omm_v2_impl<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &0x2::clock::Clock, arg7: bool, arg8: bool) : (u64, u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, u64, u64, bool) {
        let v0 = prepare_bank<T0, T1, T3>(arg1, arg3, arg6);
        let v1 = prepare_bank<T0, T2, T4>(arg2, arg3, arg6);
        current_omm_v2_prepared<T0, T1, T2, T3, T4, T5>(arg0, &v0, &v1, arg4, arg5, arg7, arg8)
    }

    public fun current_omm_v2_prepared<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &BankState, arg2: &BankState, arg3: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: bool, arg6: bool) : (u64, u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, u64, u64, bool) {
        let v0 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::new(0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::quoter<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>(arg0)));
        0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::skip(&mut v0, 50);
        let v1 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u64(&mut v0);
        let (v2, v3) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>(arg0);
        let v4 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(arg3);
        let v5 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(arg4);
        let v6 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v4);
        let v7 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v5);
        let v8 = oracle_price_wad(&v4, v6);
        let v9 = oracle_price_wad(&v5, v7);
        let v10 = if (v1 == 50) {
            true
        } else if (v1 == 100) {
            true
        } else {
            arg6 && (v1 == 20 || v1 == 30)
        };
        let v11 = if (v10) {
            if (v8 > 0) {
                if (v9 > 0) {
                    if (arg1.ready) {
                        arg2.ready
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let (v12, v13, v14, v15, v16) = if (arg5) {
            (arg2.funds, arg2.supply, arg2.available, arg1.funds, arg1.supply)
        } else {
            (arg1.funds, arg1.supply, arg1.available, arg2.funds, arg2.supply)
        };
        (v2, v3, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fees::fee_numerator(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pool_fee_config<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>(arg0)), v15, v16, v12, v13, v14, v8, v9, 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u8(&mut v0), 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u8(&mut v0), v1, 0x1::u64::max(oracle_uncertainty_bps(arg3, v6), oracle_uncertainty_bps(arg4, v7)), v11)
    }

    public fun current_omm_v2_with_migration<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &0x2::clock::Clock, arg7: bool) : (u64, u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, u64, u64, bool) {
        current_omm_v2_impl<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, true)
    }

    fun oracle_price_wad(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal, arg1: u128) : u128 {
        let v0 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::expo(arg0);
        if (v0 > 38) {
            return 0
        };
        let v1 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::is_expo_negative(arg0);
        let v2 = 1;
        let v3 = if (v1) {
            if (v0 <= 18) {
                18 - v0
            } else {
                v0 - 18
            }
        } else {
            18 + v0
        };
        let v4 = 0;
        while (v4 < v3) {
            v2 = v2 * 10;
            v4 = v4 + 1;
        };
        let v5 = if (v1 && v0 > 18) {
            (arg1 as u256) / v2
        } else {
            (arg1 as u256) * v2
        };
        if (v5 > 340282366920938463463374607431768211455) {
            0
        } else {
            (v5 as u128)
        }
    }

    fun oracle_uncertainty_bps(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg1: u128) : u64 {
        if (arg1 == 0 || arg1 > 18446744073709551615) {
            return 10000
        };
        let v0 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata_pyth(&v0));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v1);
        if (v2 > 1844674407370955) {
            return 10000
        };
        v2 * 10000 / (arg1 as u64)
    }

    public fun prepare_bank<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : BankState {
        let v0 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::new(0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>>(arg0));
        0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::skip(&mut v0, 32);
        let v1 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u64(&mut v0);
        let v2 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::length(&mut v0);
        let v3 = 0;
        let v4 = 0;
        if (v2 == 1) {
            v3 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u64(&mut v0);
            0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::skip(&mut v0, 4);
            v4 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u64(&mut v0);
            0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::skip(&mut v0, 64);
        };
        0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::skip(&mut v0, 8);
        let v5 = 0xfd6bd387b3f49e901ce9e1619c476b572529827f6b43194014d2ebf0c728efb7::cursor::read_u64(&mut v0);
        if (v2 == 0) {
            return BankState{
                funds     : (v5 as u128) * 1000000000000000000,
                supply    : v5,
                available : v1,
                ready     : v5 > 0,
            }
        };
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1);
        if (v5 == 0) {
            return BankState{
                funds     : 0,
                supply    : 0,
                available : 0,
                ready     : false,
            }
        };
        let v7 = (v1 as u256) * (1000000000000000000 as u256) + (v3 as u256) * 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v6, v4), arg2));
        if (v7 == 0 || v7 > 340282366920938463463374607431768211455) {
            return BankState{
                funds     : 0,
                supply    : 0,
                available : 0,
                ready     : false,
            }
        };
        BankState{
            funds     : (v7 as u128),
            supply    : v5,
            available : v1,
            ready     : true,
        }
    }

    // decompiled from Move bytecode v7
}

