module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::hash {
    struct Hasher has copy, drop {
        buffer: vector<u8>,
    }

    public fun check_subvec(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) : bool {
        if (0x1::vector::length<u8>(arg0) < arg2 + 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0x1::vector::length<u8>(arg1);
        while (v0 > 0) {
            let v1 = v0 - 1;
            if (*0x1::vector::borrow<u8>(arg0, arg2 + v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v0 = v0 - 1;
        };
        true
    }

    public fun finalize(arg0: &Hasher) : vector<u8> {
        0x1::hash::sha2_256(arg0.buffer)
    }

    public fun generate_attestation_msg(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64) : vector<u8> {
        let v0 = new();
        assert!(0x1::vector::length<u8>(&arg0) == 32, 9223372642445295619);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 9223372646740525063);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9223372651035623433);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 9223372655330328581);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 9223372659625689099);
        let v1 = &mut v0;
        push_bytes(v1, arg0);
        let v2 = &mut v0;
        push_bytes(v2, arg1);
        let v3 = &mut v0;
        push_bytes(v3, arg2);
        let v4 = &mut v0;
        push_bytes(v4, arg3);
        let v5 = &mut v0;
        push_bytes(v5, arg4);
        let v6 = &mut v0;
        push_u64_le(v6, arg5);
        let Hasher { buffer: v7 } = v0;
        v7
    }

    public fun generate_update_msg(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: u64) : vector<u8> {
        let v0 = new();
        assert!(0x1::vector::length<u8>(&arg1) == 32, 9223372543661309959);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 9223372547955884033);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 9223372552251113477);
        let v1 = &mut v0;
        push_bytes(v1, arg1);
        let v2 = &mut v0;
        push_bytes(v2, arg2);
        let v3 = &mut v0;
        push_decimal_le(v3, arg0);
        let v4 = &mut v0;
        push_bytes(v4, arg3);
        let v5 = &mut v0;
        push_u64_le(v5, arg4);
        let v6 = &mut v0;
        push_u32_le(v6, arg5);
        let v7 = &mut v0;
        push_u64_le(v7, arg6);
        let Hasher { buffer: v8 } = v0;
        v8
    }

    public fun new() : Hasher {
        Hasher{buffer: 0x1::vector::empty<u8>()}
    }

    public fun push_bytes(arg0: &mut Hasher, arg1: vector<u8>) {
        0x1::vector::append<u8>(&mut arg0.buffer, arg1);
    }

    public fun push_decimal(arg0: &mut Hasher, arg1: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal) {
        let (v0, v1) = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::unpack(*arg1);
        push_i128(arg0, v0, v1);
    }

    public fun push_decimal_le(arg0: &mut Hasher, arg1: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::Decimal) {
        let (v0, v1) = 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::decimal::unpack(*arg1);
        push_i128_le(arg0, v0, v1);
    }

    public fun push_i128(arg0: &mut Hasher, arg1: u128, arg2: bool) {
        let v0 = if (arg2) {
            340282366920938463463374607431768211455 - arg1 + 1
        } else {
            arg1
        };
        let v1 = v0;
        let v2 = 0x1::bcs::to_bytes<u128>(&v1);
        0x1::vector::reverse<u8>(&mut v2);
        0x1::vector::append<u8>(&mut arg0.buffer, v2);
    }

    public fun push_i128_le(arg0: &mut Hasher, arg1: u128, arg2: bool) {
        let v0 = if (arg2) {
            340282366920938463463374607431768211455 - arg1 + 1
        } else {
            arg1
        };
        let v1 = v0;
        0x1::vector::append<u8>(&mut arg0.buffer, 0x1::bcs::to_bytes<u128>(&v1));
    }

    public fun push_u128(arg0: &mut Hasher, arg1: u128) {
        let v0 = 0x1::bcs::to_bytes<u128>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(&mut arg0.buffer, v0);
    }

    public fun push_u32(arg0: &mut Hasher, arg1: u32) {
        let v0 = 0x1::bcs::to_bytes<u32>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(&mut arg0.buffer, v0);
    }

    public fun push_u32_le(arg0: &mut Hasher, arg1: u32) {
        0x1::vector::append<u8>(&mut arg0.buffer, 0x1::bcs::to_bytes<u32>(&arg1));
    }

    public fun push_u64(arg0: &mut Hasher, arg1: u64) {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        0x1::vector::append<u8>(&mut arg0.buffer, v0);
    }

    public fun push_u64_le(arg0: &mut Hasher, arg1: u64) {
        0x1::vector::append<u8>(&mut arg0.buffer, 0x1::bcs::to_bytes<u64>(&arg1));
    }

    public fun push_u8(arg0: &mut Hasher, arg1: u8) {
        0x1::vector::push_back<u8>(&mut arg0.buffer, arg1);
    }

    // decompiled from Move bytecode v6
}

