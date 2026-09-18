module 0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe {
    struct Probe {
        m00: u256,
        m10: u256,
        m11: u256,
        max_in: u256,
        size: u64,
        gross: u64,
    }

    public fun begin() : Probe {
        Probe{
            m00    : 1,
            m10    : 0,
            m11    : 1,
            max_in : 18446744073709551615,
            size   : 0,
            gross  : 0,
        }
    }

    public fun finish(arg0: Probe) {
        let Probe {
            m00    : _,
            m10    : _,
            m11    : _,
            max_in : _,
            size   : _,
            gross  : _,
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
        if (arg0 < 4) {
            return if (arg0 == 0) {
                0
            } else {
                1
            }
        };
        let v1 = arg0 / 2 + 1;
        while (v1 < arg0) {
            let v2 = arg0 / v1 + v1;
            v1 = v2 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v7
}

