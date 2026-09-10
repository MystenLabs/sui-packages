module 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_binding_v8 {
    struct RuntimePackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        installation_commitment: vector<u8>,
    }

    fun assert_config(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg3: &RuntimePackageConfigV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg2, arg1);
        assert!(arg3.version == 8, 0);
        assert!(arg3.catalog_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg1), 0);
        assert!(&arg3.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg1)), 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_role_config_installation_v2(arg1, 2, 0x2::object::id<RuntimePackageConfigV8>(arg3), &arg3.installation_commitment);
    }

    public fun authorize_pack_complete_from_output_v8<T0, T1: key>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &RuntimePackageConfigV8, arg6: &T1, arg7: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg10: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeLoadoutAuthorizationV8, arg11: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg12: &0x2::tx_context::TxContext) : 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackCompleteLineV8 {
        assert_config(arg2, arg3, arg4, arg5);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg2, arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_runtime_caller_cap_v1(arg0, 0, arg4, arg3);
        let v0 = b"output_v8";
        let v1 = b"OutputRegistryV8";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<T1>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg3), 3), &v0, &v1);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::assert_pack_complete_root_v2<T0>(arg1, arg8, arg11);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::authorize_pack_complete_line_v8<T0>(arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun certify_external_item_product_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg3: &RuntimePackageConfigV8, arg4: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::ExternalItemProductV8) : 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::ExternalItemAttestationV8 {
        assert_config(arg0, arg1, arg2, arg3);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::new_external_item_attestation_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg1), arg4)
    }

    public fun new_runtime_package_config_v8(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::PackageCallCapV8<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : RuntimePackageConfigV8 {
        let v0 = 0x2::object::new(arg2);
        RuntimePackageConfigV8{
            id                         : v0,
            version                    : 8,
            catalog_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg0),
            product_binding_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg0)),
            installation_commitment    : 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::install_runtime_setup_v2(arg0, arg1, 0x2::object::uid_to_inner(&v0)),
        }
    }

    public fun share_runtime_package_config_v8(arg0: RuntimePackageConfigV8) {
        0x2::transfer::share_object<RuntimePackageConfigV8>(arg0);
    }

    public fun validate_runtime_activation_readiness_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &RuntimePackageConfigV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackAdmissionAuthorityV8, arg8: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeActivationReadinessReceiptV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        assert_config(arg1, arg2, arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg0, arg2);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::consume_activation_readiness_v8(arg8);
        let v8 = v6;
        let v9 = v2;
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg0, v0, v1, &v9);
        assert!(v3 == 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimeDefinitionRegistryV8>(arg5), 1);
        assert!(v4 == 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8>(arg6), 1);
        assert!(v5 == 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackAdmissionAuthorityV8>(arg7), 1);
        assert!(&v8 == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_expected_pack_admission_policy_commitment_v2<T0>(arg0), 1);
        let (_, _, _, _, _, _, _, v17) = 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::consume_activation_readiness_v8(0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::runtime_activation_readiness_v8<T0>(arg5, arg6, arg7, arg0));
        assert!(v7 == v17, 1);
        (v4, v5, v8)
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

