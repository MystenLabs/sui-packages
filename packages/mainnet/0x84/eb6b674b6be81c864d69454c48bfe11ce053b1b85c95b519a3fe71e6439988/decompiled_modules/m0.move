module 0x8588bf772f76920555f443cccfee2fe1b37afb8241105141d3a5159e23d5c3c::m0 {
    public(friend) fun bk_ticks(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (((arg0 as u128) * ((arg2 as u128) + (arg3 as u128)) + 100000000 - 1) / 100000000 + (arg1 as u128) - 1) / (arg1 as u128);
        let v1 = if (v0 == 0) {
            1
        } else {
            v0
        };
        if (v1 > 18446744073709551615) {
            0
        } else {
            (v1 as u64)
        }
    }

    fun cm(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : (u64, bool) {
        if (arg3) {
            if (arg1 <= arg2) {
                return (0, false)
            };
            let v2 = arg1 - arg2;
            if (arg0 > v2) {
                (v2, false)
            } else {
                (arg0, true)
            }
        } else {
            let v3 = arg1 + arg2;
            if (arg0 < v3) {
                (v3, false)
            } else {
                (arg0, true)
            }
        }
    }

    public(friend) fun cx(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8) : (u64, u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0 < arg1
        };
        if (v0) {
            return (arg0, arg1)
        };
        let (v1, v2) = if (arg5 == 1) {
            let v3 = arg0 + arg4;
            let v4 = if (arg3 > v3) {
                arg3
            } else {
                v3
            };
            (v4, arg0)
        } else {
            let (v5, v6) = if (arg5 == 2) {
                let v7 = if (arg1 > arg4) {
                    arg1 - arg4
                } else {
                    0
                };
                let v8 = if (arg2 < v7 && arg2 > 0) {
                    arg2
                } else {
                    v7
                };
                (v8, arg1)
            } else {
                (arg2, arg3)
            };
            (v6, v5)
        };
        (v2, v1)
    }

    public(friend) fun dc(arg0: u8) : (bool, u64) {
        if (arg0 >= 128) {
            (false, ((arg0 - 128) as u64))
        } else {
            (true, ((128 - arg0) as u64))
        }
    }

    public(friend) fun dk(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u64) : (bool, u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg1 <= arg0) {
            true
        } else if (arg3 <= arg2) {
            true
        } else {
            arg4 == 0
        };
        if (v0) {
            return (false, 18446744073709551615)
        };
        let v1 = ((arg0 as u128) + (arg1 as u128)) / 2;
        let v2 = ((arg2 as u128) + (arg3 as u128)) / 2;
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            v1 - v2
        };
        let v4 = ((v3 * 10000 / v1) as u64);
        if (v4 > arg6) {
            return (false, v4)
        };
        let v5 = (arg4 as u128);
        let v6 = arg5 == 1 && v5 > v1 && v5 > v2 || arg5 == 2 && v5 < v1 && v5 < v2 || true;
        (v6, v4)
    }

    public(friend) fun ec(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else {
            arg5 == 0
        };
        if (v0) {
            return 0
        };
        if (arg0) {
            if (arg5 <= arg4) {
                return 0
            };
            let v2 = (((arg2 as u128) * 100000000 / (100000000 + (arg3 as u128))) as u64);
            let v3 = arg5 - arg4;
            let v4 = if (arg1 < v2) {
                arg1
            } else {
                v2
            };
            let v5 = v4;
            if (v4 > v3) {
                v5 = v3;
            };
            v5 - v5 % arg4
        } else {
            let v6 = ((((arg2 as u128) * (100000000 + (arg3 as u128)) + 100000000 - 1) / 100000000) as u64);
            let v7 = arg5 + arg4;
            let v8 = if (arg1 > v6) {
                arg1
            } else {
                v6
            };
            let v9 = v8;
            if (v8 < v7) {
                v9 = v7;
            };
            let v10 = v9 % arg4;
            if (v10 != 0) {
                v9 = v9 + arg4 - v10;
            };
            v9
        }
    }

    public(friend) fun iz(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64) {
        let v0 = if (arg2 > 18446744073709551615 - arg1) {
            18446744073709551615
        } else {
            arg1 + arg2
        };
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            0
        };
        let v2 = arg5 > arg1 && arg5 - arg1 > arg3;
        let v3 = arg5 < arg1 && arg1 - arg5 > arg3;
        let (v4, v5) = if (v2) {
            let v6 = arg5 - arg1;
            let v7 = if (arg0 < v6) {
                arg0
            } else {
                v6
            };
            (0, v7)
        } else if (v3) {
            let v8 = arg1 - arg5;
            let v9 = if (arg0 < v8) {
                arg0
            } else {
                v8
            };
            (v9, 0)
        } else {
            let v10 = if (arg5 >= v0) {
                0
            } else {
                v0 - arg5
            };
            let v11 = if (arg5 <= v1) {
                0
            } else {
                arg5 - v1
            };
            let v12 = if (arg0 < v10) {
                arg0
            } else {
                v10
            };
            let v13 = if (arg0 < v11) {
                arg0
            } else {
                v11
            };
            (v12, v13)
        };
        let v14 = v5;
        let v15 = v4;
        if (arg4 > 0) {
            v15 = v4 - v4 % arg4;
            v14 = v5 - v5 % arg4;
        };
        (v15, v14)
    }

    public(friend) fun lx(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 && arg1 >= arg3 || arg1 >= arg2
    }

    public(friend) fun md(arg0: u64) : (u8, u8, bool, u8, bool) {
        (((arg0 & 3) as u8), ((arg0 >> 2 & 3) as u8), arg0 >> 4 & 1 != 0, ((arg0 >> 5 & 3) as u8), arg0 >> 7 & 1 != 0)
    }

    public(friend) fun mo(arg0: bool, arg1: bool, arg2: bool, arg3: u8, arg4: bool) : u8 {
        if (arg0) {
            return 0
        };
        if (arg1) {
            return 3
        };
        if (arg2) {
            if (arg3 == 1 && arg4 || arg3 == 2 && !arg4) {
                return 2
            };
            if (arg3 == 1 || arg3 == 2) {
                return 3
            };
        };
        1
    }

    public(friend) fun mode_bkf() : u8 {
        3
    }

    public(friend) fun mode_none() : u8 {
        0
    }

    public(friend) fun mode_off() : u8 {
        1
    }

    public(friend) fun mode_tch() : u8 {
        2
    }

    public(friend) fun px1(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: u8) : (u64, u64, bool) {
        let (v0, v1) = dc(arg4);
        let v2 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            v1 > (16 as u64)
        };
        if (v2) {
            return (0, 0, false)
        };
        let v3 = v1 * arg2;
        let v4 = if (v0 == arg3) {
            if (arg0 > v3) {
                arg0 - v3
            } else {
                0
            }
        } else {
            arg0 + v3
        };
        if (v4 == 0) {
            return (0, 0, false)
        };
        let (v5, v6) = cm(v4, arg1, arg2, arg3);
        (v4, v5, v6)
    }

    public(friend) fun px2(arg0: u64, arg1: u64, arg2: bool, arg3: u64) : (u64, u64, bool) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg3 > (16 as u64)
        };
        if (v0) {
            return (0, 0, false)
        };
        let v1 = arg3 * arg1;
        let v2 = if (arg2) {
            if (arg0 > v1) {
                arg0 - v1
            } else {
                0
            }
        } else {
            arg0 + v1
        };
        if (v2 == 0) {
            return (0, 0, false)
        };
        let (v3, v4) = cm(v2, arg0, arg1, arg2);
        (v2, v3, v4)
    }

    public(friend) fun px3(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u64 {
        let v0 = bk_ticks(arg0, arg1, arg2, arg3);
        let v1 = if (v0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            v0 > 18446744073709551615 / arg1
        };
        if (v1) {
            return 0
        };
        let v2 = v0 * arg1;
        if (arg4) {
            if (arg0 > v2) {
                arg0 - v2
            } else {
                0
            }
        } else {
            arg0 + v2
        }
    }

    public(friend) fun rk(arg0: u8) : u8 {
        if (arg0 == 2) {
            3
        } else if (arg0 == 1) {
            2
        } else if (arg0 == 3) {
            1
        } else {
            0
        }
    }

    public(friend) fun rs(arg0: u8, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool) : u8 {
        let v0 = if (arg1) {
            true
        } else if (!arg3) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        if (arg2) {
            return 3
        };
        if (!arg4) {
            if (arg0 == 3) {
                return 3
            };
            return if (arg5) {
                1
            } else {
                0
            }
        };
        arg0
    }

    public(friend) fun sx(arg0: bool, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64) : bool {
        if (arg0) {
            if (arg5 > 0) {
                if (arg1 == arg5) {
                    if (arg2 == arg6) {
                        if (arg3 == arg7) {
                            if (arg4 > arg8) {
                                arg4 - arg8 > arg9
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

    public(friend) fun xs(arg0: bool, arg1: u64, arg2: u64) : bool {
        if (arg1 == 0 || arg2 == 0) {
            return false
        };
        arg0 && arg1 >= arg2 || arg1 <= arg2
    }

    // decompiled from Move bytecode v7
}

