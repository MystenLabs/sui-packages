module 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_binding_v8 {
    struct RuntimePackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        runtime_call_cap: 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::RuntimeRoleV8>,
    }

    public fun certify_runtime_activation_readiness_v8<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &RuntimePackageConfigV8, arg3: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeDefinitionRegistryV8, arg4: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackRegistryV8, arg5: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackAdmissionAuthorityV8, arg6: 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeActivationReadinessReceiptV8) : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8::RuntimeActivationReadinessV8 {
        assert_config(arg1, arg2);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::consume_activation_readiness_v8(arg6);
        let v8 = v6;
        let v9 = v2;
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_root_identity_v8<T0>(arg0, v0, v1, &v9);
        assert!(v3 == 0x2::object::id<0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeDefinitionRegistryV8>(arg3), 1);
        assert!(v4 == 0x2::object::id<0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackRegistryV8>(arg4), 1);
        assert!(v5 == 0x2::object::id<0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackAdmissionAuthorityV8>(arg5), 1);
        assert!(&v8 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_pack_admission_policy_commitment_v8<T0>(arg0), 1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8::certify_runtime_activation_readiness_v8<T0, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeOriginalMarkerV8, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeCallableMarkerV8, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeDefinitionRegistryV8, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackRegistryV8, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackAdmissionAuthorityV8>(arg0, arg1, &arg2.runtime_call_cap, arg3, arg4, arg5, v7)
    }

    fun assert_config(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg1: &RuntimePackageConfigV8) {
        assert!(arg1.version == 8, 0);
        assert!(arg1.catalog_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_id_v8(arg0), 0);
        assert!(&arg1.product_binding_commitment == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg0)), 0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_runtime_call_cap_v8(arg0, &arg1.runtime_call_cap);
    }

    public fun authorize_pack_complete_from_output_v8<T0, T1: key>(arg0: 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8::OutputRuntimeRequestV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &RuntimePackageConfigV8, arg4: &T1, arg5: &mut 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackReleaseV8<T0>, arg6: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackRegistryV8, arg7: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackPassV8, arg8: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeLoadoutAuthorizationV8, arg9: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::MakerLoadoutV8, arg10: &0x2::tx_context::TxContext) : 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::PackCompleteLineV8 {
        assert_config(arg2, arg3);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8::consume_output_runtime_request_v8<T0, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeOriginalMarkerV8, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeCallableMarkerV8, T1>(arg0, arg1, arg2, &arg3.runtime_call_cap, arg4, arg10);
        0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::authorize_pack_complete_line_v8<T0>(arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun certify_external_item_product_v8(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg1: &RuntimePackageConfigV8, arg2: &0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::ExternalItemProductV8) : 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::ExternalItemAttestationV8 {
        assert_config(arg0, arg1);
        0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::new_external_item_attestation_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_id_v8(arg0), arg2)
    }

    public fun new_runtime_package_config_v8(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg1: 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::RuntimeRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : RuntimePackageConfigV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_runtime_call_cap_v8(arg0, &arg1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeOriginalMarkerV8, 0xbcc759bab8b1e06f1df2cd2496820de87c72a75f42c4f2d064bc4ea4a2c1a4ed::runtime_v8::RuntimeCallableMarkerV8>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg0)));
        RuntimePackageConfigV8{
            id                         : 0x2::object::new(arg2),
            version                    : 8,
            catalog_id                 : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_id_v8(arg0),
            product_binding_commitment : *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg0)),
            runtime_call_cap           : arg1,
        }
    }

    public fun share_runtime_package_config_v8(arg0: RuntimePackageConfigV8) {
        0x2::transfer::share_object<RuntimePackageConfigV8>(arg0);
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

