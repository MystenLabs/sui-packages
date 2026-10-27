module 0xf2edf5fef246601ef8b1ed10c03b8dd9c46a5c2d1d49c78890ad6f65a376974a::mood {
    public(friend) fun accepts(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg0 == 0 || arg2 >= arg1 + 86400000) {
            return true
        };
        let v0 = if (arg3 > arg0) {
            arg3 - arg0
        } else {
            arg0 - arg3
        };
        (v0 as u128) * 10000 <= (2000 as u128) * (arg0 as u128)
    }

    public(friend) fun change_bps(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = arg1 > arg0;
        let v1 = if (v0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        let v2 = (v1 as u128) * 10000 / (arg0 as u128);
        let v3 = if (v2 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v2 as u64)
        };
        (v0, v3)
    }

    public(friend) fun codepoint(arg0: u8) : vector<u8> {
        if (arg0 == 4) {
            b"1f929"
        } else if (arg0 == 3) {
            b"1f642"
        } else if (arg0 == 1) {
            b"1f641"
        } else if (arg0 == 0) {
            b"1f62d"
        } else {
            b"1f610"
        }
    }

    public(friend) fun emoji(arg0: u8) : vector<u8> {
        if (arg0 == 4) {
            x"f09fa4a9"
        } else if (arg0 == 3) {
            x"f09f9982"
        } else if (arg0 == 1) {
            x"f09f9981"
        } else if (arg0 == 0) {
            x"f09f98ad"
        } else {
            x"f09f9890"
        }
    }

    public(friend) fun label(arg0: u8) : vector<u8> {
        if (arg0 == 4) {
            b"ecstatic"
        } else if (arg0 == 3) {
            b"happy"
        } else if (arg0 == 1) {
            b"sad"
        } else if (arg0 == 0) {
            b"devastated"
        } else {
            b"neutral"
        }
    }

    public(friend) fun level(arg0: bool, arg1: u64) : u8 {
        if (arg1 >= 50) {
            if (arg0) {
                4
            } else {
                0
            }
        } else if (arg1 >= 10) {
            if (arg0) {
                3
            } else {
                1
            }
        } else {
            2
        }
    }

    public(friend) fun neutral() : u8 {
        2
    }

    public(friend) fun parse_price(arg0: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = false;
        let v5 = false;
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<u8>(arg0, v6);
            if (v7 == 46) {
                if (v4) {
                    return 0
                };
                v4 = true;
            } else if (v7 >= 48 && v7 <= 57) {
                v5 = true;
                if (!v4) {
                    let v8 = v1 * 10 + ((v7 - 48) as u128);
                    v1 = v8;
                    if (v8 > 18446744073709551615) {
                        return 0
                    };
                } else if (v3 < 8) {
                    let v9 = v2 * 10;
                    v2 = v9 + ((v7 - 48) as u128);
                    v3 = v3 + 1;
                };
            } else {
                return 0
            };
            v6 = v6 + 1;
        };
        if (!v5) {
            return 0
        };
        while (v3 < 8) {
            v2 = v2 * 10;
            v3 = v3 + 1;
        };
        let v10 = v1 * 100000000 + v2;
        if (v10 > 18446744073709551615) {
            return 0
        };
        (v10 as u64)
    }

    // decompiled from Move bytecode v7
}

