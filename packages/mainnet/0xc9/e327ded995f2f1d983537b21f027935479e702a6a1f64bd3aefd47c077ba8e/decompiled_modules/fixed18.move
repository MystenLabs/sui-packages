module 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::fixed18 {
    struct Fixed18 has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        Fixed18{value: arg0.value + arg1.value}
    }

    public fun average(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        Fixed18{value: (arg0.value & arg1.value) + (arg0.value ^ arg1.value) / 2}
    }

    public fun diff(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        let v0 = if (arg0.value > arg1.value) {
            arg0.value - arg1.value
        } else {
            arg1.value - arg0.value
        };
        Fixed18{value: v0}
    }

    public fun div_down(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        Fixed18{value: (((arg0.value as u256) * 1000000000000000000 / (arg1.value as u256)) as u256)}
    }

    public fun div_up(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        let v0 = (arg0.value as u256);
        let v1 = 1000000000000000000;
        let v2 = (arg1.value as u256);
        let v3 = if (v0 * v1 % v2 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v2 as u256)) as u256) + v3) as u256)}
    }

    public fun from_raw_u128(arg0: u128) : Fixed18 {
        Fixed18{value: (arg0 as u256)}
    }

    public fun from_raw_u256(arg0: u256) : Fixed18 {
        Fixed18{value: arg0}
    }

    public fun from_raw_u64(arg0: u64) : Fixed18 {
        Fixed18{value: (arg0 as u256)}
    }

    public fun from_u128(arg0: u128) : Fixed18 {
        Fixed18{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun from_u256(arg0: u256) : Fixed18 {
        Fixed18{value: arg0 * 1000000000000000000}
    }

    public fun from_u64(arg0: u64) : Fixed18 {
        Fixed18{value: (arg0 as u256) * 1000000000000000000}
    }

    public fun gt(arg0: Fixed18, arg1: Fixed18) : bool {
        arg0.value > arg1.value
    }

    public fun gte(arg0: Fixed18, arg1: Fixed18) : bool {
        arg0.value >= arg1.value
    }

    public fun is_zero(arg0: Fixed18) : bool {
        arg0.value == 0
    }

    public fun lt(arg0: Fixed18, arg1: Fixed18) : bool {
        arg0.value < arg1.value
    }

    public fun lte(arg0: Fixed18, arg1: Fixed18) : bool {
        arg0.value <= arg1.value
    }

    public fun mul_down(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        Fixed18{value: (((arg0.value as u256) * (arg1.value as u256) / 1000000000000000000) as u256)}
    }

    public fun mul_up(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        let v0 = (arg0.value as u256);
        let v1 = (arg1.value as u256);
        let v2 = 1000000000000000000;
        let v3 = if (v0 * v1 % v2 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v2 as u256)) as u256) + v3) as u256)}
    }

    public fun one() : Fixed18 {
        Fixed18{value: 1000000000000000000}
    }

    public fun raw_value(arg0: Fixed18) : u256 {
        arg0.value
    }

    public fun sub(arg0: Fixed18, arg1: Fixed18) : Fixed18 {
        Fixed18{value: arg0.value - arg1.value}
    }

    public fun to_u128(arg0: Fixed18, arg1: u8) : u128 {
        let v0 = 10;
        let v1 = (arg1 as u256);
        let v2 = if (v1 == 0) {
            1
        } else {
            let v3 = 1;
            while (v1 > 1) {
                if (v1 % 2 == 1) {
                    v3 = v3 * v0;
                };
                v1 = v1 / 2;
                v0 = v0 * v0;
            };
            ((v3 * v0) as u256)
        };
        ((((arg0.value as u256) * (v2 as u256) / 1000000000000000000) as u256) as u128)
    }

    public fun to_u128_up(arg0: Fixed18, arg1: u8) : u128 {
        let v0 = (arg0.value as u256);
        let v1 = 10;
        let v2 = (arg1 as u256);
        let v3 = if (v2 == 0) {
            1
        } else {
            let v4 = 1;
            while (v2 > 1) {
                if (v2 % 2 == 1) {
                    v4 = v4 * v1;
                };
                v2 = v2 / 2;
                v1 = v1 * v1;
            };
            ((v4 * v1) as u256)
        };
        let v5 = (v3 as u256);
        let v6 = 1000000000000000000;
        let v7 = if (v0 * v5 % v6 > 0) {
            1
        } else {
            0
        };
        ((((((v0 as u256) * (v5 as u256) / (v6 as u256)) as u256) + v7) as u256) as u128)
    }

    public fun to_u256(arg0: Fixed18, arg1: u8) : u256 {
        let v0 = 10;
        let v1 = (arg1 as u256);
        let v2 = if (v1 == 0) {
            1
        } else {
            let v3 = 1;
            while (v1 > 1) {
                if (v1 % 2 == 1) {
                    v3 = v3 * v0;
                };
                v1 = v1 / 2;
                v0 = v0 * v0;
            };
            ((v3 * v0) as u256)
        };
        (((arg0.value as u256) * (v2 as u256) / 1000000000000000000) as u256)
    }

    public fun to_u256_up(arg0: Fixed18, arg1: u8) : u256 {
        let v0 = (arg0.value as u256);
        let v1 = 10;
        let v2 = (arg1 as u256);
        let v3 = if (v2 == 0) {
            1
        } else {
            let v4 = 1;
            while (v2 > 1) {
                if (v2 % 2 == 1) {
                    v4 = v4 * v1;
                };
                v2 = v2 / 2;
                v1 = v1 * v1;
            };
            ((v4 * v1) as u256)
        };
        let v5 = (v3 as u256);
        let v6 = 1000000000000000000;
        let v7 = if (v0 * v5 % v6 > 0) {
            1
        } else {
            0
        };
        (((((v0 as u256) * (v5 as u256) / (v6 as u256)) as u256) + v7) as u256)
    }

    public fun to_u64(arg0: Fixed18, arg1: u8) : u64 {
        let v0 = 10;
        let v1 = (arg1 as u256);
        let v2 = if (v1 == 0) {
            1
        } else {
            let v3 = 1;
            while (v1 > 1) {
                if (v1 % 2 == 1) {
                    v3 = v3 * v0;
                };
                v1 = v1 / 2;
                v0 = v0 * v0;
            };
            ((v3 * v0) as u256)
        };
        ((((arg0.value as u256) * (v2 as u256) / 1000000000000000000) as u256) as u64)
    }

    public fun to_u64_up(arg0: Fixed18, arg1: u8) : u64 {
        let v0 = (arg0.value as u256);
        let v1 = 10;
        let v2 = (arg1 as u256);
        let v3 = if (v2 == 0) {
            1
        } else {
            let v4 = 1;
            while (v2 > 1) {
                if (v2 % 2 == 1) {
                    v4 = v4 * v1;
                };
                v2 = v2 / 2;
                v1 = v1 * v1;
            };
            ((v4 * v1) as u256)
        };
        let v5 = (v3 as u256);
        let v6 = 1000000000000000000;
        let v7 = if (v0 * v5 % v6 > 0) {
            1
        } else {
            0
        };
        ((((((v0 as u256) * (v5 as u256) / (v6 as u256)) as u256) + v7) as u256) as u64)
    }

    public fun try_add(arg0: Fixed18, arg1: Fixed18) : (bool, Fixed18) {
        let v0 = (arg0.value as u256);
        let v1 = (arg1.value as u256);
        let v2 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let (v3, v4) = if (v0 == v2 && v1 != 0) {
            (false, 0)
        } else if (v1 > v2 - v0) {
            (false, 0)
        } else {
            (true, ((v0 + v1) as u256))
        };
        let v5 = Fixed18{value: v4};
        (v3, v5)
    }

    public fun try_div_down(arg0: Fixed18, arg1: Fixed18) : (bool, Fixed18) {
        let v0 = (arg0.value as u256);
        let v1 = 1000000000000000000;
        let v2 = (arg1.value as u256);
        let (v3, v4) = if (v2 == 0) {
            (false, 0)
        } else {
            let v5 = (v0 as u256);
            let v6 = (v1 as u256);
            let v7 = if (v6 == 0) {
                true
            } else if (v5 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v6) {
                false
            } else {
                true
            };
            if (!v7) {
                (false, 0)
            } else {
                let v8 = (((v0 as u256) * (v1 as u256) / (v2 as u256)) as u256);
                if (v8 > 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                    (false, 0)
                } else {
                    (true, (v8 as u256))
                }
            }
        };
        let v9 = Fixed18{value: v4};
        (v3, v9)
    }

    public fun try_div_up(arg0: Fixed18, arg1: Fixed18) : (bool, Fixed18) {
        let v0 = (arg0.value as u256);
        let v1 = 1000000000000000000;
        let v2 = (arg1.value as u256);
        let (v3, v4) = if (v2 == 0) {
            (false, 0)
        } else {
            let v5 = (v0 as u256);
            let v6 = (v1 as u256);
            let v7 = if (v6 == 0) {
                true
            } else if (v5 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v6) {
                false
            } else {
                true
            };
            if (!v7) {
                (false, 0)
            } else {
                let v8 = (v0 as u256);
                let v9 = (v1 as u256);
                let v10 = (v2 as u256);
                let v11 = if (v8 * v9 % v10 > 0) {
                    1
                } else {
                    0
                };
                let v12 = (((((v8 as u256) * (v9 as u256) / (v10 as u256)) as u256) + v11) as u256);
                if (v12 > 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                    (false, 0)
                } else {
                    (true, (v12 as u256))
                }
            }
        };
        let v13 = Fixed18{value: v4};
        (v3, v13)
    }

    public fun try_mul_down(arg0: Fixed18, arg1: Fixed18) : (bool, Fixed18) {
        let v0 = (arg0.value as u256);
        let v1 = (arg1.value as u256);
        let v2 = 1000000000000000000;
        let (v3, v4) = if (v2 == 0) {
            (false, 0)
        } else {
            let v5 = (v0 as u256);
            let v6 = (v1 as u256);
            let v7 = if (v6 == 0) {
                true
            } else if (v5 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v6) {
                false
            } else {
                true
            };
            if (!v7) {
                (false, 0)
            } else {
                let v8 = (((v0 as u256) * (v1 as u256) / (v2 as u256)) as u256);
                if (v8 > 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                    (false, 0)
                } else {
                    (true, (v8 as u256))
                }
            }
        };
        let v9 = Fixed18{value: v4};
        (v3, v9)
    }

    public fun try_mul_up(arg0: Fixed18, arg1: Fixed18) : (bool, Fixed18) {
        let v0 = (arg0.value as u256);
        let v1 = (arg1.value as u256);
        let v2 = 1000000000000000000;
        let (v3, v4) = if (v2 == 0) {
            (false, 0)
        } else {
            let v5 = (v0 as u256);
            let v6 = (v1 as u256);
            let v7 = if (v6 == 0) {
                true
            } else if (v5 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v6) {
                false
            } else {
                true
            };
            if (!v7) {
                (false, 0)
            } else {
                let v8 = (v0 as u256);
                let v9 = (v1 as u256);
                let v10 = (v2 as u256);
                let v11 = if (v8 * v9 % v10 > 0) {
                    1
                } else {
                    0
                };
                let v12 = (((((v8 as u256) * (v9 as u256) / (v10 as u256)) as u256) + v11) as u256);
                if (v12 > 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                    (false, 0)
                } else {
                    (true, (v12 as u256))
                }
            }
        };
        let v13 = Fixed18{value: v4};
        (v3, v13)
    }

    public fun try_sub(arg0: Fixed18, arg1: Fixed18) : (bool, Fixed18) {
        let (v0, v1) = if (arg1.value > arg0.value) {
            (false, 0)
        } else {
            (true, arg0.value - arg1.value)
        };
        let v2 = Fixed18{value: v1};
        (v0, v2)
    }

    public fun u128_to_fixed18(arg0: u128, arg1: u8) : Fixed18 {
        let v0 = ((arg0 as u256) as u256);
        let v1 = 1000000000000000000;
        let v2 = 10;
        let v3 = (arg1 as u256);
        let v4 = if (v3 == 0) {
            1
        } else {
            let v5 = 1;
            while (v3 > 1) {
                if (v3 % 2 == 1) {
                    v5 = v5 * v2;
                };
                v3 = v3 / 2;
                v2 = v2 * v2;
            };
            ((v5 * v2) as u256)
        };
        let v6 = (v4 as u256);
        let v7 = if (v0 * v1 % v6 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v6 as u256)) as u256) + v7) as u256)}
    }

    public fun u128_to_fixed18_up(arg0: u128, arg1: u8) : Fixed18 {
        let v0 = ((arg0 as u256) as u256);
        let v1 = 1000000000000000000;
        let v2 = 10;
        let v3 = (arg1 as u256);
        let v4 = if (v3 == 0) {
            1
        } else {
            let v5 = 1;
            while (v3 > 1) {
                if (v3 % 2 == 1) {
                    v5 = v5 * v2;
                };
                v3 = v3 / 2;
                v2 = v2 * v2;
            };
            ((v5 * v2) as u256)
        };
        let v6 = (v4 as u256);
        let v7 = if (v0 * v1 % v6 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v6 as u256)) as u256) + v7) as u256)}
    }

    public fun u256_to_fixed18(arg0: u256, arg1: u8) : Fixed18 {
        let v0 = (arg0 as u256);
        let v1 = 1000000000000000000;
        let v2 = 10;
        let v3 = (arg1 as u256);
        let v4 = if (v3 == 0) {
            1
        } else {
            let v5 = 1;
            while (v3 > 1) {
                if (v3 % 2 == 1) {
                    v5 = v5 * v2;
                };
                v3 = v3 / 2;
                v2 = v2 * v2;
            };
            ((v5 * v2) as u256)
        };
        let v6 = (v4 as u256);
        let v7 = if (v0 * v1 % v6 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v6 as u256)) as u256) + v7) as u256)}
    }

    public fun u256_to_fixed18_up(arg0: u256, arg1: u8) : Fixed18 {
        let v0 = (arg0 as u256);
        let v1 = 1000000000000000000;
        let v2 = 10;
        let v3 = (arg1 as u256);
        let v4 = if (v3 == 0) {
            1
        } else {
            let v5 = 1;
            while (v3 > 1) {
                if (v3 % 2 == 1) {
                    v5 = v5 * v2;
                };
                v3 = v3 / 2;
                v2 = v2 * v2;
            };
            ((v5 * v2) as u256)
        };
        let v6 = (v4 as u256);
        let v7 = if (v0 * v1 % v6 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v6 as u256)) as u256) + v7) as u256)}
    }

    public fun u64_to_fixed18(arg0: u64, arg1: u8) : Fixed18 {
        let v0 = (arg0 as u256);
        let v1 = 1000000000000000000;
        let v2 = 10;
        let v3 = (arg1 as u256);
        let v4 = if (v3 == 0) {
            1
        } else {
            let v5 = 1;
            while (v3 > 1) {
                if (v3 % 2 == 1) {
                    v5 = v5 * v2;
                };
                v3 = v3 / 2;
                v2 = v2 * v2;
            };
            ((v5 * v2) as u256)
        };
        let v6 = (v4 as u256);
        let v7 = if (v0 * v1 % v6 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v6 as u256)) as u256) + v7) as u256)}
    }

    public fun u64_to_fixed18_up(arg0: u64, arg1: u8) : Fixed18 {
        let v0 = ((arg0 as u256) as u256);
        let v1 = 1000000000000000000;
        let v2 = 10;
        let v3 = (arg1 as u256);
        let v4 = if (v3 == 0) {
            1
        } else {
            let v5 = 1;
            while (v3 > 1) {
                if (v3 % 2 == 1) {
                    v5 = v5 * v2;
                };
                v3 = v3 / 2;
                v2 = v2 * v2;
            };
            ((v5 * v2) as u256)
        };
        let v6 = (v4 as u256);
        let v7 = if (v0 * v1 % v6 > 0) {
            1
        } else {
            0
        };
        Fixed18{value: (((((v0 as u256) * (v1 as u256) / (v6 as u256)) as u256) + v7) as u256)}
    }

    public fun zero() : Fixed18 {
        Fixed18{value: 0}
    }

    // decompiled from Move bytecode v6
}

