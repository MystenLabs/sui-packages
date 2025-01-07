module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math {
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

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun mul_and_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_and_div_u128(arg0: u64, arg1: u128, arg2: u128) : u64 {
        (((arg0 as u128) * arg1 / arg2) as u64)
    }

    public fun verify_bls_sig_and_give_result(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64) : u64 {
        assert!(0x2::bls12381::bls12381_min_pk_verify(arg0, arg1, arg2), 0);
        let v0 = 0x2::hash::blake2b256(arg0);
        ((bytes_to_u256(&v0) % (arg3 as u256)) as u64)
    }

    // decompiled from Move bytecode v6
}

