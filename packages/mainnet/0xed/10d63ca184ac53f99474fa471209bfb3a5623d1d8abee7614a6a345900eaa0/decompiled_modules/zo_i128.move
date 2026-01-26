module 0xed10d63ca184ac53f99474fa471209bfb3a5623d1d8abee7614a6a345900eaa0::zo_i128 {
    struct I128 has copy, drop, store {
        negative: bool,
        magnitude: u128,
    }

    public fun from_u128(arg0: u128) : I128 {
        if (!(arg0 >> 127 == 1)) {
            new(arg0, false)
        } else {
            new((arg0 ^ 340282366920938463463374607431768211455) + 1, true)
        }
    }

    public fun get_magnitude(arg0: &I128) : u128 {
        arg0.magnitude
    }

    public fun get_magnitude_if_negative(arg0: &I128) : u128 {
        assert!(is_negative(arg0), 1);
        arg0.magnitude
    }

    public fun get_magnitude_if_positive(arg0: &I128) : u128 {
        assert!(!is_negative(arg0), 1);
        arg0.magnitude
    }

    public fun is_negative(arg0: &I128) : bool {
        arg0.negative
    }

    public fun new(arg0: u128, arg1: bool) : I128 {
        let v0 = arg1;
        if (!arg1) {
            assert!(arg0 <= 170141183460469231731687303715884105727, 0);
        } else {
            assert!(arg0 <= 170141183460469231731687303715884105728, 0);
        };
        if (arg0 == 0) {
            v0 = false;
        };
        I128{
            negative  : v0,
            magnitude : arg0,
        }
    }

    public fun to_bytes(arg0: I128) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = if (arg0.negative) {
            arg0.magnitude - 1 ^ 340282366920938463463374607431768211455
        } else {
            arg0.magnitude
        };
        let v2 = if (arg0.negative) {
            255
        } else {
            0
        };
        let v3 = 32;
        while (v3 > 0) {
            v3 = v3 - 1;
            let v4 = if (v3 >= 16) {
                v2
            } else {
                ((v1 >> v3 * 8 & 255) as u8)
            };
            0x1::vector::push_back<u8>(&mut v0, v4);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

