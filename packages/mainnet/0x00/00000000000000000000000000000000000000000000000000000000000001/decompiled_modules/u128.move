module 0x1::u128 {
    public fun bitwise_not(arg0: u128) : u128 {
        arg0 ^ 340282366920938463463374607431768211455
    }

    public fun checked_add(arg0: u128, arg1: u128) : 0x1::option::Option<u128> {
        if (arg1 > 340282366920938463463374607431768211455 - arg0) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(arg0 + arg1)
        }
    }

    public fun checked_div(arg0: u128, arg1: u128) : 0x1::option::Option<u128> {
        if (arg1 == 0) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(arg0 / arg1)
        }
    }

    public fun checked_mul(arg0: u128, arg1: u128) : 0x1::option::Option<u128> {
        if (arg0 == 0 || arg1 == 0) {
            0x1::option::some<u128>(0)
        } else if (arg1 > 340282366920938463463374607431768211455 / arg0) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(arg0 * arg1)
        }
    }

    public fun checked_shl(arg0: u128, arg1: u8) : 0x1::option::Option<u128> {
        if (arg1 >= 128) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(arg0 << arg1)
        }
    }

    public fun checked_shr(arg0: u128, arg1: u8) : 0x1::option::Option<u128> {
        if (arg1 >= 128) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(arg0 >> arg1)
        }
    }

    public fun checked_sub(arg0: u128, arg1: u128) : 0x1::option::Option<u128> {
        if (arg0 < arg1) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(arg0 - arg1)
        }
    }

    public fun diff(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun divide_and_round_up(arg0: u128, arg1: u128) : u128 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public fun lossless_div(arg0: u128, arg1: u128) : 0x1::option::Option<u128> {
        if (arg1 == 0) {
            0x1::option::none<u128>()
        } else if (arg0 % arg1 == 0) {
            0x1::option::some<u128>(arg0 / arg1)
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun lossless_shl(arg0: u128, arg1: u8) : 0x1::option::Option<u128> {
        if (arg1 >= 128) {
            0x1::option::none<u128>()
        } else {
            let v1 = arg0 << arg1;
            if (v1 >> arg1 == arg0) {
                0x1::option::some<u128>(v1)
            } else {
                0x1::option::none<u128>()
            }
        }
    }

    public fun lossless_shr(arg0: u128, arg1: u8) : 0x1::option::Option<u128> {
        if (arg1 >= 128) {
            0x1::option::none<u128>()
        } else {
            let v1 = arg0 >> arg1;
            if (v1 << arg1 == arg0) {
                0x1::option::some<u128>(v1)
            } else {
                0x1::option::none<u128>()
            }
        }
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun pow(arg0: u128, arg1: u8) : u128 {
        let v0 = arg0;
        let v1 = arg1;
        let v2 = 1;
        while (v1 >= 1) {
            if (v1 % 2 == 0) {
                v0 = v0 * v0;
                v1 = v1 / 2;
                continue
            };
            v2 = v2 * v0;
            v1 = v1 - 1;
        };
        v2
    }

    public fun saturating_add(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455;
        if (arg1 > v0 - arg0) {
            v0
        } else {
            arg0 + arg1
        }
    }

    public fun saturating_mul(arg0: u128, arg1: u128) : u128 {
        let v0 = 340282366920938463463374607431768211455;
        if (arg0 == 0 || arg1 == 0) {
            0
        } else if (arg1 > v0 / arg0) {
            v0
        } else {
            arg0 * arg1
        }
    }

    public fun saturating_sub(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun sqrt(arg0: u128) : u128 {
        let v0 = 340282366920938463463374607431768211456;
        let v1 = 0;
        let v2 = (arg0 as u256);
        while (v0 != 0) {
            if (v2 >= v1 + v0) {
                v2 = v2 - v1 + v0;
                let v3 = v1 >> 1;
                v1 = v3 + v0;
            } else {
                v1 = v1 >> 1;
            };
            v0 = v0 >> 2;
        };
        (v1 as u128)
    }

    public fun to_string(arg0: u128) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"0")
        } else {
            let v1 = b"";
            while (arg0 != 0) {
                0x1::vector::push_back<u8>(&mut v1, ((48 + arg0 % 10) as u8));
                arg0 = arg0 / 10;
            };
            0x1::vector::reverse<u8>(&mut v1);
            0x1::string::utf8(v1)
        }
    }

    public fun try_as_u16(arg0: u128) : 0x1::option::Option<u16> {
        if (arg0 > 65535) {
            0x1::option::none<u16>()
        } else {
            0x1::option::some<u16>((arg0 as u16))
        }
    }

    public fun try_as_u32(arg0: u128) : 0x1::option::Option<u32> {
        if (arg0 > 4294967295) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>((arg0 as u32))
        }
    }

    public fun try_as_u64(arg0: u128) : 0x1::option::Option<u64> {
        if (arg0 > 18446744073709551615) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>((arg0 as u64))
        }
    }

    public fun try_as_u8(arg0: u128) : 0x1::option::Option<u8> {
        if (arg0 > 255) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>((arg0 as u8))
        }
    }

    // decompiled from Move bytecode v6
}

