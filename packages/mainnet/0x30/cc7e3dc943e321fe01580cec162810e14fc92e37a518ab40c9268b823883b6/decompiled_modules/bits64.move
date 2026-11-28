module 0x30cc7e3dc943e321fe01580cec162810e14fc92e37a518ab40c9268b823883b6::bits64 {
    public fun clz(arg0: u64) : u16 {
        if (arg0 == 0) {
            64
        } else {
            63 - (msb(arg0) as u16)
        }
    }

    public fun ctz(arg0: u64) : u16 {
        if (arg0 == 0) {
            64
        } else {
            (lsb(arg0) as u16)
        }
    }

    public fun icbrt_down(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 2642245;
        while (v0 < v1) {
            let v2 = v0 + (v1 - v0 + 1) / 2;
            if (v2 * v2 <= arg0 / v2) {
                v0 = v2;
                continue
            };
            v1 = v2 - 1;
        };
        v0
    }

    public fun icbrt_up(arg0: u64) : u64 {
        let v0 = icbrt_down(arg0);
        if (v0 * v0 * v0 < arg0) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun ilog10(arg0: u64) : u8 {
        assert!(arg0 != 0, 1);
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >= 10000000000) {
            v0 = arg0 / 10000000000;
            v2 = v1 + 10;
        };
        if (v0 >= 100000) {
            v0 = v0 / 100000;
            v2 = v2 + 5;
        };
        if (v0 >= 1000) {
            v0 = v0 / 1000;
            v2 = v2 + 3;
        };
        if (v0 >= 100) {
            v0 = v0 / 100;
            v2 = v2 + 2;
        };
        if (v0 >= 10) {
            v2 = v2 + 1;
        };
        v2
    }

    public fun ilog2(arg0: u64) : u8 {
        msb(arg0)
    }

    public fun ilog256(arg0: u64) : u8 {
        msb(arg0) >> 3
    }

    public fun ipow(arg0: u64, arg1: u8) : u64 {
        let v0 = 1;
        let v1 = arg1;
        while (v1 > 0) {
            if (v1 & 1 == 1) {
                v0 = v0 * arg0;
            };
            v1 = v1 >> 1;
            if (v1 > 0) {
                arg0 = arg0 * arg0;
            };
        };
        v0
    }

    public fun is_pow2(arg0: u64) : bool {
        arg0 != 0 && arg0 & arg0 - 1 == 0
    }

    public fun isqrt_down(arg0: u64) : u64 {
        if (arg0 <= 1) {
            arg0
        } else {
            let v1 = 1 << (msb(arg0) >> 1) + 1;
            let v2 = sqrt_next(arg0, v1);
            while (v2 < v1) {
                v2 = sqrt_next(arg0, v2);
            };
            v1
        }
    }

    public fun isqrt_up(arg0: u64) : u64 {
        let v0 = isqrt_down(arg0);
        if (v0 * v0 < arg0) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun lsb(arg0: u64) : u8 {
        assert!(arg0 != 0, 1);
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 & 4294967295 == 0) {
            v0 = arg0 >> 32;
            v2 = v1 + 32;
        };
        if (v0 & 65535 == 0) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 & 255 == 0) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 & 15 == 0) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 & 3 == 0) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 & 1 == 0) {
            v2 = v2 + 1;
        };
        v2
    }

    public fun msb(arg0: u64) : u8 {
        assert!(arg0 != 0, 1);
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >= 4294967296) {
            v0 = arg0 >> 32;
            v2 = v1 + 32;
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
        v2
    }

    public fun next_pow2(arg0: u64) : u64 {
        if (arg0 <= 1) {
            1
        } else {
            assert!(arg0 <= 9223372036854775808, 2);
            1 << msb(arg0 - 1) + 1
        }
    }

    public fun popcount(arg0: u64) : u16 {
        let v0 = 0;
        while (arg0 != 0) {
            v0 = v0 + ((arg0 & 1) as u16);
            arg0 = arg0 >> 1;
        };
        v0
    }

    fun sqrt_next(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / arg1;
        (arg1 >> 1) + (v0 >> 1) + (arg1 & v0 & 1)
    }

    // decompiled from Move bytecode v7
}

