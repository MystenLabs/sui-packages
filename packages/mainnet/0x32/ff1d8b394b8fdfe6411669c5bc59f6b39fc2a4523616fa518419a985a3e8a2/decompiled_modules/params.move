module 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params {
    public fun encode_uint<T0: drop>(arg0: T0, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<T0>(&arg0);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(v1 <= arg1, 4);
        if (v1 < arg1) {
            let v2 = 0;
            while (v2 < arg1 - v1) {
                0x1::vector::push_back<u8>(&mut v0, 0);
                v2 = v2 + 1;
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun get_account_address_and_module_name(arg0: 0x1::type_name::TypeName) : (address, 0x1::string::String) {
        (0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(&arg0)))), 0x1::string::from_ascii(0x1::type_name::module_string(&arg0)))
    }

    public fun get_struct_name(arg0: &0x1::type_name::TypeName) : vector<u8> {
        assert!(!0x1::type_name::is_primitive(arg0), 3);
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(arg0));
        let v1 = 0x2::address::length() * 2 + 2;
        let v2 = 58;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = if (*0x1::vector::borrow<u8>(v0, v1) == v2) {
                if (v1 + 1 < 0x1::vector::length<u8>(v0)) {
                    *0x1::vector::borrow<u8>(v0, v1 + 1) == v2
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v1 = v1 + 2;
                break
            };
            v1 = v1 + 1;
        };
        let v4 = b"";
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v1);
            if (v5 == 60) {
                break
            };
            0x1::vector::push_back<u8>(&mut v4, v5);
            v1 = v1 + 1;
        };
        v4
    }

    public fun right_pad_vec(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 < arg1) {
            let v1 = 0;
            while (v1 < arg1 - v0) {
                0x1::vector::push_back<u8>(arg0, 0);
                v1 = v1 + 1;
            };
        };
    }

    public fun slice<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        assert!(arg1 + arg2 <= 0x1::vector::length<T0>(arg0), 2);
        let v0 = 0x1::vector::empty<T0>();
        while (arg1 < arg1 + arg2) {
            0x1::vector::push_back<T0>(&mut v0, *0x1::vector::borrow<T0>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun vector_u8_gt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 == 0x1::vector::length<u8>(arg1), 1);
        if (v0 == 0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            let v3 = *0x1::vector::borrow<u8>(arg1, v1);
            if (v2 > v3) {
                return true
            };
            if (v2 < v3) {
                return false
            };
            v1 = v1 + 1;
        };
        false
    }

    // decompiled from Move bytecode v6
}

