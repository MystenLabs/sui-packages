module 0x45f640e334de1900cefeed1bbea057b70754014d58a58a63acd1a920883375::imat {
    fun condense(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64, arg3: u64, arg4: 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) : vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256> {
        let v0 = arg2 - 1;
        let v1 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v2 = 0;
        while (v2 < (arg1 - 1) * v0) {
            let v3 = v2 / v0;
            let v4 = v2 % v0;
            let v5 = if (v3 + 1 == arg3) {
                0
            } else {
                v3 + 1
            };
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v1, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::div_trunc(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::sub(0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(*0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, arg3 * arg2), *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v5 * arg2 + v4 + 1)), 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(*0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v5 * arg2), *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, arg3 * arg2 + v4 + 1))), arg4));
            v2 = v2 + 1;
        };
        v1
    }

    public fun det(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0) == arg1 * arg1, 1);
        if (arg1 == 0) {
            return 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1)
        };
        let v0 = *arg0;
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1);
        let v2 = false;
        let v3 = false;
        let v4 = 0;
        while (v4 < arg1 - 1) {
            if (!v3) {
                let v5 = find_pivot(&v0, arg1, arg1);
                if (v5 == arg1) {
                    v3 = true;
                } else {
                    v1 = *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&v0, v5 * arg1);
                    let v6 = &v0;
                    v0 = condense(v6, arg1, arg1, v5, v1);
                    if (v5 != 0) {
                        v2 = !v2;
                    };
                    arg1 = arg1 - 1;
                };
            };
            v4 = v4 + 1;
        };
        if (v3) {
            return 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
        };
        if (v2) {
            0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::neg(*0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&v0, 0))
        } else {
            *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&v0, 0)
        }
    }

    public fun dot(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0);
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg1) == v0, 1);
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero();
        let v2 = 0;
        while (v2 < v0) {
            v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(v1, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(*0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v2), *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg1, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    fun drop_col(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64) : vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256> {
        let v0 = arg2 - 1;
        let v1 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v2 = 0;
        while (v2 < arg1 * v0) {
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v1, *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v2 / v0 * arg2 + v2 % v0 + 1));
            v2 = v2 + 1;
        };
        v1
    }

    fun find_pivot(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0;
        while (v0 < arg1) {
            if (arg1 == arg1) {
            };
            v0 = v0 + 1;
        };
        arg1
    }

    public fun inverse(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64) : (vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) {
        let v0 = det(arg0, arg1);
        assert!(!0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::eq(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()), 2);
        let v1 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v2 = 0;
        while (v2 < arg1 * arg1) {
            let v3 = replace_row_unit(arg0, arg1, v2 % arg1, v2 / arg1);
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v1, det(&v3, arg1));
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    public fun matmul(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg2: u64, arg3: u64, arg4: u64) : vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256> {
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0) == arg2 * arg3, 1);
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg1) == arg3 * arg4, 1);
        let v0 = arg2 * arg4;
        assert!(v0 <= 262144, 3);
        let v1 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v1, row_col(arg0, arg1, v2 / arg4, v2 % arg4, arg3, arg4));
            v2 = v2 + 1;
        };
        v1
    }

    public fun rank(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64) : u64 {
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0) == arg1 * arg2, 1);
        let v0 = *arg0;
        let v1 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < arg2) {
            if (arg1 != 0) {
                let v4 = find_pivot(&v0, arg1, arg2);
                if (v4 == arg1) {
                    let v5 = &v0;
                    v0 = drop_col(v5, arg1, arg2);
                } else {
                    v1 = *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&v0, v4 * arg2);
                    let v6 = &v0;
                    v0 = condense(v6, arg1, arg2, v4, v1);
                    arg1 = arg1 - 1;
                    v2 = v2 + 1;
                };
                arg2 = arg2 - 1;
            };
            v3 = v3 + 1;
        };
        v2
    }

    fun replace_col(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64, arg3: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>) : vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256> {
        let v0 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v1 = 0;
        while (v1 < arg1 * arg1) {
            let v2 = if (v1 % arg1 == arg2) {
                *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg3, v1 / arg1)
            } else {
                *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v1)
            };
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun replace_row_unit(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64, arg3: u64) : vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256> {
        let v0 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v1 = 0;
        while (v1 < arg1 * arg1) {
            let v2 = if (v1 / arg1 == arg2) {
                if (v1 % arg1 == arg3) {
                    0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::from_bits(1)
                } else {
                    0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()
                }
            } else {
                *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v1)
            };
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun row_col(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256 {
        let v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero();
        let v1 = 0;
        while (v1 < arg4) {
            v0 = 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::add(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::mul(*0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, arg2 * arg4 + v1), *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg1, v1 * arg5 + arg3)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun solve(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg2: u64) : (vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256) {
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg1) == arg2, 1);
        let v0 = det(arg0, arg2);
        assert!(!0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::eq(v0, 0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::zero()), 2);
        let v1 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v2 = 0;
        while (v2 < arg2) {
            let v3 = replace_col(arg0, arg2, v2, arg1);
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v1, det(&v3, arg2));
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    public fun transpose(arg0: &vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>, arg1: u64, arg2: u64) : vector<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256> {
        assert!(0x1::vector::length<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0) == arg1 * arg2, 1);
        let v0 = 0x1::vector::empty<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>();
        let v1 = 0;
        while (v1 < arg2 * arg1) {
            0x1::vector::push_back<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(&mut v0, *0x1::vector::borrow<0xa4029d0dabd86cd3f9050b0e2d6ac32cdbc9098c134c46c6ba7f40765b4b5afb::i256::I256>(arg0, v1 % arg1 * arg2 + v1 / arg1));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

