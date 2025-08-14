module 0xf9b2cbfcb04ca350641a857d82161e16948ad30c17dc777776dff7253b0ae510::utils {
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
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = 340282366920938463463374607431768211455;
        if (arg0 > v0 / arg1) {
            v0
        } else {
            arg0 * arg1
        }
    }

    public fun percentage_of(arg0: u128, arg1: u64) : u128 {
        div(mul(arg0, from_u64(arg1)), from_u64(10000))
    }

    public fun percentage_of_round_up(arg0: u128, arg1: u64) : u128 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = mul(arg0, from_u64(arg1));
        let v1 = from_u64(10000);
        let v2 = div(v0, v1);
        if (v0 - mul(v2, v1) > 0) {
            v2 + 1
        } else {
            v2
        }
    }

    public fun pow(arg0: u128, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 1
        };
        if (arg0 == 0) {
            return 0
        };
        if (arg0 == 1) {
            return 1
        };
        let v0 = 1;
        let v1 = arg0;
        let v2 = arg1;
        let v3 = 340282366920938463463374607431768211455;
        while (v2 > 0) {
            if (v2 & 1 == 1) {
                let v4 = mul(v0, v1);
                v0 = v4;
                if (v4 == v3) {
                    return v3
                };
            };
            v2 = v2 >> 1;
            if (v2 > 0) {
                v1 = mul(v1, v1);
                if (v1 == v3) {
                    return v3
                };
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

