module 0x6cdfdda6e0db3fff92aaa6f4cffd0be145422f94344d204b8f0e72cca4e51864::PasswordGen {
    struct XorShift64 has drop {
        state: u64,
    }

    public fun build_charset(arg0: bool, arg1: bool, arg2: bool, arg3: bool, arg4: bool) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0) {
            let v1 = b"abcdefghijklmnopqrstuvwxyz";
            let v2 = 0;
            while (v2 < 0x1::vector::length<u8>(&v1)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v1, v2));
                v2 = v2 + 1;
            };
        };
        if (arg1) {
            let v3 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(&v3)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v3, v4));
                v4 = v4 + 1;
            };
        };
        if (arg2) {
            let v5 = b"0123456789";
            let v6 = 0;
            while (v6 < 0x1::vector::length<u8>(&v5)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v5, v6));
                v6 = v6 + 1;
            };
        };
        if (arg3) {
            let v7 = b"!#$%&()*+,-./:;<=>?@[]^_{|}~";
            let v8 = 0;
            while (v8 < 0x1::vector::length<u8>(&v7)) {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v7, v8));
                v8 = v8 + 1;
            };
        };
        if (arg4) {
            let v10 = b"0OIl1";
            let v11 = 0x1::vector::empty<u8>();
            let v12 = 0;
            while (v12 < 0x1::vector::length<u8>(&v0)) {
                let v13 = *0x1::vector::borrow<u8>(&v0, v12);
                if (!contains_byte(&v10, v13)) {
                    0x1::vector::push_back<u8>(&mut v11, v13);
                };
                v12 = v12 + 1;
            };
            v11
        } else {
            v0
        }
    }

    fun contains_byte(arg0: &vector<u8>, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun demo_example() : vector<u8> {
        let v0 = init_prng(305419896);
        let v1 = build_charset(true, true, true, true, true);
        let v2 = &mut v0;
        generate_password(v2, 16, &v1)
    }

    public fun generate_password(arg0: &mut XorShift64, arg1: u64, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(arg2);
        assert!(v0 > 0, 1);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg2, next_bounded(arg0, v0)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun generate_with_policy(arg0: &mut XorShift64, arg1: u64) : vector<u8> {
        assert!(arg1 >= 4, 2);
        let v0 = b"abcdefghijklmnopqrstuvwxyz";
        let v1 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        let v2 = b"0123456789";
        let v3 = b"!#$%&()*+,-./:;<=>?@[]^_{|}~";
        let v4 = 0x1::vector::empty<u8>();
        let v5 = next_bounded(arg0, 0x1::vector::length<u8>(&v0));
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, v5));
        let v6 = next_bounded(arg0, 0x1::vector::length<u8>(&v1));
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v1, v6));
        let v7 = next_bounded(arg0, 0x1::vector::length<u8>(&v2));
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v2, v7));
        let v8 = next_bounded(arg0, 0x1::vector::length<u8>(&v3));
        0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, v8));
        let v9 = build_charset(true, true, true, true, false);
        let v10 = arg1 - 4;
        while (v10 > 0) {
            let v11 = next_bounded(arg0, 0x1::vector::length<u8>(&v9));
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v9, v11));
            v10 = v10 - 1;
        };
        let v12 = 0x1::vector::length<u8>(&v4);
        while (v12 > 1) {
            0x1::vector::swap<u8>(&mut v4, v12 - 1, next_u64(arg0) % v12);
            v12 = v12 - 1;
        };
        v4
    }

    public fun init_prng(arg0: u64) : XorShift64 {
        let v0 = if (arg0 == 0) {
            11400714819323198485
        } else {
            arg0
        };
        XorShift64{state: v0}
    }

    fun next_bounded(arg0: &mut XorShift64, arg1: u64) : u64 {
        next_u64(arg0) % arg1
    }

    public fun next_u64(arg0: &mut XorShift64) : u64 {
        let v0 = arg0.state;
        let v1 = v0 ^ v0 << 13;
        let v2 = v1 ^ v1 >> 7;
        let v3 = v2 ^ v2 << 17;
        arg0.state = v3;
        v3
    }

    // decompiled from Move bytecode v6
}

