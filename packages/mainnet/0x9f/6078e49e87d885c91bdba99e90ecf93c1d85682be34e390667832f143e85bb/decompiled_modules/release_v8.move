module 0x9f6078e49e87d885c91bdba99e90ecf93c1d85682be34e390667832f143e85bb::release_v8 {
    struct ReleaseOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct ReleaseCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct ReleaseSetupInstallWitnessV2 has drop {
        dummy_field: bool,
    }

    struct ReleaseActivationWitnessV2 has drop {
        dummy_field: bool,
    }

    struct ReleaseLifecycleWitnessV2 has drop {
        dummy_field: bool,
    }

    struct ReleaseRightsWitnessV2 has drop {
        dummy_field: bool,
    }

    struct ReleasePackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        installation_commitment: vector<u8>,
    }

    struct ReleaseRenderWitnessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        control_epoch: u64,
        caller: address,
    }

    struct ReleaseTransportWitnessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        policy_config_id: 0x2::object::ID,
        caller: address,
    }

    struct MakerV8Activated has copy, drop {
        root_id: 0x2::object::ID,
        version: u64,
        owner: address,
        control_epoch: u64,
        admin_cap_id: 0x2::object::ID,
        maker_key: 0x1::string::String,
        maker_version: u64,
        version_commitment: vector<u8>,
        content_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        protocol_treasury_id: 0x2::object::ID,
        maker_treasury_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
        registry_ids: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2,
        replacement_id: 0x2::object::ID,
        bootstrap_certificate_id: 0x2::object::ID,
    }

    struct MakerV8LifecycleChanged has copy, drop {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        maker_version: u64,
        content_commitment: vector<u8>,
        owner: address,
        control_epoch: u64,
        from: u8,
        to: u8,
        registry_ids: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2,
    }

    fun approve_complete_fields_v8<T0>(arg0: vector<u8>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg5: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg6: address, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<u8>, arg16: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg1, arg2, arg3, arg4, arg5);
        assert!(arg15 == arg0, 1);
        let v0 = ReleaseTransportWitnessV8{
            root_id          : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg1),
            catalog_id       : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2),
            policy_config_id : 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_id_v8(arg5),
            caller           : 0x2::tx_context::sender(arg16),
        };
        let (v1, v2) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::certify_complete_receipt_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v0, arg2, arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let (_, _, _, _, _, _, _, _, v11) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_complete_decrypt_proof_v8<T0>(arg0, arg4, arg5, arg1, v2, arg16);
        assert!(v11 == arg15, 1);
        let ReleaseTransportWitnessV8 {
            root_id          : v12,
            catalog_id       : v13,
            policy_config_id : v14,
            caller           : v15,
        } = v1;
        assert!(v12 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg1), 2);
        assert!(v13 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2), 2);
        assert!(v14 == 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_id_v8(arg5), 2);
        assert!(v15 == 0x2::tx_context::sender(arg16), 2);
    }

    public fun archive_maker_v8<T0>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &ReleasePackageConfigV8, arg6: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg5);
        let v0 = ReleaseLifecycleWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::activation_v8::archive_maker_v8<T0, ReleaseLifecycleWitnessV2>(v0, arg2, arg3, arg4, arg0, arg1, arg6);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg5, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg0), 3, arg6);
    }

    fun assert_bound_root_catalog<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8) : &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2 {
        assert_root_product_binding<T0>(arg0, arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg0)
    }

    fun assert_config(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: &ReleasePackageConfigV8) {
        assert!(arg1.version == 8 && arg1.catalog_id == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg0), 0);
        let (_, _, _, v3, v4, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg0);
        assert!(&arg1.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v3) && &arg1.call_cap_set_commitment == v4, 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_role_config_installation_v2(arg0, 6, 0x2::object::id<ReleasePackageConfigV8>(arg1), &arg1.installation_commitment);
    }

    fun assert_control_readback<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: u8, arg5: &0x2::tx_context::TxContext) : &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_admin_v8<T0>(arg0, arg1);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg0) == arg4, 3);
        assert_bound_root_catalog<T0>(arg0, arg2, arg3)
    }

    fun assert_read_seal_binding<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg4: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8) {
        assert_config(arg1, arg2);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::seal_registry_id_v2(assert_bound_root_catalog<T0>(arg0, arg1, arg2)) == 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::registry_id_v8(arg3), 1);
        assert!(0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_catalog_id_v8(arg4) == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg1) && 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_call_cap_set_commitment_v8(arg4) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg0), 1);
    }

    fun assert_root_product_binding<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8) {
        assert_config(arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg0, arg1);
    }

    fun certify_and_finalize_protected_complete<T0>(arg0: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::ProtectedCompletePendingV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &mut 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg4: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg6: u64, arg7: &0x2::tx_context::TxContext) : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulMintAuthorizationV8 {
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg5);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2);
        let v2 = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_id_v8(arg4);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg1, arg2, arg4, arg5, 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::scope_complete_v8(), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_scope_key_v8(&arg0), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_complete_instance_commitment_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_asset_key_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_output_commitment_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_render_blob_id_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_render_sha256_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_render_blob_commitment_v8(&arg0));
        let (v7, v8) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::register_complete_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v5, arg3, arg5, arg4, arg2, arg6, v6);
        let (v9, v10) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::certify_complete_receipt_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v7, arg2, arg5, v3, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_receipt_id_v8(&arg0), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_output_id_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_recipe_commitment_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_render_commitment_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_output_commitment_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_receipt_commitment_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_scope_key_v8(&arg0), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::pending_asset_key_v8(&arg0), v8);
        let ReleaseTransportWitnessV8 {
            root_id          : v11,
            catalog_id       : v12,
            policy_config_id : v13,
            caller           : v14,
        } = v9;
        assert!(v11 == v0, 2);
        assert!(v12 == v1, 2);
        assert!(v13 == v2, 2);
        assert!(v14 == v3, 2);
        0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::finalize_protected_complete_v8<T0>(arg0, v8, arg3, arg4, arg5, v10, arg7)
    }

    public fun certify_base_ciphertext_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) : 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::CiphertextCertificationV8 {
        assert_config(arg1, arg2);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg4);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg1);
        let v2 = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_id_v8(arg3);
        let v3 = 0x2::tx_context::sender(arg12);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg0, arg1, arg3, arg4, 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::scope_base_v8(), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let ReleaseTransportWitnessV8 {
            root_id          : v7,
            catalog_id       : v8,
            policy_config_id : v9,
            caller           : v10,
        } = v5;
        assert!(v7 == v0, 2);
        assert!(v8 == v1, 2);
        assert!(v9 == v2, 2);
        assert!(v10 == v3, 2);
        v6
    }

    public fun certify_pack_ciphertext_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) : 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::CiphertextCertificationV8 {
        assert_config(arg1, arg2);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg4);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg1);
        let v2 = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_id_v8(arg3);
        let v3 = 0x2::tx_context::sender(arg12);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg0, arg1, arg3, arg4, 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::scope_pack_v8(), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let ReleaseTransportWitnessV8 {
            root_id          : v7,
            catalog_id       : v8,
            policy_config_id : v9,
            caller           : v10,
        } = v5;
        assert!(v7 == v0, 2);
        assert!(v8 == v1, 2);
        assert!(v9 == v2, 2);
        assert!(v10 == v3, 2);
        v6
    }

    public fun config_call_cap_set_commitment_v8(arg0: &ReleasePackageConfigV8) : &vector<u8> {
        &arg0.call_cap_set_commitment
    }

    public fun config_catalog_id_v8(arg0: &ReleasePackageConfigV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun config_id_v8(arg0: &ReleasePackageConfigV8) : 0x2::object::ID {
        0x2::object::id<ReleasePackageConfigV8>(arg0)
    }

    public fun config_product_binding_commitment_v8(arg0: &ReleasePackageConfigV8) : &vector<u8> {
        &arg0.product_binding_commitment
    }

    fun emit_activation<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleBootstrapCertificateV2) {
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_economics_v8<T0>(arg0);
        let v1 = MakerV8Activated{
            root_id                    : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>>(arg0),
            version                    : 8,
            owner                      : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg0),
            control_epoch              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_control_epoch_v2<T0>(arg0),
            admin_cap_id               : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8>(arg1),
            maker_key                  : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_key_v2<T0>(arg0),
            maker_version              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            version_commitment         : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_version_commitment_v2<T0>(arg0),
            content_commitment         : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            renderer_commitment        : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_renderer_commitment_v2<T0>(arg0),
            protocol_config_id         : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_id_v2(&v0),
            protocol_config_revision   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_revision_v2(&v0),
            protocol_config_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_config_commitment_v2(&v0),
            protocol_treasury_id       : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_protocol_treasury_id_v2(&v0),
            maker_treasury_id          : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_treasury_id_v2<T0>(arg0),
            catalog_id                 : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg2),
            product_binding_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_binding_commitment_v8<T0>(arg0),
            call_cap_set_commitment    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg0),
            base_registry_id           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_base_registry_id_v2<T0>(arg0),
            registry_ids               : *arg3,
            replacement_id             : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2>(arg4),
            bootstrap_certificate_id   : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleBootstrapCertificateV2>(arg5),
        };
        0x2::event::emit<MakerV8Activated>(v1);
    }

    fun emit_lifecycle_after_readback<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        let v0 = assert_control_readback<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        assert!(arg4 != arg5, 3);
        let v1 = if (arg4 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8() && arg5 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8()) {
            true
        } else if (arg4 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8() && arg5 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8()) {
            true
        } else {
            (arg4 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8() || arg4 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_paused_v8()) && arg5 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_archived_v8()
        };
        assert!(v1, 3);
        let v2 = MakerV8LifecycleChanged{
            root_id            : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            catalog_id         : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2),
            maker_version      : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            owner              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg0),
            control_epoch      : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_control_epoch_v2<T0>(arg0),
            from               : arg4,
            to                 : arg5,
            registry_ids       : *v0,
        };
        0x2::event::emit<MakerV8LifecycleChanged>(v2);
    }

    public fun finalize_product_release_binding_v8<T0>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &ReleasePackageConfigV8, arg5: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::finalize_product_release_binding_v8<T0>(arg0, arg1, arg2, arg3, arg5);
        assert_root_product_binding<T0>(arg0, arg3, arg4);
    }

    public fun finish_protected_complete_v8<T0>(arg0: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteSessionV8, arg1: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &ReleasePackageConfigV8, arg6: &mut 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg7: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg8: u64, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: &mut 0x2::tx_context::TxContext) : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulMintAuthorizationV8 {
        assert_config(arg4, arg5);
        let v0 = assert_bound_root_catalog<T0>(arg2, arg4, arg5);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg2) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8(), 3);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::output_registry_id_v2(v0) == 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8>(arg1), 1);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::seal_registry_id_v2(v0) == 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::registry_id_v8(arg6), 1);
        assert!(0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_catalog_id_v8(arg7) == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg4) && 0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::policy_call_cap_set_commitment_v8(arg7) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg2), 1);
        certify_and_finalize_protected_complete<T0>(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::finish_protected_complete_v8<T0>(arg0, arg1, arg2, arg9, arg10, arg11, arg12, arg13, arg14, arg15), arg3, arg4, arg6, arg7, arg2, arg8, arg15)
    }

    public fun finish_unprotected_complete_v8<T0>(arg0: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteSessionV8, arg1: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &ReleasePackageConfigV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulMintAuthorizationV8 {
        assert_config(arg4, arg6);
        let v0 = assert_bound_root_catalog<T0>(arg2, arg4, arg6);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg2) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8(), 3);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::output_registry_id_v2(v0) == 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8>(arg1), 1);
        let v1 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg2);
        let v2 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg4);
        let v3 = 0x2::object::id<0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8>(arg1);
        let v4 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_control_epoch_v2<T0>(arg2);
        let v5 = 0x2::tx_context::sender(arg11);
        let v6 = ReleaseRenderWitnessV8{
            root_id            : v1,
            catalog_id         : v2,
            output_registry_id : v3,
            control_epoch      : v4,
            caller             : v5,
        };
        let (v7, v8) = 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::finish_unprotected_complete_v8<T0, ReleaseRenderWitnessV8>(v6, arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11);
        let ReleaseRenderWitnessV8 {
            root_id            : v9,
            catalog_id         : v10,
            output_registry_id : v11,
            control_epoch      : v12,
            caller             : v13,
        } = v7;
        assert!(v9 == v1, 2);
        assert!(v10 == v2, 2);
        assert!(v11 == v3, 2);
        assert!(v12 == v4, 2);
        assert!(v13 == v5, 2);
        v8
    }

    public fun new_license_wrapped_rights_snapshot_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg3: &ReleasePackageConfigV8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: u16, arg9: u16, arg10: u16, arg11: &0x2::tx_context::TxContext) : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::RightsSnapshotV8 {
        assert_config(arg1, arg3);
        let v0 = ReleaseRightsWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::new_license_wrapped_rights_snapshot_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::certify_wrapped_rights_v8<ReleaseRightsWitnessV2>(v0, arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg11), arg8, arg9, arg10)
    }

    public fun new_release_package_config_v8(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::PackageCallCapV8<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ReleaseRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : ReleasePackageConfigV8 {
        let v0 = 0x2::object::new(arg2);
        let v1 = ReleaseSetupInstallWitnessV2{dummy_field: false};
        let (_, _, _, v5, v6, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg0);
        ReleasePackageConfigV8{
            id                         : v0,
            version                    : 8,
            catalog_id                 : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg0),
            product_binding_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v5),
            call_cap_set_commitment    : *v6,
            installation_commitment    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::consume_release_call_cap_v8<ReleaseSetupInstallWitnessV2>(arg0, arg1, v1, 0x2::object::uid_to_inner(&v0)),
        }
    }

    public fun pause_maker_v8<T0>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &ReleasePackageConfigV8, arg6: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg5);
        let v0 = ReleaseLifecycleWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::activation_v8::pause_maker_v8<T0, ReleaseLifecycleWitnessV2>(v0, arg2, arg3, arg4, arg0, arg1, arg6);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg5, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg0), 2, arg6);
    }

    public fun prepare_maker_companion_binding_v2<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::WalrusCertificationPolicyV1, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::CertifiedLivingContentV1, arg8: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg10: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg11: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackAdmissionAuthorityV8, arg12: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg13: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg14: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputPackageConfigV8, arg15: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::OutputRegistryV8, arg16: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::SoulRegistryV8, arg17: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalPackageConfigV8, arg18: &0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::PhysicalRegistryV8, arg19: &0x2::tx_context::TxContext) : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0> {
        0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8::bind_maker_physical_companion_v2<T0>(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::bind_output_companion_v2<T0>(0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::bind_maker_seal_companion_v2<T0>(0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::bind_runtime_companion_v2<T0>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::begin_maker_companion_binding_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg19), arg0, arg1, arg2, arg3, arg4, arg9, arg10, arg11, arg19), arg0, arg1, arg2, arg3, arg4, arg12, arg13, arg19), arg0, arg1, arg2, arg3, arg4, arg14, arg15, arg16, arg19), arg0, arg1, arg2, arg3, arg4, arg17, arg18, arg5, arg19)
    }

    public fun resume_maker_v8<T0>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &ReleasePackageConfigV8, arg6: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg5);
        let v0 = ReleaseLifecycleWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::activation_v8::resume_maker_v8<T0, ReleaseLifecycleWitnessV2>(v0, arg2, arg3, arg4, arg0, arg1, arg6);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg5, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg0), 1, arg6);
    }

    public fun seal_and_activate_maker_v8<T0>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleBootstrapCertificateV2, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::WalrusCertificationPolicyV1, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::CertifiedLivingContentV1, arg8: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg10: &ReleasePackageConfigV8, arg11: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg10);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg0);
        let v1 = ReleaseActivationWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::activation_v8::activate_maker_v8<T0, ReleaseActivationWitnessV2>(v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg0, arg1, arg9, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::pack_registry_id_v2(v0), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::admission_authority_id_v2(v0), *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_expected_pack_admission_policy_commitment_v2<T0>(arg0), arg11);
        emit_activation<T0>(arg0, arg1, arg3, assert_control_readback<T0>(arg0, arg1, arg3, arg10, 1, arg11), arg4, arg5);
    }

    entry fun seal_approve_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg3: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg8: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg9: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: vector<u8>, arg15: vector<u8>, arg16: vector<u8>, arg17: &0x2::tx_context::TxContext) {
        assert!(!0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::is_soul_equipment_v8(arg2), 1);
        assert_read_seal_binding<T0>(arg5, arg7, arg1, arg8, arg9);
        0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg8, arg9, arg5, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::certify_protected_base_entitlement_v8<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17), arg17);
    }

    entry fun seal_approve_complete_v8<T0>(arg0: vector<u8>, arg1: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg2: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::NativeSoulBindingV8, arg3: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteOutputV8, arg4: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::CompleteReceiptV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg8: &ReleasePackageConfigV8, arg9: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg10: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg11: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::consume_native_complete_decrypt_proof_v8(0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_v8_binding::certify_native_complete_read_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg11));
        approve_complete_fields_v8<T0>(arg0, arg5, arg7, arg8, arg9, arg10, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, arg11);
    }

    entry fun seal_approve_equipped_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg10: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg11: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg12: u64, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg7, arg9, arg1, arg10, arg11);
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg2, arg4, arg3, arg19);
        0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg10, arg11, arg7, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::certify_protected_base_entitlement_v8<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19), arg19);
    }

    entry fun seal_approve_equipped_owned_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedBaseItemV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg11: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg12: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg13: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg14: u64, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg9, arg11, arg1, arg12, arg13);
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg2, arg4, arg3, arg21);
        0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg12, arg13, arg9, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::certify_protected_owned_base_entitlement_v8<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), arg21);
    }

    entry fun seal_approve_equipped_pack_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::soul::SoulState, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg11: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg12: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg13: u64, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: vector<u8>, arg18: 0x1::string::String, arg19: vector<u8>, arg20: vector<u8>, arg21: vector<u8>, arg22: vector<u8>, arg23: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg9, arg8, arg1, arg11, arg12);
        0xe870d11e9922fa2f047bd5c1710401b5421a97c4b2100090bb1c762636c2fc41::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg2, arg4, arg3, arg23);
        0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_pack_decrypt_proof_v8<T0>(arg0, arg11, arg12, arg9, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::certify_protected_pack_entitlement_v8<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23), arg23);
    }

    entry fun seal_approve_owned_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg3: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::OwnedBaseItemV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg10: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg11: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg12: u64, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: &0x2::tx_context::TxContext) {
        assert!(!0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::is_soul_equipment_v8(arg2), 1);
        assert_read_seal_binding<T0>(arg7, arg9, arg1, arg10, arg11);
        0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg10, arg11, arg7, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::certify_protected_owned_base_entitlement_v8<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19), arg19);
    }

    entry fun seal_approve_pack_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg3: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg7: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerAccessPassV8, arg9: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealRegistryV8, arg10: &0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::SealPolicyConfigV8, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<u8>, arg16: 0x1::string::String, arg17: vector<u8>, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: &0x2::tx_context::TxContext) {
        assert!(!0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::is_soul_equipment_v8(arg2), 1);
        assert_read_seal_binding<T0>(arg7, arg6, arg1, arg9, arg10);
        0x12504100e9b3315562d84b874034b805ad1be2fd7472ccf40506f489e45855f2::seal_v8::consume_pack_decrypt_proof_v8<T0>(arg0, arg9, arg10, arg7, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_seal_v8::certify_protected_pack_entitlement_v8<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), arg21);
    }

    public fun share_release_package_config_v8(arg0: ReleasePackageConfigV8) {
        0x2::transfer::share_object<ReleasePackageConfigV8>(arg0);
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

