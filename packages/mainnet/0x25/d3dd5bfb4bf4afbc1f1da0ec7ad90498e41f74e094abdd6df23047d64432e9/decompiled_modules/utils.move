module 0x25d3dd5bfb4bf4afbc1f1da0ec7ad90498e41f74e094abdd6df23047d64432e9::utils {
    public fun add_growth(arg0: u64, arg1: u64) : u64 {
        clamp(arg0 + arg1, 0, 100)
    }

    public fun clamp(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 < arg1) {
            arg1
        } else if (arg0 > arg2) {
            arg2
        } else {
            arg0
        }
    }

    public fun clone_vec_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun contains_u8(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun eq_str(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) != 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun miss(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u64) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64(&mut v0) % 100 < arg2
    }

    public fun rand_inclusive(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u64, arg3: u64) : u64 {
        if (arg3 <= arg2) {
            return arg2
        };
        let v0 = 0x2::random::new_generator(arg0, arg1);
        arg2 + 0x2::random::generate_u64(&mut v0) % (arg3 - arg2 + 1)
    }

    public fun sub_growth(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

