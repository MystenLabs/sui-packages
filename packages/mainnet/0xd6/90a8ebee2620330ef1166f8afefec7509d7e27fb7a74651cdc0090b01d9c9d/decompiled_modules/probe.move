module 0xd690a8ebee2620330ef1166f8afefec7509d7e27fb7a74651cdc0090b01d9c9d::probe {
    struct Probe {
        m00: u256,
        m10: u256,
        m11: u256,
        max_in: u256,
        size: u64,
        gross: u64,
        reference: u64,
        floor: u64,
        quote_size: u64,
        quote_amount: u64,
        base_left: u64,
        best_size: u64,
        best_gross: u64,
        checking: bool,
    }

    public fun begin() : Probe {
        Probe{
            m00          : 1,
            m10          : 0,
            m11          : 1,
            max_in       : 18446744073709551615,
            size         : 0,
            gross        : 0,
            reference    : 0,
            floor        : 0,
            quote_size   : 0,
            quote_amount : 0,
            base_left    : 0,
            best_size    : 0,
            best_gross   : 0,
            checking     : false,
        }
    }

    public fun begin_at(arg0: u64) : Probe {
        let v0 = begin();
        v0.reference = arg0;
        v0
    }

    public fun check_amount(arg0: &Probe) : u64 {
        arg0.quote_amount
    }

    public fun check_end(arg0: &mut Probe) {
        if (!arg0.checking) {
            return
        };
        let v0 = (arg0.quote_amount as u256) + (arg0.base_left as u256);
        if (v0 <= (arg0.quote_size as u256)) {
            return
        };
        let v1 = v0 - (arg0.quote_size as u256);
        let v2 = if (v1 >= (arg0.floor as u256)) {
            if (v1 <= 18446744073709551615) {
                arg0.best_size == 0 || v1 > (arg0.best_gross as u256)
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            arg0.best_size = arg0.quote_size;
            arg0.best_gross = (v1 as u64);
        };
    }

    public fun check_start(arg0: &mut Probe, arg1: bool) {
        let v0 = if (arg1) {
            arg0.reference
        } else {
            arg0.size
        };
        let v1 = v0 > 0 && (!arg1 || arg0.best_size == 0 && v0 != arg0.size);
        arg0.checking = v1;
        arg0.quote_size = v0;
        arg0.quote_amount = v0;
        arg0.base_left = 0;
    }

    public fun check_step(arg0: &mut Probe, arg1: u64, arg2: u64, arg3: bool) {
        if (!arg0.checking) {
            return
        };
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 > arg0.quote_amount) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            arg0.checking = false;
            return
        };
        if (arg3) {
            arg0.base_left = arg0.base_left + arg0.quote_amount - arg1;
        };
        arg0.quote_amount = arg2;
    }

    public fun checking(arg0: &Probe) : bool {
        arg0.checking
    }

    public fun choose(arg0: &mut Probe) {
        assert!(arg0.best_size > 0, 1);
        arg0.size = arg0.best_size;
        arg0.gross = arg0.best_gross;
        arg0.checking = false;
    }

    public fun finish(arg0: Probe) {
        let Probe {
            m00          : _,
            m10          : _,
            m11          : _,
            max_in       : _,
            size         : _,
            gross        : _,
            reference    : _,
            floor        : _,
            quote_size   : _,
            quote_amount : _,
            base_left    : _,
            best_size    : _,
            best_gross   : _,
            checking     : _,
        } = arg0;
    }

    public fun fold(arg0: &mut Probe, arg1: u256, arg2: u256, arg3: u256) {
        while (arg1 >= 340282366920938463463374607431768211456 || arg3 >= 340282366920938463463374607431768211456) {
            arg1 = arg1 >> 8;
            let v0 = arg3 >> 8;
            arg3 = v0 + 1;
            if (arg2 != 0) {
                let v1 = arg2 >> 8;
                arg2 = v1 + 1;
            };
        };
        arg0.m10 = arg2 * arg0.m00 + arg3 * arg0.m10;
        arg0.m11 = arg3 * arg0.m11;
        arg0.m00 = arg1 * arg0.m00;
        normalise(arg0);
    }

    public fun fold_closed(arg0: &mut Probe) {
        arg0.m00 = 0;
    }

    public fun fold_tick(arg0: &mut Probe, arg1: u128, arg2: u128, arg3: u64, arg4: bool) {
        if (arg1 == 0 || arg2 == 0) {
            fold_closed(arg0);
            return
        };
        let v0 = (arg1 as u256);
        let v1 = (arg2 as u256);
        let (v2, v3) = if (arg4) {
            (v0 * v1 / 18446744073709551616, (v0 * 18446744073709551616 + v1 - 1) / v1)
        } else {
            (v0 * 18446744073709551616 / v1, (v0 * v1 + 18446744073709551616 - 1) / 18446744073709551616)
        };
        let v4 = 1000000 - (arg3 as u256);
        fold(arg0, v2 * v4, v4, v3 * 1000000);
    }

    public fun fold_to(arg0: &mut Probe, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        let v0 = arg4 * arg0.m10;
        if (arg0.m00 > v0) {
            let v1 = arg4 * arg0.m11 / (arg0.m00 - v0);
            if (v1 < arg0.max_in) {
                arg0.max_in = v1;
            };
        };
        fold(arg0, arg1, arg2, arg3);
    }

    public fun gross(arg0: &Probe) : u64 {
        arg0.gross
    }

    fun normalise(arg0: &mut Probe) {
        loop {
            let v0 = if (arg0.m00 >= 1329227995784915872903807060280344576) {
                true
            } else if (arg0.m10 >= 1329227995784915872903807060280344576) {
                true
            } else {
                arg0.m11 >= 1329227995784915872903807060280344576
            };
            if (v0) {
                arg0.m00 = arg0.m00 >> 8;
                arg0.m11 = (arg0.m11 >> 8) + 1;
                if (arg0.m10 != 0) {
                    arg0.m10 = (arg0.m10 >> 8) + 1;
                };
            } else {
                break
            };
        };
    }

    public fun plan(arg0: &mut Probe, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 0);
        let v0 = if (arg0.max_in < (arg1 as u256)) {
            arg0.max_in
        } else {
            (arg1 as u256)
        };
        if ((arg0.reference as u256) > v0) {
            arg0.reference = (v0 as u64);
        };
        let v1 = if (arg0.m00 <= arg0.m11) {
            (arg0.reference as u256)
        } else if (arg0.m10 == 0) {
            v0
        } else {
            (sqrt(arg0.m00 * arg0.m11) - arg0.m11) / arg0.m10
        };
        let v2 = if (v1 > v0) {
            v0
        } else {
            v1
        };
        arg0.size = (v2 as u64);
        if (arg0.size == 0) {
            arg0.size = arg0.reference;
        };
        arg0.floor = arg2;
        arg0.best_size = 0;
        arg0.best_gross = 0;
    }

    public fun reference_input(arg0: &Probe) : u64 {
        let v0 = if ((arg0.reference as u256) < arg0.max_in) {
            (arg0.reference as u256)
        } else {
            arg0.max_in
        };
        let v1 = arg0.m00 * v0 / (arg0.m10 * v0 + arg0.m11);
        if (v1 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v1 as u64)
        }
    }

    public fun size(arg0: &Probe) : u64 {
        arg0.size
    }

    public fun solve(arg0: &mut Probe, arg1: u64, arg2: u64) {
        assert!(arg0.m00 > arg0.m11 && arg1 > 0, 0);
        let v0 = if (arg0.max_in < (arg1 as u256)) {
            arg0.max_in
        } else {
            (arg1 as u256)
        };
        let v1 = if (arg0.m10 == 0) {
            v0
        } else {
            (sqrt(arg0.m00 * arg0.m11) - arg0.m11) / arg0.m10
        };
        let v2 = v1;
        if (v1 > v0) {
            v2 = v0;
        };
        assert!(v2 > 0, 0);
        let v3 = arg0.m00 * v2 / (arg0.m10 * v2 + arg0.m11);
        assert!(v3 > v2 && v3 <= 18446744073709551615, 0);
        let v4 = v3 - v2;
        assert!(v4 >= (arg2 as u256), 1);
        arg0.size = (v2 as u64);
        arg0.gross = (v4 as u64);
    }

    public fun sqrt(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v0 = arg0 >> 128;
            v2 = v1 + 128;
        };
        if (v0 >= 18446744073709551616) {
            v0 = v0 >> 64;
            v2 = v2 + 64;
        };
        if (v0 >= 4294967296) {
            v0 = v0 >> 32;
            v2 = v2 + 32;
        };
        if (v0 >= 65536) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 >= 256) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 >= 16) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 >= 4) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 >= 2) {
            v2 = v2 + 1;
        };
        let v3 = 1 << v2 / 2 + 1;
        let v4 = v3 + 1;
        while (v3 < v4) {
            v4 = v3;
            let v5 = arg0 / v3 + v3;
            v3 = v5 / 2;
        };
        v4
    }

    // decompiled from Move bytecode v7
}

