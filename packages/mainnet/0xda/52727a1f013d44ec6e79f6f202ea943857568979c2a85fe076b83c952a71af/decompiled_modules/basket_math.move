module 0xda52727a1f013d44ec6e79f6f202ea943857568979c2a85fe076b83c952a71af::basket_math {
    public fun allocations(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64, u64) {
        validate(arg1, arg2, arg3, arg4);
        assert!(arg0 > 0, 2);
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        let v1 = (((arg0 as u128) * (arg3 as u128) / 10000) as u64);
        let v2 = (((arg0 as u128) * (arg4 as u128) / 10000) as u64);
        (v0, arg0 - v0 - v1 - v2, v1, v2)
    }

    public fun assert_rebalance_progress(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg0 > 0) {
            if (arg2 > 0) {
                if (arg1 <= arg0) {
                    if (arg3 <= arg2) {
                        if (arg5 > 0) {
                            arg5 <= arg0
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
        assert!(v0, 2);
        assert!(arg4 >= 5000 && arg4 <= 9500, 1);
        assert!((arg2 as u128) + ((arg5 as u128) * 100 + 9999) / 10000 + 2 >= (arg0 as u128), 3);
        let v1 = (arg0 as u256) * (arg4 as u256);
        let v2 = (arg1 as u256) * 10000;
        let v3 = if (v2 >= v1) {
            v2 - v1
        } else {
            v1 - v2
        };
        let v4 = (arg2 as u256) * (arg4 as u256);
        let v5 = (arg3 as u256) * 10000;
        let v6 = if (v5 >= v4) {
            v5 - v4
        } else {
            v4 - v5
        };
        assert!(v6 * (arg0 as u256) < v3 * (arg2 as u256), 3);
    }

    public fun assert_sweep_cost(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg2 <= arg0, 2);
        assert!((arg1 as u128) + ((arg2 as u128) * 100 + 9999) / 10000 + 2 >= (arg0 as u128), 3);
    }

    public fun cash_targets(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64, u64) {
        validate(arg1, arg2, arg3, arg4);
        let v0 = ((10000 - arg1) as u128);
        let v1 = (((arg0 as u128) * (arg3 as u128) / v0) as u64);
        let v2 = (((arg0 as u128) * (arg4 as u128) / v0) as u64);
        (arg0 - v1 - v2, v1, v2)
    }

    public fun portion(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 > 0) {
            if (arg1 > 0) {
                arg1 <= arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun rebalance_plan(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        assert!(arg1 <= arg0, 2);
        let v0 = if (arg2 >= 5000) {
            if (arg2 <= 9500) {
                if (arg3 > 0) {
                    arg3 <= 1000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = (arg1 as u128) * 10000;
        let v2 = (arg0 as u128) * (arg2 as u128);
        let v3 = v1 < v2;
        let v4 = if (v3) {
            v2 - v1
        } else {
            v1 - v2
        };
        if (v4 <= (arg0 as u128) * 200) {
            return (v3, 0)
        };
        let v5 = if (v3) {
            ((v2 / 10000) as u64) - arg1
        } else {
            arg1 - ((v2 / 10000) as u64)
        };
        (v3, 0x1::u64::min(v5, (((arg0 as u128) * (arg3 as u128) / 10000) as u64)))
    }

    public fun refill_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg2 <= 10000, 1);
        assert!(arg1 <= arg0 && arg3 <= arg0 - arg1, 2);
        let v0 = (((arg0 as u128) * (arg2 as u128) / 10000) as u64);
        if (arg1 >= v0) {
            0
        } else {
            0x1::u64::min(v0 - arg1, arg3)
        }
    }

    public fun sweep_shares(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 <= arg2) {
            if (arg3 > 0) {
                arg3 <= 1000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        if (arg0 == 0) {
            return 0
        };
        if (arg1 == 0) {
            return arg0
        };
        0x1::u64::min(arg0, ((((arg0 as u128) * 0x1::u128::min(0x1::u128::max(1, (arg2 as u128) * (arg3 as u128) / 10000), (arg1 as u128)) + (arg1 as u128) - 1) / (arg1 as u128)) as u64))
    }

    public fun validate(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg0 >= 5000) {
            if (arg0 <= 9500) {
                if (arg1 >= 500) {
                    if (arg1 <= 10000) {
                        if (arg2 <= 6000) {
                            arg3 <= 10000
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
        assert!(v0, 1);
        assert!((arg0 as u128) + (arg1 as u128) + (arg2 as u128) + (arg3 as u128) == 10000, 1);
    }

    // decompiled from Move bytecode v7
}

