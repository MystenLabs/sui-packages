module 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::activation_v8 {
    struct MakerLifecycleChangedV2 has copy, drop {
        root_id: 0x2::object::ID,
        previous: u8,
        current: u8,
    }

    public fun activate_maker_v8<T0, T1: drop>(arg0: T1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleBootstrapCertificateV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::WalrusCertificationPolicyV1, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::CertifiedLivingContentV1, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg11: 0x2::object::ID, arg12: 0x2::object::ID, arg13: vector<u8>, arg14: &0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg8, arg9);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg8) == 0x2::tx_context::sender(arg14), 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg3, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_bootstrap_certificate_v2(arg4, arg3, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg8, arg2);
        let v0 = b"release_v8";
        let v1 = b"ReleaseActivationWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2), 6), &v0, &v1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::assert_walrus_policy_current_v1(arg1, arg2, arg5);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::assert_certified_living_content_v1<T0>(arg5, arg6, arg7, arg8);
        let v2 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg8);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::pack_registry_id_v2(v2) == arg11 && 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::admission_authority_id_v2(v2) == arg12, 1);
        assert!(&arg13 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_expected_pack_admission_policy_commitment_v2<T0>(arg8), 1);
        let (_, _, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::core_v8::assert_activation_scaffold_ready_v8<T0>(arg8, arg10);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::activate_from_core_v8<T0>(arg8, arg9, arg1, arg2, arg3);
        let v6 = MakerLifecycleChangedV2{
            root_id  : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg8),
            previous : 0,
            current  : 1,
        };
        0x2::event::emit<MakerLifecycleChangedV2>(v6);
    }

    public fun archive_maker_v8<T0, T1: drop>(arg0: T1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg6: &0x2::tx_context::TxContext) {
        transition_with_release_witness<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 3, arg6);
    }

    public fun pause_maker_v8<T0, T1: drop>(arg0: T1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg6: &0x2::tx_context::TxContext) {
        transition_with_release_witness<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 2, arg6);
    }

    public fun resume_maker_v8<T0, T1: drop>(arg0: T1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg6: &0x2::tx_context::TxContext) {
        transition_with_release_witness<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 1, arg6);
    }

    fun transition_with_release_witness<T0, T1: drop>(arg0: T1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        let v0 = b"release_v8";
        let v1 = b"ReleaseLifecycleWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2), 6), &v0, &v1);
        let (v2, v3) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::transition_lifecycle_from_core_v8<T0>(arg4, arg5, arg1, arg2, arg3, arg6, arg7);
        let v4 = MakerLifecycleChangedV2{
            root_id  : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg4),
            previous : v2,
            current  : v3,
        };
        0x2::event::emit<MakerLifecycleChangedV2>(v4);
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

