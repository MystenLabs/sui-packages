module 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::math {
    public fun bytes_to_u256(arg0: &vector<u8>) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun err_invalid_bls_signature() {
        abort 0
    }

    fun get_result(arg0: &mut vector<u8>, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = 0x2::vec_set::empty<u64>();
        let v1 = 0;
        while (0x2::vec_set::size<u64>(&v0) < arg2) {
            0x1::vector::push_back<u8>(arg0, v1);
            let v2 = 0x2::hash::blake2b256(arg0);
            let v3 = ((bytes_to_u256(&v2) % (arg1 as u256)) as u64);
            if (!0x2::vec_set::contains<u64>(&v0, &v3)) {
                0x2::vec_set::insert<u64>(&mut v0, v3);
            };
            0x1::vector::pop_back<u8>(arg0);
            if (v1 == 255) {
                break
            };
            v1 = v1 + 1;
        };
        0x2::vec_set::into_keys<u64>(v0)
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_and_div_u128(arg0: u64, arg1: u128, arg2: u128) : u64 {
        (((arg0 as u128) * arg1 / arg2) as u64)
    }

    public fun verify_bls_sig_and_give_results(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: u64) : vector<u64> {
        if (!0x2::bls12381::bls12381_min_pk_verify(arg0, arg1, arg2)) {
            err_invalid_bls_signature();
        };
        get_result(arg0, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

