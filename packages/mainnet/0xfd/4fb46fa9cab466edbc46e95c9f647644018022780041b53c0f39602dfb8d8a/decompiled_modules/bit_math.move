module 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math {
    public fun closest_bit_left(arg0: u256, arg1: u8) : (u8, bool) {
        let v0 = arg0 >> arg1;
        if (v0 == 0) {
            (0, false)
        } else {
            let (v3, _) = least_significant_bit(v0);
            (v3 + arg1, true)
        }
    }

    public fun closest_bit_right(arg0: u256, arg1: u8) : (u8, bool) {
        let v0 = 255 - arg1;
        let v1 = arg0 << v0;
        if (v1 == 0) {
            (0, false)
        } else {
            let (v4, _) = most_significant_bit(v1);
            (v4 - v0, true)
        }
    }

    public fun least_significant_bit(arg0: u256) : (u8, bool) {
        if (arg0 == 0) {
            return (0, false)
        };
        let v0 = 0;
        let v1 = arg0 << 128;
        if (v1 != 0) {
            v0 = 128;
            arg0 = v1;
        };
        let v2 = arg0 << 64;
        if (v2 != 0) {
            v0 = v0 + 64;
            arg0 = v2;
        };
        let v3 = arg0 << 32;
        if (v3 != 0) {
            v0 = v0 + 32;
            arg0 = v3;
        };
        let v4 = arg0 << 16;
        if (v4 != 0) {
            v0 = v0 + 16;
            arg0 = v4;
        };
        let v5 = arg0 << 8;
        if (v5 != 0) {
            v0 = v0 + 8;
            arg0 = v5;
        };
        let v6 = arg0 << 4;
        if (v6 != 0) {
            v0 = v0 + 4;
            arg0 = v6;
        };
        let v7 = arg0 << 2;
        if (v7 != 0) {
            v0 = v0 + 2;
            arg0 = v7;
        };
        if (arg0 << 1 != 0) {
            v0 = v0 + 1;
        };
        (255 - v0, true)
    }

    public fun most_significant_bit(arg0: u256) : (u8, bool) {
        if (arg0 == 0) {
            return (0, false)
        };
        let v0 = 0;
        if (arg0 > 340282366920938463463374607431768211455) {
            arg0 = arg0 >> 128;
            v0 = 128;
        };
        if (arg0 > 18446744073709551615) {
            arg0 = arg0 >> 64;
            v0 = v0 + 64;
        };
        if (arg0 > 4294967295) {
            arg0 = arg0 >> 32;
            v0 = v0 + 32;
        };
        if (arg0 > 65535) {
            arg0 = arg0 >> 16;
            v0 = v0 + 16;
        };
        if (arg0 > 255) {
            arg0 = arg0 >> 8;
            v0 = v0 + 8;
        };
        if (arg0 > 15) {
            arg0 = arg0 >> 4;
            v0 = v0 + 4;
        };
        if (arg0 > 3) {
            arg0 = arg0 >> 2;
            v0 = v0 + 2;
        };
        if (arg0 > 1) {
            v0 = v0 + 1;
        };
        (v0, true)
    }

    // decompiled from Move bytecode v6
}

