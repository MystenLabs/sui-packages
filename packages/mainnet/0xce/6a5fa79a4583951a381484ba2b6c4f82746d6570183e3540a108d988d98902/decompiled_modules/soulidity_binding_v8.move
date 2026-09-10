module 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::soulidity_binding_v8 {
    public fun assert_mint_witness_v8<T0: drop>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) {
        assert!(0x1::type_name::with_original_ids<T0>() == mint_witness_original_v8(arg0) && 0x1::type_name::with_defining_ids<T0>() == mint_witness_defining_v8(arg0), 0);
    }

    fun assert_name<T0>(arg0: vector<u8>, arg1: vector<u8>) {
        assert_named(0x1::type_name::with_original_ids<T0>(), &arg0, &arg1);
        assert_named(0x1::type_name::with_defining_ids<T0>(), &arg0, &arg1);
    }

    fun assert_named(arg0: 0x1::type_name::TypeName, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::module_string(&arg0));
        let v1 = if (&v0 == arg1) {
            let v2 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&arg0));
            &v2 == arg2
        } else {
            false
        };
        assert!(v1, 0);
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&arg0));
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0));
        assert!(0x1::vector::length<u8>(&v4) == 0x1::vector::length<u8>(&v3) + 4 + 0x1::vector::length<u8>(arg1) + 0x1::vector::length<u8>(arg2), 0);
    }

    public fun assert_native_soul_v8<T0: key>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) {
        assert!(0x1::type_name::with_original_ids<T0>() == native_soul_original_v8(arg0) && 0x1::type_name::with_defining_ids<T0>() == native_soul_defining_v8(arg0), 0);
    }

    public fun assert_owner_witness_v8<T0: drop>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) {
        assert!(0x1::type_name::with_original_ids<T0>() == owner_witness_original_v8(arg0) && 0x1::type_name::with_defining_ids<T0>() == owner_witness_defining_v8(arg0), 0);
    }

    fun assert_package_lineage(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address) {
        let v0 = if (arg0 == arg1) {
            if (arg1 == arg2) {
                arg3 == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun binding_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::SoulidityBindingV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::borrow_soulidity_binding_v8(arg0)
    }

    public fun install_soulidity_binding_v8<T0: key, T1: drop, T2: drop>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        assert_name<T0>(b"soul", b"Soul");
        assert_name<T1>(b"animacraft_v8_binding", b"MintBindingWitnessV8");
        assert_name<T2>(b"animacraft_v8_binding", b"SoulOwnerWitnessV8");
        assert_package_lineage(0x1::type_name::original_id<T0>(), 0x1::type_name::original_id<T1>(), 0x1::type_name::original_id<T2>(), 0x1::type_name::defining_id<T1>(), 0x1::type_name::defining_id<T2>());
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::attach_soulidity_binding_v8(arg0, arg1, 0x1::type_name::with_original_ids<T0>(), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_original_ids<T1>(), 0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_original_ids<T2>(), 0x1::type_name::with_defining_ids<T2>());
    }

    public fun mint_witness_defining_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : 0x1::type_name::TypeName {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::soulidity_mint_defining_v8(binding_v8(arg0))
    }

    public fun mint_witness_original_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : 0x1::type_name::TypeName {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::soulidity_mint_original_v8(binding_v8(arg0))
    }

    public fun native_soul_defining_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : 0x1::type_name::TypeName {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::soulidity_soul_defining_v8(binding_v8(arg0))
    }

    public fun native_soul_original_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : 0x1::type_name::TypeName {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::soulidity_soul_original_v8(binding_v8(arg0))
    }

    public fun owner_witness_defining_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : 0x1::type_name::TypeName {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::soulidity_owner_defining_v8(binding_v8(arg0))
    }

    public fun owner_witness_original_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8) : 0x1::type_name::TypeName {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::soulidity_owner_original_v8(binding_v8(arg0))
    }

    // decompiled from Move bytecode v7
}

