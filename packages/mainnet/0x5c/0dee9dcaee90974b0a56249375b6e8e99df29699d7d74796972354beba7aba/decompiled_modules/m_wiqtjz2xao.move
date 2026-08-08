module 0x5c0dee9dcaee90974b0a56249375b6e8e99df29699d7d74796972354beba7aba::m_wiqtjz2xao {
    public(friend) fun f_4dmlze34yd(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : bool {
        let v0 = arg7 == 0 && arg8 == 0 || arg7 > 0 && arg8 > 0;
        let v1 = arg9 == 0 && arg10 == 0 || arg9 > 0 && arg10 > 0;
        if (v0) {
            if (v1) {
                if (arg4 == arg0 + arg8) {
                    if (arg5 == arg1 + arg10) {
                        arg6 + arg7 + arg9 == arg2 + arg3
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

    public(friend) fun f_5jyj7eansw(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 5;
        (arg0 - v0, v0, arg0 % 5)
    }

    public(friend) fun f_cdhks4yvy4(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u32, arg6: u32, arg7: u32, arg8: u32) : bool {
        if (arg0 != arg1) {
            if (arg0 == arg3) {
                if (arg1 == arg4) {
                    if (arg2 == arg3) {
                        if (arg5 == arg7) {
                            if (arg6 == arg8) {
                                if (arg5 > 0) {
                                    arg6 > 0
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

    public(friend) fun f_dz37qrjq3c(arg0: u32, arg1: u32) : u32 {
        assert!(arg0 > 0, 0);
        assert!(f_yquqv2emyr(arg1), 1);
        arg0 * arg1
    }

    public(friend) fun f_eczusplrq2(arg0: u32, arg1: u32, arg2: u32) : bool {
        arg1 < arg2 && (arg0 < arg1 || arg0 >= arg2)
    }

    fun f_f3fz2jpxm2(arg0: u32, arg1: u32) : bool {
        arg1 == 0 && false || (arg0 as u64) >= 2147483648 && (4294967296 - (arg0 as u64)) % (arg1 as u64) == 0 || (arg0 as u64) % (arg1 as u64) == 0
    }

    public(friend) fun f_jcrti7oomy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64) : bool {
        if (arg4 == 0) {
            if (arg5 == 0) {
                if (arg6 == 0) {
                    if (arg0 == arg2) {
                        arg1 == arg3
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else if (arg4 == 1) {
            if (arg5 > 0) {
                if (arg6 > 0) {
                    if (arg2 + arg5 == arg0) {
                        arg3 == arg1 + arg6
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else if (arg4 == 2) {
            if (arg5 > 0) {
                if (arg6 > 0) {
                    if (arg3 + arg5 == arg1) {
                        arg2 == arg0 + arg6
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

    fun f_mp44t6e26g(arg0: u32) : u64 {
        let v0 = (arg0 as u64);
        if (v0 >= 2147483648) {
            2147483648 - 4294967296 - v0
        } else {
            2147483648 + v0
        }
    }

    public(friend) fun f_nl2rfqp7pz(arg0: u32, arg1: u32, arg2: u32, arg3: u32) : bool {
        if (arg2 == 0 || !f_yquqv2emyr(arg3)) {
            false
        } else {
            let v1 = f_mp44t6e26g(arg0);
            let v2 = f_mp44t6e26g(arg1);
            if (v1 < v2) {
                if (v2 - v1 == (arg2 as u64) * (arg3 as u64)) {
                    f_f3fz2jpxm2(arg0, arg2)
                } else {
                    false
                }
            } else {
                false
            }
        }
    }

    public(friend) fun f_rbizdkkqn4(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : bool {
        if (arg2 == arg0) {
            if (arg3 == arg1) {
                if (arg4 == arg6) {
                    if (arg5 == arg7) {
                        let v1 = arg0 > 0 || arg1 > 0;
                        let v2 = arg6 > 0 || arg7 > 0;
                        v1 == v2
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

    public(friend) fun f_s6qdjhgfeu(arg0: u32, arg1: u32, arg2: u32) : (u32, u32) {
        let v0 = arg0 / arg1 * arg1 - (arg2 - 1) / 2 * arg1;
        (v0, v0 + f_dz37qrjq3c(arg1, arg2))
    }

    public(friend) fun f_sfgnhnr7ek(arg0: address, arg1: address, arg2: address) : bool {
        if (arg0 != @0x0) {
            if (arg0 == arg1) {
                arg1 == arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun f_so4apk6tin(arg0: u32, arg1: u32, arg2: u32) : bool {
        let v0 = f_mp44t6e26g(arg0);
        let v1 = f_mp44t6e26g(arg1);
        let v2 = f_mp44t6e26g(arg2);
        if (v1 < v2) {
            if (v0 >= v1) {
                v0 < v2
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun f_soo3poa3lm(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: address) : bool {
        if (arg0 == arg5) {
            if (arg1 == arg6) {
                if (arg2 == arg7) {
                    if (arg3 == arg8) {
                        if (arg4 == arg9) {
                            arg9 != @0x0
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

    public(friend) fun f_sx4g5ai6yn(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
        if (arg0 == 0 == arg3 == 0) {
            if (arg1 == 0 == arg4 == 0) {
                if (arg2 == 0 == arg5 == 0) {
                    arg3 + arg4 + arg5 == arg6
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

    public(friend) fun f_urdcw7ba6q(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: address, arg7: address) : bool {
        if (arg0 != arg1) {
            if (arg0 == arg2) {
                if (arg1 == arg3) {
                    if (arg4 == arg5) {
                        if (arg6 != @0x0) {
                            arg6 == arg7
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

    public(friend) fun f_vjurbauvan(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : bool {
        if (arg0 > 0 || arg1 > 0) {
            if (arg0 <= arg2) {
                if (arg1 <= arg3) {
                    if (arg4 >= arg6) {
                        if (arg5 >= arg7) {
                            if (arg8 <= arg10) {
                                arg9 <= arg11
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

    public(friend) fun f_yquqv2emyr(arg0: u32) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 4
        }
    }

    // decompiled from Move bytecode v7
}

