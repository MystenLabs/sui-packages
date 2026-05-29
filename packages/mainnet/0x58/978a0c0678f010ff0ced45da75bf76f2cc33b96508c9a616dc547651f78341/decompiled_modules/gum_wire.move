module 0x58978a0c0678f010ff0ced45da75bf76f2cc33b96508c9a616dc547651f78341::gum_wire {
    public fun action_invalidate(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 0);
        let v2 = &mut v0;
        write_address(v2, arg0);
        let v3 = &mut v0;
        write_u64_be(v3, arg1);
        v0
    }

    public fun action_kind_swap() : u8 {
        2
    }

    public fun action_kind_withdraw() : u8 {
        1
    }

    public fun action_swap<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 2);
        let v2 = &mut v0;
        write_address(v2, arg0);
        let v3 = &mut v0;
        write_u64_be(v3, arg1);
        let v4 = &mut v0;
        write_sui_token(v4, 0x1::type_name::with_defining_ids<T0>());
        let v5 = &mut v0;
        write_sui_token(v5, 0x1::type_name::with_defining_ids<T1>());
        let v6 = &mut v0;
        write_u256_from_u64(v6, arg2);
        let v7 = &mut v0;
        write_u256_from_u64(v7, arg3);
        v0
    }

    public fun action_withdraw<T0>(arg0: address, arg1: u64, arg2: u64, arg3: address) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 1);
        let v2 = &mut v0;
        write_address(v2, arg0);
        let v3 = &mut v0;
        write_u64_be(v3, arg1);
        let v4 = &mut v0;
        write_sui_token(v4, 0x1::type_name::with_defining_ids<T0>());
        let v5 = &mut v0;
        write_u256_from_u64(v5, arg2);
        let v6 = &mut v0;
        write_address(v6, arg3);
        v0
    }

    public fun decode_invalidate_action(arg0: &vector<u8>) : (address, u64) {
        let (v0, v1) = read_u8(arg0, 0);
        assert!(v0 == 0, 103);
        let (v2, v3) = read_address(arg0, v1);
        let (v4, v5) = read_u64_be(arg0, v3);
        assert!(v5 == 0x1::vector::length<u8>(arg0), 109);
        (v2, v4)
    }

    public fun decode_swap_action<T0, T1>(arg0: &vector<u8>) : (address, u64, u64, u64) {
        let (v0, v1) = read_u8(arg0, 0);
        assert!(v0 == 2, 103);
        let (v2, v3) = read_address(arg0, v1);
        let (v4, v5) = read_u64_be(arg0, v3);
        let (v6, v7) = read_u256_as_u64(arg0, read_sui_token_name<T1>(arg0, read_sui_token_name<T0>(arg0, v5)));
        let (v8, v9) = read_u256_as_u64(arg0, v7);
        assert!(v9 == 0x1::vector::length<u8>(arg0), 109);
        (v2, v4, v6, v8)
    }

    public fun decode_withdraw_action<T0>(arg0: &vector<u8>) : (address, u64, u64, address) {
        let (v0, v1) = read_u8(arg0, 0);
        assert!(v0 == 1, 103);
        let (v2, v3) = read_address(arg0, v1);
        let (v4, v5) = read_u64_be(arg0, v3);
        let (v6, v7) = read_u256_as_u64(arg0, read_sui_token_name<T0>(arg0, v5));
        let (v8, v9) = read_address(arg0, v7);
        assert!(v9 == 0x1::vector::length<u8>(arg0), 109);
        (v2, v4, v6, v8)
    }

    public fun encode_deposited<T0>(arg0: address, arg1: u64, arg2: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 3);
        let v2 = &mut v0;
        write_address(v2, arg0);
        let v3 = &mut v0;
        write_sui_token(v3, 0x1::type_name::with_defining_ids<T0>());
        let v4 = &mut v0;
        write_u256_from_u64(v4, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        v0
    }

    public fun encode_invalidated(arg0: address) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 0);
        let v2 = &mut v0;
        write_address(v2, arg0);
        v0
    }

    public fun encode_swapped<T0>(arg0: address, arg1: u64, arg2: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 2);
        let v2 = &mut v0;
        write_address(v2, arg0);
        let v3 = &mut v0;
        write_sui_token(v3, 0x1::type_name::with_defining_ids<T0>());
        let v4 = &mut v0;
        write_u256_from_u64(v4, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        v0
    }

    public fun encode_withdrew<T0>(arg0: address, arg1: u64, arg2: address) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 1);
        let v2 = &mut v0;
        write_address(v2, arg0);
        let v3 = &mut v0;
        write_u256_from_u64(v3, arg1);
        let v4 = &mut v0;
        write_sui_token(v4, 0x1::type_name::with_defining_ids<T0>());
        let v5 = &mut v0;
        write_address(v5, arg2);
        v0
    }

    public fun hash_token_meta(arg0: vector<u8>, arg1: vector<u8>, arg2: u8) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) <= 64, 107);
        assert!(0x1::vector::length<u8>(&arg1) <= 32, 108);
        let v0 = b"";
        let v1 = &mut v0;
        write_bytes(v1, arg0);
        let v2 = &mut v0;
        write_bytes(v2, arg1);
        let v3 = &mut v0;
        write_u8(v3, arg2);
        0x1::hash::sha2_256(v0)
    }

    public fun message_hash(arg0: u64, arg1: address, arg2: vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        write_u8(v1, 1);
        let v2 = &mut v0;
        write_u64_be(v2, arg0);
        let v3 = &mut v0;
        write_address(v3, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::hash::sha2_256(v0)
    }

    public fun message_to_hash(arg0: &vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(*arg0)
    }

    fun read_address(arg0: &vector<u8>, arg1: u64) : (address, u64) {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        (0x2::address::from_bytes(v0), arg1 + 32)
    }

    fun read_sui_token_name<T0>(arg0: &vector<u8>, arg1: u64) : u64 {
        let (v0, v1) = read_u8(arg0, arg1);
        assert!(v0 == 3, 104);
        let (v2, v3) = read_u8(arg0, v1);
        let v4 = b"";
        let v5 = 0;
        while (v5 < (v2 as u64)) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(arg0, v3 + v5));
            v5 = v5 + 1;
        };
        assert!(v4 == type_name_to_wire_payload(0x1::type_name::with_defining_ids<T0>()), 106);
        v3 + (v2 as u64)
    }

    fun read_u256_as_u64(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        let v0 = 0;
        while (v0 < 24) {
            assert!(*0x1::vector::borrow<u8>(arg0, arg1 + v0) == 0, 105);
            v0 = v0 + 1;
        };
        read_u64_be(arg0, arg1 + 24)
    }

    fun read_u64_be(arg0: &vector<u8>, arg1: u64) : (u64, u64) {
        ((*0x1::vector::borrow<u8>(arg0, arg1) as u64) << 56 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, arg1 + 4) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 5) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 6) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 7) as u64), arg1 + 8)
    }

    fun read_u8(arg0: &vector<u8>, arg1: u64) : (u8, u64) {
        (*0x1::vector::borrow<u8>(arg0, arg1), arg1 + 1)
    }

    public fun sanitize_token_meta(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>) {
        (truncate_bytes(arg0, 64), truncate_bytes(arg1, 32))
    }

    fun truncate_bytes(arg0: vector<u8>, arg1: u64) : vector<u8> {
        if (0x1::vector::length<u8>(&arg0) > arg1) {
            0x1::vector::take<u8>(arg0, arg1)
        } else {
            arg0
        }
    }

    fun type_name_to_wire_payload(arg0: 0x1::type_name::TypeName) : vector<u8> {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0));
        let v1 = b"";
        let v2 = 0;
        while (v2 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::hex::decode(v1);
        let v4 = 64;
        while (v4 < 0x1::vector::length<u8>(&v0)) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, v4));
            v4 = v4 + 1;
        };
        v3
    }

    fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    public fun verify_and_strip_header(arg0: vector<u8>, arg1: u64, arg2: address) : vector<u8> {
        let (v0, v1) = read_u8(&arg0, 0);
        assert!(v0 == 1, 100);
        let (v2, v3) = read_u64_be(&arg0, v1);
        assert!(v2 == arg1, 101);
        let (v4, _) = read_address(&arg0, v3);
        assert!(v4 == arg2, 102);
        let v6 = b"";
        let v7 = 41;
        while (v7 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&arg0, v7));
            v7 = v7 + 1;
        };
        v6
    }

    fun write_address(arg0: &mut vector<u8>, arg1: address) {
        0x1::vector::append<u8>(arg0, 0x2::address::to_bytes(arg1));
    }

    fun write_bytes(arg0: &mut vector<u8>, arg1: vector<u8>) {
        write_u32_be(arg0, (0x1::vector::length<u8>(&arg1) as u64));
        0x1::vector::append<u8>(arg0, arg1);
    }

    fun write_sui_token(arg0: &mut vector<u8>, arg1: 0x1::type_name::TypeName) {
        let v0 = type_name_to_wire_payload(arg1);
        write_u8(arg0, 3);
        write_u8(arg0, (0x1::vector::length<u8>(&v0) as u8));
        0x1::vector::append<u8>(arg0, v0);
    }

    fun write_u256_from_u64(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 24) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
        0x1::vector::append<u8>(arg0, u64_to_be_bytes(arg1));
    }

    fun write_u32_be(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 & 255) as u8));
    }

    fun write_u64_be(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::append<u8>(arg0, u64_to_be_bytes(arg1));
    }

    fun write_u8(arg0: &mut vector<u8>, arg1: u8) {
        0x1::vector::push_back<u8>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

