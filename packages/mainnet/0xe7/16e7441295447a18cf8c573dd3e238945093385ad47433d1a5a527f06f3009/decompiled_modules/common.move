module 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common {
    public(friend) fun clz(arg0: u256, arg1: u16) : u16 {
        if (arg0 == 0) {
            return arg1
        };
        let v0 = 0;
        let v1 = ((arg1 / 2) as u8);
        while (v1 > 0) {
            let v2 = arg0 >> v1;
            if (v2 == 0) {
                v0 = v0 + (v1 as u16);
            } else {
                arg0 = v2;
            };
            v1 = v1 / 2;
        };
        v0
    }

    public(friend) fun msb(arg0: u256, arg1: u16) : u8 {
        if (arg0 == 0) {
            return 0
        };
        ((arg1 - 1 - clz(arg0, arg1)) as u8)
    }

    public(friend) fun sqrt_floor(arg0: u256) : u256 {
        if (arg0 <= 1) {
            return arg0
        };
        let v0 = arg0;
        let v1 = 1;
        let v2 = v1;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v0 = arg0 >> 128;
            v2 = v1 << 64;
        };
        if (v0 >= 18446744073709551616) {
            v0 = v0 >> 64;
            v2 = v2 << 32;
        };
        if (v0 >= 4294967296) {
            v0 = v0 >> 32;
            v2 = v2 << 16;
        };
        if (v0 >= 65536) {
            v0 = v0 >> 16;
            v2 = v2 << 8;
        };
        if (v0 >= 256) {
            v0 = v0 >> 8;
            v2 = v2 << 4;
        };
        if (v0 >= 16) {
            v0 = v0 >> 4;
            v2 = v2 << 2;
        };
        if (v0 >= 4) {
            v2 = v2 << 1;
        };
        let v3 = 3 * v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        if (v9 > arg0 / v9) {
            v9 - 1
        } else {
            v9
        }
    }

    // decompiled from Move bytecode v7
}

