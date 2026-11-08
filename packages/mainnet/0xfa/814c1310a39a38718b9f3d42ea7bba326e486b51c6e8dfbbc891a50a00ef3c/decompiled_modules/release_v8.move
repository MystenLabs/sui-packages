module 0xfa814c1310a39a38718b9f3d42ea7bba326e486b51c6e8dfbbc891a50a00ef3c::release_v8 {
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
        registry_ids: 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2,
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
        registry_ids: 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2,
    }

    public fun archive_maker_v8<T0>(arg0: &mut 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &ReleasePackageConfigV8, arg6: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg5);
        let v0 = ReleaseLifecycleWitnessV2{dummy_field: false};
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::activation_v8::archive_maker_v8<T0, ReleaseLifecycleWitnessV2>(v0, arg2, arg3, arg4, arg0, arg1, arg6);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg5, 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_lifecycle_v8<T0>(arg0), 3, arg6);
    }

    public fun pause_maker_v8<T0>(arg0: &mut 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &ReleasePackageConfigV8, arg6: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg5);
        let v0 = ReleaseLifecycleWitnessV2{dummy_field: false};
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::activation_v8::pause_maker_v8<T0, ReleaseLifecycleWitnessV2>(v0, arg2, arg3, arg4, arg0, arg1, arg6);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg5, 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_lifecycle_v8<T0>(arg0), 2, arg6);
    }

    public fun resume_maker_v8<T0>(arg0: &mut 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &ReleasePackageConfigV8, arg6: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg5);
        let v0 = ReleaseLifecycleWitnessV2{dummy_field: false};
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::activation_v8::resume_maker_v8<T0, ReleaseLifecycleWitnessV2>(v0, arg2, arg3, arg4, arg0, arg1, arg6);
        emit_lifecycle_after_readback<T0>(arg0, arg1, arg3, arg5, 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_lifecycle_v8<T0>(arg0), 1, arg6);
    }

    public fun finalize_product_release_binding_v8<T0>(arg0: &mut 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg4: &ReleasePackageConfigV8, arg5: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg4);
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::finalize_product_release_binding_v8<T0>(arg0, arg1, arg2, arg3, arg5);
        assert_root_product_binding<T0>(arg0, arg3, arg4);
    }

    public fun new_license_wrapped_rights_snapshot_v8(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg3: &ReleasePackageConfigV8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: u16, arg9: u16, arg10: u16, arg11: &0x2::tx_context::TxContext) : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::RightsSnapshotV8 {
        assert_config(arg1, arg3);
        let v0 = ReleaseRightsWitnessV2{dummy_field: false};
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::new_license_wrapped_rights_snapshot_v8(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::certify_wrapped_rights_v8<ReleaseRightsWitnessV2>(v0, arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg11), arg8, arg9, arg10)
    }

    public fun finish_protected_complete_v8<T0>(arg0: 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteSessionV8, arg1: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputRegistryV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg5: &ReleasePackageConfigV8, arg6: &mut 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg7: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg8: u64, arg9: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: &mut 0x2::tx_context::TxContext) : 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::SoulMintAuthorizationV8 {
        assert_config(arg4, arg5);
        let v0 = assert_bound_root_catalog<T0>(arg2, arg4, arg5);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_lifecycle_v8<T0>(arg2) == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_active_v8(), 3);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::output_registry_id_v2(v0) == 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputRegistryV8>(arg1), 1);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::seal_registry_id_v2(v0) == 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::registry_id_v8(arg6), 1);
        assert!(0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_catalog_id_v8(arg7) == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8>(arg4) && 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_call_cap_set_commitment_v8(arg7) == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg2), 1);
        certify_and_finalize_protected_complete<T0>(0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::finish_protected_complete_v8<T0>(arg0, arg1, arg2, arg9, arg10, arg11, arg12, arg13, arg14, arg15), arg3, arg4, arg6, arg7, arg2, arg8, arg15)
    }

    public fun finish_unprotected_complete_v8<T0>(arg0: 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteSessionV8, arg1: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputRegistryV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &ReleasePackageConfigV8, arg7: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::SoulMintAuthorizationV8 {
        assert_config(arg4, arg6);
        let v0 = assert_bound_root_catalog<T0>(arg2, arg4, arg6);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_lifecycle_v8<T0>(arg2) == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_active_v8(), 3);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::output_registry_id_v2(v0) == 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputRegistryV8>(arg1), 1);
        let v1 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg2);
        let v2 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg4);
        let v3 = 0x2::object::id<0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputRegistryV8>(arg1);
        let v4 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_control_epoch_v2<T0>(arg2);
        let v5 = 0x2::tx_context::sender(arg11);
        let v6 = ReleaseRenderWitnessV8{
            root_id            : v1,
            catalog_id         : v2,
            output_registry_id : v3,
            control_epoch      : v4,
            caller             : v5,
        };
        let (v7, v8) = 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::finish_unprotected_complete_v8<T0, ReleaseRenderWitnessV8>(v6, arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11);
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

    fun approve_complete_fields_v8<T0>(arg0: vector<u8>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg5: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg6: address, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<u8>, arg16: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg1, arg2, arg3, arg4, arg5);
        assert!(arg15 == arg0, 1);
        let v0 = ReleaseTransportWitnessV8{
            root_id          : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg1),
            catalog_id       : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg2),
            policy_config_id : 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_id_v8(arg5),
            caller           : 0x2::tx_context::sender(arg16),
        };
        let (v1, v2) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::certify_complete_receipt_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v0, arg2, arg1, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let (_, _, _, _, _, _, _, _, v11) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_complete_decrypt_proof_v8<T0>(arg0, arg4, arg5, arg1, v2, arg16);
        assert!(v11 == arg15, 1);
        let ReleaseTransportWitnessV8 {
            root_id          : v12,
            catalog_id       : v13,
            policy_config_id : v14,
            caller           : v15,
        } = v1;
        assert!(v12 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg1), 2);
        assert!(v13 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg2), 2);
        assert!(v14 == 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_id_v8(arg5), 2);
        assert!(v15 == 0x2::tx_context::sender(arg16), 2);
    }

    fun assert_bound_root_catalog<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8) : &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2 {
        assert_root_product_binding<T0>(arg0, arg1, arg2);
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_companion_registry_ids_v2<T0>(arg0)
    }

    fun assert_config(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg1: &ReleasePackageConfigV8) {
        assert!(arg1.version == 8 && arg1.catalog_id == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8>(arg0), 0);
        let (_, _, _, v3, v4, _) = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_terms_v2(arg0);
        assert!(&arg1.product_binding_commitment == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::product_binding_commitment_v8(v3) && &arg1.call_cap_set_commitment == v4, 0);
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::assert_role_config_installation_v2(arg0, 6, 0x2::object::id<ReleasePackageConfigV8>(arg1), &arg1.installation_commitment);
    }

    fun assert_control_readback<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: u8, arg5: &0x2::tx_context::TxContext) : &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2 {
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::assert_admin_v8<T0>(arg0, arg1);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_owner_v8<T0>(arg0) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_lifecycle_v8<T0>(arg0) == arg4, 3);
        assert_bound_root_catalog<T0>(arg0, arg2, arg3)
    }

    fun assert_read_seal_binding<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg4: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8) {
        assert_config(arg1, arg2);
        assert!(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::seal_registry_id_v2(assert_bound_root_catalog<T0>(arg0, arg1, arg2)) == 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::registry_id_v8(arg3), 1);
        assert!(0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_catalog_id_v8(arg4) == 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8>(arg1) && 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_call_cap_set_commitment_v8(arg4) == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg0), 1);
    }

    fun assert_root_product_binding<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8) {
        assert_config(arg1, arg2);
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::assert_product_release_catalog_v8<T0>(arg0, arg1);
    }

    fun certify_and_finalize_protected_complete<T0>(arg0: 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::ProtectedCompletePendingV8, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg3: &mut 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg4: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg6: u64, arg7: &0x2::tx_context::TxContext) : 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::SoulMintAuthorizationV8 {
        let v0 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg5);
        let v1 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg2);
        let v2 = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_id_v8(arg4);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg1, arg2, arg4, arg5, 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::scope_complete_v8(), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_scope_key_v8(&arg0), 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_complete_instance_commitment_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_asset_key_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_output_commitment_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_render_blob_id_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_render_sha256_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_render_blob_commitment_v8(&arg0));
        let (v7, v8) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::register_complete_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v5, arg3, arg5, arg4, arg2, arg6, v6);
        let (v9, v10) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::certify_complete_receipt_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v7, arg2, arg5, v3, 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_receipt_id_v8(&arg0), 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_output_id_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_recipe_commitment_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_render_commitment_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_output_commitment_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_receipt_commitment_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_scope_key_v8(&arg0), *0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::pending_asset_key_v8(&arg0), v8);
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
        0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::finalize_protected_complete_v8<T0>(arg0, v8, arg3, arg4, arg5, v10, arg7)
    }

    public fun certify_base_ciphertext_v8<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) : 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::CiphertextCertificationV8 {
        assert_config(arg1, arg2);
        let v0 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg4);
        let v1 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg1);
        let v2 = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_id_v8(arg3);
        let v3 = 0x2::tx_context::sender(arg12);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg0, arg1, arg3, arg4, 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::scope_base_v8(), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
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

    public fun certify_pack_ciphertext_v8<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg2: &ReleasePackageConfigV8, arg3: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg5: 0x1::string::String, arg6: vector<u8>, arg7: 0x1::string::String, arg8: vector<u8>, arg9: 0x1::string::String, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::tx_context::TxContext) : 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::CiphertextCertificationV8 {
        assert_config(arg1, arg2);
        let v0 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg4);
        let v1 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg1);
        let v2 = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::policy_id_v8(arg3);
        let v3 = 0x2::tx_context::sender(arg12);
        let v4 = ReleaseTransportWitnessV8{
            root_id          : v0,
            catalog_id       : v1,
            policy_config_id : v2,
            caller           : v3,
        };
        let (v5, v6) = 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::certify_ciphertext_v8<T0, ReleaseOriginalMarkerV8, ReleaseTransportWitnessV8>(v4, arg0, arg1, arg3, arg4, 0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::scope_pack_v8(), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
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

    fun emit_activation<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::MakerRuntimeCompanionRegistryIdsV2, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleBootstrapCertificateV2) {
        let v0 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_economics_v8<T0>(arg0);
        let v1 = MakerV8Activated{
            root_id                    : 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>>(arg0),
            version                    : 8,
            owner                      : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_owner_v8<T0>(arg0),
            control_epoch              : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_control_epoch_v2<T0>(arg0),
            admin_cap_id               : 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8>(arg1),
            maker_key                  : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_maker_key_v2<T0>(arg0),
            maker_version              : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_maker_version_v8<T0>(arg0),
            version_commitment         : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_version_commitment_v2<T0>(arg0),
            content_commitment         : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_content_commitment_v8<T0>(arg0),
            renderer_commitment        : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_renderer_commitment_v2<T0>(arg0),
            protocol_config_id         : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::economics_protocol_config_id_v2(&v0),
            protocol_config_revision   : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::economics_protocol_config_revision_v2(&v0),
            protocol_config_commitment : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::economics_protocol_config_commitment_v2(&v0),
            protocol_treasury_id       : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::economics_protocol_treasury_id_v2(&v0),
            maker_treasury_id          : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_maker_treasury_id_v2<T0>(arg0),
            catalog_id                 : 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8>(arg2),
            product_binding_commitment : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_product_release_binding_commitment_v8<T0>(arg0),
            call_cap_set_commitment    : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg0),
            base_registry_id           : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_base_registry_id_v2<T0>(arg0),
            registry_ids               : *arg3,
            replacement_id             : 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2>(arg4),
            bootstrap_certificate_id   : 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleBootstrapCertificateV2>(arg5),
        };
        0x2::event::emit<MakerV8Activated>(v1);
    }

    fun emit_lifecycle_after_readback<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg3: &ReleasePackageConfigV8, arg4: u8, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        let v0 = assert_control_readback<T0>(arg0, arg1, arg2, arg3, arg5, arg6);
        assert!(arg4 != arg5, 3);
        let v1 = if (arg4 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_active_v8() && arg5 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_paused_v8()) {
            true
        } else if (arg4 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_paused_v8() && arg5 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_active_v8()) {
            true
        } else {
            (arg4 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_active_v8() || arg4 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_paused_v8()) && arg5 == 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::lifecycle_archived_v8()
        };
        assert!(v1, 3);
        let v2 = MakerV8LifecycleChanged{
            root_id            : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_id_v8<T0>(arg0),
            catalog_id         : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_id_v8(arg2),
            maker_version      : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_maker_version_v8<T0>(arg0),
            content_commitment : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_content_commitment_v8<T0>(arg0),
            owner              : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_owner_v8<T0>(arg0),
            control_epoch      : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_control_epoch_v2<T0>(arg0),
            from               : arg4,
            to                 : arg5,
            registry_ids       : *v0,
        };
        0x2::event::emit<MakerV8LifecycleChanged>(v2);
    }

    public fun new_release_package_config_v8(arg0: &mut 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg1: 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::PackageCallCapV8<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ReleaseRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : ReleasePackageConfigV8 {
        let v0 = 0x2::object::new(arg2);
        let v1 = ReleaseSetupInstallWitnessV2{dummy_field: false};
        let (_, _, _, v5, v6, _) = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::catalog_terms_v2(arg0);
        ReleasePackageConfigV8{
            id                         : v0,
            version                    : 8,
            catalog_id                 : 0x2::object::id<0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8>(arg0),
            product_binding_commitment : *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::product_binding_commitment_v8(v5),
            call_cap_set_commitment    : *v6,
            installation_commitment    : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::consume_release_call_cap_v8<ReleaseSetupInstallWitnessV2>(arg0, arg1, v1, 0x2::object::uid_to_inner(&v0)),
        }
    }

    public fun prepare_maker_companion_binding_v2<T0>(arg0: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::core_v8::WalrusCertificationPolicyV1, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::core_v8::CertifiedLivingContentV1, arg8: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg9: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg10: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg11: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackAdmissionAuthorityV8, arg12: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg13: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg14: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputPackageConfigV8, arg15: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::OutputRegistryV8, arg16: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::SoulRegistryV8, arg17: &0x739087caba482780561ac8ba99c3898fdf7fc371d421ecd7243060e72cbe096f::physical_v8::PhysicalPackageConfigV8, arg18: &0x739087caba482780561ac8ba99c3898fdf7fc371d421ecd7243060e72cbe096f::physical_v8::PhysicalRegistryV8, arg19: &0x2::tx_context::TxContext) : 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0> {
        0x739087caba482780561ac8ba99c3898fdf7fc371d421ecd7243060e72cbe096f::physical_v8::bind_maker_physical_companion_v2<T0>(0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::bind_output_companion_v2<T0>(0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::bind_maker_seal_companion_v2<T0>(0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::bind_runtime_companion_v2<T0>(0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::core_v8::begin_maker_companion_binding_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg19), arg0, arg1, arg2, arg3, arg4, arg9, arg10, arg11, arg19), arg0, arg1, arg2, arg3, arg4, arg12, arg13, arg19), arg0, arg1, arg2, arg3, arg4, arg14, arg15, arg16, arg19), arg0, arg1, arg2, arg3, arg4, arg17, arg18, arg5, arg19)
    }

    public fun seal_and_activate_maker_v8<T0>(arg0: &mut 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg1: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerAdminCapV8, arg2: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::FreshTupleBootstrapCertificateV2, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::core_v8::WalrusCertificationPolicyV1, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::core_v8::CertifiedLivingContentV1, arg8: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg9: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg10: &ReleasePackageConfigV8, arg11: &0x2::tx_context::TxContext) {
        assert_config(arg3, arg10);
        let v0 = 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_companion_registry_ids_v2<T0>(arg0);
        let v1 = ReleaseActivationWitnessV2{dummy_field: false};
        0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::activation_v8::activate_maker_v8<T0, ReleaseActivationWitnessV2>(v1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg0, arg1, arg9, 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::pack_registry_id_v2(v0), 0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::companion_binding_v2::admission_authority_id_v2(v0), *0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::root_expected_pack_admission_policy_commitment_v2<T0>(arg0), arg11);
        emit_activation<T0>(arg0, arg1, arg3, assert_control_readback<T0>(arg0, arg1, arg3, arg10, 1, arg11), arg4, arg5);
    }

    entry fun seal_approve_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg8: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg9: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: vector<u8>, arg15: vector<u8>, arg16: vector<u8>, arg17: &0x2::tx_context::TxContext) {
        assert!(!0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::is_soul_equipment_v8(arg2), 1);
        assert_read_seal_binding<T0>(arg5, arg7, arg1, arg8, arg9);
        0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg8, arg9, arg5, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::certify_protected_base_entitlement_v8<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17), arg17);
    }

    entry fun seal_approve_complete_v8<T0>(arg0: vector<u8>, arg1: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg2: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::NativeSoulBindingV8, arg3: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteOutputV8, arg4: &0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::CompleteReceiptV8, arg5: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg8: &ReleasePackageConfigV8, arg9: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg10: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg11: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0xb59fa1d9a296922b13475aed3dcb1c6bacb67aabe32fd5186cb27b562f533ad2::output_v8::consume_native_complete_decrypt_proof_v8(0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_v8_binding::certify_native_complete_read_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg11));
        approve_complete_fields_v8<T0>(arg0, arg5, arg7, arg8, arg9, arg10, v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, arg11);
    }

    entry fun seal_approve_equipped_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg8: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg9: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg10: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg11: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg12: u64, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg7, arg9, arg1, arg10, arg11);
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg2, arg4, arg3, arg19);
        0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg10, arg11, arg7, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::certify_protected_base_entitlement_v8<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19), arg19);
    }

    entry fun seal_approve_equipped_owned_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedBaseItemV8, arg6: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg7: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg8: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg9: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg10: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg11: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg12: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg13: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg14: u64, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::string::String, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg9, arg11, arg1, arg12, arg13);
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg2, arg4, arg3, arg21);
        0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg12, arg13, arg9, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::certify_protected_owned_base_entitlement_v8<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), arg21);
    }

    entry fun seal_approve_equipped_pack_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg6: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackReleaseV8<T0>, arg7: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackPassV8, arg8: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg9: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg10: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg11: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg12: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg13: u64, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: vector<u8>, arg18: 0x1::string::String, arg19: vector<u8>, arg20: vector<u8>, arg21: vector<u8>, arg22: vector<u8>, arg23: &0x2::tx_context::TxContext) {
        assert_read_seal_binding<T0>(arg9, arg8, arg1, arg11, arg12);
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg2, arg4, arg3, arg23);
        0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_pack_decrypt_proof_v8<T0>(arg0, arg11, arg12, arg9, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::certify_protected_pack_entitlement_v8<T0>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23), arg23);
    }

    entry fun seal_approve_owned_base_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::OwnedBaseItemV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::RuntimeDefinitionRegistryV8, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::base_registry_v8::BaseDefinitionRegistryV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg8: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg9: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg10: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg11: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg12: u64, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: vector<u8>, arg18: vector<u8>, arg19: &0x2::tx_context::TxContext) {
        assert!(!0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::is_soul_equipment_v8(arg2), 1);
        assert_read_seal_binding<T0>(arg7, arg9, arg1, arg10, arg11);
        0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_base_decrypt_proof_v8<T0>(arg0, arg10, arg11, arg7, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::certify_protected_owned_base_entitlement_v8<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19), arg19);
    }

    entry fun seal_approve_pack_v8<T0>(arg0: vector<u8>, arg1: &ReleasePackageConfigV8, arg2: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg3: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackRegistryV8, arg4: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackReleaseV8<T0>, arg5: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::PackPassV8, arg6: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::package_binding_v8::ProductReleaseCatalogV8, arg7: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::maker_v8::MakerRootV8<T0>, arg8: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::treasury_v8::MakerAccessPassV8, arg9: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealRegistryV8, arg10: &0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::SealPolicyConfigV8, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<u8>, arg16: 0x1::string::String, arg17: vector<u8>, arg18: vector<u8>, arg19: vector<u8>, arg20: vector<u8>, arg21: &0x2::tx_context::TxContext) {
        assert!(!0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::is_soul_equipment_v8(arg2), 1);
        assert_read_seal_binding<T0>(arg7, arg6, arg1, arg9, arg10);
        0x9cc989aa2228c60032b0dc8992e3904963bb167ae2201737bbe95f06eeb3e678::seal_v8::consume_pack_decrypt_proof_v8<T0>(arg0, arg9, arg10, arg7, 0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_seal_v8::certify_protected_pack_entitlement_v8<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), arg21);
    }

    public fun share_release_package_config_v8(arg0: ReleasePackageConfigV8) {
        0x2::transfer::share_object<ReleasePackageConfigV8>(arg0);
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

