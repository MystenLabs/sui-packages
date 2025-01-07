module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode {
    public fun type_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun append_struct_name<T0>(arg0: 0x1::string::String) : 0x1::string::String {
        append_struct_name_(package_id_and_module_name<T0>(), arg0)
    }

    public fun append_struct_name_(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut arg0, arg1);
        arg0
    }

    public fun decompose_struct_name(arg0: 0x1::string::String) : (0x1::string::String, vector<0x1::string::String>) {
        let (v0, v1) = parse_angle_bracket(arg0);
        (v0, parse_comma_delimited_list(v1))
    }

    public fun decompose_type_name(arg0: 0x1::string::String) : (0x2::object::ID, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>) {
        let v0 = 0x1::string::utf8(b"::");
        let v1 = 0x2::address::length();
        if (0x1::string::length(&arg0) > v1 * 2 + 2 && 0x1::string::sub_string(&arg0, v1 * 2, v1 * 2 + 2) == v0) {
            let v6 = 0x1::string::sub_string(&arg0, v1 * 2 + 2, 0x1::string::length(&arg0));
            let v7 = 0x1::string::index_of(&v6, &v0);
            assert!(0x1::string::length(&v6) > v7, 0);
            let v8 = 0x1::string::sub_string(&arg0, 0, v1 * 2);
            let (v9, v10) = decompose_struct_name(0x1::string::sub_string(&v6, v7 + 2, 0x1::string::length(&v6)));
            (0x2::object::id_from_bytes(0x2::hex::decode(*0x1::string::bytes(&v8))), 0x1::string::sub_string(&v6, 0, v7), v9, v10)
        } else {
            let (v11, v12) = decompose_struct_name(arg0);
            (0x2::object::id_from_address(@0x0), 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2::empty(), v11, v12)
        }
    }

    public fun has_generics<T0>() : bool {
        let v0 = type_name<T0>();
        let v1 = 0x1::string::utf8(b"<");
        0x1::string::index_of(&v0, &v1) == 0x1::string::length(&v0) && false || true
    }

    public fun is_same_module<T0, T1>() : bool {
        package_id_and_module_name<T0>() == package_id_and_module_name<T1>()
    }

    public fun is_same_type<T0, T1>() : bool {
        0x1::type_name::get<T0>() == 0x1::type_name::get<T1>()
    }

    public fun is_vector(arg0: 0x1::string::String) : bool {
        0x1::string::length(&arg0) < 6 && false || 0x1::string::sub_string(&arg0, 0, 6) == 0x1::string::utf8(b"vector")
    }

    public fun module_and_struct_name<T0>() : 0x1::string::String {
        let (_, v1, v2, _) = type_name_decomposed<T0>();
        let v4 = v1;
        0x1::string::append(&mut v4, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v4, v2);
        v4
    }

    public fun module_name<T0>() : 0x1::string::String {
        let v0 = type_name<T0>();
        let v1 = 0x1::string::sub_string(&v0, 0x2::address::length() * 2 + 2, 0x1::string::length(&v0));
        let v2 = 0x1::string::utf8(b"::");
        let v3 = 0x1::string::index_of(&v1, &v2);
        assert!(0x1::string::length(&v1) > v3, 0);
        0x1::string::sub_string(&v1, 0, v3)
    }

    public fun package_addr<T0>() : address {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::address::from_bytes(0x2::hex::decode(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(&v0, 0, 0x2::address::length() * 2)))
    }

    public fun package_addr_(arg0: 0x1::string::String) : address {
        0x2::address::from_bytes(0x2::hex::decode(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(0x1::string::bytes(&arg0), 0, 0x2::address::length() * 2)))
    }

    public fun package_id<T0>() : 0x2::object::ID {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::object::id_from_bytes(0x2::hex::decode(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(&v0, 0, 0x2::address::length() * 2)))
    }

    public fun package_id_(arg0: 0x1::string::String) : 0x2::object::ID {
        0x2::object::id_from_bytes(0x2::hex::decode(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::slice<u8>(0x1::string::bytes(&arg0), 0, 0x2::address::length() * 2)))
    }

    public fun package_id_and_module_name<T0>() : 0x1::string::String {
        package_id_and_module_name_(type_name<T0>())
    }

    public fun package_id_and_module_name_(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"::");
        let v1 = 0x1::string::sub_string(&arg0, 0x2::address::length() * 2 + 2, 0x1::string::length(&arg0));
        let v2 = 0x1::string::index_of(&v1, &v0);
        assert!(0x1::string::length(&v1) > v2, 0);
        0x1::string::sub_string(&arg0, 0, 0x2::address::length() * 2 + 2 + v2)
    }

    public fun parse_angle_bracket(arg0: 0x1::string::String) : (0x1::string::String, 0x1::string::String) {
        let v0 = *0x1::string::bytes(&arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v3);
            if (v4 == 60) {
                v2 = v2 + 1;
            } else if (v4 == 62) {
                if (v2 == 0 || v2 == 1) {
                    break
                };
                v2 = v2 - 1;
            };
            v3 = v3 + 1;
        };
        if (v3 == v1 || v1 + 1 >= v3) {
            (arg0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2::empty())
        } else {
            (0x1::string::sub_string(&arg0, 0, v1), 0x1::string::sub_string(&arg0, v1 + 1, v3))
        }
    }

    public fun parse_comma_delimited_list(arg0: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = *0x1::string::bytes(&arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::string::length(&arg0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v2) {
            if (*0x1::vector::borrow<u8>(&v0, v4) == 44) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::sub_string(&arg0, v3, v4));
                if (v4 < v2 - 1) {
                    if (*0x1::vector::borrow<u8>(&v0, v4 + 1) == 32) {
                        v3 = v4 + 2;
                    } else {
                        v3 = v4 + 1;
                    };
                } else {
                    v3 = v4 + 1;
                };
            } else if (v4 == v2 - 1) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::sub_string(&arg0, v3, v2));
            };
            v4 = v4 + 1;
        };
        if (0x1::vector::length<0x1::string::String>(&v1) == 0) {
            let v5 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v5, arg0);
            v1 = v5;
        };
        v1
    }

    public fun parse_option(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::length(&arg0);
        let v1 = 0x1::string::utf8(b"Option");
        let v2 = 0x1::string::index_of(&arg0, &v1);
        if (v2 == v0) {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2::empty()
        } else {
            let (_, v5) = parse_angle_bracket(0x1::string::sub_string(&arg0, v2 + 6, v0));
            v5
        }
    }

    public fun type_into_address<T0>() : address {
        type_string_into_address(type_name<T0>())
    }

    public fun type_name_decomposed<T0>() : (0x2::object::ID, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>) {
        decompose_type_name(type_name<T0>())
    }

    public fun type_string_into_address(arg0: 0x1::string::String) : address {
        let v0 = 0x2::bcs::new(0x2::hash::blake2b256(0x1::string::bytes(&arg0)));
        0x2::bcs::peel_address(&mut v0)
    }

    // decompiled from Move bytecode v6
}

