module 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils {
    public fun calculate_power(arg0: u128, arg1: u16) : u256 {
        let v0 = 1;
        let v1 = (arg0 as u256);
        assert!(v1 | (arg1 as u256) != 0, 1);
        if (v1 == 0) {
            return 0
        };
        while (arg1 != 0) {
            if (arg1 & 1 == 1) {
                v0 = v0 * v1;
            };
            v1 = v1 * v1;
            arg1 = arg1 >> 1;
        };
        v0
    }

    public fun compare_vector_greater_than(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) != 0, 3);
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<u8>(arg1), 2);
        let v0 = 0;
        let v1 = 0;
        loop {
            let v2 = *0x1::vector::borrow<u8>(arg0, v0);
            let v3 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v2 > v3) {
                v1 = 1;
                break
            };
            if (v2 < v3) {
                v1 = 2;
                break
            };
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<u8>(arg0)) {
                break
            };
        };
        v1
    }

    public fun destroy<T0: drop>(arg0: vector<T0>) {
        let v0 = 0x1::vector::length<T0>(&arg0);
        while (v0 > 0) {
            0x1::vector::pop_back<T0>(&mut arg0);
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
    }

    public fun destructive_reverse_append<T0: drop>(arg0: &mut vector<T0>, arg1: vector<T0>) {
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            0x1::vector::push_back<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1));
        };
    }

    public fun ensure_multileaf_merkle_proof_lengths<T0: drop>(arg0: vector<vector<u8>>, arg1: vector<bool>, arg2: vector<T0>) {
        assert!(0x1::vector::length<T0>(&arg2) + 0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<bool>(&arg1) + 1, 5);
    }

    public fun is_valid_multileaf_merkle_proof(arg0: vector<vector<u8>>, arg1: vector<bool>, arg2: vector<vector<u8>>, arg3: vector<u8>) : bool {
        ensure_multileaf_merkle_proof_lengths<vector<u8>>(arg0, arg1, arg2);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = vector[];
        let v4 = 0x1::vector::length<vector<u8>>(&arg2);
        let v5 = 0;
        while (v5 < 0x1::vector::length<bool>(&arg1)) {
            let v6 = if (v0 < v4) {
                let v7 = &mut v0;
                next_element<vector<u8>>(v7, &arg2)
            } else {
                let v8 = &mut v1;
                next_element<vector<u8>>(v8, &v3)
            };
            let v9 = v6;
            let v10 = if (*0x1::vector::borrow<bool>(&arg1, v5)) {
                if (v0 < v4) {
                    let v11 = &mut v0;
                    next_element<vector<u8>>(v11, &arg2)
                } else {
                    let v12 = &mut v1;
                    next_element<vector<u8>>(v12, &v3)
                }
            } else {
                let v13 = &mut v2;
                next_element<vector<u8>>(v13, &arg0)
            };
            let v14 = v10;
            let v15 = if (compare_vector_greater_than(&v9, &v14) == 1) {
                0x1::vector::append<u8>(&mut v14, v9);
                0x2::hash::keccak256(&v14)
            } else {
                0x1::vector::append<u8>(&mut v9, v14);
                0x2::hash::keccak256(&v9)
            };
            0x1::vector::push_back<vector<u8>>(&mut v3, v15);
            v5 = v5 + 1;
        };
        let v16 = if (0x1::vector::length<bool>(&arg1) > 0) {
            assert!(v2 == 0x1::vector::length<vector<u8>>(&arg0), 5);
            0x1::vector::pop_back<vector<u8>>(&mut v3)
        } else if (v4 > 0) {
            *0x1::vector::borrow<vector<u8>>(&arg2, 0)
        } else {
            *0x1::vector::borrow<vector<u8>>(&arg0, 0)
        };
        arg3 == v16
    }

    fun next_element<T0: copy>(arg0: &mut u64, arg1: &vector<T0>) : T0 {
        assert!(0x1::vector::length<T0>(arg1) > *arg0, 4);
        *arg0 = *arg0 + 1;
        *0x1::vector::borrow<T0>(arg1, *arg0)
    }

    public fun trim<T0>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = trim_reverse<T0>(arg0, arg1);
        0x1::vector::reverse<T0>(&mut v0);
        v0
    }

    public fun trim_reverse<T0>(arg0: &mut vector<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::length<T0>(arg0);
        assert!(arg1 <= v0, 4);
        let v1 = 0x1::vector::empty<T0>();
        while (arg1 < v0) {
            0x1::vector::push_back<T0>(&mut v1, 0x1::vector::pop_back<T0>(arg0));
            v0 = v0 - 1;
        };
        v1
    }

    public fun vector_flatten_concat<T0: copy + drop>(arg0: &mut vector<T0>, arg1: vector<vector<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<T0>>(&arg1)) {
            0x1::vector::append<T0>(arg0, *0x1::vector::borrow<vector<T0>>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun verify_merkle_tree(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(&arg1, v0);
            let v2 = if (compare_vector_greater_than(&arg0, &v1) < 2) {
                0x1::vector::append<u8>(&mut v1, arg0);
                0x2::hash::keccak256(&v1)
            } else {
                0x1::vector::append<u8>(&mut arg0, v1);
                0x2::hash::keccak256(&arg0)
            };
            arg0 = v2;
            v0 = v0 + 1;
        };
        arg0 == arg2
    }

    // decompiled from Move bytecode v6
}

