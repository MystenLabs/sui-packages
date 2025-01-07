module 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema {
    struct Key has copy, drop, store {
        namespace: 0x1::option::Option<0x2::object::ID>,
    }

    public fun length(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : u64 {
        if (!exists_(arg0, arg1)) {
            return 0
        };
        0x2::vec_map::size<0x1::string::String, 0x1::string::String>(borrow(arg0, arg1))
    }

    public fun borrow(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = Key{namespace: arg1};
        0x2::dynamic_field::borrow<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, v0)
    }

    fun borrow_mut(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : &mut 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = Key{namespace: arg1};
        if (!0x2::dynamic_field::exists_<Key>(arg0, v0)) {
            0x2::dynamic_field::add<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, v0, 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>());
        };
        let v1 = Key{namespace: arg1};
        0x2::dynamic_field::borrow_mut<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, v1)
    }

    public fun exists_(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : bool {
        let v0 = Key{namespace: arg1};
        0x2::dynamic_field::exists_<Key>(arg0, v0)
    }

    public(friend) fun remove(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<0x1::string::String>) : vector<0x1::string::String> {
        let v0 = borrow_mut(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v3 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::remove_maybe<0x1::string::String, 0x1::string::String>(v0, 0x1::vector::borrow<0x1::string::String>(&arg2, v2));
            if (0x1::option::is_some<0x1::string::String>(&v3)) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::option::destroy_some<0x1::string::String>(v3));
            } else {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2::empty());
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_type(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        if (!exists_(arg0, arg1)) {
            return 0x1::option::none<0x1::string::String>()
        };
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::get_maybe<0x1::string::String, 0x1::string::String>(borrow(arg0, arg1), &arg2)
    }

    public fun has_key(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String) : bool {
        if (!exists_(arg0, arg1)) {
            return false
        };
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(borrow(arg0, arg1), &arg2)
    }

    public fun into_keys(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : vector<0x1::string::String> {
        if (!exists_(arg0, arg1)) {
            return 0x1::vector::empty<0x1::string::String>()
        };
        0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(borrow(arg0, arg1))
    }

    public fun into_keys_types(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        if (!exists_(arg0, arg1)) {
            return (0x1::vector::empty<0x1::string::String>(), 0x1::vector::empty<0x1::string::String>())
        };
        0x2::vec_map::into_keys_values<0x1::string::String, 0x1::string::String>(*borrow(arg0, arg1))
    }

    public fun is_supported_type(arg0: 0x1::string::String) : bool {
        let v0 = vector[b"address", b"bool", b"id", b"u8", b"u16", b"u32", b"u64", b"u128", b"u256", b"String", b"Url", b"vector<address>", b"VecMap", b"vector<bool>", b"vector<id>", b"vector<u8>", b"vector<u16>", b"vector<u32>", b"vector<u64>", b"vector<u128>", b"vector<u256>", b"vector<String>", b"vector<Url>", b"vector<VecMap>", b"vector<vector<u8>>"];
        0x1::vector::contains<vector<u8>>(&v0, 0x1::string::bytes(&arg0))
    }

    public fun parse_field(arg0: vector<0x1::string::String>) : (0x1::string::String, 0x1::string::String) {
        let v0 = 0x1::vector::borrow<0x1::string::String>(&arg0, 0);
        let v1 = 0x1::vector::borrow<0x1::string::String>(&arg0, 1);
        assert!(is_supported_type(*v1), 1);
        (*v0, *v1)
    }

    public(friend) fun remove_all(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = Key{namespace: arg1};
        if (0x2::dynamic_field::exists_<Key>(arg0, v0)) {
            0x2::vec_map::into_keys_values<0x1::string::String, 0x1::string::String>(0x2::dynamic_field::remove<Key, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, v0))
        } else {
            (0x1::vector::empty<0x1::string::String>(), 0x1::vector::empty<0x1::string::String>())
        }
    }

    public fun simple_type_name<T0>() : 0x1::string::String {
        let v0 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::type_name<T0>();
        let v1 = *0x1::string::bytes(&v0);
        if (v1 == b"0000000000000000000000000000000000000000000000000000000000000001::string::String") {
            0x1::string::utf8(b"String")
        } else if (v1 == b"0000000000000000000000000000000000000000000000000000000000000002::url::Url") {
            0x1::string::utf8(b"Url")
        } else if (v1 == b"0000000000000000000000000000000000000000000000000000000000000002::vec_map::VecMap<0000000000000000000000000000000000000000000000000000000000000001::string::String,0000000000000000000000000000000000000000000000000000000000000001::string::String>") {
            0x1::string::utf8(b"VecMap")
        } else if (v1 == b"vector<0000000000000000000000000000000000000000000000000000000000000001::string::String") {
            0x1::string::utf8(b"vector<String>")
        } else if (v1 == b"vector<0000000000000000000000000000000000000000000000000000000000000002::url::Url") {
            0x1::string::utf8(b"vector<Url>")
        } else if (v1 == b"vector<0000000000000000000000000000000000000000000000000000000000000002::vec_map::VecMap<0000000000000000000000000000000000000000000000000000000000000001::string::String,0000000000000000000000000000000000000000000000000000000000000001::string::String>") {
            0x1::string::utf8(b"vector<VecMap>")
        } else {
            assert!(is_supported_type(v0), 1);
            v0
        }
    }

    public(friend) fun update_object_schema(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<vector<0x1::string::String>>) : vector<0x1::string::String> {
        let v0 = borrow_mut(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<0x1::string::String>>(&arg2)) {
            let (v3, v4) = parse_field(*0x1::vector::borrow<vector<0x1::string::String>>(&arg2, v2));
            let v5 = v3;
            let v6 = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2::set<0x1::string::String, 0x1::string::String>(v0, &v5, v4);
            if (0x1::option::is_some<0x1::string::String>(&v6) && *0x1::option::borrow<0x1::string::String>(&v6) != v4) {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::option::destroy_some<0x1::string::String>(v6));
            } else {
                0x1::vector::push_back<0x1::string::String>(&mut v1, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::string2::empty());
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun update_object_schema_(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<0x1::string::String>, arg3: 0x1::string::String) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<vector<0x1::string::String>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = 0x1::vector::empty<0x1::string::String>();
            let v3 = &mut v2;
            0x1::vector::push_back<0x1::string::String>(v3, *0x1::vector::borrow<0x1::string::String>(&arg2, v1));
            0x1::vector::push_back<0x1::string::String>(v3, arg3);
            0x1::vector::push_back<vector<0x1::string::String>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        update_object_schema(arg0, arg1, v0)
    }

    // decompiled from Move bytecode v6
}

