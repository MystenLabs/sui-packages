module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed {
    struct Fixed has copy, drop, store {
        negative: bool,
        magnitude: u128,
    }

    public fun add(arg0: Fixed, arg1: Fixed) : Fixed {
        if (arg0.negative == arg1.negative) {
            raw(arg0.negative, arg0.magnitude + arg1.magnitude)
        } else if (arg0.magnitude >= arg1.magnitude) {
            raw(arg0.negative, arg0.magnitude - arg1.magnitude)
        } else {
            raw(arg1.negative, arg1.magnitude - arg0.magnitude)
        }
    }

    public fun greater(arg0: Fixed, arg1: Fixed) : bool {
        arg0.negative != arg1.negative && !arg0.negative || arg0.negative && arg0.magnitude < arg1.magnitude || arg0.magnitude > arg1.magnitude
    }

    public fun magnitude(arg0: Fixed) : u128 {
        arg0.magnitude
    }

    public fun neg(arg0: Fixed) : Fixed {
        raw(!arg0.negative, arg0.magnitude)
    }

    public fun negative(arg0: Fixed) : bool {
        arg0.negative
    }

    public fun pack(arg0: Fixed) : u64 {
        let v0 = if (arg0.negative) {
            9223372036854775808
        } else {
            0
        };
        (arg0.magnitude as u64) + v0
    }

    public fun ratio(arg0: Fixed, arg1: u128, arg2: u128) : Fixed {
        assert!(arg2 != 0, 1);
        raw(arg0.negative, arg0.magnitude * arg1 / arg2)
    }

    public fun raw(arg0: bool, arg1: u128) : Fixed {
        assert!(arg1 <= 281474976710655, 0);
        let v0 = arg0 && arg1 != 0;
        Fixed{
            negative  : v0,
            magnitude : arg1,
        }
    }

    public fun sub(arg0: Fixed, arg1: Fixed) : Fixed {
        add(arg0, neg(arg1))
    }

    public fun unpack(arg0: u64) : Fixed {
        if (arg0 >= 9223372036854775808) {
            raw(true, ((arg0 - 9223372036854775808) as u128))
        } else {
            raw(false, (arg0 as u128))
        }
    }

    public fun zero() : Fixed {
        raw(false, 0)
    }

    // decompiled from Move bytecode v7
}

