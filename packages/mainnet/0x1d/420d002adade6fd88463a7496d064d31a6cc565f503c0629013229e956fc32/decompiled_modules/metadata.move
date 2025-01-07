module 0x1d420d002adade6fd88463a7496d064d31a6cc565f503c0629013229e956fc32::metadata {
    public fun get(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<u8>> {
        let v0 = get_chunk_offset(arg0, arg1);
        let v1 = get_chunk_length_at_offset(arg0, v0);
        if (v1 == 0 || 0x1::vector::length<u8>(arg0) < v0 + (v1 as u64)) {
            return 0x1::option::none<vector<u8>>()
        };
        let v2 = 0x1::vector::empty<u8>();
        let v3 = v0 + 8;
        while (v3 < v0 + (v1 as u64)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v3));
            v3 = v3 + 1;
        };
        0x1::option::some<vector<u8>>(v2)
    }

    public fun clamp(arg0: &mut vector<u8>, arg1: u64, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x1::vector::length<u8>(arg0);
        if (arg1 + arg2 > v0) {
            abort 131072
        };
        let v1 = arg1;
        while (v1 < v0 - arg2) {
            0x1::vector::swap<u8>(arg0, v1, v1 + arg2);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < arg2) {
            0x1::vector::pop_back<u8>(arg0);
            v1 = v1 + 1;
        };
    }

    public fun get_address(arg0: &vector<u8>, arg1: u32, arg2: address) : address {
        0x1::option::destroy_with_default<address>(get_option_address(arg0, arg1), arg2)
    }

    public fun get_any_u256(arg0: &vector<u8>, arg1: u32, arg2: u256) : u256 {
        0x1::option::destroy_with_default<u256>(get_option_any_u256(arg0, arg1), arg2)
    }

    public fun get_any_vec_u256(arg0: &vector<u8>, arg1: u32) : vector<u256> {
        0x1::option::destroy_with_default<vector<u256>>(get_option_any_vec_u256(arg0, arg1), 0x1::vector::empty<u256>())
    }

    public fun get_bool(arg0: &vector<u8>, arg1: u32, arg2: bool) : bool {
        0x1::option::destroy_with_default<bool>(get_option_bool(arg0, arg1), arg2)
    }

    fun get_chunk_length_at_offset(arg0: &vector<u8>, arg1: u64) : u32 {
        if (arg1 == 0x1::vector::length<u8>(arg0)) {
            return 0
        };
        u32_from_le_bytes_at_offset(arg0, arg1 + 4)
    }

    fun get_chunk_offset(arg0: &vector<u8>, arg1: u32) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 <= 1) {
            return 0
        };
        let v1 = 1;
        while (v1 < v0) {
            if (u32_from_le_bytes_at_offset(arg0, v1) == arg1) {
                return v1
            };
            let v2 = (u32_from_le_bytes_at_offset(arg0, v1 + 4) as u64);
            v1 = v1 + v2;
        };
        v0
    }

    public fun get_chunks_count(arg0: &vector<u8>) : u32 {
        let v0 = get_chunks_ids(arg0);
        (0x1::vector::length<u32>(&v0) as u32)
    }

    public fun get_chunks_ids(arg0: &vector<u8>) : vector<u32> {
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u32>(&mut v0, u32_from_le_bytes_at_offset(arg0, v1));
            let v2 = (u32_from_le_bytes_at_offset(arg0, v1 + 4) as u64);
            v1 = v1 + v2;
        };
        v0
    }

    public fun get_option_address(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<address> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<address>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<address>(0x2::bcs::peel_address(&mut v1))
    }

    public fun get_option_any_u256(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<u256> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<u256>()
        };
        let v1 = 0x1::option::destroy_some<vector<u8>>(v0);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            let v4 = v3 << 8;
            v3 = v4 | (*0x1::vector::borrow<u8>(&v1, v2) as u256);
            v2 = v2 + 1;
        };
        0x1::option::some<u256>(v3)
    }

    public fun get_option_any_vec_u256(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<u256>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<u256>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        let v2 = 0x2::bcs::peel_vec_length(&mut v1);
        let v3 = 0x2::bcs::into_remainder_bytes(v1);
        let v4 = 0x1::vector::length<u8>(&v3);
        if (v2 == 0 || v4 == 0) {
            return 0x1::option::some<vector<u256>>(0x1::vector::empty<u256>())
        };
        if (v4 % v2 != 0) {
            return 0x1::option::some<vector<u256>>(0x1::vector::empty<u256>())
        };
        let v5 = v4 / v2;
        let v6 = 0x1::vector::empty<u256>();
        let v7 = 0;
        while (v7 < v4) {
            let v8 = 0;
            let v9 = 0;
            while (v8 < v5) {
                v9 = v9 | (*0x1::vector::borrow<u8>(&v3, v7 + v8) as u256) << 8 * (v8 as u8);
                v8 = v8 + 1;
            };
            0x1::vector::push_back<u256>(&mut v6, v9);
            v7 = v7 + v5;
        };
        0x1::option::some<vector<u256>>(v6)
    }

    public fun get_option_bool(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<bool> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<bool>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<bool>(0x2::bcs::peel_bool(&mut v1))
    }

    public fun get_option_u128(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<u128> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<u128>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<u128>(0x2::bcs::peel_u128(&mut v1))
    }

    public fun get_option_u256(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<u256> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<u256>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<u256>(0x2::bcs::peel_u256(&mut v1))
    }

    public fun get_option_u64(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<u64> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<u64>(0x2::bcs::peel_u64(&mut v1))
    }

    public fun get_option_u8(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<u8> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<u8>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<u8>(0x2::bcs::peel_u8(&mut v1))
    }

    public fun get_option_vec_address(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<address>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<address>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<vector<address>>(0x2::bcs::peel_vec_address(&mut v1))
    }

    public fun get_option_vec_bool(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<bool>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<bool>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<vector<bool>>(0x2::bcs::peel_vec_bool(&mut v1))
    }

    public fun get_option_vec_u128(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<u128>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<u128>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<vector<u128>>(0x2::bcs::peel_vec_u128(&mut v1))
    }

    public fun get_option_vec_u64(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<u64>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<u64>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<vector<u64>>(0x2::bcs::peel_vec_u64(&mut v1))
    }

    public fun get_option_vec_u8(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<u8>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<u8>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<vector<u8>>(0x2::bcs::peel_vec_u8(&mut v1))
    }

    public fun get_option_vec_vec_u8(arg0: &vector<u8>, arg1: u32) : 0x1::option::Option<vector<vector<u8>>> {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0x1::option::none<vector<vector<u8>>>()
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x1::option::some<vector<vector<u8>>>(0x2::bcs::peel_vec_vec_u8(&mut v1))
    }

    public fun get_u128(arg0: &vector<u8>, arg1: u32, arg2: u128) : u128 {
        0x1::option::destroy_with_default<u128>(get_option_u128(arg0, arg1), arg2)
    }

    public fun get_u256(arg0: &vector<u8>, arg1: u32, arg2: u256) : u256 {
        0x1::option::destroy_with_default<u256>(get_option_u256(arg0, arg1), arg2)
    }

    public fun get_u64(arg0: &vector<u8>, arg1: u32, arg2: u64) : u64 {
        0x1::option::destroy_with_default<u64>(get_option_u64(arg0, arg1), arg2)
    }

    public fun get_u8(arg0: &vector<u8>, arg1: u32, arg2: u8) : u8 {
        0x1::option::destroy_with_default<u8>(get_option_u8(arg0, arg1), arg2)
    }

    public fun get_vec_address(arg0: &vector<u8>, arg1: u32) : vector<address> {
        0x1::option::destroy_with_default<vector<address>>(get_option_vec_address(arg0, arg1), 0x1::vector::empty<address>())
    }

    public fun get_vec_bool(arg0: &vector<u8>, arg1: u32) : vector<bool> {
        0x1::option::destroy_with_default<vector<bool>>(get_option_vec_bool(arg0, arg1), 0x1::vector::empty<bool>())
    }

    public fun get_vec_length(arg0: &vector<u8>, arg1: u32) : u64 {
        let v0 = get(arg0, arg1);
        if (0x1::option::is_none<vector<u8>>(&v0)) {
            return 0
        };
        let v1 = 0x2::bcs::new(0x1::option::destroy_some<vector<u8>>(v0));
        0x2::bcs::peel_vec_length(&mut v1)
    }

    public fun get_vec_u128(arg0: &vector<u8>, arg1: u32) : vector<u128> {
        0x1::option::destroy_with_default<vector<u128>>(get_option_vec_u128(arg0, arg1), 0x1::vector::empty<u128>())
    }

    public fun get_vec_u64(arg0: &vector<u8>, arg1: u32) : vector<u64> {
        0x1::option::destroy_with_default<vector<u64>>(get_option_vec_u64(arg0, arg1), 0x1::vector::empty<u64>())
    }

    public fun get_vec_u8(arg0: &vector<u8>, arg1: u32) : vector<u8> {
        0x1::option::destroy_with_default<vector<u8>>(get_option_vec_u8(arg0, arg1), 0x1::vector::empty<u8>())
    }

    public fun get_vec_vec_u8(arg0: &vector<u8>, arg1: u32) : vector<vector<u8>> {
        0x1::option::destroy_with_default<vector<vector<u8>>>(get_option_vec_vec_u8(arg0, arg1), 0x1::vector::empty<vector<u8>>())
    }

    public fun has_chunk(arg0: &vector<u8>, arg1: u32) : bool {
        let v0 = get_chunk_offset(arg0, arg1);
        let v1 = get_chunk_length_at_offset(arg0, v0);
        if (v1 == 0 || 0x1::vector::length<u8>(arg0) < v0 + (v1 as u64)) {
            return false
        };
        true
    }

    public fun has_chunk_of_type<T0>(arg0: &vector<u8>, arg1: u32) : bool {
        let v0 = get_chunk_length_at_offset(arg0, get_chunk_offset(arg0, arg1));
        if (v0 < 8) {
            return false
        };
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v2 = 0x1::ascii::as_bytes(&v1);
        let v3 = b"bool";
        if (v2 == &v3) {
            if (v0 - 8 == 1) {
                if (get_u8(arg0, arg1, 3) > 1) {
                    return false
                };
                return true
            };
        } else {
            let v4 = b"u8";
            if (v2 == &v4) {
                if (v0 - 8 == 1) {
                    return true
                };
            } else {
                let v5 = b"u64";
                if (v2 == &v5) {
                    if (v0 - 8 == 8) {
                        return true
                    };
                } else {
                    let v6 = b"u128";
                    if (v2 == &v6) {
                        if (v0 - 8 == 16) {
                            return true
                        };
                    } else {
                        let v7 = b"u256";
                        if (v2 == &v7) {
                            if (v0 - 8 == 32) {
                                return true
                            };
                        } else {
                            let v8 = b"address";
                            if (v2 == &v8) {
                                if (v0 - 8 == (0x2::address::length() as u32)) {
                                    return true
                                };
                            } else if (0x1::vector::length<u8>(v2) > 6 && *0x1::vector::borrow<u8>(v2, 0) == 118 && *0x1::vector::borrow<u8>(v2, 1) == 101 && *0x1::vector::borrow<u8>(v2, 2) == 99 && *0x1::vector::borrow<u8>(v2, 3) == 116 && *0x1::vector::borrow<u8>(v2, 4) == 111 && *0x1::vector::borrow<u8>(v2, 5) == 114) {
                                let v9 = 1;
                                let v10 = false;
                                if (*0x1::vector::borrow<u8>(v2, 7) == 117) {
                                    let v11 = b"vector<u8>";
                                    if (v2 == &v11) {
                                        v9 = 1;
                                    } else {
                                        let v12 = b"vector<u64>";
                                        if (v2 == &v12) {
                                            v9 = 8;
                                        } else {
                                            let v13 = b"vector<u32>";
                                            if (v2 == &v13) {
                                                v9 = 4;
                                            } else {
                                                let v14 = b"vector<u256>";
                                                if (v2 == &v14) {
                                                    v9 = 32;
                                                } else {
                                                    let v15 = b"vector<u16>";
                                                    if (v2 == &v15) {
                                                        v9 = 2;
                                                    } else {
                                                        let v16 = b"vector<u128>";
                                                        if (v2 == &v16) {
                                                            v9 = 16;
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                } else {
                                    let v17 = b"vector<address>";
                                    if (v2 == &v17) {
                                        v9 = 32;
                                    } else {
                                        let v18 = b"vector<bool>";
                                        if (v2 == &v18) {
                                            v9 = 1;
                                            v10 = true;
                                        };
                                    };
                                };
                                if (((v0 - 8) as u64) < get_vec_length(arg0, arg1) * v9) {
                                    return false
                                };
                                if (v10) {
                                    let v19 = get_vec_u8(arg0, arg1);
                                    let v20 = 0x1::vector::length<u8>(&v19);
                                    while (v20 > 0) {
                                        v20 = v20 - 1;
                                        if (*0x1::vector::borrow<u8>(&v19, v20) > 1) {
                                            return false
                                        };
                                    };
                                };
                                return true
                            };
                        };
                    };
                };
            };
        };
        false
    }

    public fun key(arg0: &vector<u8>) : u32 {
        0x1d420d002adade6fd88463a7496d064d31a6cc565f503c0629013229e956fc32::utils::key(arg0)
    }

    public fun remove_chunk(arg0: &mut vector<u8>, arg1: u32) : bool {
        let v0 = get_chunk_offset(arg0, arg1);
        let v1 = get_chunk_length_at_offset(arg0, v0);
        if (v1 == 0) {
            return false
        };
        clamp(arg0, v0, (v1 as u64));
        true
    }

    public fun set<T0>(arg0: &mut vector<u8>, arg1: u32, arg2: &T0) : bool {
        let v0 = get_chunk_offset(arg0, arg1);
        let v1 = get_chunk_length_at_offset(arg0, v0);
        let v2 = 8;
        let v3 = 0x2::bcs::to_bytes<T0>(arg2);
        let v4 = 0x1::vector::length<u8>(&v3);
        if (v1 != 0) {
            if ((v4 as u32) == (v1 as u32) - (v2 as u32)) {
                let v5 = v0 + (v1 as u64);
                while (!0x1::vector::is_empty<u8>(&v3)) {
                    v5 = v5 - 1;
                    0x1::vector::push_back<u8>(arg0, 0x1::vector::pop_back<u8>(&mut v3));
                    0x1::vector::swap<u8>(arg0, 0x1::vector::length<u8>(arg0), v5);
                    0x1::vector::pop_back<u8>(arg0);
                };
                0x1::vector::destroy_empty<u8>(v3);
                return true
            };
            clamp(arg0, v0, (v1 as u64));
        };
        if (0x1::vector::length<u8>(arg0) == 0) {
            0x1::vector::push_back<u8>(arg0, 0);
        };
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u32>(&arg1));
        let v6 = (v4 as u32) + (v2 as u32);
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<u32>(&v6));
        0x1::vector::append<u8>(arg0, v3);
        true
    }

    public fun single<T0>(arg0: &T0) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        set<T0>(v1, 0, arg0);
        v0
    }

    public fun u32_from_le_bytes_at_offset(arg0: &vector<u8>, arg1: u64) : u32 {
        ((*0x1::vector::borrow<u8>(arg0, arg1) as u32) << 0) + ((*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u32) << 8) + ((*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u32) << 16) + ((*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u32) << 24)
    }

    public fun unpack_key(arg0: u32) : vector<u8> {
        0x1d420d002adade6fd88463a7496d064d31a6cc565f503c0629013229e956fc32::utils::unpack_key(arg0)
    }

    // decompiled from Move bytecode v6
}

