module 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m1 {
    public(friend) fun act_cancel() : u8 {
        2
    }

    public(friend) fun act_keep() : u8 {
        0
    }

    public(friend) fun act_replace() : u8 {
        1
    }

    public(friend) fun ad(arg0: u64, arg1: u64, arg2: u64) : (bool, u64) {
        if (arg0 == 0 || arg1 == 0) {
            return (false, 18446744073709551615)
        };
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            v0 - v1
        };
        let v3 = ((v2 * 10000 / v0) as u64);
        (v3 <= arg2, v3)
    }

    public(friend) fun ed(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        if (arg1 == 0 || arg2 == 0) {
            return (false, 0)
        };
        let v0 = if (arg0) {
            (arg1 as u128) * 10000 / (arg2 as u128)
        } else {
            (arg2 as u128) * 10000 / (arg1 as u128)
        };
        if (v0 <= 10000) {
            return (false, 0)
        };
        let v1 = v0 - 10000;
        let v2 = (arg3 as u128);
        if (v1 <= v2) {
            return (false, 0)
        };
        (true, ((v1 - v2) as u64))
    }

    public(friend) fun fb(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg0 == 0 || (arg1 as u128) >= 100000000) {
            return 0
        };
        let v0 = if (arg2) {
            (arg0 as u128) * (100000000 + (arg1 as u128))
        } else {
            (arg0 as u128) * (100000000 - (arg1 as u128))
        };
        let v1 = if (arg2) {
            v0 / 100000000
        } else {
            (v0 + 100000000 - 1) / 100000000
        };
        if (v1 > 18446744073709551615) {
            0
        } else {
            (v1 as u64)
        }
    }

    public(friend) fun kind_backoff() : u8 {
        3
    }

    public(friend) fun kind_none() : u8 {
        0
    }

    public(friend) fun kind_offset() : u8 {
        1
    }

    public(friend) fun kind_touch() : u8 {
        2
    }

    public(friend) fun mkp(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u8) {
        mkpd(arg0, arg1, arg2, arg3, arg4, arg3, arg4, arg5, arg6)
    }

    public(friend) fun mkpc(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u8) {
        let v0 = if (arg6 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg2 <= arg1) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg4 <= arg3) {
            true
        } else {
            arg5 > 18446744073709551615 / arg6
        };
        if (v0) {
            return (0, 0)
        };
        let v1 = arg5 * arg6;
        if (arg0) {
            if (arg4 <= arg6 || arg1 > 18446744073709551615 - v1) {
                return (0, 0)
            };
            let v4 = arg1 + v1;
            let v5 = arg4 - arg6;
            let v6 = if (v4 < v5) {
                v4
            } else {
                v5
            };
            let v7 = v6 - v6 % arg6;
            if (v7 == 0) {
                (0, 0)
            } else {
                let v8 = if (v5 < v4) {
                    2
                } else {
                    1
                };
                (v7, v8)
            }
        } else {
            let v9 = if (arg2 > v1) {
                arg2 - v1
            } else {
                0
            };
            if (v9 == 0 || arg3 > 18446744073709551615 - arg6) {
                return (0, 0)
            };
            let v10 = arg3 + arg6;
            let v11 = if (v9 > v10) {
                v9
            } else {
                v10
            };
            let v12 = v11 % arg6;
            let v13 = if (v12 == 0) {
                v11
            } else {
                if (v11 > 18446744073709551615 - arg6 - v12) {
                    return (0, 0)
                };
                v11 + arg6 - v12
            };
            let v14 = if (v10 > v9) {
                2
            } else {
                1
            };
            (v13, v14)
        }
    }

    public(friend) fun mkpd(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u8) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg8 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg4 <= arg3) {
            true
        } else if (arg5 == 0) {
            true
        } else if (arg6 == 0) {
            true
        } else {
            arg6 <= arg5
        };
        if (v0) {
            return (0, 0)
        };
        if (arg0) {
            if (arg6 <= arg8 || arg7 > 18446744073709551615 / arg8) {
                return (0, 0)
            };
            let v3 = arg7 * arg8;
            if (arg3 > 18446744073709551615 - v3) {
                return (0, 0)
            };
            let v4 = arg3 + v3;
            let v5 = (((arg1 as u128) * 10000 / (10000 + (arg2 as u128))) as u64);
            let v6 = arg6 - arg8;
            let v7 = v4;
            let v8 = 1;
            if (v5 < v4) {
                v7 = v5;
                v8 = 3;
            };
            if (v6 < v7) {
                v7 = v6;
                v8 = 2;
            };
            let v9 = v7 - v7 % arg8;
            if (v9 == 0) {
                (0, 0)
            } else {
                (v9, v8)
            }
        } else {
            if (arg7 > 18446744073709551615 / arg8) {
                return (0, 0)
            };
            let v10 = arg7 * arg8;
            let v11 = if (arg4 > v10) {
                arg4 - v10
            } else {
                0
            };
            let v12 = ((((arg1 as u128) * (10000 + (arg2 as u128)) + 10000 - 1) / 10000) as u64);
            if (arg5 > 18446744073709551615 - arg8) {
                return (0, 0)
            };
            let v13 = arg5 + arg8;
            let v14 = v11;
            let v15 = 1;
            if (v11 == 0 || v12 > v11) {
                v14 = v12;
                v15 = 3;
            };
            if (v13 > v14) {
                v14 = v13;
                v15 = 2;
            };
            let v16 = v14 % arg8;
            let v17 = if (v16 == 0) {
                v14
            } else {
                v14 + arg8 - v16
            };
            if (v17 == 0) {
                (0, 0)
            } else {
                (v17, v15)
            }
        }
    }

    public(friend) fun mkpdb(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : (u64, u8) {
        let v0 = fb(arg1, arg2, arg0);
        if (v0 == 0) {
            return (0, 0)
        };
        mkpd(arg0, v0, 0, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun rqd(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : u8 {
        if (!arg0) {
            return if (arg2 == 0) {
                0
            } else {
                1
            }
        };
        if (arg3 && arg1 > arg4 || arg1 < arg4) {
            return if (arg2 == 0) {
                2
            } else {
                1
            }
        };
        if (arg2 == 0) {
            return 2
        };
        if (arg7 <= arg8 || arg7 - arg8 <= arg9) {
            return 1
        };
        let v2 = if (arg3) {
            if (arg2 > arg1) {
                arg2 - arg1
            } else {
                0
            }
        } else if (arg2 < arg1) {
            arg1 - arg2
        } else {
            0
        };
        if ((v2 as u128) >= (arg5 as u128) * (arg6 as u128)) {
            1
        } else {
            0
        }
    }

    public(friend) fun rqdb(arg0: bool, arg1: u64, arg2: u64, arg3: u8, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : u8 {
        if (!arg0) {
            return if (arg2 == 0) {
                0
            } else {
                1
            }
        };
        if (arg4 && arg1 > arg5 || arg1 < arg5) {
            return if (arg2 == 0) {
                2
            } else {
                1
            }
        };
        if (arg2 == 0) {
            return 2
        };
        if (arg8 <= arg9 || arg8 - arg9 <= arg10) {
            return 1
        };
        if (arg3 == 3) {
            return 0
        };
        rqd(true, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public(friend) fun rqdx(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u8 {
        if (!arg0) {
            return if (arg2 == 0) {
                0
            } else {
                1
            }
        };
        if (arg2 == 0) {
            return 2
        };
        if (arg3 <= arg4 || arg3 - arg4 <= arg5) {
            return 1
        };
        if (arg2 == arg1) {
            0
        } else {
            1
        }
    }

    public(friend) fun tg(arg0: u64, arg1: u8, arg2: u64, arg3: bool) : u64 {
        if (arg0 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return arg0
        };
        let v0 = (arg2 as u128);
        let v1 = if (arg1 == 1) {
            (arg0 as u128) * (1000000000 + v0)
        } else {
            if (v0 >= 1000000000) {
                return 0
            };
            (arg0 as u128) * (1000000000 - v0)
        };
        let v2 = if (arg3) {
            (v1 + 1000000000 - 1) / 1000000000
        } else {
            v1 / 1000000000
        };
        if (v2 > 18446744073709551615) {
            0
        } else {
            (v2 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

