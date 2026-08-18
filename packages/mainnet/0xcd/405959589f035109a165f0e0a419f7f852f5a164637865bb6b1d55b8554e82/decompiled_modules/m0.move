module 0xcd405959589f035109a165f0e0a419f7f852f5a164637865bb6b1d55b8554e82::m0 {
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

    public(friend) fun lx(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 && arg1 >= arg3 || arg1 >= arg2
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

    // decompiled from Move bytecode v7
}

