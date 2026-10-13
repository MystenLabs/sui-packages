module 0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math {
    public fun builder_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x1::u64::min(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0, arg2), 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, arg3))
    }

    public fun digital(arg0: u128, arg1: bool, arg2: u128, arg3: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg4: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg5: u64, arg6: u64, arg7: u64) : (0x1::option::Option<u64>, u64) {
        if (arg6 == 0) {
            return (0x1::option::none<u64>(), 0)
        };
        let v0 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::ln(arg7);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::ln(arg6);
        let v2 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::sub(&v0, &v1);
        let v3 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::sub(&v2, &arg4);
        let v4 = (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v3) as u128);
        let v5 = (arg5 as u128);
        let v6 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_u64((0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_u128_down(v4 * v4 + v5 * v5) as u64));
        let v7 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::mul_scaled(&arg3, &v3);
        let v8 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::add(&v7, &v6);
        if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v8)) {
            return (0x1::option::none<u64>(), 1)
        };
        let v9 = total_var(arg0, arg1, arg2, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v8));
        if (0x1::option::is_none<u128>(&v9)) {
            return (0x1::option::none<u64>(), 2)
        };
        let (v10, v11) = sqrt_var_d2(0x1::option::destroy_some<u128>(v9), &v2);
        let v12 = v11;
        let v13 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::div_scaled(&v3, &v6);
        let v14 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::add(&arg3, &v13);
        let v15 = 1000000000;
        let v16 = ((arg2 * (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v14) as u128) / v15 * v15) as u64);
        if (v16 == 0) {
            return (0x1::option::some<u64>(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::normal_cdf(&v12)), 0)
        };
        let v17 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::normal_pdf(&v12), v16, 2 * v10), 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v14));
        let v18 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_u64(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::normal_cdf(&v12));
        let v19 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::sub(&v18, &v17);
        let v20 = if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&v19)) {
            0
        } else if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v19) > 1000000000) {
            1000000000
        } else {
            0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&v19)
        };
        (0x1::option::some<u64>(v20), 0)
    }

    public fun inputs_ok(arg0: u64, arg1: u64, arg2: u64, arg3: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg4: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg5: u64) : bool {
        if (arg0 > 0) {
            if (arg1 > 0) {
                if (arg1 <= 184467440737095516) {
                    if (0x1::u64::div_ceil(arg1, 100) <= arg0) {
                        if (arg2 <= 100000000000) {
                            if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&arg3) <= 1000000000) {
                                if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&arg4) <= 100000000000) {
                                    if (arg5 >= 10000) {
                                        arg5 <= 100000000000
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

    public fun leg_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = if (arg4 == 0 || arg4 == 1000000000) {
            0
        } else {
            0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg4, 1000000000 - arg4)))
        };
        let v1 = if (arg6 >= arg2) {
            1000000000
        } else {
            1000000000 + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(arg3 - 1000000000, arg2 - arg6, arg2)
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x1::u64::max(v0, arg1), v1), arg5)
    }

    public fun max_qty(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 0;
        while (v0 < arg3) {
            let v1 = (v0 + arg3 + 1) / 2;
            if (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0, v1 * arg2) <= arg1) {
                v0 = v1;
                continue
            };
            arg3 = v1 - 1;
        };
        v0 * arg2
    }

    public fun need_budget(arg0: u64, arg1: u64) : u64 {
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(arg0 + 1, 1000000000 - arg1, arg1) + 1
    }

    public fun need_qty(arg0: u64, arg1: u64) : u64 {
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(arg0, 1000000000 - arg1, 1000000000) + 1
    }

    public fun need_sell(arg0: u64, arg1: u64) : u64 {
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(arg0, 1000000000 - arg1, 1000000000) + 1
    }

    public fun order_terms(arg0: u256) : (u64, u64, u64) {
        let v0 = 1073741823;
        (((arg0 >> 70 & v0) as u64), ((arg0 >> 40 & v0) as u64), ((arg0 >> 100 & 4294967295) as u64) * 10000)
    }

    public fun potential(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg2 == 0) {
            return 0
        };
        let v0 = 0x1::u64::min(arg2, arg1);
        if (arg2 <= arg1) {
            return 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(v0, 1000000000, arg1)), v0) / 2
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(v0, 1000000000, arg1)), v0) / 2 + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0, arg2 - arg1)
    }

    public fun raw_var_ok(arg0: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg1: u64, arg2: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg3: u64) : bool {
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(&arg0) && 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, smile_inner(arg2, arg3)) > 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&arg0) || 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&arg0) > 0 || 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, smile_inner(arg2, arg3)) > 0
    }

    public fun roll_down(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (((arg0 as u256) * 1000000000 * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    fun smile_inner(arg0: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg1: u64) : u64 {
        let v0 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(&arg0);
        if (v0 == 1000000000) {
            return 0
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_down(1000000000 - 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v0, v0)))
    }

    fun sqrt_var_d2(arg0: u128, arg1: &0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64) : (u64, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64) {
        let v0 = 1000000000;
        let v1 = (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_u128_down(arg0) as u64);
        let v2 = (0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::magnitude(arg1) as u128) * v0;
        let v3 = arg0 / 2;
        let (v4, v5) = if (!0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::is_negative(arg1)) {
            (v2 + v3, false)
        } else if (v3 >= v2) {
            (v3 - v2, false)
        } else {
            (v2 - v3, true)
        };
        let v6 = 8 * v0 + 1;
        let v7 = v4 / (v1 as u128);
        let v8 = if (v7 > v6) {
            v6
        } else {
            v7
        };
        (v1, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::from_parts((v8 as u64), !v5))
    }

    fun total_var(arg0: u128, arg1: bool, arg2: u128, arg3: u64) : 0x1::option::Option<u128> {
        let v0 = arg2 * (arg3 as u128) / 1000000000;
        if (arg1) {
            if (v0 > arg0) {
                0x1::option::some<u128>(v0 - arg0)
            } else {
                0x1::option::none<u128>()
            }
        } else if (v0 + arg0 > 0) {
            0x1::option::some<u128>(v0 + arg0)
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun var_positive(arg0: u128, arg1: bool, arg2: u128, arg3: 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::i64::I64, arg4: u64) : bool {
        let v0 = total_var(arg0, arg1, arg2, smile_inner(arg3, arg4));
        0x1::option::is_some<u128>(&v0)
    }

    // decompiled from Move bytecode v7
}

