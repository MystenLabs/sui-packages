module 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::data {
    struct Key has copy, drop, store {
        namespace: 0x1::option::Option<0x2::object::ID>,
        key: 0x1::string::String,
    }

    struct WRITE {
        dummy_field: bool,
    }

    public fun borrow<T0: store>(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String) : &T0 {
        let v0 = Key{
            namespace : arg1,
            key       : arg2,
        };
        0x2::dynamic_field::borrow<Key, T0>(arg0, v0)
    }

    public fun borrow_mut<T0: store>(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : &mut T0 {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg3), 0);
        let v0 = Key{
            namespace : arg1,
            key       : arg2,
        };
        0x2::dynamic_field::borrow_mut<Key, T0>(arg0, v0)
    }

    public fun exists_(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String) : bool {
        let v0 = Key{
            namespace : arg1,
            key       : arg2,
        };
        0x2::dynamic_field::exists_<Key>(arg0, v0)
    }

    public fun exists_with_type<T0: store>(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String) : bool {
        let v0 = Key{
            namespace : arg1,
            key       : arg2,
        };
        0x2::dynamic_field::exists_with_type<Key, T0>(arg0, v0)
    }

    public fun borrow_mut_fill<T0, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: T1, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : &mut T1 {
        borrow_mut_fill_<T1>(arg0, 0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>()), arg1, arg2, arg3)
    }

    public fun borrow_mut_fill_<T0: drop + store>(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String, arg3: T0, arg4: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) : &mut T0 {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg4), 0);
        let v0 = Key{
            namespace : arg1,
            key       : arg2,
        };
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::borrow_mut_fill<Key, T0>(arg0, v0, arg3)
    }

    public fun deserialize_and_set<T0>(arg0: &mut 0x2::object::UID, arg1: vector<vector<u8>>, arg2: vector<vector<0x1::string::String>>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        deserialize_and_set_(arg0, 0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>()), arg1, arg2, arg3);
    }

    public fun deserialize_and_set_(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<vector<u8>>, arg3: vector<vector<0x1::string::String>>, arg4: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg4), 0);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<vector<0x1::string::String>>(&arg3), 1);
        let v0 = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::update_object_schema(arg0, arg1, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<0x1::string::String>>(&arg3)) {
            let (v2, v3) = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::parse_field(*0x1::vector::borrow<vector<0x1::string::String>>(&arg3, v1));
            let v4 = Key{
                namespace : arg1,
                key       : v2,
            };
            0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer::set_field<Key>(arg0, v4, v3, *0x1::vector::borrow<0x1::string::String>(&v0, v1), *0x1::vector::borrow<vector<u8>>(&arg2, v1), true);
            v1 = v1 + 1;
        };
    }

    public fun deserialize_and_take_string(arg0: 0x1::string::String, arg1: &mut vector<vector<u8>>, arg2: &mut vector<vector<0x1::string::String>>, arg3: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::vector::length<vector<0x1::string::String>>(arg2);
        let v1 = v0;
        let v2 = 0;
        while (v2 < v0) {
            if (0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(arg2, v2), 0) == &arg0) {
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v1 == v0) {
            return arg3
        };
        0x1::vector::swap_remove<vector<0x1::string::String>>(arg2, v1);
        0x1::string::utf8(0x1::vector::swap_remove<vector<u8>>(arg1, v1))
    }

    public fun duplicate<T0, T1>(arg0: &0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        duplicate_(0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>()), 0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T1>()), arg0, arg1, arg2);
    }

    public fun duplicate_(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &0x2::object::UID, arg3: &mut 0x2::object::UID, arg4: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg4), 0);
        let (v0, v1) = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::into_keys_types(arg2, arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&v3)) {
            let v5 = *0x1::vector::borrow<0x1::string::String>(&v3, v4);
            let v6 = *0x1::vector::borrow<0x1::string::String>(&v2, v4);
            let v7 = Key{
                namespace : arg0,
                key       : v5,
            };
            let v8 = Key{
                namespace : arg1,
                key       : v5,
            };
            let v9 = 0x1::vector::empty<0x1::string::String>();
            0x1::vector::push_back<0x1::string::String>(&mut v9, v5);
            let v10 = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::update_object_schema_(arg3, arg1, v9, v6);
            0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer::duplicate<Key, Key>(arg2, arg3, v7, v8, v6, 0x1::vector::pop_back<0x1::string::String>(&mut v10), true);
            v4 = v4 + 1;
        };
    }

    public fun get_bcs_bytes(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::string::String) : vector<u8> {
        let v0 = Key{
            namespace : arg1,
            key       : arg2,
        };
        0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer::get_bcs_bytes<Key>(arg0, v0, 0x1::option::destroy_some<0x1::string::String>(0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::get_type(arg0, arg1, arg2)))
    }

    public fun remove<T0>(arg0: &mut 0x2::object::UID, arg1: vector<0x1::string::String>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        remove_(arg0, 0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>()), arg1, arg2);
    }

    public fun remove_(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<0x1::string::String>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg3), 0);
        let v0 = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::remove(arg0, arg1, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&v0, v1);
            if (!0x1::string::is_empty(&v2)) {
                let v3 = Key{
                    namespace : arg1,
                    key       : *0x1::vector::borrow<0x1::string::String>(&arg2, v1),
                };
                0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer::drop_field<Key>(arg0, v3, v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun remove_all<T0>(arg0: &mut 0x2::object::UID, arg1: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        remove_all_(arg0, 0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>()), arg1);
    }

    public fun remove_all_(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg2), 0);
        let (v0, v1) = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::remove_all(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&v3)) {
            let v5 = Key{
                namespace : arg1,
                key       : *0x1::vector::borrow<0x1::string::String>(&v3, v4),
            };
            0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer::drop_field<Key>(arg0, v5, *0x1::vector::borrow<0x1::string::String>(&v2, v4));
            v4 = v4 + 1;
        };
    }

    public fun set<T0, T1: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: vector<0x1::string::String>, arg2: vector<T1>, arg3: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        set_<T1>(arg0, 0x1::option::some<0x2::object::ID>(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::package_id<T0>()), arg1, arg2, arg3);
    }

    public fun set_<T0: drop + store>(arg0: &mut 0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<0x1::string::String>, arg3: vector<T0>, arg4: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority) {
        assert!(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::can_act_as_package_opt<WRITE>(arg1, arg4), 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<T0>(&arg3), 1);
        let v0 = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::simple_type_name<T0>();
        let v1 = 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::update_object_schema_(arg0, arg1, arg2, v0);
        while (0x1::vector::length<0x1::string::String>(&arg2) > 0) {
            let v2 = Key{
                namespace : arg1,
                key       : 0x1::vector::pop_back<0x1::string::String>(&mut arg2),
            };
            0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer::set_field_<Key, T0>(arg0, v2, v0, 0x1::vector::pop_back<0x1::string::String>(&mut v1), 0x1::vector::pop_back<T0>(&mut arg3), true);
        };
    }

    public fun view(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<0x1::string::String>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            0x1::vector::append<u8>(&mut v0, get_bcs_bytes(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun view_all(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>) : vector<u8> {
        view(arg0, arg1, 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::schema::into_keys(arg0, arg1))
    }

    public fun view_parsed(arg0: &0x2::object::UID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<0x1::string::String>) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, get_bcs_bytes(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun view_with_default(arg0: &0x2::object::UID, arg1: &0x2::object::UID, arg2: 0x1::option::Option<0x2::object::ID>, arg3: vector<0x1::string::String>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg3, v1);
            let v3 = get_bcs_bytes(arg0, arg2, v2);
            let v4 = v3;
            if (v3 == x"00") {
                v4 = get_bcs_bytes(arg1, arg2, v2);
            };
            0x1::vector::append<u8>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

