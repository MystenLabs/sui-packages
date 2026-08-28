module 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8 {
    struct SealReadinessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        seal_registry_id: 0x2::object::ID,
        companion_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct RuntimeActivationReadinessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        runtime_definition_registry_id: 0x2::object::ID,
        pack_registry_id: 0x2::object::ID,
        admission_authority_id: 0x2::object::ID,
        expected_pack_policy_commitment: vector<u8>,
        companion_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct OutputReadinessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        companion_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct PhysicalReadinessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        registry_id: 0x2::object::ID,
        companion_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct MarketReadinessV8 {
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        market_registry_id: 0x2::object::ID,
        market_treasury_id: 0x2::object::ID,
        companion_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct OutputRuntimeRequestV8 {
        request_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        output_registry_id: 0x2::object::ID,
        requester: address,
        commitment: vector<u8>,
    }

    struct RoleReadinessCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        role: u8,
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        role_binding_commitment: vector<u8>,
        companion_ids: vector<0x2::object::ID>,
        expected_pack_policy_commitment: vector<u8>,
        companion_commitment: vector<u8>,
    }

    struct OutputRuntimeRequestCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        request_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        output_registry_id: 0x2::object::ID,
        requester: address,
    }

    public fun activate_maker_v8<T0, T1, T2>(arg0: &mut 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::treasury_v8::MakerTreasuryV8<T0>, arg6: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg7: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ReleaseRoleV8>, arg8: SealReadinessV8, arg9: RuntimeActivationReadinessV8, arg10: OutputReadinessV8, arg11: PhysicalReadinessV8, arg12: MarketReadinessV8, arg13: &0x2::tx_context::TxContext) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_release_call_cap_v8(arg3, arg7);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::release_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg3)));
        activate_with_verified_release<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun activate_with_verified_release<T0>(arg0: &mut 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::base_registry_v8::BaseDefinitionRegistryV8, arg5: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::treasury_v8::MakerTreasuryV8<T0>, arg6: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg7: SealReadinessV8, arg8: RuntimeActivationReadinessV8, arg9: OutputReadinessV8, arg10: PhysicalReadinessV8, arg11: MarketReadinessV8, arg12: &0x2::tx_context::TxContext) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_owner_v8<T0>(arg0) == 0x2::tx_context::sender(arg12), 1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg2);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::assert_exact_protocol_treasury_v8<T0>(arg2, arg6);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::treasury_v8::assert_maker_treasury_v8<T0>(arg0, arg5);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_catalog_current_v8(arg2, arg3);
        let (v0, v1, v2) = assert_draft_root_catalog<T0>(arg0, arg3);
        let v3 = v2;
        let (v4, _, _) = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::base_registry_v8::assert_activation_ready_v8<T0>(arg4, arg0);
        let (v7, v8, v9) = consume_seal_readiness(arg7, v0, v1, &v3, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::seal_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg3)));
        let (v10, v11, v12, v13, v14) = consume_runtime_readiness(arg8, v0, v1, &v3, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg3)));
        let v15 = v13;
        assert!(&v15 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_pack_admission_policy_commitment_v8<T0>(arg0), 1);
        let (v16, v17, v18) = consume_output_readiness(arg9, v0, v1, &v3, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::output_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg3)));
        let (v19, v20) = consume_physical_readiness(arg10, v0, v1, &v3, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::physical_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg3)));
        let (v21, v22, v23) = consume_market_readiness(arg11, v0, v1, &v3, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::market_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg3)));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::finalize_pack_admission_binding_from_core_v8<T0>(arg0, arg1, v11, v12, v15);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::finalize_capability_registry_binding_v8<T0>(arg0, arg1, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::native_capability_mask_v8(), v1, *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_call_cap_set_v8(arg3), 0x2::object::id<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolConfigV8>(arg2), v4, 0x2::object::id<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::treasury_v8::MakerTreasuryV8<T0>>(arg5), 0x2::object::id<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolTreasuryV8<T0>>(arg6), v7, v8, v10, v11, v12, v16, v17, v19, v21, v22, v9, v14, v18, v20, v23);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::activate_from_core_v8<T0>(arg0, arg1);
    }

    public fun archive_maker_v8<T0, T1, T2>(arg0: &mut 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ReleaseRoleV8>, arg4: &0x2::tx_context::TxContext) : (u8, u8) {
        assert_release_lifecycle_boundary<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::transition_lifecycle_from_core_v8<T0>(arg0, arg1, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_archived_v8(), arg4)
    }

    fun assert_active_root_catalog<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_active_capability_registry_v8<T0>(arg0);
        let (v0, v1, v2) = assert_root_catalog<T0>(arg0, arg1);
        let v3 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_capability_registry_binding_v8<T0>(arg0);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::capability_catalog_id_v8(v3) == v1, 1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_same_call_cap_set_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::capability_call_cap_set_v8(v3), 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_call_cap_set_v8(arg1));
        (v0, v1, v2)
    }

    fun assert_common_readiness(arg0: u8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<0x2::object::ID>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: &vector<u8>, arg11: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) {
        assert!(arg1 == arg8, 1);
        assert!(arg2 == arg9, 1);
        assert!(&arg3 == arg10, 1);
        let v0 = readiness_commitment(arg0, arg1, arg2, arg3, arg11, arg4, arg5, arg6);
        assert!(&v0 == &arg7, 1);
    }

    fun assert_distinct_nonzero_ids(arg0: &vector<0x2::object::ID>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(arg0, v0) != 0x2::object::id_from_address(@0x0), 2);
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(arg0, v0) != *0x1::vector::borrow<0x2::object::ID>(arg0, v1), 2);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun assert_draft_root_catalog<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_v8<T0>(arg0);
        assert_root_catalog<T0>(arg0, arg1)
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0);
        let v0 = false;
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 0);
    }

    fun assert_release_lifecycle_boundary<T0, T1, T2>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ReleaseRoleV8>, arg4: &0x2::tx_context::TxContext) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_release_call_cap_v8(arg2, arg3);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::release_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg2)));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_admin_v8<T0>(arg0, arg1);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_owner_v8<T0>(arg0) == 0x2::tx_context::sender(arg4), 1);
        let (_, v1, _) = assert_root_catalog<T0>(arg0, arg2);
        let v3 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_capability_registry_binding_v8<T0>(arg0);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::capability_catalog_id_v8(v3) == v1, 1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_same_call_cap_set_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::capability_call_cap_set_v8(v3), 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_call_cap_set_v8(arg2));
    }

    fun assert_root_catalog<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_catalog_snapshot_v8(arg1, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_protocol_config_id_v8<T0>(arg0), 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_protocol_config_revision_v8<T0>(arg0), 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_protocol_config_commitment_v8<T0>(arg0));
        let v0 = 0x2::object::id<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8>(arg1);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_catalog_id_v8<T0>(arg0) == v0, 1);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg0)) == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1)), 1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_same_call_cap_set_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_call_cap_set_v8<T0>(arg0), 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_call_cap_set_v8(arg1));
        (0x2::object::id<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>>(arg0), v0, *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::call_cap_set_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_call_cap_set_v8(arg1)))
    }

    public fun certify_market_readiness_v8<T0, T1, T2, T3: key, T4: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::MarketRoleV8>, arg3: &T3, arg4: &T4, arg5: vector<u8>) : MarketReadinessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_market_call_cap_v8(arg1, arg2);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::market_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T4>(v0);
        let (v1, v2, v3) = assert_draft_root_catalog<T0>(arg0, arg1);
        let v4 = 0x2::object::id<T3>(arg3);
        let v5 = 0x2::object::id<T4>(arg4);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x2::object::ID>(v7, v4);
        0x1::vector::push_back<0x2::object::ID>(v7, v5);
        MarketReadinessV8{
            root_id                 : v1,
            catalog_id              : v2,
            call_cap_set_commitment : v3,
            market_registry_id      : v4,
            market_treasury_id      : v5,
            companion_commitment    : arg5,
            commitment              : readiness_commitment(4, v1, v2, v3, v0, v6, b"", arg5),
        }
    }

    public fun certify_output_readiness_v8<T0, T1, T2, T3: key, T4: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::OutputRoleV8>, arg3: &T3, arg4: &T4, arg5: vector<u8>) : OutputReadinessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_output_call_cap_v8(arg1, arg2);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::output_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T4>(v0);
        let (v1, v2, v3) = assert_draft_root_catalog<T0>(arg0, arg1);
        let v4 = 0x2::object::id<T3>(arg3);
        let v5 = 0x2::object::id<T4>(arg4);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x2::object::ID>(v7, v4);
        0x1::vector::push_back<0x2::object::ID>(v7, v5);
        OutputReadinessV8{
            root_id                 : v1,
            catalog_id              : v2,
            call_cap_set_commitment : v3,
            output_registry_id      : v4,
            soul_registry_id        : v5,
            companion_commitment    : arg5,
            commitment              : readiness_commitment(2, v1, v2, v3, v0, v6, b"", arg5),
        }
    }

    public fun certify_physical_readiness_v8<T0, T1, T2, T3: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PhysicalRoleV8>, arg3: &T3, arg4: vector<u8>) : PhysicalReadinessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_physical_call_cap_v8(arg1, arg2);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::physical_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(v0);
        let (v1, v2, v3) = assert_draft_root_catalog<T0>(arg0, arg1);
        let v4 = 0x2::object::id<T3>(arg3);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v5, v4);
        PhysicalReadinessV8{
            root_id                 : v1,
            catalog_id              : v2,
            call_cap_set_commitment : v3,
            registry_id             : v4,
            companion_commitment    : arg4,
            commitment              : readiness_commitment(3, v1, v2, v3, v0, v5, b"", arg4),
        }
    }

    public fun certify_runtime_activation_readiness_v8<T0, T1, T2, T3: key, T4: key, T5: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::RuntimeRoleV8>, arg3: &T3, arg4: &T4, arg5: &T5, arg6: vector<u8>) : RuntimeActivationReadinessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_runtime_call_cap_v8(arg1, arg2);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T4>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T5>(v0);
        let (v1, v2, v3) = assert_draft_root_catalog<T0>(arg0, arg1);
        let v4 = 0x2::object::id<T3>(arg3);
        let v5 = 0x2::object::id<T4>(arg4);
        let v6 = 0x2::object::id<T5>(arg5);
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x2::object::ID>(v8, v4);
        0x1::vector::push_back<0x2::object::ID>(v8, v5);
        0x1::vector::push_back<0x2::object::ID>(v8, v6);
        assert_distinct_nonzero_ids(&v7);
        let v9 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_pack_admission_policy_commitment_v8<T0>(arg0);
        RuntimeActivationReadinessV8{
            root_id                         : v1,
            catalog_id                      : v2,
            call_cap_set_commitment         : v3,
            runtime_definition_registry_id  : v4,
            pack_registry_id                : v5,
            admission_authority_id          : v6,
            expected_pack_policy_commitment : v9,
            companion_commitment            : arg6,
            commitment                      : readiness_commitment(1, v1, v2, v3, v0, v7, v9, arg6),
        }
    }

    public fun certify_seal_readiness_v8<T0, T1, T2, T3: key, T4: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::SealRoleV8>, arg3: &T3, arg4: &T4, arg5: vector<u8>) : SealReadinessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_seal_call_cap_v8(arg1, arg2);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::seal_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T4>(v0);
        let (v1, v2, v3) = assert_draft_root_catalog<T0>(arg0, arg1);
        let v4 = 0x2::object::id<T3>(arg3);
        let v5 = 0x2::object::id<T4>(arg4);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x2::object::ID>(v7, v4);
        0x1::vector::push_back<0x2::object::ID>(v7, v5);
        SealReadinessV8{
            root_id                 : v1,
            catalog_id              : v2,
            call_cap_set_commitment : v3,
            policy_config_id        : v4,
            seal_registry_id        : v5,
            companion_commitment    : arg5,
            commitment              : readiness_commitment(0, v1, v2, v3, v0, v6, b"", arg5),
        }
    }

    fun consume_market_readiness(arg0: MarketReadinessV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        let MarketReadinessV8 {
            root_id                 : v0,
            catalog_id              : v1,
            call_cap_set_commitment : v2,
            market_registry_id      : v3,
            market_treasury_id      : v4,
            companion_commitment    : v5,
            commitment              : v6,
        } = arg0;
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x2::object::ID>(v8, v3);
        0x1::vector::push_back<0x2::object::ID>(v8, v4);
        assert_common_readiness(4, v0, v1, v2, v7, b"", v5, v6, arg1, arg2, arg3, arg4);
        (v3, v4, v6)
    }

    fun consume_output_readiness(arg0: OutputReadinessV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        let OutputReadinessV8 {
            root_id                 : v0,
            catalog_id              : v1,
            call_cap_set_commitment : v2,
            output_registry_id      : v3,
            soul_registry_id        : v4,
            companion_commitment    : v5,
            commitment              : v6,
        } = arg0;
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x2::object::ID>(v8, v3);
        0x1::vector::push_back<0x2::object::ID>(v8, v4);
        assert_common_readiness(2, v0, v1, v2, v7, b"", v5, v6, arg1, arg2, arg3, arg4);
        (v3, v4, v6)
    }

    public fun consume_output_runtime_request_v8<T0, T1, T2, T3: key>(arg0: OutputRuntimeRequestV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::RuntimeRoleV8>, arg4: &T3, arg5: &0x2::tx_context::TxContext) : 0x2::object::ID {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_runtime_call_cap_v8(arg2, arg3);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg2)));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::output_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg2)));
        consume_verified_output_request<T0, T3>(arg0, arg1, arg2, arg4, arg5)
    }

    fun consume_physical_readiness(arg0: PhysicalReadinessV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) : (0x2::object::ID, vector<u8>) {
        let PhysicalReadinessV8 {
            root_id                 : v0,
            catalog_id              : v1,
            call_cap_set_commitment : v2,
            registry_id             : v3,
            companion_commitment    : v4,
            commitment              : v5,
        } = arg0;
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v6, v3);
        assert_common_readiness(3, v0, v1, v2, v6, b"", v4, v5, arg1, arg2, arg3, arg4);
        (v3, v5)
    }

    fun consume_runtime_readiness(arg0: RuntimeActivationReadinessV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, vector<u8>, vector<u8>) {
        let RuntimeActivationReadinessV8 {
            root_id                         : v0,
            catalog_id                      : v1,
            call_cap_set_commitment         : v2,
            runtime_definition_registry_id  : v3,
            pack_registry_id                : v4,
            admission_authority_id          : v5,
            expected_pack_policy_commitment : v6,
            companion_commitment            : v7,
            commitment                      : v8,
        } = arg0;
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x2::object::ID>(v10, v3);
        0x1::vector::push_back<0x2::object::ID>(v10, v4);
        0x1::vector::push_back<0x2::object::ID>(v10, v5);
        assert_common_readiness(1, v0, v1, v2, v9, v6, v7, v8, arg1, arg2, arg3, arg4);
        (v3, v4, v5, v6, v8)
    }

    fun consume_seal_readiness(arg0: SealReadinessV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &vector<u8>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) : (0x2::object::ID, 0x2::object::ID, vector<u8>) {
        let SealReadinessV8 {
            root_id                 : v0,
            catalog_id              : v1,
            call_cap_set_commitment : v2,
            policy_config_id        : v3,
            seal_registry_id        : v4,
            companion_commitment    : v5,
            commitment              : v6,
        } = arg0;
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x2::object::ID>(v8, v3);
        0x1::vector::push_back<0x2::object::ID>(v8, v4);
        assert_common_readiness(0, v0, v1, v2, v7, b"", v5, v6, arg1, arg2, arg3, arg4);
        (v3, v4, v6)
    }

    fun consume_verified_output_request<T0, T1: key>(arg0: OutputRuntimeRequestV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &T1, arg4: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1, v2) = assert_active_root_catalog<T0>(arg1, arg2);
        let v3 = v2;
        let OutputRuntimeRequestV8 {
            request_id              : v4,
            root_id                 : v5,
            catalog_id              : v6,
            call_cap_set_commitment : v7,
            output_registry_id      : v8,
            requester               : v9,
            commitment              : v10,
        } = arg0;
        let v11 = v10;
        let v12 = v7;
        assert!(v5 == v0, 3);
        assert!(v6 == v1, 3);
        assert!(&v12 == &v3, 3);
        assert!(v8 == 0x2::object::id<T1>(arg3), 3);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::capability_output_registry_id_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_capability_registry_binding_v8<T0>(arg1)) == v8, 3);
        assert!(v9 == 0x2::tx_context::sender(arg4), 3);
        let v13 = output_request_commitment(v4, v5, v6, v12, v8, v9);
        assert!(&v13 == &v11, 3);
        v4
    }

    fun fresh_id(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    public fun new_output_runtime_request_v8<T0, T1, T2, T3: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::OutputRoleV8>, arg3: &T3, arg4: &mut 0x2::tx_context::TxContext) : OutputRuntimeRequestV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_output_call_cap_v8(arg1, arg2);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::output_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1)));
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_original_v8<T3>(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::output_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg1)));
        new_verified_output_request<T0, T3>(arg0, arg1, arg3, arg4)
    }

    fun new_verified_output_request<T0, T1: key>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &T1, arg3: &mut 0x2::tx_context::TxContext) : OutputRuntimeRequestV8 {
        let (v0, v1, v2) = assert_active_root_catalog<T0>(arg0, arg1);
        let v3 = 0x2::object::id<T1>(arg2);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::capability_output_registry_id_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_capability_registry_binding_v8<T0>(arg0)) == v3, 3);
        let v4 = fresh_id(arg3);
        let v5 = 0x2::tx_context::sender(arg3);
        OutputRuntimeRequestV8{
            request_id              : v4,
            root_id                 : v0,
            catalog_id              : v1,
            call_cap_set_commitment : v2,
            output_registry_id      : v3,
            requester               : v5,
            commitment              : output_request_commitment(v4, v0, v1, v2, v3, v5),
        }
    }

    fun output_request_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: address) : vector<u8> {
        assert_hash(&arg3);
        let v0 = OutputRuntimeRequestCommitmentInputV8{
            domain                  : b"animacraft-v8/output-runtime-request",
            version                 : 8,
            request_id              : arg0,
            root_id                 : arg1,
            catalog_id              : arg2,
            call_cap_set_commitment : arg3,
            output_registry_id      : arg4,
            requester               : arg5,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<OutputRuntimeRequestCommitmentInputV8>(&v0))
    }

    public fun pause_maker_v8<T0, T1, T2>(arg0: &mut 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ReleaseRoleV8>, arg4: &0x2::tx_context::TxContext) : (u8, u8) {
        assert_release_lifecycle_boundary<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::transition_lifecycle_from_core_v8<T0>(arg0, arg1, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_paused_v8(), arg4)
    }

    fun readiness_commitment(arg0: u8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8, arg5: vector<0x2::object::ID>, arg6: vector<u8>, arg7: vector<u8>) : vector<u8> {
        assert_hash(&arg3);
        assert_hash(&arg7);
        if (arg0 == 1) {
            assert_hash(&arg6);
        } else {
            assert!(0x1::vector::is_empty<u8>(&arg6), 0);
        };
        assert_distinct_nonzero_ids(&arg5);
        let v0 = RoleReadinessCommitmentInputV8{
            domain                          : b"animacraft-v8/role-readiness",
            version                         : 8,
            role                            : arg0,
            root_id                         : arg1,
            catalog_id                      : arg2,
            call_cap_set_commitment         : arg3,
            role_binding_commitment         : *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::exact_binding_commitment_v8(arg4),
            companion_ids                   : arg5,
            expected_pack_policy_commitment : arg6,
            companion_commitment            : arg7,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RoleReadinessCommitmentInputV8>(&v0))
    }

    public fun resume_maker_v8<T0, T1, T2>(arg0: &mut 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ReleaseRoleV8>, arg5: &0x2::tx_context::TxContext) : (u8, u8) {
        assert_release_lifecycle_boundary<T0, T1, T2>(arg0, arg1, arg3, arg4, arg5);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg2);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_catalog_current_v8(arg2, arg3);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::transition_lifecycle_from_core_v8<T0>(arg0, arg1, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_active_v8(), arg5)
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

