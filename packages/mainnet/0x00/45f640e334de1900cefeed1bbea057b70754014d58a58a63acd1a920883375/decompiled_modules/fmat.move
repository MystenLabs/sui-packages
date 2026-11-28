module 0x45f640e334de1900cefeed1bbea057b70754014d58a58a63acd1a920883375::fmat {
    public fun dot_down(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(dot_raw(arg0, arg1), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000)))
    }

    fun dot_raw(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0);
        assert!(0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg1) == v0, 1);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero();
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(v1, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(*0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0, v2)), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(*0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg1, v2))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun dot_up(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>) : 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18 {
        0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_ceil(dot_raw(arg0, arg1), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000)))
    }

    public fun matmul_down(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg2: u64, arg3: u64, arg4: u64) : vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18> {
        matmul_r(arg0, arg1, arg2, arg3, arg4, false)
    }

    fun matmul_r(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18> {
        assert!(0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0) == arg2 * arg3, 1);
        assert!(0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg1) == arg3 * arg4, 1);
        let v0 = arg2 * arg4;
        assert!(v0 <= 262144, 3);
        let v1 = 0x1::vector::empty<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = if (arg5) {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_ceil(row_col_raw(arg0, arg1, v2 / arg4, v2 % arg4, arg3, arg4), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))
            } else {
                0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_floor(row_col_raw(arg0, arg1, v2 / arg4, v2 % arg4, arg3, arg4), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1000000000000000000))
            };
            0x1::vector::push_back<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(&mut v1, 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::wrap(v3));
            v2 = v2 + 1;
        };
        v1
    }

    public fun matmul_up(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg2: u64, arg3: u64, arg4: u64) : vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18> {
        matmul_r(arg0, arg1, arg2, arg3, arg4, true)
    }

    fun row_col_raw(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero();
        let v1 = 0;
        while (v1 < arg4) {
            v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(*0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0, arg2 * arg4 + v1)), 0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::unwrap(*0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg1, v1 * arg5 + arg3))));
            v1 = v1 + 1;
        };
        v0
    }

    public fun transpose(arg0: &vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>, arg1: u64, arg2: u64) : vector<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18> {
        assert!(0x1::vector::length<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0) == arg1 * arg2, 1);
        let v0 = 0x1::vector::empty<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>();
        let v1 = 0;
        while (v1 < arg2 * arg1) {
            0x1::vector::push_back<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(&mut v0, *0x1::vector::borrow<0x723d0b53c1303f490de96eb95b133023ed5b73a0f23351d1484b72f4a1d959bd::sd18::SD18>(arg0, v1 % arg1 * arg2 + v1 / arg1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

