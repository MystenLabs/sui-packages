module 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety {
    public fun achievement_credit_cost(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 100000 * (arg1 as u256);
        ((((arg0 as u256) * 10000 + v0 - 1) / v0) as u64)
    }

    public fun achievement_fee_basis(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: bool) : u64 {
        if (arg3 || arg4) {
            0
        } else if (arg5) {
            arg0
        } else {
            let v1 = (arg0 as u128) + (arg1 as u128) + (arg2 as u128);
            if (v1 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v1 as u64)
            }
        }
    }

    public fun achievement_mint_allowance(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u256) * 100000 * (arg1 as u256) / 10000;
        if (v0 < (arg2 as u256)) {
            (v0 as u64)
        } else {
            arg2
        }
    }

    public fun bps_of(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun buckets_conserve(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : bool {
        (arg0 as u128) + (arg1 as u128) + (arg2 as u128) + (arg3 as u128) + (arg4 as u128) + (arg5 as u128) + (arg6 as u128) + (arg7 as u128) + (arg8 as u128) == (arg9 as u128)
    }

    public fun builder_create_fee_ok(arg0: u64) : bool {
        arg0 <= 100000000
    }

    public fun effective_bust_buffer(arg0: u128, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 4000000000000000000000 / 10000 * (arg1 as u128);
        if (arg0 < v0) {
            arg0
        } else {
            v0
        }
    }

    public fun emergency_after_ms_ok(arg0: u64) : bool {
        arg0 >= 5000 && arg0 <= 60000
    }

    public fun factor_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (((arg0 as u128) * 10000 / (arg1 as u128)) as u64)
        }
    }

    public fun fee_owed_take(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 > arg1) {
            arg2 - arg1
        } else {
            0
        };
        if (arg0 < v0) {
            arg0
        } else {
            v0
        }
    }

    public fun fill_price_in_window(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 > arg1 && arg0 - arg1 <= arg2
    }

    public fun genuine_win(arg0: bool, arg1: u64, arg2: u64) : bool {
        if (!arg0) {
            if (arg1 > 0) {
                arg2 == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun isqrt(arg0: u128) : u128 {
        if (arg0 <= 1) {
            return arg0
        };
        let v0 = arg0 / 2 + arg0 % 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun keeper_batch_ok(arg0: u8, arg1: u8) : bool {
        if (arg0 <= 2) {
            if (arg1 <= 2) {
                arg1 >= arg0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun leverage_within(arg0: u64, arg1: u64) : bool {
        arg0 >= 1 && arg0 <= arg1
    }

    public fun liq_bounty_paid(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun liq_kind(arg0: u8, arg1: bool) : u8 {
        if (arg1) {
            2
        } else {
            arg0
        }
    }

    public fun liq_mint_basis(arg0: u8, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        if (arg4) {
            0
        } else if (arg0 == 0) {
            arg1
        } else if (arg0 == 1 || arg0 == 3) {
            0x1::u64::min(arg3, arg2)
        } else {
            0
        }
    }

    public fun loss_mint_basis(arg0: u64, arg1: bool, arg2: bool) : u64 {
        if (arg1 || arg2) {
            0
        } else {
            arg0
        }
    }

    public fun marginal_exposure(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u128) + (arg2 as u128);
        if (v0 > 18446744073709551615) {
            return 0
        };
        let v1 = winning_exposure(arg0, (v0 as u64));
        let v2 = winning_exposure(arg0, arg1);
        if (v1 <= v2) {
            0
        } else {
            v1 - v2
        }
    }

    public fun mint_room(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            0
        } else {
            arg1 - arg0
        }
    }

    public fun order_params_ok(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : bool {
        if (arg0 >= 200) {
            if (arg0 <= 5000) {
                if (arg1 >= arg0 + 1000) {
                    if (arg1 <= 30000) {
                        if (arg2 >= arg0) {
                            if (arg2 >= 5000) {
                                if (arg2 <= arg1) {
                                    if (emergency_after_ms_ok(arg3)) {
                                        if (arg3 >= arg1 + 5000) {
                                            if (arg4 <= 1000000) {
                                                if (arg5 >= 1) {
                                                    if (arg5 <= arg6) {
                                                        if (arg7 >= 200) {
                                                            if (arg7 <= 5000) {
                                                                arg7 + 1000 <= arg1
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
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun protocol_shares_fit(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) + (arg1 as u128) + (arg2 as u128) <= 10000
    }

    public fun retained_staker_bps(arg0: u64, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg1 == 0) {
            return arg3
        };
        let v0 = (arg0 as u256) * 10000;
        let v1 = (arg1 as u256);
        let v2 = v1 * (arg4 as u256);
        let v3 = v1 * (arg5 as u256);
        if (v0 <= v2) {
            return arg2
        };
        if (v0 >= v3) {
            return arg3
        };
        arg2 + (((v0 - v2) * ((arg3 - arg2) as u256) / (v3 - v2)) as u64)
    }

    public fun session_drain_next(arg0: u64) : (u64, bool) {
        assert!(arg0 > 0, 13906835888035332095);
        let v0 = arg0 - 1;
        (v0, v0 > 0)
    }

    public fun session_eligible(arg0: u64, arg1: u64) : bool {
        arg0 < arg1
    }

    public fun session_gap_ok(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= arg0 && arg1 - arg0 >= arg2
    }

    public fun session_pending(arg0: bool, arg1: u64) : bool {
        arg0 && arg1 > 0
    }

    public fun session_snapshot_monotonic(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u64) : bool {
        if (arg0 >= arg1) {
            if (arg0 >= arg2) {
                !arg3 || arg0 > arg4
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun surplus_take(arg0: u64, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = (arg1 as u256);
        let v1 = v0 * (arg2 as u256) / 10000;
        let v2 = if (v1 >= (arg5 as u256)) {
            v1
        } else {
            (arg5 as u256)
        };
        let v3 = (arg0 as u256);
        if (v3 <= v2) {
            return 0
        };
        let v4 = (v3 - v2) * (arg3 as u256) / 10000;
        let v5 = v0 * (arg4 as u256) / 10000;
        let v6 = if (v4 <= v5) {
            v4
        } else {
            v5
        };
        (v6 as u64)
    }

    public fun take_capped(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = mint_room(arg1, arg2);
        let v1 = mint_room(arg3, arg4);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        if (arg0 < v2) {
            arg0
        } else {
            v2
        }
    }

    public fun tighter_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun timestamp_accepted(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 > arg1 && arg0 - arg1 <= arg3 || arg1 - arg0 <= arg2
    }

    public fun trading_blocked(arg0: bool) : bool {
        arg0
    }

    public fun trim_profit(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u256) * (arg1 as u256) / 10000) as u64)
    }

    public fun utc_day(arg0: u64) : u64 {
        arg0 / 86400000
    }

    public fun winning_exposure(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            arg1
        } else {
            (isqrt((arg0 as u128) * (arg1 as u128)) as u64)
        }
    }

    // decompiled from Move bytecode v7
}

