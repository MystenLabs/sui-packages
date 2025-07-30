module 0x618d83d967ddbc15119cc225211932943272a42c22cc9cdca42969176bf251f3::utils {
    public fun add(arg0: u128, arg1: u128) : u128 {
        arg0 + arg1
    }

    public fun as_u64(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    public fun ascii_to_string(arg0: &0x1::ascii::String) : 0x1::string::String {
        0x1::string::utf8(*0x1::ascii::as_bytes(arg0))
    }

    public fun div(arg0: u128, arg1: u128) : u128 {
        if (arg1 == 0) {
            return 0
        };
        arg0 / arg1
    }

    public fun from_u64(arg0: u64) : u128 {
        (arg0 as u128)
    }

    public fun is_safe_u64(arg0: u64) : bool {
        arg0 <= 9223372036854775807
    }

    public fun mul(arg0: u128, arg1: u128) : u128 {
        arg0 * arg1
    }

    public fun percentage_of(arg0: u128, arg1: u64) : u128 {
        div(mul(arg0, from_u64(arg1)), from_u64(10000))
    }

    public fun pow(arg0: u128, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 1
        };
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

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        let v1 = 1 << (v0 >> 1) + 1;
        while (v1 != 0) {
            let v2 = v1 + div(arg0, v1);
            v1 = v2 >> 1;
        };
        v1
    }

    public fun sub(arg0: u128, arg1: u128) : u128 {
        if (arg1 > arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    // decompiled from Move bytecode v6
}

