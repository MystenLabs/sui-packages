module 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math {
    struct SwitchboardDecimal has copy, drop, store {
        value: u128,
        dec: u8,
        neg: bool,
    }

    fun abs_gt(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        arg0.value > arg1.value
    }

    fun abs_lt(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        arg0.value < arg1.value
    }

    public fun add(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : SwitchboardDecimal {
        if (arg0.neg && arg1.neg) {
            let v1 = add_internal(arg0, arg1);
            v1.neg = true;
            v1
        } else if (arg0.neg) {
            sub_internal(arg1, arg0)
        } else if (arg1.neg) {
            sub_internal(arg0, arg1)
        } else {
            add_internal(arg0, arg1)
        }
    }

    fun add_internal(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : SwitchboardDecimal {
        new(arg0.value + arg1.value, 9, false)
    }

    public fun add_u64(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : (bool, u64) {
        let (v0, v1) = if (arg1 && arg3) {
            (arg0 + arg2, true)
        } else {
            let (v2, v3) = if (arg1) {
                if (arg0 > arg2) {
                    (true, arg0 - arg2)
                } else {
                    (false, arg2 - arg0)
                }
            } else if (arg3) {
                if (arg2 > arg0) {
                    (true, arg2 - arg0)
                } else {
                    (false, arg0 - arg2)
                }
            } else {
                (false, arg0 + arg2)
            };
            (v3, v2)
        };
        (v1, v0)
    }

    public fun div(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal, arg2: &mut SwitchboardDecimal) {
        let v0 = arg0.neg && arg1.neg || !arg0.neg && !arg1.neg;
        arg2.value = arg0.value * 1000000000 / arg1.value;
        arg2.dec = 9;
        arg2.neg = !v0;
    }

    public fun equals(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        scale_to_decimals(arg0, 9) == scale_to_decimals(arg1, 9) && arg0.neg == arg1.neg
    }

    public fun gt(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        if (arg0.neg && arg1.neg) {
            return arg0.value < arg1.value
        };
        if (arg0.neg) {
            return false
        };
        if (arg1.neg) {
            return true
        };
        arg0.value > arg1.value
    }

    public fun gte(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        if (arg0.neg && arg1.neg) {
            return arg0.value <= arg1.value
        };
        if (arg0.neg) {
            return false
        };
        if (arg1.neg) {
            return true
        };
        arg0.value >= arg1.value
    }

    public fun lt(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        if (arg0.neg && arg1.neg) {
            return arg0.value > arg1.value
        };
        if (arg0.neg) {
            return true
        };
        if (arg1.neg) {
            return false
        };
        arg0.value < arg1.value
    }

    public fun lt_u64(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : bool {
        if (arg1 && arg3) {
            return arg0 > arg2
        };
        if (arg1) {
            return true
        };
        if (arg3) {
            return false
        };
        arg0 < arg2
    }

    public fun lte(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : bool {
        if (arg0.neg && arg1.neg) {
            return arg0.value >= arg1.value
        };
        if (arg0.neg) {
            return true
        };
        if (arg1.neg) {
            return false
        };
        arg0.value <= arg1.value
    }

    fun max(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun median(arg0: &mut vector<SwitchboardDecimal>) : SwitchboardDecimal {
        let v0 = 0x1::vector::length<SwitchboardDecimal>(arg0);
        sort_results(arg0);
        if (v0 % 2 == 0) {
            let v2 = zero();
            let v3 = add(0x1::vector::borrow<SwitchboardDecimal>(arg0, v0 / 2 - 1), 0x1::vector::borrow<SwitchboardDecimal>(arg0, v0 / 2));
            let v4 = new(2, 0, false);
            let v5 = &mut v2;
            div(&v3, &v4, v5);
            v2
        } else {
            *0x1::vector::borrow<SwitchboardDecimal>(arg0, v0 / 2)
        }
    }

    fun min(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun mul(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal, arg2: &mut SwitchboardDecimal) {
        let v0 = arg0.neg && arg1.neg || !arg0.neg && !arg1.neg;
        mul_internal(arg0, arg1, arg2);
        arg2.neg = !v0;
    }

    fun mul_internal(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal, arg2: &mut SwitchboardDecimal) {
        let v0 = arg0.dec + arg1.dec;
        let v1 = if (v0 < 9) {
            arg0.value * arg1.value * pow_10(9 - v0)
        } else if (v0 > 9) {
            arg0.value * arg1.value / pow_10(v0 - 9)
        } else {
            arg0.value * arg1.value
        };
        arg2.value = v1;
        arg2.dec = 9;
        arg2.neg = false;
    }

    public fun new(arg0: u128, arg1: u8, arg2: bool) : SwitchboardDecimal {
        assert!(arg1 <= 9, 2);
        let v0 = SwitchboardDecimal{
            value : arg0,
            dec   : arg1,
            neg   : arg2,
        };
        v0.value = scale_to_decimals(&v0, 9);
        v0.dec = 9;
        v0
    }

    public fun pow(arg0: u64, arg1: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * (arg0 as u128);
            v1 = v1 + 1;
        };
        v0
    }

    fun pow_10(arg0: u8) : u128 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            10
        } else if (arg0 == 2) {
            100
        } else if (arg0 == 3) {
            1000
        } else if (arg0 == 4) {
            10000
        } else if (arg0 == 5) {
            100000
        } else if (arg0 == 5) {
            100000
        } else if (arg0 == 6) {
            1000000
        } else if (arg0 == 7) {
            10000000
        } else if (arg0 == 8) {
            100000000
        } else if (arg0 == 9) {
            1000000000
        } else {
            0
        }
    }

    public fun quick_sort(arg0: &mut vector<SwitchboardDecimal>, arg1: u64, arg2: bool, arg3: u64, arg4: bool) {
        let v0 = arg2;
        let v1 = arg1;
        let v2 = arg4;
        let v3 = arg3;
        let (v4, v5) = sub_u64(arg3, arg4, arg1, arg2);
        let (_, v7) = add_u64(arg1, arg2, v5 / 2, v4);
        let v8 = *0x1::vector::borrow<SwitchboardDecimal>(arg0, v7);
        while (v1 <= v3) {
            while (lt(0x1::vector::borrow<SwitchboardDecimal>(arg0, v1), &v8)) {
                let (v9, v10) = add_u64(v1, v0, 1, false);
                v1 = v10;
                v0 = v9;
            };
            while (gt(0x1::vector::borrow<SwitchboardDecimal>(arg0, v3), &v8)) {
                let (v11, v12) = sub_u64(v3, v2, 1, false);
                v3 = v12;
                v2 = v11;
            };
            if (lt_u64(v1, v0, v3, v2) || v1 == v3 && v0 == v2) {
                0x1::vector::swap<SwitchboardDecimal>(arg0, v1, v3);
                let (v13, v14) = add_u64(v1, v0, 1, false);
                v1 = v14;
                v0 = v13;
                let (v15, v16) = sub_u64(v3, v2, 1, false);
                v3 = v16;
                v2 = v15;
            };
        };
        if (lt_u64(arg1, arg2, v3, v2)) {
            quick_sort(arg0, arg1, arg2, v3, v2);
        };
        if (lt_u64(v1, v0, arg3, arg4)) {
            quick_sort(arg0, v1, v0, arg3, arg4);
        };
    }

    public fun scale_to_decimals(arg0: &SwitchboardDecimal, arg1: u8) : u128 {
        if (arg0.dec < arg1) {
            return arg0.value * pow_10(arg1 - arg0.dec)
        };
        arg0.value / pow_10(arg0.dec - arg1)
    }

    public fun sort_results(arg0: &mut vector<SwitchboardDecimal>) {
        let v0 = 0x1::vector::length<SwitchboardDecimal>(arg0);
        if (v0 < 2) {
            return
        };
        let v1 = true;
        let v2 = 1;
        while (v2 < v0) {
            if (gt(0x1::vector::borrow<SwitchboardDecimal>(arg0, v2 - 1), 0x1::vector::borrow<SwitchboardDecimal>(arg0, v2))) {
                v1 = false;
                break
            };
            v2 = v2 + 1;
        };
        if (v1) {
            return
        };
        v1 = true;
        let v3 = 0;
        while (v3 < v0 / 2) {
            if (gt(0x1::vector::borrow<SwitchboardDecimal>(arg0, v3), 0x1::vector::borrow<SwitchboardDecimal>(arg0, v0 - v3 - 1))) {
                0x1::vector::swap<SwitchboardDecimal>(arg0, v3, v0 - v3 - 1);
                v3 = v3 + 1;
            } else {
                v1 = false;
                break
            };
        };
        if (v1) {
            return
        };
        quick_sort(arg0, 0, false, v0 - 1, false);
    }

    public fun sub(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : SwitchboardDecimal {
        if (arg0.neg && arg1.neg) {
            let v1 = add_internal(arg0, arg1);
            v1.neg = abs_gt(arg0, arg1);
            v1
        } else if (arg0.neg) {
            let v2 = add_internal(arg0, arg1);
            v2.neg = true;
            v2
        } else if (arg1.neg) {
            add_internal(arg0, arg1)
        } else {
            sub_internal(arg0, arg1)
        }
    }

    fun sub_abs_u8(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    fun sub_internal(arg0: &SwitchboardDecimal, arg1: &SwitchboardDecimal) : SwitchboardDecimal {
        if (arg1.value > arg0.value) {
            new(arg1.value - arg0.value, 9, true)
        } else {
            new(arg0.value - arg1.value, 9, false)
        }
    }

    public fun sub_u64(arg0: u64, arg1: bool, arg2: u64, arg3: bool) : (bool, u64) {
        add_u64(arg0, arg1, arg2, !arg3)
    }

    public fun unpack(arg0: SwitchboardDecimal) : (u128, u8, bool) {
        let SwitchboardDecimal {
            value : v0,
            dec   : v1,
            neg   : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun zero() : SwitchboardDecimal {
        SwitchboardDecimal{
            value : 0,
            dec   : 0,
            neg   : false,
        }
    }

    // decompiled from Move bytecode v6
}

