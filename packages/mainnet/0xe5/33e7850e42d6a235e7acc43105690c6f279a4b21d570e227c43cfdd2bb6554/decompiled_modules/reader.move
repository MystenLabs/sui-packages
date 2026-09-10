module 0xe533e7850e42d6a235e7acc43105690c6f279a4b21d570e227c43cfdd2bb6554::reader {
    fun bank_state<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : (u128, u64, u64, bool) {
        let v0 = 0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>>(arg0);
        if (0x1::vector::length<u8>(&v0) > 512) {
            return (0, 0, 0, false)
        };
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        let v2 = 0x2::bcs::peel_u64(&mut v1);
        let v3 = 0x2::bcs::peel_vec_length(&mut v1);
        if (v3 > 1) {
            return (0, 0, 0, false)
        };
        let v4 = 0;
        let v5 = 0;
        if (v3 == 1) {
            v4 = 0x2::bcs::peel_u64(&mut v1);
            0x2::bcs::peel_u16(&mut v1);
            0x2::bcs::peel_u16(&mut v1);
            v5 = 0x2::bcs::peel_u64(&mut v1);
            0x2::bcs::peel_address(&mut v1);
            0x2::bcs::peel_address(&mut v1);
        };
        0x2::bcs::peel_u64(&mut v1);
        let v6 = 0x2::bcs::peel_u64(&mut v1);
        let v7 = if (0x2::bcs::peel_u16(&mut v1) != 1) {
            true
        } else {
            let v8 = 0x2::bcs::into_remainder_bytes(v1);
            !0x1::vector::is_empty<u8>(&v8)
        };
        if (v7) {
            return (0, 0, 0, false)
        };
        if (v3 == 0) {
            return ((v6 as u128) * 1000000000000000000, v6, v2, v6 > 0)
        };
        let v9 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1);
        let v10 = 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v9);
        let v11 = if (v10 > 256) {
            true
        } else if (v5 >= v10) {
            true
        } else {
            v6 == 0
        };
        if (v11) {
            return (0, 0, 0, false)
        };
        let v12 = (v2 as u256) * (1000000000000000000 as u256) + (v4 as u256) * 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v9, v5), arg2));
        if (v12 == 0 || v12 > 340282366920938463463374607431768211455) {
            return (0, 0, 0, false)
        };
        ((v12 as u128), v6, v2, true)
    }

    public fun current_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: bool) : (u64, u64, u64, u64, u128, u64, u64, u128, u64, u64, bool) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::fees::fee_numerator(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::pool_fee_config<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>(arg0));
        let (v3, v4, v5, v6) = bank_state<T0, T1, T3>(arg1, arg3, arg4);
        let (v7, v8, v9, v10) = bank_state<T0, T2, T4>(arg2, arg3, arg4);
        let (v11, v12, v13, v14, v15, v16, v17, v18, v19) = if (arg5) {
            let v20 = if (validate_cpmm_pool<T3, T4, T5>(arg0)) {
                if (v6) {
                    if (v10) {
                        v2 < 10000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            (v0, v1, v3, v4, v5, v7, v8, v9, v20)
        } else {
            let v21 = if (validate_cpmm_pool<T3, T4, T5>(arg0)) {
                if (v6) {
                    if (v10) {
                        v2 < 10000
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            (v1, v0, v7, v8, v9, v3, v4, v5, v21)
        };
        (v11, v12, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::offset<T3, T4, T5>(arg0), v2, v13, v14, v15, v16, v17, v18, v19)
    }

    public fun current_omm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &0x2::clock::Clock, arg7: bool) : (u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, bool) {
        let v0 = 0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>>(arg0);
        if (0x1::vector::length<u8>(&v0) > 512) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        let v2 = 0x2::bcs::peel_address(&mut v1);
        let v3 = 0x2::bcs::peel_u8(&mut v1);
        let v4 = 0x2::bcs::peel_u8(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v5 = 0;
        while (v5 < 5) {
            0x2::bcs::peel_u64(&mut v1);
            v5 = v5 + 1;
        };
        let v6 = 0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        v5 = 0;
        while (v5 < 4) {
            0x2::bcs::peel_u128(&mut v1);
            v5 = v5 + 1;
        };
        v5 = 0;
        while (v5 < 4) {
            0x2::bcs::peel_u64(&mut v1);
            v5 = v5 + 1;
        };
        let v7 = oracle_price_wad(arg4);
        let v8 = oracle_price_wad(arg5);
        let v9 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(arg4);
        let v10 = if (0x2::object::id_to_address(&v9) == v2) {
            let v11 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(arg5);
            if (0x2::object::id_to_address(&v11) == v2) {
                if (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(arg4) == 0x2::bcs::peel_u64(&mut v1)) {
                    0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(arg5) == 0x2::bcs::peel_u64(&mut v1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let (v12, v13, v14, v15) = bank_state<T0, T1, T3>(arg1, arg3, arg6);
        let (v16, v17, v18, v19) = bank_state<T0, T2, T4>(arg2, arg3, arg6);
        let v20 = if (0x2::bcs::peel_u16(&mut v1) == 1) {
            if (0x2::bcs::peel_u16(&mut v1) == 1) {
                if (v6 < 10000) {
                    if (0x2::bcs::peel_u64(&mut v1) == 10000) {
                        if (v3 <= 18) {
                            if (v4 <= 18) {
                                if (v7 > 0) {
                                    if (v8 > 0) {
                                        if (v10) {
                                            if (v15) {
                                                if (v19) {
                                                    let v21 = 0x2::bcs::into_remainder_bytes(v1);
                                                    0x1::vector::is_empty<u8>(&v21)
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
                                    }
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
        let (v22, v23, v24, v25, v26, v27, v28, v29, v30, v31) = if (arg7) {
            (v16, v17, v18, v7, v8, v3, v4, 0x2::bcs::peel_u64(&mut v1), v12, v13)
        } else {
            (v12, v13, v14, v8, v7, v4, v3, 0x2::bcs::peel_u64(&mut v1), v16, v17)
        };
        (v29, v6, v30, v31, v22, v23, v24, v25, v26, v27, v28, v20)
    }

    public fun current_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg5: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: &0x2::clock::Clock, arg7: bool) : (u64, u64, u64, u128, u64, u128, u64, u64, u128, u128, u8, u8, u64, u64, bool) {
        let v0 = 0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>>(arg0);
        if (0x1::vector::length<u8>(&v0) > 512) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        let v2 = 0x2::bcs::peel_address(&mut v1);
        let v3 = 0x2::bcs::peel_u8(&mut v1);
        let v4 = 0x2::bcs::peel_u8(&mut v1);
        let v5 = 0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v6 = 0;
        while (v6 < 5) {
            0x2::bcs::peel_u64(&mut v1);
            v6 = v6 + 1;
        };
        let v7 = 0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        v6 = 0;
        while (v6 < 4) {
            0x2::bcs::peel_u128(&mut v1);
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 4) {
            0x2::bcs::peel_u64(&mut v1);
            v6 = v6 + 1;
        };
        let v8 = oracle_price_wad(arg4);
        let v9 = oracle_price_wad(arg5);
        let v10 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(arg4);
        let v11 = if (0x2::object::id_to_address(&v10) == v2) {
            let v12 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_registry_id(arg5);
            if (0x2::object::id_to_address(&v12) == v2) {
                if (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(arg4) == 0x2::bcs::peel_u64(&mut v1)) {
                    0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::oracle_index(arg5) == 0x2::bcs::peel_u64(&mut v1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let (v13, v14, v15, v16) = bank_state<T0, T1, T3>(arg1, arg3, arg6);
        let (v17, v18, v19, v20) = bank_state<T0, T2, T4>(arg2, arg3, arg6);
        let v21 = if (0x2::bcs::peel_u16(&mut v1) == 5) {
            if (0x2::bcs::peel_u16(&mut v1) == 1) {
                if (v5 == 50 || v5 == 100) {
                    if (v7 < 10000) {
                        if (0x2::bcs::peel_u64(&mut v1) == 10000) {
                            if (v3 <= 18) {
                                if (v4 <= 18) {
                                    if (v8 > 0) {
                                        if (v9 > 0) {
                                            if (v11) {
                                                if (v16) {
                                                    if (v20) {
                                                        let v22 = 0x2::bcs::into_remainder_bytes(v1);
                                                        0x1::vector::is_empty<u8>(&v22)
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
                                        }
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
                        }
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
        let (v23, v24, v25, v26, v27) = if (arg7) {
            (v13, v14, v17, v18, v19)
        } else {
            (v17, v18, v13, v14, v15)
        };
        (0x2::bcs::peel_u64(&mut v1), 0x2::bcs::peel_u64(&mut v1), v7, v23, v24, v25, v26, v27, v8, v9, v3, v4, v5, 0x1::u64::max(oracle_uncertainty_bps(arg4), oracle_uncertainty_bps(arg5)), v21)
    }

    fun oracle_price_wad(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate) : u128 {
        let v0 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(arg0);
        let v1 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::expo(&v0);
        if (v1 > 38) {
            return 0
        };
        let v2 = 1;
        let v3 = if (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::is_expo_negative(&v0)) {
            if (v1 <= 18) {
                18 - v1
            } else {
                v1 - 18
            }
        } else {
            18 + v1
        };
        let v4 = 0;
        while (v4 < v3) {
            v2 = v2 * 10;
            v4 = v4 + 1;
        };
        let v5 = if (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::is_expo_negative(&v0) && v1 > 18) {
            (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v0) as u256) / v2
        } else {
            (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v0) as u256) * v2
        };
        if (v5 > 340282366920938463463374607431768211455) {
            0
        } else {
            (v5 as u128)
        }
    }

    fun oracle_uncertainty_bps(arg0: &0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate) : u64 {
        let v0 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::price(arg0);
        let v1 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v0);
        if (v1 == 0 || v1 > 18446744073709551615) {
            return 10000
        };
        let v2 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata(arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::metadata_pyth(&v2));
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v3);
        if (v4 > 1844674407370955) {
            return 10000
        };
        v4 * 10000 / (v1 as u64)
    }

    fun validate_cpmm_pool<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>) : bool {
        let v0 = 0x1::bcs::to_bytes<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>>(arg0);
        if (0x1::vector::length<u8>(&v0) > 512) {
            return false
        };
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        let v2 = 0;
        while (v2 < 5) {
            0x2::bcs::peel_u64(&mut v1);
            v2 = v2 + 1;
        };
        0x2::bcs::peel_u64(&mut v1);
        0x2::bcs::peel_u64(&mut v1);
        v2 = 0;
        while (v2 < 4) {
            0x2::bcs::peel_u128(&mut v1);
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < 4) {
            0x2::bcs::peel_u64(&mut v1);
            v2 = v2 + 1;
        };
        if (0x2::bcs::peel_u16(&mut v1) == 1) {
            if (0x2::bcs::peel_u16(&mut v1) == 1) {
                if (0x2::bcs::peel_u64(&mut v1) == 10000) {
                    let v4 = 0x2::bcs::into_remainder_bytes(v1);
                    0x1::vector::is_empty<u8>(&v4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

