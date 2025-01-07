module 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::format {
    public fun format(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = 0;
        let v3 = 0;
        while (v2 < v1) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v2);
            if (v4 == 123 && v1 > v2 + 1) {
                let v5 = *0x1::vector::borrow<u8>(arg0, v2 + 1);
                if (v5 != 123) {
                    let v6 = b"";
                    if (v5 == 125) {
                        let v7 = &mut v0;
                        append_format_piece(v7, &v6, v3, arg1);
                        v3 = v3 + 1;
                        v2 = v2 + 1;
                    } else {
                        0x1::vector::push_back<u8>(&mut v6, v5);
                        let v8 = false;
                        let v9 = v2 + 2;
                        while (!v8 && v1 > v9) {
                            let v10 = *0x1::vector::borrow<u8>(arg0, v9);
                            if (v10 == 125) {
                                v8 = true;
                            } else {
                                0x1::vector::push_back<u8>(&mut v6, v10);
                            };
                            v9 = v9 + 1;
                        };
                        let v11 = &mut v0;
                        if (append_format_piece(v11, &v6, v3, arg1)) {
                            v3 = v3 + 1;
                        };
                        v2 = v9 - 1;
                    };
                } else {
                    0x1::vector::push_back<u8>(&mut v0, 123);
                    v2 = v2 + 1;
                };
            } else {
                0x1::vector::push_back<u8>(&mut v0, v4);
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun append_format_piece(arg0: &mut vector<u8>, arg1: &vector<u8>, arg2: u64, arg3: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg1) > 0) {
            let v0 = b"";
            let v1 = 0x1::vector::empty<u8>();
            if (*0x1::vector::borrow<u8>(arg1, 0) != 58) {
                let v2 = 0;
                let v3 = false;
                while (v2 < 0x1::vector::length<u8>(arg1)) {
                    let v4 = *0x1::vector::borrow<u8>(arg1, v2);
                    if (v3) {
                        0x1::vector::push_back<u8>(&mut v1, v4);
                    } else if (v4 == 58) {
                        v3 = true;
                        0x1::vector::push_back<u8>(&mut v1, 58);
                    } else {
                        0x1::vector::push_back<u8>(&mut v0, v4);
                    };
                    v2 = v2 + 1;
                };
            };
            if (0x1::vector::length<u8>(&v0) > 0) {
                if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk(arg3, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v0))) {
                    0x1::vector::append<u8>(arg0, meta_chunk_to_string(arg3, 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::key(&v0), &v1));
                    return false
                };
                0x1::vector::append<u8>(arg0, b"{???}");
                return false
            };
        };
        let v5 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_chunks_ids(arg3);
        if (arg2 < 0x1::vector::length<u32>(&v5)) {
            0x1::vector::append<u8>(arg0, meta_chunk_to_string(arg3, *0x1::vector::borrow<u32>(&v5, arg2), arg1));
            return true
        };
        0x1::vector::append<u8>(arg0, b"{???}");
        true
    }

    public fun bool_to_string(arg0: bool) : vector<u8> {
        if (arg0) {
            return b"true"
        };
        b"false"
    }

    public fun format_ascii(arg0: &0x1::ascii::String, arg1: &vector<u8>) : 0x1::ascii::String {
        0x1::ascii::string(format(0x1::ascii::as_bytes(arg0), arg1))
    }

    public fun format_string(arg0: &0x1::string::String, arg1: &vector<u8>) : 0x1::string::String {
        0x1::string::utf8(format(0x1::string::bytes(arg0), arg1))
    }

    public fun is_printable_char(arg0: u8) : bool {
        arg0 == 10 || arg0 >= 32 && arg0 < 126
    }

    public fun looks_like_a_string(arg0: &vector<u8>, arg1: u32) : bool {
        let v0 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_vec_u8(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::length<u8>(&v0);
        if (v2 == 0) {
            return false
        };
        while (v1 < v2) {
            if (!is_printable_char(*0x1::vector::borrow<u8>(&v0, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun meta_chunk_to_string(arg0: &vector<u8>, arg1: u32, arg2: &vector<u8>) : vector<u8> {
        if (!0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk(arg0, arg1)) {
            return b"{???}"
        };
        let v0 = 120;
        let v1 = b"";
        if (arg2 == &v1) {
            if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<bool>(arg0, arg1)) {
                v0 = 66;
            } else if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<address>(arg0, arg1)) {
                v0 = 121;
            } else if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<u8>(arg0, arg1) || 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<u64>(arg0, arg1) || 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<u128>(arg0, arg1) || 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<u256>(arg0, arg1)) {
                v0 = 105;
            } else if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<vector<u16>>(arg0, arg1) || 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<vector<u32>>(arg0, arg1) || 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<vector<u64>>(arg0, arg1)) {
                v0 = 97;
            } else if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<vector<u8>>(arg0, arg1) && looks_like_a_string(arg0, arg1)) {
                v0 = 115;
            } else if (0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<vector<u128>>(arg0, arg1) || 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::has_chunk_of_type<vector<u256>>(arg0, arg1)) {
                v0 = 65;
            } else {
                v0 = 120;
            };
        } else if (*0x1::vector::borrow<u8>(arg2, 0) == 58) {
            v0 = *0x1::vector::borrow<u8>(arg2, 1);
        };
        if (v0 == 66) {
            return bool_to_string(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_bool(arg0, arg1, false))
        };
        if (v0 == 105) {
            return u256_to_string(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_any_u256(arg0, arg1, 0))
        };
        if (v0 == 115) {
            return 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_vec_u8(arg0, arg1)
        };
        if (v0 == 97) {
            let v2 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_any_vec_u256(arg0, arg1);
            let v3 = b"[";
            let v4 = 0;
            let v5 = 0x1::vector::length<u256>(&v2);
            if (v5 == 0) {
                return b"[]"
            };
            while (v4 < v5) {
                0x1::vector::append<u8>(&mut v3, u256_to_string(*0x1::vector::borrow<u256>(&v2, v4)));
                0x1::vector::append<u8>(&mut v3, b", ");
                v4 = v4 + 1;
            };
            0x1::vector::pop_back<u8>(&mut v3);
            0x1::vector::pop_back<u8>(&mut v3);
            0x1::vector::append<u8>(&mut v3, b"]");
            return v3
        };
        if (v0 == 65) {
            let v6 = 0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get_any_vec_u256(arg0, arg1);
            let v7 = b"[0x";
            let v8 = 0;
            let v9 = 0x1::vector::length<u256>(&v6);
            if (v9 == 0) {
                return b"[]"
            };
            while (v8 < v9) {
                0x1::vector::append<u8>(&mut v7, u256_to_hex(*0x1::vector::borrow<u256>(&v6, v8)));
                0x1::vector::append<u8>(&mut v7, b", 0x");
                v8 = v8 + 1;
            };
            0x1::vector::pop_back<u8>(&mut v7);
            0x1::vector::pop_back<u8>(&mut v7);
            0x1::vector::pop_back<u8>(&mut v7);
            0x1::vector::pop_back<u8>(&mut v7);
            0x1::vector::append<u8>(&mut v7, b"]");
            return v7
        };
        if (v0 == 121) {
            let v10 = 0x1::option::destroy_with_default<vector<u8>>(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get(arg0, arg1), 0x1::vector::empty<u8>());
            let v11 = b"0x";
            0x1::vector::append<u8>(&mut v11, vu8_to_hex(&v10, true, false));
            return v11
        };
        if (v0 == 120) {
            let v12 = 0x1::option::destroy_with_default<vector<u8>>(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get(arg0, arg1), 0x1::vector::empty<u8>());
            let v13 = b"0x";
            0x1::vector::append<u8>(&mut v13, vu8_to_hex(&v12, false, false));
            return v13
        };
        if (v0 == 89) {
            let v14 = 0x1::option::destroy_with_default<vector<u8>>(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get(arg0, arg1), 0x1::vector::empty<u8>());
            let v15 = b"0x";
            0x1::vector::append<u8>(&mut v15, vu8_to_hex(&v14, true, true));
            return v15
        };
        if (v0 == 88) {
            let v16 = 0x1::option::destroy_with_default<vector<u8>>(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get(arg0, arg1), 0x1::vector::empty<u8>());
            let v17 = b"0x";
            0x1::vector::append<u8>(&mut v17, vu8_to_hex(&v16, false, true));
            return v17
        };
        let v18 = b"0x";
        0x1::vector::append<u8>(&mut v18, 0x2::hex::encode(0x1::option::destroy_with_default<vector<u8>>(0x20abcd433df2c68f62b794d0751d3a839945dcb6776ecf9fac76d3f0324a274::metadata::get(arg0, arg1), 0x1::vector::empty<u8>())));
        v18
    }

    public fun u256_to_hex(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = false;
        while (arg0 != 0) {
            let v2 = ((arg0 % 256) as u8);
            if (v2 > 0 || v1) {
                0x1::vector::push_back<u8>(&mut v0, v2);
                v1 = true;
            };
            arg0 = arg0 / 256;
        };
        0x2::hex::encode(v0)
    }

    public fun u256_to_string(arg0: u256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun vu8_to_hex(arg0: &vector<u8>, arg1: bool, arg2: bool) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        let v2 = 87;
        if (arg2) {
            v2 = 55;
        };
        let v3 = 0x1::vector::length<u8>(arg0);
        if (v3 == 0) {
            return v0
        };
        let v4 = *0x1::vector::borrow<u8>(arg0, 0);
        if (v4 > 0 && (v4 as u64) == v3 - 1) {
            v1 = 1;
        };
        let v5 = !arg1;
        while (v1 < v3) {
            let v6 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v6 != 0 || v5) {
                let v7 = v6 >> 4;
                let v8 = v6 & 15;
                if (v7 > 9) {
                    0x1::vector::push_back<u8>(&mut v0, v7 + v2);
                } else {
                    0x1::vector::push_back<u8>(&mut v0, v7 + 48);
                };
                if (v8 > 9) {
                    0x1::vector::push_back<u8>(&mut v0, v8 + v2);
                } else {
                    0x1::vector::push_back<u8>(&mut v0, v8 + 48);
                };
                v5 = true;
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

