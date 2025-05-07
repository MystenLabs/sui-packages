module 0xc9e327ded995f2f1d983537b21f027935479e702a6a1f64bd3aefd47c077ba8e::u256 {
    public fun add(arg0: u256, arg1: u256) : u256 {
        arg0 + arg1
    }

    public fun average(arg0: u256, arg1: u256) : u256 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun average_vector(arg0: vector<u256>) : u256 {
        let v0 = 0x1::vector::length<u256>(&arg0);
        if (v0 == 0) {
            0
        } else {
            let v2 = 0;
            let v3 = 0;
            while (v2 < 0x1::vector::length<u256>(&arg0)) {
                let v4 = (v3 as u256);
                v3 = v4 + (*0x1::vector::borrow<u256>(&arg0, v2) as u256);
                v2 = v2 + 1;
            };
            ((v3 / (v0 as u256)) as u256)
        }
    }

    public fun clamp(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = if (arg1 >= arg0) {
            arg1
        } else {
            arg0
        };
        if (arg2 < v0) {
            arg2
        } else if (arg1 >= arg0) {
            arg1
        } else {
            arg0
        }
    }

    public fun diff(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun div_down(arg0: u256, arg1: u256) : u256 {
        arg0 / arg1
    }

    public fun div_up(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            1 + (arg0 - 1) / arg1
        }
    }

    public fun log10_down(arg0: u256) : u8 {
        let v0 = (arg0 as u256);
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        if (v0 >= 10000000000000000000000000000000000000000000000000000000000000000) {
            v1 = v0 / 10000000000000000000000000000000000000000000000000000000000000000;
            v3 = v2 + 64;
        };
        if (v1 >= 100000000000000000000000000000000) {
            v1 = v1 / 100000000000000000000000000000000;
            v3 = v3 + 32;
        };
        if (v1 >= 10000000000000000) {
            v1 = v1 / 10000000000000000;
            v3 = v3 + 16;
        };
        if (v1 >= 100000000) {
            v1 = v1 / 100000000;
            v3 = v3 + 8;
        };
        if (v1 >= 10000) {
            v1 = v1 / 10000;
            v3 = v3 + 4;
        };
        if (v1 >= 100) {
            v1 = v1 / 100;
            v3 = v3 + 2;
        };
        if (v1 >= 10) {
            v3 = v3 + 1;
        };
        v3
    }

    public fun log10_up(arg0: u256) : u8 {
        let v0 = (arg0 as u256);
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        if (v0 >= 10000000000000000000000000000000000000000000000000000000000000000) {
            v1 = v0 / 10000000000000000000000000000000000000000000000000000000000000000;
            v3 = v2 + 64;
        };
        if (v1 >= 100000000000000000000000000000000) {
            v1 = v1 / 100000000000000000000000000000000;
            v3 = v3 + 32;
        };
        if (v1 >= 10000000000000000) {
            v1 = v1 / 10000000000000000;
            v3 = v3 + 16;
        };
        if (v1 >= 100000000) {
            v1 = v1 / 100000000;
            v3 = v3 + 8;
        };
        if (v1 >= 10000) {
            v1 = v1 / 10000;
            v3 = v3 + 4;
        };
        if (v1 >= 100) {
            v1 = v1 / 100;
            v3 = v3 + 2;
        };
        if (v1 >= 10) {
            v3 = v3 + 1;
        };
        let v4 = 10;
        let v5 = ((v3 as u256) as u256);
        let v6 = if (v5 == 0) {
            1
        } else {
            let v7 = 1;
            while (v5 > 1) {
                if (v5 % 2 == 1) {
                    v7 = v7 * v4;
                };
                v5 = v5 / 2;
                v4 = v4 * v4;
            };
            ((v7 * v4) as u256)
        };
        let v8 = if (v6 < arg0) {
            1
        } else {
            0
        };
        v3 + v8
    }

    public fun log256_down(arg0: u256) : u8 {
        let v0 = (arg0 as u256);
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        if (v0 >> 128 > 0) {
            v1 = v0 >> 128;
            v3 = v2 + 16;
        };
        if (v1 >> 64 > 0) {
            v1 = v1 >> 64;
            v3 = v3 + 8;
        };
        if (v1 >> 32 > 0) {
            v1 = v1 >> 32;
            v3 = v3 + 4;
        };
        if (v1 >> 16 > 0) {
            v1 = v1 >> 16;
            v3 = v3 + 2;
        };
        if (v1 >> 8 > 0) {
            v3 = v3 + 1;
        };
        v3
    }

    public fun log256_up(arg0: u256) : u8 {
        let v0 = (arg0 as u256);
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        if (v0 >> 128 > 0) {
            v1 = v0 >> 128;
            v3 = v2 + 16;
        };
        if (v1 >> 64 > 0) {
            v1 = v1 >> 64;
            v3 = v3 + 8;
        };
        if (v1 >> 32 > 0) {
            v1 = v1 >> 32;
            v3 = v3 + 4;
        };
        if (v1 >> 16 > 0) {
            v1 = v1 >> 16;
            v3 = v3 + 2;
        };
        if (v1 >> 8 > 0) {
            v3 = v3 + 1;
        };
        let v4 = if (1 << v3 << 3 < arg0) {
            1
        } else {
            0
        };
        v3 + v4
    }

    public fun log2_down(arg0: u256) : u8 {
        let v0 = (arg0 as u256);
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        if (v0 >> 128 > 0) {
            v1 = v0 >> 128;
            v3 = v2 + 128;
        };
        if (v1 >> 64 > 0) {
            v1 = v1 >> 64;
            v3 = v3 + 64;
        };
        if (v1 >> 32 > 0) {
            v1 = v1 >> 32;
            v3 = v3 + 32;
        };
        if (v1 >> 16 > 0) {
            v1 = v1 >> 16;
            v3 = v3 + 16;
        };
        if (v1 >> 8 > 0) {
            v1 = v1 >> 8;
            v3 = v3 + 8;
        };
        if (v1 >> 4 > 0) {
            v1 = v1 >> 4;
            v3 = v3 + 4;
        };
        if (v1 >> 2 > 0) {
            v1 = v1 >> 2;
            v3 = v3 + 2;
        };
        if (v1 >> 1 > 0) {
            v3 = v3 + 1;
        };
        v3
    }

    public fun log2_up(arg0: u256) : u16 {
        let v0 = (arg0 as u256);
        let v1 = (v0 as u256);
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        if (v1 >> 128 > 0) {
            v2 = v1 >> 128;
            v4 = v3 + 128;
        };
        if (v2 >> 64 > 0) {
            v2 = v2 >> 64;
            v4 = v4 + 64;
        };
        if (v2 >> 32 > 0) {
            v2 = v2 >> 32;
            v4 = v4 + 32;
        };
        if (v2 >> 16 > 0) {
            v2 = v2 >> 16;
            v4 = v4 + 16;
        };
        if (v2 >> 8 > 0) {
            v2 = v2 >> 8;
            v4 = v4 + 8;
        };
        if (v2 >> 4 > 0) {
            v2 = v2 >> 4;
            v4 = v4 + 4;
        };
        if (v2 >> 2 > 0) {
            v2 = v2 >> 2;
            v4 = v4 + 2;
        };
        if (v2 >> 1 > 0) {
            v4 = v4 + 1;
        };
        let v5 = if (1 << (v4 as u8) < v0) {
            1
        } else {
            0
        };
        (v4 as u16) + v5
    }

    public fun max(arg0: u256, arg1: u256) : u256 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1
    }

    public fun mul_div_down(arg0: u256, arg1: u256, arg2: u256) : u256 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u256)
    }

    public fun mul_div_up(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = if (v0 * v1 % v2 > 0) {
            1
        } else {
            0
        };
        (((((v0 as u256) * (v1 as u256) / (v2 as u256)) as u256) + v3) as u256)
    }

    public fun pow(arg0: u256, arg1: u256) : u256 {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        if (v1 == 0) {
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
        }
    }

    public fun sqrt_down(arg0: u256) : u256 {
        let v0 = (arg0 as u256);
        if (v0 == 0) {
            0
        } else {
            let v2 = (v0 as u256);
            let v3 = v2;
            let v4 = 0;
            let v5 = v4;
            if (v2 >> 128 > 0) {
                v3 = v2 >> 128;
                v5 = v4 + 128;
            };
            if (v3 >> 64 > 0) {
                v3 = v3 >> 64;
                v5 = v5 + 64;
            };
            if (v3 >> 32 > 0) {
                v3 = v3 >> 32;
                v5 = v5 + 32;
            };
            if (v3 >> 16 > 0) {
                v3 = v3 >> 16;
                v5 = v5 + 16;
            };
            if (v3 >> 8 > 0) {
                v3 = v3 >> 8;
                v5 = v5 + 8;
            };
            if (v3 >> 4 > 0) {
                v3 = v3 >> 4;
                v5 = v5 + 4;
            };
            if (v3 >> 2 > 0) {
                v3 = v3 >> 2;
                v5 = v5 + 2;
            };
            if (v3 >> 1 > 0) {
                v5 = v5 + 1;
            };
            let v6 = 1 << ((v5 >> 1) as u8);
            let v7 = v6 + v0 / v6 >> 1;
            let v8 = v7 + v0 / v7 >> 1;
            let v9 = v8 + v0 / v8 >> 1;
            let v10 = v9 + v0 / v9 >> 1;
            let v11 = v10 + v0 / v10 >> 1;
            let v12 = v11 + v0 / v11 >> 1;
            let v13 = v12 + v0 / v12 >> 1;
            let v14 = if (v13 < v0 / v13) {
                v13
            } else {
                v0 / v13
            };
            (v14 as u256)
        }
    }

    public fun sqrt_up(arg0: u256) : u256 {
        let v0 = (arg0 as u256);
        let v1 = if (v0 == 0) {
            0
        } else {
            let v2 = (v0 as u256);
            let v3 = v2;
            let v4 = 0;
            let v5 = v4;
            if (v2 >> 128 > 0) {
                v3 = v2 >> 128;
                v5 = v4 + 128;
            };
            if (v3 >> 64 > 0) {
                v3 = v3 >> 64;
                v5 = v5 + 64;
            };
            if (v3 >> 32 > 0) {
                v3 = v3 >> 32;
                v5 = v5 + 32;
            };
            if (v3 >> 16 > 0) {
                v3 = v3 >> 16;
                v5 = v5 + 16;
            };
            if (v3 >> 8 > 0) {
                v3 = v3 >> 8;
                v5 = v5 + 8;
            };
            if (v3 >> 4 > 0) {
                v3 = v3 >> 4;
                v5 = v5 + 4;
            };
            if (v3 >> 2 > 0) {
                v3 = v3 >> 2;
                v5 = v5 + 2;
            };
            if (v3 >> 1 > 0) {
                v5 = v5 + 1;
            };
            let v6 = 1 << ((v5 >> 1) as u8);
            let v7 = v6 + v0 / v6 >> 1;
            let v8 = v7 + v0 / v7 >> 1;
            let v9 = v8 + v0 / v8 >> 1;
            let v10 = v9 + v0 / v9 >> 1;
            let v11 = v10 + v0 / v10 >> 1;
            let v12 = v11 + v0 / v11 >> 1;
            let v13 = v12 + v0 / v12 >> 1;
            let v14 = if (v13 < v0 / v13) {
                v13
            } else {
                v0 / v13
            };
            (v14 as u256)
        };
        let v15 = if (v1 * v1 < arg0) {
            1
        } else {
            0
        };
        v1 + v15
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        arg0 - arg1
    }

    public fun sum(arg0: vector<u256>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u256>(&arg0)) {
            let v2 = (v1 as u256);
            v1 = v2 + (*0x1::vector::borrow<u256>(&arg0, v0) as u256);
            v0 = v0 + 1;
        };
        v1
    }

    public fun try_add(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg0 == 115792089237316195423570985008687907853269984665640564039457584007913129639935 && arg1 != 0) {
            return (false, 0)
        };
        if (arg1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg0) {
            return (false, 0)
        };
        (true, arg0 + arg1)
    }

    public fun try_div_down(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, arg0 / arg1)
        }
    }

    public fun try_div_up(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            let v2 = if (arg0 == 0) {
                0
            } else {
                1 + (arg0 - 1) / arg1
            };
            (true, v2)
        }
    }

    public fun try_mod(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 == 0) {
            (false, 0)
        } else {
            (true, arg0 % arg1)
        }
    }

    public fun try_mul(arg0: u256, arg1: u256) : (bool, u256) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        if (v1 == 0) {
            (true, 0)
        } else if (v0 > (115792089237316195423570985008687907853269984665640564039457584007913129639935 as u256) / v1) {
            (false, 0)
        } else {
            (true, v0 * v1)
        }
    }

    public fun try_mul_div_down(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        if (v2 == 0) {
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
                if (v8 > (115792089237316195423570985008687907853269984665640564039457584007913129639935 as u256)) {
                    (false, 0)
                } else {
                    (true, (v8 as u256))
                }
            }
        }
    }

    public fun try_mul_div_up(arg0: u256, arg1: u256, arg2: u256) : (bool, u256) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        if (v2 == 0) {
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
                if (v12 > (115792089237316195423570985008687907853269984665640564039457584007913129639935 as u256)) {
                    (false, 0)
                } else {
                    (true, (v12 as u256))
                }
            }
        }
    }

    public fun try_sub(arg0: u256, arg1: u256) : (bool, u256) {
        if (arg1 > arg0) {
            (false, 0)
        } else {
            (true, arg0 - arg1)
        }
    }

    // decompiled from Move bytecode v6
}

