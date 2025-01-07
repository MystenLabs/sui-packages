module 0xb316533ddbba458762cf151d6f929b77f65095e03ce9aede944d2122f081ad37::serializer {
    public fun drop_field<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x1::string::String) {
        let v0 = *0x1::string::bytes(&arg2);
        if (v0 == b"address") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, address>(arg0, arg1);
        } else if (v0 == b"bool") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, bool>(arg0, arg1);
        } else if (v0 == b"id") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, 0x2::object::ID>(arg0, arg1);
        } else if (v0 == b"u8") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, u8>(arg0, arg1);
        } else if (v0 == b"u64") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, u64>(arg0, arg1);
        } else if (v0 == b"u128") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, u128>(arg0, arg1);
        } else if (v0 == b"String") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, 0x1::string::String>(arg0, arg1);
        } else if (v0 == b"Url") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, 0x2::url::Url>(arg0, arg1);
        } else if (v0 == b"vector<address>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<address>>(arg0, arg1);
        } else if (v0 == b"vector<bool>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<bool>>(arg0, arg1);
        } else if (v0 == b"vector<id>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<0x2::object::ID>>(arg0, arg1);
        } else if (v0 == b"vector<u8>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<u8>>(arg0, arg1);
        } else if (v0 == b"vector<u64>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<u64>>(arg0, arg1);
        } else if (v0 == b"vector<u128>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<u128>>(arg0, arg1);
        } else if (v0 == b"vector<String>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<0x1::string::String>>(arg0, arg1);
        } else if (v0 == b"vector<Url>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<0x2::url::Url>>(arg0, arg1);
        } else if (v0 == b"VecMap") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, arg1);
        } else {
            assert!(v0 == b"vector<VecMap>", 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::drop<T0, vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>>(arg0, arg1);
        };
    }

    public fun duplicate<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: T0, arg3: T1, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: bool) {
        if (!arg6 && 0x2::dynamic_field::exists_<T1>(arg1, arg3)) {
            return
        };
        if (!0x2::dynamic_field::exists_<T0>(arg0, arg2)) {
            if (arg6 && !0x1::string::is_empty(&arg5)) {
                drop_field<T1>(arg1, arg3, arg5);
            };
            return
        };
        if (!0x1::string::is_empty(&arg5) && arg5 != arg4) {
            drop_field<T1>(arg1, arg3, arg5);
        };
        let v0 = *0x1::string::bytes(&arg4);
        if (v0 == b"address") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, address>(arg1, arg3, *0x2::dynamic_field::borrow<T0, address>(arg0, arg2));
        } else if (v0 == b"bool") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, bool>(arg1, arg3, *0x2::dynamic_field::borrow<T0, bool>(arg0, arg2));
        } else if (v0 == b"id") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, 0x2::object::ID>(arg1, arg3, *0x2::dynamic_field::borrow<T0, 0x2::object::ID>(arg0, arg2));
        } else if (v0 == b"u8") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, u8>(arg1, arg3, *0x2::dynamic_field::borrow<T0, u8>(arg0, arg2));
        } else if (v0 == b"u16") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, u16>(arg1, arg3, *0x2::dynamic_field::borrow<T0, u16>(arg0, arg2));
        } else if (v0 == b"u32") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, u32>(arg1, arg3, *0x2::dynamic_field::borrow<T0, u32>(arg0, arg2));
        } else if (v0 == b"u64") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, u64>(arg1, arg3, *0x2::dynamic_field::borrow<T0, u64>(arg0, arg2));
        } else if (v0 == b"u128") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, u128>(arg1, arg3, *0x2::dynamic_field::borrow<T0, u128>(arg0, arg2));
        } else if (v0 == b"u256") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, u256>(arg1, arg3, *0x2::dynamic_field::borrow<T0, u256>(arg0, arg2));
        } else if (v0 == b"String") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, 0x1::string::String>(arg1, arg3, *0x2::dynamic_field::borrow<T0, 0x1::string::String>(arg0, arg2));
        } else if (v0 == b"Url") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, 0x2::url::Url>(arg1, arg3, *0x2::dynamic_field::borrow<T0, 0x2::url::Url>(arg0, arg2));
        } else if (v0 == b"vector<address>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<address>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<address>>(arg0, arg2));
        } else if (v0 == b"vector<bool>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<bool>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<bool>>(arg0, arg2));
        } else if (v0 == b"vector<id>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<0x2::object::ID>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<0x2::object::ID>>(arg0, arg2));
        } else if (v0 == b"vector<u8>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<u8>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<u8>>(arg0, arg2));
        } else if (v0 == b"vector<u16>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<u16>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<u16>>(arg0, arg2));
        } else if (v0 == b"vector<u32>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<u32>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<u32>>(arg0, arg2));
        } else if (v0 == b"vector<u64>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<u64>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<u64>>(arg0, arg2));
        } else if (v0 == b"vector<u128>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<u128>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<u128>>(arg0, arg2));
        } else if (v0 == b"vector<u256>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<u256>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<u256>>(arg0, arg2));
        } else if (v0 == b"vector<vector<u8>>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<vector<u8>>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<vector<u8>>>(arg0, arg2));
        } else if (v0 == b"vector<String>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<0x1::string::String>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<0x1::string::String>>(arg0, arg2));
        } else if (v0 == b"vector<Url>") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<0x2::url::Url>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<0x2::url::Url>>(arg0, arg2));
        } else if (v0 == b"VecMap") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, arg2));
        } else {
            assert!(v0 == b"vector<VecMap>", 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T1, vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>>(arg1, arg3, *0x2::dynamic_field::borrow<T0, vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>>(arg0, arg2));
        };
    }

    public fun get_bcs_bytes<T0: copy + drop + store>(arg0: &0x2::object::UID, arg1: T0, arg2: 0x1::string::String) : vector<u8> {
        let v0 = *0x1::string::bytes(&arg2);
        if (v0 == b"address") {
            0x2::bcs::to_bytes<address>(0x2::dynamic_field::borrow<T0, address>(arg0, arg1))
        } else if (v0 == b"bool") {
            0x2::bcs::to_bytes<bool>(0x2::dynamic_field::borrow<T0, bool>(arg0, arg1))
        } else if (v0 == b"id") {
            0x2::bcs::to_bytes<0x2::object::ID>(0x2::dynamic_field::borrow<T0, 0x2::object::ID>(arg0, arg1))
        } else if (v0 == b"u8") {
            0x2::bcs::to_bytes<u8>(0x2::dynamic_field::borrow<T0, u8>(arg0, arg1))
        } else if (v0 == b"u64") {
            0x2::bcs::to_bytes<u64>(0x2::dynamic_field::borrow<T0, u64>(arg0, arg1))
        } else if (v0 == b"u128") {
            0x2::bcs::to_bytes<u128>(0x2::dynamic_field::borrow<T0, u128>(arg0, arg1))
        } else if (v0 == b"String") {
            0x2::bcs::to_bytes<0x1::string::String>(0x2::dynamic_field::borrow<T0, 0x1::string::String>(arg0, arg1))
        } else if (v0 == b"Url") {
            0x2::bcs::to_bytes<0x2::url::Url>(0x2::dynamic_field::borrow<T0, 0x2::url::Url>(arg0, arg1))
        } else if (v0 == b"vector<address>") {
            0x2::bcs::to_bytes<vector<address>>(0x2::dynamic_field::borrow<T0, vector<address>>(arg0, arg1))
        } else if (v0 == b"vector<bool>") {
            0x2::bcs::to_bytes<vector<bool>>(0x2::dynamic_field::borrow<T0, vector<bool>>(arg0, arg1))
        } else if (v0 == b"vector<id>") {
            0x2::bcs::to_bytes<vector<0x2::object::ID>>(0x2::dynamic_field::borrow<T0, vector<0x2::object::ID>>(arg0, arg1))
        } else if (v0 == b"vector<u8>") {
            0x2::bcs::to_bytes<vector<u8>>(0x2::dynamic_field::borrow<T0, vector<u8>>(arg0, arg1))
        } else if (v0 == b"vector<u64>") {
            0x2::bcs::to_bytes<vector<u64>>(0x2::dynamic_field::borrow<T0, vector<u64>>(arg0, arg1))
        } else if (v0 == b"vector<u128>") {
            0x2::bcs::to_bytes<vector<u128>>(0x2::dynamic_field::borrow<T0, vector<u128>>(arg0, arg1))
        } else if (v0 == b"vector<String>") {
            0x2::bcs::to_bytes<vector<0x1::string::String>>(0x2::dynamic_field::borrow<T0, vector<0x1::string::String>>(arg0, arg1))
        } else if (v0 == b"vector<Url>") {
            0x2::bcs::to_bytes<vector<0x2::url::Url>>(0x2::dynamic_field::borrow<T0, vector<0x2::url::Url>>(arg0, arg1))
        } else if (v0 == b"VecMap") {
            0x2::bcs::to_bytes<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(0x2::dynamic_field::borrow<T0, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, arg1))
        } else {
            assert!(v0 == b"vector<VecMap>", 0);
            0x2::bcs::to_bytes<vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>>(0x2::dynamic_field::borrow<T0, vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>>(arg0, arg1))
        }
    }

    public fun set_field<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: bool) {
        if (!arg5 && 0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            return
        };
        if (!0x1::string::is_empty(&arg3) && arg3 != arg2) {
            drop_field<T0>(arg0, arg1, arg3);
        };
        let v0 = *0x1::string::bytes(&arg2);
        if (0x1::vector::length<u8>(&arg4) == 0) {
            if (v0 == b"String" || v0 == b"VecMap" || 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::encode::is_vector(arg2)) {
                arg4 = x"00";
            } else {
                drop_field<T0>(arg0, arg1, arg2);
                return
            };
        };
        if (v0 == b"address") {
            let (v1, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::address_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, address>(arg0, arg1, v1);
        } else if (v0 == b"bool") {
            let (v3, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::bool_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, bool>(arg0, arg1, v3);
        } else if (v0 == b"id") {
            let (v5, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::id_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, 0x2::object::ID>(arg0, arg1, v5);
        } else if (v0 == b"u8") {
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, u8>(arg0, arg1, *0x1::vector::borrow<u8>(&arg4, 0));
        } else if (v0 == b"u16") {
            let (v7, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::u16_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, u16>(arg0, arg1, v7);
        } else if (v0 == b"u32") {
            let (v9, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::u32_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, u32>(arg0, arg1, v9);
        } else if (v0 == b"u64") {
            let (v11, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::u64_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, u64>(arg0, arg1, v11);
        } else if (v0 == b"u128") {
            let (v13, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::u128_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, u128>(arg0, arg1, v13);
        } else if (v0 == b"u256") {
            let (v15, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::u256_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, u256>(arg0, arg1, v15);
        } else if (v0 == b"String") {
            let (v17, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::string_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, 0x1::string::String>(arg0, arg1, v17);
        } else if (v0 == b"Url") {
            let (v19, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::url_(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, 0x2::url::Url>(arg0, arg1, v19);
        } else if (v0 == b"vector<address>") {
            let (v21, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_address(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<address>>(arg0, arg1, v21);
        } else if (v0 == b"vector<bool>") {
            let (v23, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_bool(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<bool>>(arg0, arg1, v23);
        } else if (v0 == b"vector<id>") {
            let (v25, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_id(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<0x2::object::ID>>(arg0, arg1, v25);
        } else if (v0 == b"vector<u8>") {
            let (v27, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_u8(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<u8>>(arg0, arg1, v27);
        } else if (v0 == b"vector<u16>") {
            let (v29, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_u16(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<u16>>(arg0, arg1, v29);
        } else if (v0 == b"vector<u32>") {
            let (v31, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_u32(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<u32>>(arg0, arg1, v31);
        } else if (v0 == b"vector<u64>") {
            let (v33, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_u64(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<u64>>(arg0, arg1, v33);
        } else if (v0 == b"vector<u128>") {
            let (v35, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_u128(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<u128>>(arg0, arg1, v35);
        } else if (v0 == b"vector<u256>") {
            let (v37, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_u256(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<u256>>(arg0, arg1, v37);
        } else if (v0 == b"vector<vector<u8>>") {
            let (v39, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_vec_u8(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<vector<u8>>>(arg0, arg1, v39);
        } else if (v0 == b"vector<String>") {
            let (v41, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_string(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<0x1::string::String>>(arg0, arg1, v41);
        } else if (v0 == b"vector<Url>") {
            let (v43, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_url(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<0x2::url::Url>>(arg0, arg1, v43);
        } else if (v0 == b"VecMap") {
            let (v45, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_map_string_string(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>(arg0, arg1, v45);
        } else {
            assert!(v0 == b"vector<VecMap>", 0);
            let (v47, _) = 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::deserialize::vec_vec_map_string_string(&arg4, 0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, vector<0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>>>(arg0, arg1, v47);
        };
    }

    public fun set_field_<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: T1, arg5: bool) {
        if (!arg5 && 0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            return
        };
        if (!0x1::string::is_empty(&arg3) && arg3 != arg2) {
            drop_field<T0>(arg0, arg1, arg3);
        };
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::dynamic_field2::set<T0, T1>(arg0, arg1, arg4);
    }

    // decompiled from Move bytecode v6
}

