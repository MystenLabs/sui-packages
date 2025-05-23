module 0x2c6b186d1bb437e09132af796714340d431c7dfaa83cddfd4b9bd785204be743::bet_manager {
    struct Bet has store, key {
        id: 0x2::object::UID,
        bet_type: u64,
        bet_size: u64,
        bet_number: 0x1::option::Option<u64>,
        player: address,
    }

    public fun all_of_them_bet() : u64 {
        8
    }

    public fun any_craps_bet() : u64 {
        12
    }

    public fun any_craps_numbers() : vector<u64> {
        vector[2, 3, 12]
    }

    public fun bet_metadata(arg0: &Bet) : (u64, u64, 0x1::option::Option<u64>, address) {
        (arg0.bet_type, arg0.bet_size, arg0.bet_number, arg0.player)
    }

    public fun big_ones_bet() : u64 {
        7
    }

    public fun buy_bet() : u64 {
        4
    }

    public fun c_e_split_bet() : u64 {
        18
    }

    public fun come_bet() : u64 {
        9
    }

    public fun come_odds_bet() : u64 {
        16
    }

    public fun destroy_bet(arg0: Bet) : (u64, u64, 0x1::option::Option<u64>, address) {
        let Bet {
            id         : v0,
            bet_type   : v1,
            bet_size   : v2,
            bet_number : v3,
            player     : v4,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4)
    }

    public fun dont_come_bet() : u64 {
        10
    }

    public fun dont_come_odds_bet() : u64 {
        17
    }

    public fun dont_pass_line_bet() : u64 {
        1
    }

    public fun dont_pass_odds_bet() : u64 {
        15
    }

    public fun field_bet() : u64 {
        2
    }

    public fun fill_bet_number(arg0: &mut Bet, arg1: u64) {
        0x1::option::fill<u64>(&mut arg0.bet_number, arg1);
    }

    public fun get_bet_max_payout(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u64>) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 == 1) {
            true
        } else if (arg1 == 9) {
            true
        } else {
            arg1 == 10
        };
        if (v0) {
            return mul(arg0, 1000000000)
        };
        if (arg1 == 14 || arg1 == 16) {
            let v1 = *0x1::option::borrow<u64>(&arg2);
            if (v1 == 4 || v1 == 10) {
                return mul(arg0, 2000000000)
            };
            if (v1 == 5 || v1 == 9) {
                return mul(arg0, 1500000000)
            };
            return mul(arg0, 1200000000)
        };
        if (arg1 == 15 || arg1 == 17) {
            let v2 = *0x1::option::borrow<u64>(&arg2);
            if (v2 == 4 || v2 == 10) {
                return mul(arg0, 500000000)
            };
            if (v2 == 5 || v2 == 9) {
                return mul(arg0, 666666666)
            };
            return mul(arg0, 833333333)
        };
        if (arg1 == 3) {
            let v3 = *0x1::option::borrow<u64>(&arg2);
            if (v3 == 4 || v3 == 10) {
                return mul(arg0, 1800000000)
            };
            if (v3 == 5 || v3 == 9) {
                return mul(arg0, 1400000000)
            };
            return mul(arg0, 1166666666)
        };
        if (arg1 == 4) {
            let v4 = *0x1::option::borrow<u64>(&arg2);
            if (v4 == 4 || v4 == 10) {
                return mul(arg0, 2000000000)
            };
            if (v4 == 5 || v4 == 9) {
                return mul(arg0, 1500000000)
            };
            return mul(arg0, 1200000000)
        };
        if (arg1 == 5) {
            let v5 = *0x1::option::borrow<u64>(&arg2);
            if (v5 == 4 || v5 == 10) {
                return mul(arg0, 500000000)
            };
            if (v5 == 5 || v5 == 9) {
                return mul(arg0, 666666666)
            };
            return mul(arg0, 833333333)
        };
        if (arg1 == 2) {
            return mul(arg0, 3000000000)
        };
        if (arg1 == 11) {
            let v6 = *0x1::option::borrow<u64>(&arg2);
            if (v6 == 4 || v6 == 10) {
                return mul(arg0, 7000000000)
            };
            assert!(v6 == 6 || v6 == 8, 0);
            return mul(arg0, 9000000000)
        };
        if (arg1 == 12) {
            if (0x1::option::is_some<u64>(&arg2)) {
                let v7 = 0x1::option::borrow<u64>(&arg2);
                if (*v7 == 2) {
                    return mul(arg0, 30000000000)
                };
                if (*v7 == 3) {
                    return mul(arg0, 15000000000)
                };
                if (*v7 == 11) {
                    return mul(arg0, 15000000000)
                };
                assert!(*v7 == 12, 0);
                return mul(arg0, 30000000000)
            };
            return mul(arg0, 7000000000)
        };
        if (arg1 == 13) {
            return mul(arg0, 4000000000)
        };
        if (arg1 == 6 || arg1 == 7) {
            return mul(arg0, 30000000000)
        };
        if (arg1 == 8) {
            return mul(arg0, 150000000000)
        };
        assert!(arg1 == 18, 0);
        if (0x1::option::is_some<u64>(&arg2)) {
            let v8 = *0x1::option::borrow<u64>(&arg2);
            let v9 = if (v8 == 2) {
                true
            } else if (v8 == 3) {
                true
            } else {
                v8 == 12
            };
            if (v9) {
                return mul(arg0, 3000000000)
            };
        };
        mul(arg0, 7000000000)
    }

    public fun get_bet_result_and_payout(arg0: u64, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &0x2::vec_set::VecSet<u64>, arg4: u64, arg5: u64, arg6: u64) : (bool, bool, u64) {
        if (arg0 == 12) {
            if (0x1::option::is_some<u64>(&arg1)) {
                let v0 = 0x1::option::borrow<u64>(&arg1);
                if (v0 == &arg5 && *v0 == 2) {
                    return (true, false, mul(arg2, 30000000000))
                };
                if (v0 == &arg5 && *v0 == 3) {
                    return (true, false, mul(arg2, 15000000000))
                };
                if (v0 == &arg5 && *v0 == 11) {
                    return (true, false, mul(arg2, 15000000000))
                };
                if (v0 == &arg5 && *v0 == 12) {
                    return (true, false, mul(arg2, 30000000000))
                };
                return (false, false, 0)
            };
            let v1 = vector[2, 3, 12];
            if (0x1::vector::contains<u64>(&v1, &arg5)) {
                return (true, false, mul(arg2, 7000000000))
            };
            return (false, false, 0)
        };
        if (arg0 == 13) {
            if (arg5 == 7) {
                return (true, false, mul(arg2, 4000000000))
            };
            return (false, false, 0)
        };
        if (arg0 == 2) {
            let v2 = vector[2, 12];
            if (0x1::vector::contains<u64>(&v2, &arg5)) {
                return (true, false, mul(arg2, 2000000000))
            };
            let v3 = vector[3, 4, 9, 10, 11];
            if (0x1::vector::contains<u64>(&v3, &arg5)) {
                return (true, false, mul(arg2, 1000000000))
            };
            return (false, false, 0)
        };
        if (arg0 == 3) {
            if (arg5 == 7) {
                return (false, false, 0)
            };
            let v4 = *0x1::option::borrow<u64>(&arg1);
            if (v4 == arg5 && (v4 == 4 || v4 == 10)) {
                return (true, false, mul(arg2, 1800000000))
            };
            if (v4 == arg5 && (v4 == 5 || v4 == 9)) {
                return (true, false, mul(arg2, 1400000000))
            };
            if (v4 == arg5 && (v4 == 6 || v4 == 8)) {
                return (true, false, mul(arg2, 1166666666))
            };
            return (false, true, 0)
        };
        if (arg0 == 4) {
            if (arg5 == 7) {
                return (false, false, 0)
            };
            let v5 = *0x1::option::borrow<u64>(&arg1);
            if (v5 == arg5 && (v5 == 4 || v5 == 10)) {
                return (true, false, mul(arg2, 2000000000))
            };
            if (v5 == arg5 && (v5 == 5 || v5 == 9)) {
                return (true, false, mul(arg2, 1500000000))
            };
            if (v5 == arg5 && (v5 == 6 || v5 == 8)) {
                return (true, false, mul(arg2, 1200000000))
            };
            return (false, true, 0)
        };
        if (arg0 == 5) {
            if (arg5 == 7) {
                let v6 = *0x1::option::borrow<u64>(&arg1);
                if (v6 == 4 || v6 == 10) {
                    return (true, false, mul(arg2, 500000000))
                };
                if (v6 == 5 || v6 == 9) {
                    return (true, false, mul(arg2, 666666666))
                };
                assert!(v6 == 6 || v6 == 8, 0);
                return (true, false, mul(arg2, 833333333))
            };
            let v7 = *0x1::option::borrow<u64>(&arg1);
            if (v7 == arg5 && (v7 == 4 || v7 == 10)) {
                return (false, false, 0)
            };
            if (v7 == arg5 && (v7 == 5 || v7 == 9)) {
                return (false, false, 0)
            };
            if (v7 == arg5 && (v7 == 6 || v7 == 8)) {
                return (false, false, 0)
            };
            return (false, true, 0)
        };
        if (arg0 == 6) {
            if (arg5 == 7) {
                return (false, false, 0)
            };
            let v8 = 2;
            let v9 = if (0x2::vec_set::contains<u64>(arg3, &v8)) {
                let v10 = 3;
                if (0x2::vec_set::contains<u64>(arg3, &v10)) {
                    let v11 = 4;
                    if (0x2::vec_set::contains<u64>(arg3, &v11)) {
                        let v12 = 5;
                        if (0x2::vec_set::contains<u64>(arg3, &v12)) {
                            let v13 = 6;
                            0x2::vec_set::contains<u64>(arg3, &v13)
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
            if (v9) {
                return (true, false, mul(arg2, 30000000000))
            };
            return (false, true, 0)
        };
        if (arg0 == 7) {
            if (arg5 == 7) {
                return (false, false, 0)
            };
            let v14 = 8;
            let v15 = if (0x2::vec_set::contains<u64>(arg3, &v14)) {
                let v16 = 9;
                if (0x2::vec_set::contains<u64>(arg3, &v16)) {
                    let v17 = 10;
                    if (0x2::vec_set::contains<u64>(arg3, &v17)) {
                        let v18 = 11;
                        if (0x2::vec_set::contains<u64>(arg3, &v18)) {
                            let v19 = 12;
                            0x2::vec_set::contains<u64>(arg3, &v19)
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
            if (v15) {
                return (true, false, mul(arg2, 30000000000))
            };
            return (false, true, 0)
        };
        if (arg0 == 8) {
            if (arg5 == 7) {
                return (false, false, 0)
            };
            let v20 = 2;
            let v21 = if (0x2::vec_set::contains<u64>(arg3, &v20)) {
                let v22 = 3;
                if (0x2::vec_set::contains<u64>(arg3, &v22)) {
                    let v23 = 4;
                    if (0x2::vec_set::contains<u64>(arg3, &v23)) {
                        let v24 = 5;
                        if (0x2::vec_set::contains<u64>(arg3, &v24)) {
                            let v25 = 6;
                            if (0x2::vec_set::contains<u64>(arg3, &v25)) {
                                let v26 = 8;
                                if (0x2::vec_set::contains<u64>(arg3, &v26)) {
                                    let v27 = 9;
                                    if (0x2::vec_set::contains<u64>(arg3, &v27)) {
                                        let v28 = 10;
                                        if (0x2::vec_set::contains<u64>(arg3, &v28)) {
                                            let v29 = 11;
                                            if (0x2::vec_set::contains<u64>(arg3, &v29)) {
                                                let v30 = 12;
                                                0x2::vec_set::contains<u64>(arg3, &v30)
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
            if (v21) {
                return (true, false, mul(arg2, 150000000000))
            };
            return (false, true, 0)
        };
        if (arg0 == 11) {
            if (arg5 == 7) {
                return (false, false, 0)
            };
            let v31 = *0x1::option::borrow<u64>(&arg1);
            if (v31 == arg5) {
                let (v32, v33) = 0x2c6b186d1bb437e09132af796714340d431c7dfaa83cddfd4b9bd785204be743::dice_interpreter::get_dice(arg4);
                if (v32 == v33) {
                    if (v31 == 4 || v31 == 10) {
                        return (true, false, mul(arg2, 7000000000))
                    };
                    if (v31 == 6 || v31 == 8) {
                        return (true, false, mul(arg2, 9000000000))
                    };
                } else {
                    return (false, false, 0)
                };
            };
            return (false, true, 0)
        };
        if (arg0 == 9) {
            if (0x1::option::is_none<u64>(&arg1)) {
                if (arg5 == 7 || arg5 == 11) {
                    return (true, false, mul(arg2, 1000000000))
                };
                let v34 = if (arg5 == 2) {
                    true
                } else if (arg5 == 3) {
                    true
                } else {
                    arg5 == 12
                };
                if (v34) {
                    return (false, false, 0)
                };
                return (false, true, 0)
            };
            if (arg5 == 7) {
                return (false, false, 0)
            };
            if (*0x1::option::borrow<u64>(&arg1) == arg5) {
                return (true, false, mul(arg2, 1000000000))
            };
            return (false, true, 0)
        };
        if (arg0 == 16) {
            let v35 = *0x1::option::borrow<u64>(&arg1);
            if (arg5 == 7) {
                return (false, false, 0)
            };
            if (v35 != arg5) {
                return (false, true, 0)
            };
            if (v35 == 4 || v35 == 10) {
                return (true, false, mul(arg2, 2000000000))
            };
            if (v35 == 5 || v35 == 9) {
                return (true, false, mul(arg2, 1500000000))
            };
            return (true, false, mul(arg2, 1200000000))
        };
        if (arg0 == 10) {
            if (0x1::option::is_none<u64>(&arg1)) {
                if (arg5 == 7 || arg5 == 11) {
                    return (false, false, 0)
                };
                if (arg5 == 2 || arg5 == 3) {
                    return (true, false, mul(arg2, 1000000000))
                };
                if (arg5 == 12) {
                    return (true, false, 0)
                };
                return (false, true, 0)
            };
            if (arg5 == 7) {
                return (true, false, mul(arg2, 1000000000))
            };
            if (*0x1::option::borrow<u64>(&arg1) == arg5) {
                return (false, false, 0)
            };
            return (false, true, 0)
        };
        if (arg0 == 17) {
            if (arg5 == 7) {
                let v36 = *0x1::option::borrow<u64>(&arg1);
                if (v36 == 4 || v36 == 10) {
                    return (true, false, mul(arg2, 500000000))
                };
                if (v36 == 5 || v36 == 9) {
                    return (true, false, mul(arg2, 666666666))
                };
                return (true, false, mul(arg2, 833333333))
            };
            if (*0x1::option::borrow<u64>(&arg1) == arg5) {
                return (false, false, 0)
            };
            return (false, true, 0)
        };
        if (arg0 == 18) {
            if (arg5 == 11) {
                return (true, false, mul(arg2, 7000000000))
            };
            let v37 = if (arg5 == 2) {
                true
            } else if (arg5 == 3) {
                true
            } else {
                arg5 == 12
            };
            if (v37) {
                return (true, false, mul(arg2, 3000000000))
            };
            return (false, false, 0)
        };
        if (arg6 == 0) {
            if (arg0 == 0) {
                if (arg5 == 7 || arg5 == 11) {
                    return (true, false, mul(arg2, 1000000000))
                };
                let v38 = if (arg5 == 2) {
                    true
                } else if (arg5 == 3) {
                    true
                } else {
                    arg5 == 12
                };
                if (v38) {
                    return (false, false, 0)
                };
                return (false, true, 0)
            };
            assert!(arg0 == 1, 0);
            if (arg5 == 7 || arg5 == 11) {
                return (false, false, 0)
            };
            if (arg5 == 2 || arg5 == 3) {
                return (true, false, mul(arg2, 1000000000))
            };
            if (arg5 == 12) {
                return (true, false, 0)
            };
            return (false, true, 0)
        };
        if (arg5 == 7) {
            if (arg0 == 1) {
                return (true, false, mul(arg2, 1000000000))
            };
            if (arg0 == 15) {
                let v39 = *0x1::option::borrow<u64>(&arg1);
                if (v39 == 4 || v39 == 10) {
                    return (true, false, mul(arg2, 500000000))
                };
                if (v39 == 5 || v39 == 9) {
                    return (true, false, mul(arg2, 666666666))
                };
                return (true, false, mul(arg2, 833333333))
            };
            return (false, false, 0)
        };
        if (arg0 == 1 || arg0 == 15) {
            if (arg5 == arg6) {
                return (false, false, 0)
            };
            return (false, true, 0)
        };
        if (arg0 == 0) {
            if (arg5 == arg6) {
                return (true, false, mul(arg2, 1000000000))
            };
        };
        if (arg0 == 14) {
            if (arg5 == arg6) {
                let v40 = *0x1::option::borrow<u64>(&arg1);
                if (v40 == 4 || v40 == 10) {
                    return (true, false, mul(arg2, 2000000000))
                };
                if (v40 == 5 || v40 == 9) {
                    return (true, false, mul(arg2, 1500000000))
                };
                return (true, false, mul(arg2, 1200000000))
            };
        };
        (false, true, 0)
    }

    public fun hard_ways_bet() : u64 {
        11
    }

    public fun is_valid_bet(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: vector<u64>, arg5: &vector<Bet>) {
        assert!(arg0 < 19 && arg0 >= 0, 0);
        if (arg0 == 0 || arg0 == 1) {
            assert!(arg3 == 0, 0);
        };
        if (arg0 == 14) {
            assert!(arg3 == *0x1::option::borrow<u64>(&arg2) && arg3 != 0, 0);
            let v0 = 0;
            let v1 = false;
            loop {
                if (v0 >= 0x1::vector::length<Bet>(arg5)) {
                    break
                };
                let v2 = 0x1::vector::borrow<Bet>(arg5, v0);
                if (v2.bet_type == 0) {
                    v1 = true;
                    assert!(arg1 <= v2.bet_size * 5, 0);
                };
                v0 = v0 + 1;
            };
            assert!(v1, 0);
        };
        if (arg0 == 15) {
            assert!(arg3 == *0x1::option::borrow<u64>(&arg2) && arg3 != 0, 0);
            let v3 = 0;
            let v4 = false;
            loop {
                if (v3 >= 0x1::vector::length<Bet>(arg5)) {
                    break
                };
                let v5 = 0x1::vector::borrow<Bet>(arg5, v3);
                if (v5.bet_type == 1) {
                    v4 = true;
                    assert!(arg1 <= v5.bet_size * 5, 0);
                };
                v3 = v3 + 1;
            };
            assert!(v4, 0);
        };
        if (arg0 == 9 || arg0 == 10) {
            assert!(0x1::option::is_none<u64>(&arg2), 0);
            assert!(arg3 != 0, 0);
        };
        if (arg0 == 16) {
            let v6 = 0;
            let v7 = false;
            loop {
                if (v6 >= 0x1::vector::length<Bet>(arg5)) {
                    break
                };
                let v8 = 0x1::vector::borrow<Bet>(arg5, v6);
                if (v8.bet_type == 9) {
                    if (0x1::option::is_some<u64>(&v8.bet_number)) {
                        if (*0x1::option::borrow<u64>(&v8.bet_number) == *0x1::option::borrow<u64>(&arg2)) {
                            assert!(arg1 <= v8.bet_size * 5, 0);
                            v7 = true;
                            break
                        };
                    };
                };
                v6 = v6 + 1;
            };
            assert!(v7, 0);
        };
        if (arg0 == 17) {
            let v9 = 0;
            let v10 = false;
            loop {
                if (v9 >= 0x1::vector::length<Bet>(arg5)) {
                    break
                };
                let v11 = 0x1::vector::borrow<Bet>(arg5, v9);
                if (v11.bet_type == 10) {
                    if (0x1::option::is_some<u64>(&v11.bet_number)) {
                        if (*0x1::option::borrow<u64>(&v11.bet_number) == *0x1::option::borrow<u64>(&arg2)) {
                            assert!(arg1 <= v11.bet_size * 5, 0);
                            v10 = true;
                            break
                        };
                    };
                };
                v9 = v9 + 1;
            };
            assert!(v10, 0);
        };
        if (arg0 == 3) {
            assert!(0x1::option::is_some<u64>(&arg2), 1);
            let v12 = vector[4, 5, 6, 8, 9, 10];
            assert!(0x1::vector::contains<u64>(&v12, 0x1::option::borrow<u64>(&arg2)), 1);
        };
        if (arg0 == 5) {
            assert!(0x1::option::is_some<u64>(&arg2), 1);
            let v13 = vector[4, 5, 6, 8, 9, 10];
            assert!(0x1::vector::contains<u64>(&v13, 0x1::option::borrow<u64>(&arg2)), 1);
        };
        if (arg0 == 4) {
            assert!(0x1::option::is_some<u64>(&arg2), 1);
            let v14 = vector[4, 5, 6, 8, 9, 10];
            assert!(0x1::vector::contains<u64>(&v14, 0x1::option::borrow<u64>(&arg2)), 1);
        };
        if (arg0 == 11) {
            assert!(0x1::option::is_some<u64>(&arg2), 1);
            let v15 = vector[4, 6, 8, 10];
            assert!(0x1::vector::contains<u64>(&v15, 0x1::option::borrow<u64>(&arg2)), 1);
        };
        if (arg0 == 12) {
            if (0x1::option::is_some<u64>(&arg2)) {
                let v16 = vector[2, 3, 12];
                assert!(0x1::vector::contains<u64>(&v16, 0x1::option::borrow<u64>(&arg2)) || *0x1::option::borrow<u64>(&arg2) == 11, 1);
            };
        };
        let v17 = if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else {
            arg0 == 8
        };
        if (v17) {
            assert!(0x1::vector::length<u64>(&arg4) == 0, 0);
        };
    }

    public fun is_valid_remove(arg0: u64, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u8, arg4: vector<u64>, arg5: &vector<Bet>) {
        assert!(arg3 != 1, 2);
        if (arg0 == 0 || arg0 == 1) {
            assert!(arg2 == 0, 2);
        };
        if (arg0 == 9 || arg0 == 10) {
            assert!(0x1::option::is_none<u64>(&arg1), 2);
        };
    }

    public fun lay_bet() : u64 {
        5
    }

    public fun little_ones_bet() : u64 {
        6
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    public fun new_bet(arg0: u64, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Bet {
        Bet{
            id         : 0x2::object::new(arg4),
            bet_type   : arg0,
            bet_size   : arg1,
            bet_number : arg2,
            player     : arg3,
        }
    }

    public fun pass_line_bet() : u64 {
        0
    }

    public fun pass_odds_bet() : u64 {
        14
    }

    public fun place_bet() : u64 {
        3
    }

    public fun seven_bet() : u64 {
        13
    }

    public fun update_bet_size(arg0: &mut Bet, arg1: u64) {
        arg0.bet_size = arg1;
    }

    // decompiled from Move bytecode v6
}

