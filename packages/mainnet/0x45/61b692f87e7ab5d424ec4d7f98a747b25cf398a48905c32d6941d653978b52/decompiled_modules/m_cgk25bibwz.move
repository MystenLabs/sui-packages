module 0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_cgk25bibwz {
    public(friend) fun f_2gkf3ombdy(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 5;
        (arg0 - v0, v0, arg0 % 5)
    }

    public(friend) fun f_ernwde2fox(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : bool {
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

    public(friend) fun f_eur5274opo(arg0: u32, arg1: u32, arg2: u32) : bool {
        arg1 < arg2 && (arg0 < arg1 || arg0 >= arg2)
    }

    public(friend) fun f_jn5pg2t72q(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : bool {
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

    public(friend) fun f_k7kz7i2rso(arg0: u32, arg1: u32, arg2: u32) : (u32, u32) {
        let v0 = arg0 / arg1 * arg1 - (arg2 - 1) / 2 * arg1;
        (v0, v0 + f_u7yoggilzz(arg1, arg2))
    }

    public(friend) fun f_u7yoggilzz(arg0: u32, arg1: u32) : u32 {
        assert!(arg0 > 0, 0);
        assert!(f_zutbgzxug2(arg1), 1);
        arg0 * arg1
    }

    public(friend) fun f_w4tjem7zqm(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64) : bool {
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

    public(friend) fun f_zutbgzxug2(arg0: u32) : bool {
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

