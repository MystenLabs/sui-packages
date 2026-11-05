module 0xbe8ac9546c443fac1d74c14e884e8229534bb1a7303e1c8698c450db30fe0a18::size {
    struct Sizer {
        floor: u64,
        max: u64,
        found: bool,
        best_x: u64,
        best_out: u64,
    }

    public fun around(arg0: &Sizer, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        assert!(arg3 > 0 && arg2 > arg3, 2);
        let v0 = if (arg0.found) {
            arg0.best_x
        } else {
            arg1
        };
        let v1 = (v0 as u128) * (arg2 as u128) / (arg3 as u128);
        let v2 = if (v1 > (arg0.max as u128)) {
            arg0.max
        } else {
            (v1 as u64)
        };
        ((((v0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64), v2)
    }

    public fun at_least_one(arg0: u64) : u64 {
        if (arg0 == 0) {
            1
        } else {
            arg0
        }
    }

    fun le_at(arg0: &vector<u8>, arg1: u64, arg2: u64) : u128 {
        assert!(arg2 >= 1 && arg2 <= 16, 4);
        assert!((arg1 as u128) + (arg2 as u128) <= (0x1::vector::length<u8>(arg0) as u128), 3);
        let v0 = 0;
        while (arg2 > 0) {
            let v1 = arg2 - 1;
            arg2 = v1;
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u128);
        };
        v0
    }

    public fun new(arg0: u64, arg1: u64) : Sizer {
        Sizer{
            floor    : arg0,
            max      : arg1,
            found    : false,
            best_x   : 0,
            best_out : 0,
        }
    }

    public fun nonzero(arg0: u64) : bool {
        arg0 != 0
    }

    public fun nonzero_at(arg0: &vector<u8>, arg1: u64, arg2: u64) : bool {
        le_at(arg0, arg1, arg2) != 0
    }

    public fun pick(arg0: Sizer) : u64 {
        let Sizer {
            floor    : v0,
            max      : _,
            found    : v2,
            best_x   : v3,
            best_out : v4,
        } = arg0;
        assert!(v2 && (v4 as u128) >= (v3 as u128) + (v0 as u128), 1);
        v3
    }

    public fun probe(arg0: &mut Sizer, arg1: u64, arg2: u64, arg3: vector<bool>) {
        let v0 = if (arg1 == 0) {
            true
        } else if (arg1 > arg0.max) {
            true
        } else {
            let v1 = true;
            0x1::vector::contains<bool>(&arg3, &v1)
        };
        if (v0) {
            return
        };
        if (!arg0.found || (arg2 as u128) + (arg0.best_x as u128) > (arg0.best_out as u128) + (arg1 as u128)) {
            arg0.found = true;
            arg0.best_x = arg1;
            arg0.best_out = arg2;
        };
    }

    public fun to_u128(arg0: u64) : u128 {
        (arg0 as u128)
    }

    public fun u64_at(arg0: &vector<u8>, arg1: u64, arg2: u64) : u64 {
        let v0 = le_at(arg0, arg1, arg2);
        assert!(v0 <= 18446744073709551615, 5);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

