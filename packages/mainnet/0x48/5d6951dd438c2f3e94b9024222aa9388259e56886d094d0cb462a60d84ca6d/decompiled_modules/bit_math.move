module 0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::bit_math {
    public fun get_least_significant_bit(arg0: u256) : u8 {
        assert!(arg0 > 0, 0);
        let v0 = 255;
        let v1 = v0;
        if (arg0 & (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u128() as u256) > 0) {
            v1 = v0 - 128;
        } else {
            arg0 = arg0 >> 128;
        };
        if (arg0 & (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u64() as u256) > 0) {
            v1 = v1 - 64;
        } else {
            arg0 = arg0 >> 64;
        };
        if (arg0 & (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u32() as u256) > 0) {
            v1 = v1 - 32;
        } else {
            arg0 = arg0 >> 32;
        };
        if (arg0 & (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u16() as u256) > 0) {
            v1 = v1 - 16;
        } else {
            arg0 = arg0 >> 16;
        };
        if (arg0 & (0x485d6951dd438c2f3e94b9024222aa9388259e56886d094d0cb462a60d84ca6d::constants::get_max_u8() as u256) > 0) {
            v1 = v1 - 8;
        } else {
            arg0 = arg0 >> 8;
        };
        if (arg0 & 15 > 0) {
            v1 = v1 - 4;
        } else {
            arg0 = arg0 >> 4;
        };
        if (arg0 & 3 > 0) {
            v1 = v1 - 2;
        } else {
            arg0 = arg0 >> 2;
        };
        if (arg0 & 1 > 0) {
            v1 = v1 - 1;
        };
        v1
    }

    public fun get_most_significant_bit(arg0: u256) : u8 {
        assert!(arg0 > 0, 0);
        let v0 = 0;
        let v1 = v0;
        if (arg0 >= 340282366920938463463374607431768211456) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >= 18446744073709551616) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >= 4294967296) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >= 65536) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >= 256) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >= 16) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >= 4) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >= 2) {
            v1 = v1 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

