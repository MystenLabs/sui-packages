module 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::live {
    struct TickLimit has drop {
        l: u128,
        p: u128,
        spacing: u64,
        a2b: bool,
        prefix_upper: u256,
    }

    struct Sizer has drop {
        model: 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe,
        expected: 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe,
        legs: vector<0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe>,
        limits: vector<TickLimit>,
        reference: u64,
        minimum: u64,
        maximum: u64,
        safe_cap: u64,
        floor: u64,
        reference_gross: u64,
        upper_rate: u256,
        unchanged: bool,
    }

    fun append(arg0: &mut Sizer, arg1: u256, arg2: u256, arg3: u256, arg4: u64, arg5: u256) {
        let v0 = if (arg3 > 0) {
            if (arg5 > 0) {
                arg5 < 340282366920938463463374607431768211456
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = (arg4 as u256) * 18446744073709551616 / arg0.upper_rate;
        if (v1 < (arg0.safe_cap as u256)) {
            arg0.safe_cap = (v1 as u64);
        };
        arg0.upper_rate = (arg0.upper_rate * arg5 + 18446744073709551616 - 1) / 18446744073709551616;
        assert!(arg0.upper_rate > 0 && arg0.upper_rate < 340282366920938463463374607431768211456, 2);
        let v2 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::begin();
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold(&mut v2, arg1, arg2, arg3);
        0x1::vector::push_back<0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe>(&mut arg0.legs, v2);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold(&mut arg0.model, arg1, arg2, arg3);
    }

    public fun begin(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Sizer {
        let v0 = if (arg1 > 0) {
            if (arg0 > 0) {
                arg2 >= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        Sizer{
            model           : 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::begin(),
            expected        : 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::begin(),
            legs            : 0x1::vector::empty<0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe>(),
            limits          : 0x1::vector::empty<TickLimit>(),
            reference       : arg0,
            minimum         : arg1,
            maximum         : arg2,
            safe_cap        : arg2,
            floor           : arg3,
            reference_gross : arg4,
            upper_rate      : 18446744073709551616,
            unchanged       : true,
        }
    }

    public fun cached(arg0: &mut Sizer, arg1: u128, arg2: u64, arg3: u64) {
        assert!(arg1 > 0 && arg3 > 0, 2);
        arg0.unchanged = false;
        let v0 = (arg1 as u256);
        let (v1, v2, v3) = if (arg2 == 0) {
            (v0, 0, 18446744073709551616)
        } else {
            (v0 * (arg2 as u256), 18446744073709551616, 18446744073709551616 * (arg2 as u256))
        };
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold(&mut arg0.expected, v1, v2, v3);
        append(arg0, v1, v2, v3, arg3, v0 + v0 / 1000000 + 1);
    }

    public fun finish(arg0: Sizer) : u64 {
        assert!(!0x1::vector::is_empty<0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe>(&arg0.legs), 2);
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::model_rate(&arg0.model);
        assert!(v0 > 18446744073709551616, 0);
        let v1 = if (arg0.unchanged) {
            if (arg0.reference >= arg0.minimum) {
                if (arg0.reference <= arg0.maximum) {
                    if (arg0.reference_gross > 0) {
                        arg0.reference_gross >= arg0.floor
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
        if (v1) {
            return arg0.reference
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<TickLimit>(&arg0.limits)) {
            let v3 = 0x1::vector::borrow<TickLimit>(&arg0.limits, v2);
            let v4 = (0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::live_tick::boundary(v3.p, v3.spacing, v3.a2b) as u256);
            let v5 = (v3.p as u256);
            let v6 = if (v4 == v5) {
                0
            } else if (v3.a2b) {
                (v3.l as u256) * (v5 - v4) / v5 * 18446744073709551616 / v4
            } else {
                (v3.l as u256) * (v4 - v5) / 18446744073709551616
            };
            let v7 = if (v6 > 0) {
                v6 - 1
            } else {
                0
            };
            let v8 = if (v7 > 18446744073709551615) {
                18446744073709551615
            } else {
                v7
            };
            let v9 = v8 * 18446744073709551616 / v3.prefix_upper;
            if (v9 < (arg0.safe_cap as u256)) {
                arg0.safe_cap = (v9 as u64);
            };
            v2 = v2 + 1;
        };
        assert!(arg0.safe_cap >= arg0.minimum, 0);
        let v10 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::model_size(&arg0.model, arg0.safe_cap);
        let v11 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::model_rate(&arg0.expected);
        let v12 = if (v11 > 18446744073709551616) {
            (arg0.reference as u256) * (v0 - 18446744073709551616) / (v11 - 18446744073709551616)
        } else {
            (v10 as u256)
        };
        let v13 = if (v12 > (arg0.safe_cap as u256)) {
            (arg0.safe_cap as u256)
        } else {
            v12
        };
        let v14 = 0;
        let v15 = 0;
        let v16 = v15;
        let v17 = if (v10 > 0) {
            v10 - 1
        } else {
            0
        };
        let v18 = if (v10 < arg0.safe_cap) {
            v10 + 1
        } else {
            v10
        };
        let v19 = 0x1::vector::empty<u64>();
        let v20 = &mut v19;
        0x1::vector::push_back<u64>(v20, v10);
        0x1::vector::push_back<u64>(v20, v17);
        0x1::vector::push_back<u64>(v20, v18);
        0x1::vector::push_back<u64>(v20, (v13 as u64));
        0x1::vector::push_back<u64>(v20, arg0.minimum);
        0x1::vector::push_back<u64>(v20, arg0.safe_cap);
        let v21 = 0;
        while (v21 < 0x1::vector::length<u64>(&v19)) {
            let v22 = *0x1::vector::borrow<u64>(&v19, v21);
            let v23 = profit(&arg0, v22);
            if (v23 > v15) {
                v14 = v22;
                v16 = v23;
            };
            v21 = v21 + 1;
        };
        assert!(v14 > 0 && v16 >= arg0.floor, 1);
        v14
    }

    fun profit(arg0: &Sizer, arg1: u64) : u64 {
        if (arg1 < arg0.minimum || arg1 > arg0.safe_cap) {
            return 0
        };
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe>(&arg0.legs)) {
            v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::model_out(0x1::vector::borrow<0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe>(&arg0.legs, v1), v0);
            v1 = v1 + 1;
        };
        if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        }
    }

    public fun tick(arg0: &mut Sizer, arg1: u128, arg2: u128, arg3: u64, arg4: bool, arg5: u128, arg6: u128, arg7: u64, arg8: u64) {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg3 < 1000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = if (arg5 > 0) {
            if (arg6 > 0) {
                arg7 < 1000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 2);
        let v2 = if (arg1 == arg5) {
            if (arg2 == arg6) {
                arg3 == arg7
            } else {
                false
            }
        } else {
            false
        };
        let v3 = arg0.unchanged && v2;
        arg0.unchanged = v3;
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::fold_tick(&mut arg0.expected, arg5, arg6, arg7, arg4);
        assert!(arg8 > 0 && arg8 <= 443636, 2);
        if (arg1 < arg5) {
            let v4 = (arg0.maximum as u256) * (arg1 as u256) / (arg5 as u256);
            if (v4 < (arg0.safe_cap as u256)) {
                arg0.safe_cap = (v4 as u64);
            };
        };
        let v5 = TickLimit{
            l            : arg1,
            p            : arg2,
            spacing      : arg8,
            a2b          : arg4,
            prefix_upper : arg0.upper_rate,
        };
        0x1::vector::push_back<TickLimit>(&mut arg0.limits, v5);
        let v6 = (arg1 as u256);
        let v7 = (arg2 as u256);
        let v8 = 1000000 - (arg3 as u256);
        let (v9, v10) = if (arg4) {
            (v6 * v7 >> 64, ((v6 << 64) + v7 - 1) / v7)
        } else {
            ((v6 << 64) / v7, v6 * v7 + 18446744073709551616 - 1 >> 64)
        };
        let (v11, v12) = if (arg4) {
            (v7 * v7 * v8, 18446744073709551616 * 1000000)
        } else {
            (18446744073709551616 * 18446744073709551616 * 18446744073709551616 * v8, v7 * v7 * 1000000)
        };
        append(arg0, v9, 1, (v10 * 1000000 + v8 - 1) / v8, (18446744073709551615 as u64), (v11 + v12 - 1) / v12);
    }

    // decompiled from Move bytecode v7
}

