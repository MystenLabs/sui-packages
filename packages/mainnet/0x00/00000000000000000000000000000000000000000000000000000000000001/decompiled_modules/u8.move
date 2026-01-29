module 0x1::u8 {
    public fun bitwise_not(arg0: u8) : u8 {
        arg0 ^ 255
    }

    public fun checked_add(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        if (arg1 > 255 - arg0) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(arg0 + arg1)
        }
    }

    public fun checked_div(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        if (arg1 == 0) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(arg0 / arg1)
        }
    }

    public fun checked_mul(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        if (arg0 == 0 || arg1 == 0) {
            0x1::option::some<u8>(0)
        } else if (arg1 > 255 / arg0) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(arg0 * arg1)
        }
    }

    public fun checked_sub(arg0: u8, arg1: u8) : 0x1::option::Option<u8> {
        if (arg0 < arg1) {
            0x1::option::none<u8>()
        } else {
            0x1::option::some<u8>(arg0 - arg1)
        }
    }

    public fun diff(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun divide_and_round_up(arg0: u8, arg1: u8) : u8 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public fun max(arg0: u8, arg1: u8) : u8 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u8, arg1: u8) : u8 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun pow(arg0: u8, arg1: u8) : u8 {
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

    public fun sqrt(arg0: u8) : u8 {
        let v0 = 256;
        let v1 = 0;
        let v2 = (arg0 as u16);
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
        (v1 as u8)
    }

    public fun to_string(arg0: u8) : 0x1::string::String {
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

    // decompiled from Move bytecode v6
}

