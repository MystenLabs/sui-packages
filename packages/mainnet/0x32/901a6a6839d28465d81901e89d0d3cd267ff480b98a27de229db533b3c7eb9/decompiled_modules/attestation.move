module 0xa0ab220feb3e4a14be664cc8fa889aa6bd95815012a90f405e4fef4ecb89fe07::attestation {
    public fun assert_membership(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: &vector<vector<u8>>) {
        assert!(verify_membership(arg0, arg1, arg2), 2);
    }

    public fun leaf_hash(arg0: 0x2::object::ID) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x2::hash::keccak256(&v0)
    }

    fun lte(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = if (0x1::vector::length<u8>(arg0) < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::length<u8>(arg0)
        } else {
            0x1::vector::length<u8>(arg1)
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) < *0x1::vector::borrow<u8>(arg1, v1)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v1) > *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        0x1::vector::length<u8>(arg0) <= 0x1::vector::length<u8>(arg1)
    }

    fun node_hash(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = x"01";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::keccak256(&v0)
    }

    public fun trait_message(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) : vector<u8> {
        let v0 = b"";
        let v1 = b"GEMSUI::TRAIT_ATTESTATION::V1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<u8>>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        v0
    }

    public fun type_string<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun verify_membership(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: &vector<vector<u8>>) : bool {
        assert!(0x1::vector::length<vector<u8>>(arg2) <= 32, 4);
        let v0 = leaf_hash(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(arg2, v1);
            let v3 = if (lte(&v0, &v2)) {
                node_hash(&v0, &v2)
            } else {
                node_hash(&v2, &v0)
            };
            v0 = v3;
            v1 = v1 + 1;
        };
        &v0 == arg0
    }

    public fun verify_trait(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &vector<u8>, arg8: u64) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 3);
        assert!(arg8 <= arg6, 1);
        let v0 = trait_message(arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(0x2::ed25519::ed25519_verify(arg7, arg0, &v0), 0);
    }

    // decompiled from Move bytecode v7
}

