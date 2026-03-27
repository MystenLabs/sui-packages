module 0x120fdca1774a9543ace0f4a38fb06efadae8966c58de1783d6e30d8d6a50b024::version_witness {
    struct VersionWitness has copy, drop {
        package_addr: address,
    }

    fun is_valid_version_module(arg0: &0x1::ascii::String) : bool {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = b"version";
        let v2 = if (v0 == &v1) {
            true
        } else {
            let v3 = b"version_witness";
            v0 == &v3
        };
        if (v2) {
            return true
        };
        let v4 = 0x1::vector::length<u8>(v0);
        let v5 = b"_version";
        let v6 = 0x1::vector::length<u8>(&v5);
        if (v4 <= v6) {
            return false
        };
        let v7 = 0;
        while (v7 < v6) {
            let v8 = b"_version";
            if (*0x1::vector::borrow<u8>(v0, v4 - v6 + v7) != *0x1::vector::borrow<u8>(&v8, v7)) {
                return false
            };
            v7 = v7 + 1;
        };
        true
    }

    fun is_valid_version_struct_name(arg0: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 < 2) {
            return false
        };
        if (*0x1::vector::borrow<u8>(arg0, 0) != 86) {
            return false
        };
        let v1 = 1;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (v2 < 48 || v2 > 57) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun is_valid_version_witness_type(arg0: &0x1::type_name::TypeName) : bool {
        if (0x1::type_name::is_primitive(arg0)) {
            return false
        };
        let v0 = 0x1::type_name::module_string(arg0);
        if (!is_valid_version_module(&v0)) {
            return false
        };
        let v1 = struct_name_bytes(arg0);
        is_valid_version_struct_name(&v1)
    }

    public fun new<T0: drop>(arg0: T0) : VersionWitness {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(is_valid_version_witness_type(&v0), 0);
        VersionWitness{package_addr: 0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(&v0))))}
    }

    public fun package_addr(arg0: &VersionWitness) : address {
        arg0.package_addr
    }

    fun struct_name_bytes(arg0: &0x1::type_name::TypeName) : vector<u8> {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        let v1 = 0x1::type_name::address_string(arg0);
        let v2 = 0x1::type_name::module_string(arg0);
        let v3 = 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v1)) + 2 + 0x1::vector::length<u8>(0x1::ascii::as_bytes(&v2)) + 2;
        if (v3 >= 0x1::vector::length<u8>(v0)) {
            return b""
        };
        let v4 = b"";
        while (v3 < 0x1::vector::length<u8>(v0)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v3);
            if (v5 == 60) {
                break
            };
            0x1::vector::push_back<u8>(&mut v4, v5);
            v3 = v3 + 1;
        };
        v4
    }

    // decompiled from Move bytecode v6
}

