module 0x683c1e2781609b7c8211ccb26296c474ede83f3f0dd019a1e840a7bb8b85b44::value {
    struct Signed has copy, drop {
        abs: u64,
        neg: bool,
    }

    public fun basket(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 + arg2
    }

    public fun equity(arg0: u64, arg1: Signed, arg2: Signed) : u64 {
        let v0 = (arg0 as u128);
        let v1 = v0;
        let v2 = 0;
        let v3 = v2;
        if (arg1.neg) {
            v3 = v2 + (arg1.abs as u128);
        } else {
            v1 = v0 + (arg1.abs as u128);
        };
        if (arg2.neg) {
            v3 = v3 + (arg2.abs as u128);
        } else {
            v1 = v1 + (arg2.abs as u128);
        };
        if (v3 >= v1) {
            0
        } else {
            ((v1 - v3) as u64)
        }
    }

    public fun signed(arg0: u64, arg1: bool) : Signed {
        let v0 = arg1 && arg0 > 0;
        Signed{
            abs : arg0,
            neg : v0,
        }
    }

    // decompiled from Move bytecode v7
}

