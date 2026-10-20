module 0xb6306a92f72f0bf98fed6e6276142ccf4548656da348130605f0e0e6e077b04b::search_numeric {
    public fun bg(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128) : (u128, u64) {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<u128>(arg0);
        while (v2 <= v3) {
            let v4 = if (v2 == v3) {
                arg2
            } else {
                0x1::u128::min(*0x1::vector::borrow<u128>(arg0, v2), arg2)
            };
            if (v4 > arg1) {
                if (v4 - arg1 > v1) {
                    v1 = v4 - arg1;
                    v0 = v4;
                };
            };
            if (v4 == arg2) {
                break
            };
            v2 = v2 + 1;
        };
        let v5 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aligned_in_range(arg1 + (v0 - arg1) / 2, arg1, arg2, arg3);
        (v5, bl(arg0, v5))
    }

    fun bl(arg0: &vector<u128>, arg1: u128) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u128>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            if (*0x1::vector::borrow<u128>(arg0, v1) < arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        v0
    }

    public fun book_anchor_point(arg0: u128, arg1: u256, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: bool, arg12: u128) : (u128, u128, bool) {
        let (v0, v1, v2, _) = book_anchor_projected_point(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        (v0, v1, v2)
    }

    public fun book_anchor_projected_point(arg0: u128, arg1: u256, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128, arg11: bool, arg12: u128) : (u128, u128, bool, bool) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg2 > 18446744073709551615) {
            true
        } else if (arg3 > 18446744073709551615) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg6 == 0
        };
        if (v0) {
            return (0, 0, false, false)
        };
        let v1 = (arg0 as u256) * (arg2 as u256);
        let v2 = (arg3 as u256) * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64();
        if (v1 <= v2) {
            return (0, 0, false, false)
        };
        let v3 = (v1 - v2) / (arg2 as u256) * (arg3 as u256);
        if (v3 == 0) {
            return (0, 0, false, false)
        };
        let v4 = (arg0 as u256) * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() / arg1;
        if (v4 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) {
            return (0, 0, false, false)
        };
        let v5 = coefficient_root(v4, v3, arg5);
        let (v6, v7, v8) = book_joint_points(v5, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v9 = if (v8) {
            true
        } else if (arg7 == 0) {
            true
        } else if (arg8 == 0) {
            true
        } else {
            arg12 == 0
        };
        if (v9) {
            return (v6, v7, v8, false)
        };
        let v10 = if (arg11) {
            (arg12 as u256) * 1000000000 / (arg7 as u256)
        } else {
            (arg12 as u256)
        };
        let v11 = if (arg11) {
            (arg5 as u256)
        } else {
            (arg5 as u256) * 1000000000 / (arg7 as u256)
        };
        let v12 = 0x1::u256::min(0x1::u256::min(v10, v11), (arg10 as u256));
        let v13 = v12 - v12 % (arg8 as u256);
        if (v13 == 0 || v13 < (arg9 as u256)) {
            return (v6, v7, v8, false)
        };
        let v14 = if (arg11) {
            v13
        } else {
            0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::div_ceil(v13 * (arg7 as u256), 1000000000)
        };
        let v15 = if (v14 >= (v5 as u256)) {
            true
        } else if (v14 < (arg4 as u256)) {
            true
        } else if (v14 > (arg5 as u256)) {
            true
        } else {
            v14 > (18446744073709551615 as u256)
        };
        if (v15) {
            return (v6, v7, v8, false)
        };
        let (v16, v17, v18) = book_joint_points((v14 as u128), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let (v19, v20, v21, v22) = if (v18) {
            (v18, true, v16, v17)
        } else {
            (v8, false, v6, v7)
        };
        (v21, v22, v19, v20)
    }

    public fun book_coverage_cell(arg0: u128, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u8, arg6: u128, arg7: u128, arg8: u128, arg9: u128, arg10: u128) : bool {
        if (arg1 == 0) {
            if (arg5 == 0) {
                if (arg6 > 0) {
                    if (arg7 > 0) {
                        if (arg8 > 0) {
                            if (arg9 == 340282366920938463463374607431768211455) {
                                if (arg10 == 340282366920938463463374607431768211455) {
                                    arg2 && arg0 <= arg3 || (arg0 as u256) * 1000000000 <= (arg3 as u256) * (arg4 as u256)
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

    public fun book_joint_points(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: bool, arg9: u128) : (u128, u128, bool) {
        let v0 = if (arg4 == 0) {
            true
        } else if (arg5 == 0) {
            true
        } else {
            (arg4 as u256) * (arg5 as u256) % 1000000000 != 0
        };
        if (v0) {
            return (0, 0, false)
        };
        let v1 = if (arg8) {
            (arg0 as u256)
        } else {
            (arg0 as u256) * 1000000000 / (arg4 as u256)
        };
        let v2 = v1 - v1 % (arg5 as u256);
        let v3 = v2 + (arg5 as u256);
        let v4 = if (v2 > 0) {
            if (v2 >= (arg6 as u256)) {
                v2 <= (arg7 as u256)
            } else {
                false
            }
        } else {
            false
        };
        let v5 = v3 >= (arg6 as u256) && v3 <= (arg7 as u256);
        let v6 = if (!v4) {
            0
        } else if (arg8) {
            v2
        } else {
            0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::div_ceil(v2 * (arg4 as u256), 1000000000)
        };
        let v7 = if (!v5) {
            0
        } else if (arg8) {
            v3
        } else {
            0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::div_ceil(v3 * (arg4 as u256), 1000000000)
        };
        let v8 = if (v4) {
            if (v6 >= (arg1 as u256)) {
                if (v6 <= (arg2 as u256)) {
                    v6 % (arg3 as u256) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v9 = if (v5) {
            if (v7 >= (arg1 as u256)) {
                if (v7 <= (arg2 as u256)) {
                    v7 % (arg3 as u256) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (!v8 && !v9) {
            return (0, 0, false)
        };
        let v10 = if (v8) {
            v2
        } else {
            v3
        };
        let v11 = if (arg8) {
            0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_div_down((v10 as u128), arg4, 1000000000)
        } else {
            (v10 as u128)
        };
        if (v11 > arg9) {
            return (0, 1, false)
        };
        let v12 = if (v8) {
            v6
        } else {
            v7
        };
        let v13 = if (!v8 || !v9) {
            0
        } else {
            ((v7 - v6) as u128)
        };
        ((v12 as u128), v13, true)
    }

    public fun bp(arg0: bool, arg1: u128, arg2: &vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64) : (u128, u64) {
        if (!arg0 || arg6 % 4 == 3) {
            return bg(arg2, arg3, arg4, arg5)
        };
        let v0 = bl(arg2, arg1);
        let v1 = 0x1::vector::length<u128>(arg2);
        let v2 = if (v0 == 0) {
            arg3
        } else {
            *0x1::vector::borrow<u128>(arg2, v0 - 1)
        };
        let v3 = if (v0 < v1 && *0x1::vector::borrow<u128>(arg2, v0) == arg1) {
            v0 + 1
        } else {
            v0
        };
        let v4 = if (v3 == v1) {
            arg4
        } else {
            0x1::u128::min(*0x1::vector::borrow<u128>(arg2, v3), arg4)
        };
        let v5 = if (arg1 - v2 >= v4 - arg1) {
            v2 + (arg1 - v2) / 2
        } else {
            arg1 + (v4 - arg1) / 2
        };
        let v6 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aligned_in_range(v5, arg3, arg4, arg5);
        let v7 = bl(arg2, v6);
        let (v8, v9) = if (v6 == 0 || v7 < v1 && *0x1::vector::borrow<u128>(arg2, v7) == v6) {
            let (v10, v11) = bg(arg2, arg3, arg4, arg5);
            (v11, v10)
        } else {
            (v7, v6)
        };
        (v9, v8)
    }

    public fun bq(arg0: bool, arg1: u128, arg2: &vector<u128>, arg3: u128, arg4: u128, arg5: u128, arg6: u64) : (u128, u64) {
        if (!arg0 || arg6 % 4 == 3) {
            return br(arg2, arg3, arg4, arg5)
        };
        let v0 = bl(arg2, arg1);
        let v1 = 0x1::vector::length<u128>(arg2);
        let v2 = if (v0 == 0) {
            arg3
        } else {
            *0x1::vector::borrow<u128>(arg2, v0 - 1)
        };
        let v3 = if (v0 < v1 && *0x1::vector::borrow<u128>(arg2, v0) == arg1) {
            v0 + 1
        } else {
            v0
        };
        let v4 = if (v3 == v1) {
            arg4
        } else {
            0x1::u128::min(*0x1::vector::borrow<u128>(arg2, v3), arg4)
        };
        let v5 = arg1 - v2 >= v4 - arg1;
        let v6 = if (v5) {
            v2 + (arg1 - v2) / 2
        } else {
            arg1 + (v4 - arg1) / 2
        };
        let v7 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aligned_in_range(v6, arg3, arg4, arg5);
        let v8 = if (v5) {
            if (v7 > v2) {
                v7 < arg1
            } else {
                false
            }
        } else {
            false
        };
        let v9 = if (v8) {
            v0
        } else {
            let v10 = if (!v5) {
                if (v7 > arg1) {
                    v7 < v4
                } else {
                    false
                }
            } else {
                false
            };
            if (v10) {
                v3
            } else {
                bl(arg2, v7)
            }
        };
        if (v7 == 0 || v9 < v1 && *0x1::vector::borrow<u128>(arg2, v9) == v7) {
            br(arg2, arg3, arg4, arg5)
        } else {
            (v7, v9)
        }
    }

    fun br(arg0: &vector<u128>, arg1: u128, arg2: u128, arg3: u128) : (u128, u64) {
        let v0 = arg2;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::length<u128>(arg0);
        while (v3 <= v4) {
            let v5 = if (v3 == v4) {
                arg2
            } else {
                let v6 = *0x1::vector::borrow<u128>(arg0, v3);
                if (v6 < arg2) {
                    v6
                } else {
                    arg2
                }
            };
            if (v5 > arg1) {
                if (v5 - arg1 > v1) {
                    v1 = v5 - arg1;
                    v0 = v5;
                    v2 = v3;
                };
            };
            if (v5 == arg2) {
                break
            };
            v3 = v3 + 1;
        };
        let v7 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aligned_in_range(arg1 + (v0 - arg1) / 2, arg1, arg2, arg3);
        let v8 = if (v7 > arg1 && v7 < v0) {
            v2
        } else {
            bl(arg0, v7)
        };
        (v7, v8)
    }

    public fun bs(arg0: u128, arg1: u64, arg2: &vector<u128>, arg3: u128, arg4: u128, arg5: u128) : (u128, u64) {
        let v0 = 0x1::vector::length<u128>(arg2);
        let v1 = if (arg1 == 0) {
            arg3
        } else {
            *0x1::vector::borrow<u128>(arg2, arg1 - 1)
        };
        let v2 = if (arg1 < v0 && *0x1::vector::borrow<u128>(arg2, arg1) == arg0) {
            arg1 + 1
        } else {
            arg1
        };
        let v3 = if (v2 == v0) {
            arg4
        } else {
            0x1::u128::min(*0x1::vector::borrow<u128>(arg2, v2), arg4)
        };
        let v4 = arg0 - v1 >= v3 - arg0;
        let v5 = if (v4) {
            v1 + (arg0 - v1) / 2
        } else {
            arg0 + (v3 - arg0) / 2
        };
        let v6 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::aligned_in_range(v5, arg3, arg4, arg5);
        let v7 = if (v4) {
            if (v6 > v1) {
                v6 < arg0
            } else {
                false
            }
        } else {
            false
        };
        let v8 = if (v7) {
            arg1
        } else {
            let v9 = if (!v4) {
                if (v6 > arg0) {
                    v6 < v3
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                v2
            } else {
                bl(arg2, v6)
            }
        };
        if (v6 == 0 || v8 < v0 && *0x1::vector::borrow<u128>(arg2, v8) == v6) {
            br(arg2, arg3, arg4, arg5)
        } else {
            (v6, v8)
        }
    }

    public fun cap_endpoint_v3(arg0: u128, arg1: bool, arg2: u128, arg3: bool, arg4: u128, arg5: u128) : u256 {
        let v0 = if (arg5 == 0) {
            (arg2 as u256)
        } else {
            (0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::next_sqrt_price(arg0, arg1, arg2, arg3, arg5, arg4) as u256)
        };
        if (arg3) {
            v0 * v0 / 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()
        } else {
            0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() / v0 * v0
        }
    }

    fun clmm_log2(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun clmm_residual_proposal(arg0: u128, arg1: u128, arg2: u256, arg3: u256, arg4: u256, arg5: u128, arg6: u256, arg7: u128, arg8: u128, arg9: u128) : (u128, bool) {
        let v0 = if (arg1 <= arg0) {
            true
        } else if (arg2 <= arg4) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg3 >= arg4) {
            true
        } else if (arg9 == 0) {
            true
        } else if (arg8 < arg7) {
            true
        } else {
            arg5 != arg0 && arg5 != arg1
        };
        if (v0) {
            return (0, false)
        };
        let v1 = clmm_sqrt(arg2);
        let v2 = clmm_sqrt(arg3);
        let v3 = if (arg4 == 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) {
            4294967296
        } else {
            clmm_sqrt(arg4)
        };
        let v4 = if (v1 <= v3) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v2 >= v3
        };
        if (v4) {
            return (0, false)
        };
        let v5 = (v1 - v3) * v2;
        let v6 = ((arg1 - arg0) as u256);
        if (v6 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v5) {
            return (0, false)
        };
        let v7 = 0x1::u128::min(0x1::u128::max(arg0 + ((v6 * v5 / (v1 - v2) * v3) as u128), arg7), arg8);
        let v8 = v7 - v7 % arg9;
        let v9 = v8;
        if (v8 < arg7) {
            let v10 = arg7 % arg9;
            let v11 = if (v10 == 0) {
                0
            } else {
                arg9 - v10
            };
            if (arg7 > 340282366920938463463374607431768211455 - v11) {
                return (0, false)
            };
            v9 = arg7 + v11;
        };
        let v12 = if (v9 > arg8) {
            true
        } else if (v9 <= arg0) {
            true
        } else if (v9 >= arg1) {
            true
        } else {
            v9 == arg5
        };
        if (v12) {
            return (0, false)
        };
        let v13 = if (v9 > arg5) {
            v9 - arg5
        } else {
            arg5 - v9
        };
        let v14 = if (arg6 > arg4) {
            arg6 - arg4
        } else {
            arg4 - arg6
        };
        if (v13 <= arg9 || v14 <= (2 * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() - 1) / (v13 as u256)) {
            return (0, false)
        };
        (v9, true)
    }

    fun clmm_sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((clmm_log2(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        0x1::u256::min(v7, arg0 / v7)
    }

    public fun closed_form_root(arg0: u128, arg1: u128, arg2: u256) : (u128, bool) {
        if (arg2 <= 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) {
            return (0, true)
        };
        let v0 = arg2 * (arg0 as u256);
        let v1 = (arg1 as u256) * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64();
        if (v0 <= v1 || arg1 == 0) {
            return (arg0, false)
        };
        let v2 = (sqrt_down(arg2 * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) - 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) * (arg1 as u256) * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() / (v0 - v1);
        if (v2 > 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) {
            return (arg0, false)
        };
        (0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::to_u128((arg0 as u256) * v2 / 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()), true)
    }

    public fun coefficient_root(arg0: u256, arg1: u256, arg2: u128) : u128 {
        if (arg1 == 0) {
            return arg2
        };
        let v0 = sqrt_down(arg0 * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64());
        if (v0 <= 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) {
            return 0
        };
        let v1 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::to_u128((v0 - 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64()) / arg1);
        if (v1 > arg2) {
            arg2
        } else {
            v1
        }
    }

    public fun log2_down(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun nv(arg0: &vector<u128>, arg1: &vector<u256>, arg2: u128) : u64 {
        if (0x1::vector::length<u128>(arg0) != 0x1::vector::length<u256>(arg1)) {
            return (18446744073709551615 as u64)
        };
        let v0 = (18446744073709551615 as u64);
        let v1 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;
        let v2 = 1;
        while (v2 + 1 < 0x1::vector::length<u128>(arg0)) {
            let v3 = if (*0x1::vector::borrow<u256>(arg1, v2 - 1) != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                if (*0x1::vector::borrow<u256>(arg1, v2 + 1) != 115792089237316195423570985008687907853269984665640564039457584007913129639935) {
                    if (*0x1::vector::borrow<u256>(arg1, v2) < *0x1::vector::borrow<u256>(arg1, v2 - 1)) {
                        if (*0x1::vector::borrow<u256>(arg1, v2) < *0x1::vector::borrow<u256>(arg1, v2 + 1)) {
                            if (*0x1::vector::borrow<u256>(arg1, v2) < v1) {
                                if (*0x1::vector::borrow<u128>(arg0, v2) < arg2) {
                                    *0x1::vector::borrow<u128>(arg0, v2) < (18446744073709551615 as u128)
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
            if (v3) {
                v0 = (*0x1::vector::borrow<u128>(arg0, v2) as u64);
                v1 = *0x1::vector::borrow<u256>(arg1, v2);
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun profit_chord_left(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg0 >= arg2) {
            true
        } else if (arg1 >= arg4) {
            true
        } else if (arg3 < arg4) {
            true
        } else {
            arg1 >= arg3
        };
        if (v0) {
            return arg2
        };
        let v1 = ((arg2 - arg0) as u256) * ((arg4 - arg1) as u256);
        let v2 = ((arg3 - arg1) as u256);
        let v3 = if (v1 % v2 > 0) {
            1
        } else {
            0
        };
        arg0 + ((v1 / v2 + v3) as u128)
    }

    public fun quote_cpmm_cached_with_slope(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: u128, arg6: u128) : (u128, u256) {
        let v0 = 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::effective_input(arg6, arg1, arg0);
        let v1 = arg4 + v0;
        (0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::effective_output(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_div_down(v0, arg5, v1), arg3, arg2), 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_ratio_down_saturating(0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::mul_ratio_down_saturating((arg5 as u256) * 0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::q64() / (v1 as u256), (arg4 as u256), (v1 as u256)), ((arg2 - arg3) as u256), (arg2 as u256)))
    }

    public fun quote_stable_hop(arg0: u128, arg1: u128, arg2: u64, arg3: u128, arg4: bool, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u128, arg10: &mut u64) : (u128, u8, u64) {
        let v0 = 0;
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::quote_stable_with_d(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, &mut v0)
    }

    public fun search_rejection_code(arg0: u8) : u64 {
        if (arg0 == 10) {
            return 418
        };
        if (arg0 == 7) {
            return 419
        };
        if (arg0 == 11) {
            return 420
        };
        if (arg0 == 12) {
            return 421
        };
        if (arg0 == 8) {
            return 416
        };
        if (arg0 == 9) {
            return 417
        };
        if (arg0 == 6) {
            return 406
        };
        if (arg0 == 5) {
            return 407
        };
        if (arg0 == 3) {
            return 408
        };
        if (arg0 == 4) {
            return 409
        };
        if (arg0 == 2) {
            return 410
        };
        412
    }

    public fun sqrt_down(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((log2_down(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = arg0 / v7;
        if (v7 < v8) {
            v7
        } else {
            v8
        }
    }

    public fun stable_compute_y(arg0: u256, arg1: u256, arg2: u256, arg3: &mut u64) : (u256, u8) {
        0xce2e229b90968069392793d96d6fce41220fdb4b2173d243d3e82f9a03309f20::numeric::stable_compute_y_seeded(arg0, arg1, arg2, arg1, false, arg3)
    }

    public fun steamm_omm_state_ok(arg0: u64, arg1: u64, arg2: u128, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u8, arg10: u8, arg11: bool) : bool {
        if (arg11) {
            if (arg0 > 0) {
                if (arg1 < 10000) {
                    if (arg2 > 0) {
                        if (arg3 > 0) {
                            if (arg4 > 0) {
                                if (arg5 > 1000) {
                                    if (arg6 > 0) {
                                        if (arg7 > 0) {
                                            if (arg8 > 0) {
                                                if (arg9 <= 18) {
                                                    arg10 <= 18
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

    public fun steamm_omm_v2_state_ok(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64, arg7: u64, arg8: u128, arg9: u128, arg10: u8, arg11: u8, arg12: u64, arg13: bool) : bool {
        if (arg13) {
            if (arg0 > 0) {
                if (arg1 > 0) {
                    if (arg2 < 10000) {
                        if (arg3 > 0) {
                            if (arg4 > 0) {
                                if (arg5 > 0) {
                                    if (arg6 > 1000) {
                                        if (arg7 > 0) {
                                            if (arg8 > 0) {
                                                if (arg9 > 0) {
                                                    if (arg10 <= 18) {
                                                        if (arg11 <= 18) {
                                                            if (arg12 == 20) {
                                                                true
                                                            } else if (arg12 == 30) {
                                                                true
                                                            } else if (arg12 == 50) {
                                                                true
                                                            } else {
                                                                arg12 == 100
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

    public fun suiswap_stable_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u8) : u8 {
        if (arg10 & 1 != 0) {
            2
        } else {
            let v1 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else if (arg4 == 0) {
                true
            } else if (arg4 > 4294967295) {
                true
            } else if (arg8 != 101) {
                true
            } else if (arg9 != 200 && arg9 != 201) {
                true
            } else if ((arg5 as u128) + (arg6 as u128) + (arg7 as u128) >= 10000) {
                true
            } else if ((arg0 as u256) * (arg2 as u256) > 1267650600228229401496703205376) {
                true
            } else {
                (arg1 as u256) * (arg3 as u256) > 1267650600228229401496703205376
            };
            if (v1) {
                5
            } else {
                0
            }
        }
    }

    public fun ve33_stable_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool) : u8 {
        let v0 = if (arg2 == 0) {
            0
        } else {
            (arg0 as u256) * (arg4 as u256) / (arg2 as u256)
        };
        let v1 = if (arg3 == 0) {
            0
        } else {
            (arg1 as u256) * (arg4 as u256) / (arg3 as u256)
        };
        if (arg7) {
            2
        } else {
            let v3 = if (arg0 == 0) {
                true
            } else if (arg1 == 0) {
                true
            } else if (arg2 == 0) {
                true
            } else if (arg3 == 0) {
                true
            } else if (arg4 == 0) {
                true
            } else if (arg6 == 0) {
                true
            } else if (arg5 >= arg6) {
                true
            } else if (v0 == 0) {
                true
            } else if (v1 == 0) {
                true
            } else if (v0 > 10000000000000000000) {
                true
            } else {
                v1 > 10000000000000000000
            };
            if (v3) {
                5
            } else {
                0
            }
        }
    }

    public fun virtual_cpmm_state_status(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64) : u8 {
        if (arg8) {
            return 2
        };
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else if (arg3 == 0) {
            true
        } else if (arg4 == 0) {
            true
        } else if (arg6 == 0) {
            true
        } else {
            arg7 >= 1000000
        };
        if (v0) {
            return 5
        };
        let v1 = (arg4 as u256) * (arg6 as u256);
        let v2 = if (v1 == 0) {
            true
        } else if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1) {
            true
        } else {
            v1 * v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (arg2 as u256)
        };
        if (v2) {
            return 5
        };
        let v3 = (arg0 as u256) * (arg2 as u256);
        let v4 = (arg1 as u256) * (arg3 as u256);
        let v5 = (arg4 as u256) * (arg2 as u256);
        if (v3 + v4 < v5) {
            return 5
        };
        let v6 = (v3 + v4 - v5) / (arg3 as u256);
        let v7 = if (arg5 > 0) {
            if (v6 < (arg5 as u256)) {
                ((arg5 as u256) - v6) * 10000 / (arg5 as u256) > 500
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            return 2
        };
        let v8 = if (arg9 >= arg10) {
            arg9 - arg10
        } else {
            0
        };
        let v9 = if (arg11 == 0) {
            true
        } else if (arg10 == 0) {
            true
        } else {
            v8 >= arg11
        };
        if (v9) {
            2
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

