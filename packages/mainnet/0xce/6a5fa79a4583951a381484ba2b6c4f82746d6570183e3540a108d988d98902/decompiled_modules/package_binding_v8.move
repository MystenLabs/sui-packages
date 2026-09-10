module 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8 {
    struct PackageCommitmentsV8 has copy, drop, store {
        source_commitment: vector<u8>,
        package_commitment: vector<u8>,
        abi_commitment: vector<u8>,
    }

    struct ExactPackageBindingV8 has copy, drop, store {
        original_package_id: 0x2::object::ID,
        callable_package_id: 0x2::object::ID,
        source_commitment: vector<u8>,
        package_commitment: vector<u8>,
        abi_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct ProductReleaseBindingV8 has copy, drop, store {
        bindings: vector<ExactPackageBindingV8>,
        commitment: vector<u8>,
    }

    struct ProductReleaseCatalogV8 has key {
        id: 0x2::object::UID,
        schema_revision: u64,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        binding: ProductReleaseBindingV8,
        authority_ids: vector<0x2::object::ID>,
        call_cap_set_commitment: vector<u8>,
        catalog_commitment: vector<u8>,
        next_setup_role: u8,
        role_config_ids: vector<0x2::object::ID>,
        role_config_commitments: vector<vector<u8>>,
    }

    struct PackageCallCapV8<phantom T0> {
        role: u8,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        role_authority_id: 0x2::object::ID,
        role_binding_commitment: vector<u8>,
    }

    struct SealRoleV8 has drop {
        dummy_field: bool,
    }

    struct RuntimeRoleV8 has drop {
        dummy_field: bool,
    }

    struct OutputRoleV8 has drop {
        dummy_field: bool,
    }

    struct PhysicalRoleV8 has drop {
        dummy_field: bool,
    }

    struct MarketRoleV8 has drop {
        dummy_field: bool,
    }

    struct ReleaseRoleV8 has drop {
        dummy_field: bool,
    }

    struct ExactPackageBindingInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        role: u8,
        original_package_id: 0x2::object::ID,
        callable_package_id: 0x2::object::ID,
        source_commitment: vector<u8>,
        package_commitment: vector<u8>,
        abi_commitment: vector<u8>,
    }

    struct PackageCallCapSetCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        core_binding_commitment: vector<u8>,
        seal_binding_commitment: vector<u8>,
        runtime_binding_commitment: vector<u8>,
        output_binding_commitment: vector<u8>,
        physical_binding_commitment: vector<u8>,
        market_binding_commitment: vector<u8>,
        release_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        runtime_authority_id: 0x2::object::ID,
        output_authority_id: 0x2::object::ID,
        physical_authority_id: 0x2::object::ID,
        market_authority_id: 0x2::object::ID,
        release_authority_id: 0x2::object::ID,
    }

    struct PackageTupleInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        native_capability_mask: u64,
        call_cap_set_commitment: vector<u8>,
        core_binding: vector<u8>,
        seal_binding: vector<u8>,
        runtime_binding: vector<u8>,
        output_binding: vector<u8>,
        physical_binding: vector<u8>,
        market_binding: vector<u8>,
        release_binding: vector<u8>,
    }

    struct CatalogCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        protocol_config_commitment: vector<u8>,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        native_capability_mask: u64,
        seal_authority_id: 0x2::object::ID,
        runtime_authority_id: 0x2::object::ID,
        output_authority_id: 0x2::object::ID,
        physical_authority_id: 0x2::object::ID,
        market_authority_id: 0x2::object::ID,
        release_authority_id: 0x2::object::ID,
    }

    struct FreshTupleReplacementBindingInputV2 has copy, drop, store {
        core_binding_commitment: vector<u8>,
        seal_binding_commitment: vector<u8>,
        runtime_binding_commitment: vector<u8>,
        output_binding_commitment: vector<u8>,
        physical_binding_commitment: vector<u8>,
        market_binding_commitment: vector<u8>,
        release_binding_commitment: vector<u8>,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        runtime_config_id: 0x2::object::ID,
        output_config_id: 0x2::object::ID,
        market_config_id: 0x2::object::ID,
        release_config_id: 0x2::object::ID,
    }

    struct FreshTupleReplacementBindingV2 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        core_binding_commitment: vector<u8>,
        seal_binding_commitment: vector<u8>,
        runtime_binding_commitment: vector<u8>,
        output_binding_commitment: vector<u8>,
        physical_binding_commitment: vector<u8>,
        market_binding_commitment: vector<u8>,
        release_binding_commitment: vector<u8>,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        runtime_config_id: 0x2::object::ID,
        output_config_id: 0x2::object::ID,
        market_config_id: 0x2::object::ID,
        release_config_id: 0x2::object::ID,
        binding_commitment: vector<u8>,
    }

    struct FreshTupleBootstrapAdminV2 has key {
        id: 0x2::object::UID,
        version: u64,
        protocol_admin_id: 0x2::object::ID,
        replacement_binding_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        caps_minted: bool,
        install_mask: u8,
        install_mark_commitments: vector<vector<u8>>,
        bootstrap_commitment: vector<u8>,
    }

    struct FreshTupleBootstrapCertificateV2 has key {
        id: 0x2::object::UID,
        version: u64,
        replacement_binding_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        install_mask: u8,
        install_mark_commitments: vector<vector<u8>>,
        certificate_commitment: vector<u8>,
    }

    struct FreshTupleBootstrapSlotKeyV2 has copy, drop, store {
        dummy_field: bool,
    }

    struct FreshTupleBootstrapSlotV2 has store {
        state: u8,
        replacement_binding_id: 0x2::object::ID,
        admin_id: 0x1::option::Option<0x2::object::ID>,
        certificate_id: 0x1::option::Option<0x2::object::ID>,
        certificate_commitment: 0x1::option::Option<vector<u8>>,
    }

    struct RuntimeCallerCapV1 has store {
        schema_revision: u64,
        role: u8,
        catalog_id: 0x2::object::ID,
        replacement_binding_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        caller_original_package_id: 0x2::object::ID,
        caller_callable_package_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        cap_commitment: vector<u8>,
    }

    struct FreshTupleBootstrapUseWitnessV2 {
        replacement_binding_id: 0x2::object::ID,
        bootstrap_certificate_id: 0x2::object::ID,
        bootstrap_certificate_commitment: vector<u8>,
        release_config_id: 0x2::object::ID,
        release_original_package_id: 0x2::object::ID,
    }

    struct FreshTupleReplacementBindingCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        binding_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        core_binding_commitment: vector<u8>,
        seal_binding_commitment: vector<u8>,
        runtime_binding_commitment: vector<u8>,
        output_binding_commitment: vector<u8>,
        physical_binding_commitment: vector<u8>,
        market_binding_commitment: vector<u8>,
        release_binding_commitment: vector<u8>,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        runtime_config_id: 0x2::object::ID,
        output_config_id: 0x2::object::ID,
        market_config_id: 0x2::object::ID,
        release_config_id: 0x2::object::ID,
    }

    struct FreshTupleBootstrapAdminCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        admin_id: 0x2::object::ID,
        protocol_admin_id: 0x2::object::ID,
        replacement_binding_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        caps_minted: bool,
        install_mask: u8,
        ordered_install_mark_commitments: vector<vector<u8>>,
    }

    struct FreshTupleBootstrapSlotCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        catalog_id: 0x2::object::ID,
        key_type_name: 0x1::string::String,
        key_bcs: vector<u8>,
        state: u8,
        replacement_binding_id: 0x2::object::ID,
        admin_id: 0x1::option::Option<0x2::object::ID>,
        certificate_id: 0x1::option::Option<0x2::object::ID>,
        certificate_commitment: 0x1::option::Option<vector<u8>>,
    }

    struct TupleBootstrapInstallMarkCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        replacement_binding_id: 0x2::object::ID,
        role: u8,
        install_kind: u8,
        config_id: 0x2::object::ID,
        installed_object_id: 0x1::option::Option<0x2::object::ID>,
        installed_commitment: vector<u8>,
        role_witness_type_name: 0x1::string::String,
    }

    struct FreshTupleBootstrapCertificateCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        certificate_id: 0x2::object::ID,
        replacement_binding_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        install_mask: u8,
        ordered_install_mark_commitments: vector<vector<u8>>,
    }

    struct RuntimeCallerCapCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        role: u8,
        catalog_id: 0x2::object::ID,
        replacement_binding_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        caller_original_package_id: 0x2::object::ID,
        caller_callable_package_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
    }

    struct RoleConfigCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        role: u8,
        config_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        package_tuple_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        authority_id: 0x2::object::ID,
        finalized: bool,
        seal_policy_commitment: 0x1::option::Option<vector<u8>>,
        key_server_set_commitment: 0x1::option::Option<vector<u8>>,
        encryption_policy_commitment: 0x1::option::Option<vector<u8>>,
        external_validator_policy_id: 0x1::option::Option<0x2::object::ID>,
        external_validator_registry_id: 0x1::option::Option<0x2::object::ID>,
        soul_binding_registry_id: 0x1::option::Option<0x2::object::ID>,
        runtime_caller_cap_commitment: 0x1::option::Option<vector<u8>>,
        bootstrap_certificate_id: 0x1::option::Option<0x2::object::ID>,
        bootstrap_certificate_commitment: 0x1::option::Option<vector<u8>>,
    }

    fun assert_binding_well_formed(arg0: u8, arg1: &ExactPackageBindingV8) {
        let v0 = ExactPackageBindingInputV2{
            domain              : 0x1::string::utf8(b"animacraft-fresh-v8/package/exact-binding/v2"),
            schema_revision     : 2,
            role                : arg0,
            original_package_id : arg1.original_package_id,
            callable_package_id : arg1.callable_package_id,
            source_commitment   : arg1.source_commitment,
            package_commitment  : arg1.package_commitment,
            abi_commitment      : arg1.abi_commitment,
        };
        let v1 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ExactPackageBindingInputV2>(&v0));
        assert!(&v1 == &arg1.commitment, 0);
    }

    fun assert_bootstrap_admin(arg0: &FreshTupleBootstrapAdminV2, arg1: &FreshTupleReplacementBindingV2, arg2: &ProductReleaseCatalogV8) {
        assert!(arg0.version == 2, 12);
        assert!(arg0.replacement_binding_id == 0x2::object::id<FreshTupleReplacementBindingV2>(arg1), 12);
        assert!(arg0.catalog_id == 0x2::object::id<ProductReleaseCatalogV8>(arg2), 12);
        assert!(&arg0.package_tuple_commitment == &arg1.package_tuple_commitment, 12);
        assert!(&arg0.call_cap_set_commitment == &arg1.call_cap_set_commitment, 12);
        let v0 = derive_bootstrap_admin_commitment(arg0);
        assert!(&v0 == &arg0.bootstrap_commitment, 12);
    }

    public fun assert_bootstrap_certificate_v2(arg0: &FreshTupleBootstrapCertificateV2, arg1: &FreshTupleReplacementBindingV2, arg2: &ProductReleaseCatalogV8) {
        assert!(arg0.version == 2, 11);
        assert!(arg0.replacement_binding_id == 0x2::object::id<FreshTupleReplacementBindingV2>(arg1), 10);
        assert!(arg0.catalog_id == 0x2::object::id<ProductReleaseCatalogV8>(arg2), 10);
        assert!(&arg0.package_tuple_commitment == &arg1.package_tuple_commitment, 10);
        assert!(&arg0.call_cap_set_commitment == &arg1.call_cap_set_commitment, 10);
        assert!(arg0.install_mask == 12, 13);
        assert!(0x1::vector::length<vector<u8>>(&arg0.install_mark_commitments) == 2, 13);
        let v0 = derive_bootstrap_certificate_commitment(0x2::object::id<FreshTupleBootstrapCertificateV2>(arg0), arg0.replacement_binding_id, arg0.catalog_id, arg0.package_tuple_commitment, arg0.call_cap_set_commitment, arg0.install_mask, arg0.install_mark_commitments);
        assert!(&v0 == &arg0.certificate_commitment, 11);
        let v1 = FreshTupleBootstrapSlotKeyV2{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<FreshTupleBootstrapSlotKeyV2, FreshTupleBootstrapSlotV2>(&arg2.id, v1);
        assert!(v2.state == 2, 11);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2.certificate_id) && *0x1::option::borrow<0x2::object::ID>(&v2.certificate_id) == 0x2::object::id<FreshTupleBootstrapCertificateV2>(arg0), 11);
        assert!(0x1::option::is_some<vector<u8>>(&v2.certificate_commitment) && 0x1::option::borrow<vector<u8>>(&v2.certificate_commitment) == &arg0.certificate_commitment, 11);
    }

    fun assert_bootstrap_slot_admin(arg0: &ProductReleaseCatalogV8, arg1: &FreshTupleBootstrapAdminV2) {
        let v0 = FreshTupleBootstrapSlotKeyV2{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<FreshTupleBootstrapSlotKeyV2, FreshTupleBootstrapSlotV2>(&arg0.id, v0);
        assert!(v1.state == 1, 11);
        assert!(v1.replacement_binding_id == arg1.replacement_binding_id, 10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1.admin_id) && *0x1::option::borrow<0x2::object::ID>(&v1.admin_id) == 0x2::object::id<FreshTupleBootstrapAdminV2>(arg1), 12);
        assert!(0x1::option::is_none<0x2::object::ID>(&v1.certificate_id), 11);
    }

    public fun assert_catalog_current_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &ProductReleaseCatalogV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_enabled_v8(arg0);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_id_v8(arg0) == arg1.protocol_config_id, 3);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_revision_v8(arg0) == arg1.protocol_config_revision, 3);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_commitment_v8(arg0) == &arg1.protocol_config_commitment, 3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_product_release_catalog_if_claimed_v2(arg0, 0x2::object::id<ProductReleaseCatalogV8>(arg1));
        assert_catalog_well_formed(arg1);
    }

    public(friend) fun assert_catalog_for_stop_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &ProductReleaseCatalogV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_stop_identity_v8(arg0);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_id_v8(arg0) == arg1.protocol_config_id, 3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_product_release_catalog_if_claimed_v2(arg0, 0x2::object::id<ProductReleaseCatalogV8>(arg1));
        assert_catalog_well_formed(arg1);
    }

    public fun assert_catalog_setup_complete_v2(arg0: &ProductReleaseCatalogV8) {
        assert_catalog_well_formed(arg0);
        assert!(arg0.next_setup_role == 6, 6);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.role_config_ids) == (6 as u64) && 0x1::vector::length<vector<u8>>(&arg0.role_config_commitments) == (6 as u64), 6);
    }

    fun assert_catalog_well_formed(arg0: &ProductReleaseCatalogV8) {
        assert!(arg0.schema_revision == 2, 4);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.authority_ids) == 6, 4);
        assert_product_release_binding_well_formed_v8(0x2::object::id<ProductReleaseCatalogV8>(arg0), &arg0.binding, &arg0.call_cap_set_commitment);
        let v0 = derive_call_cap_set_commitment(0x2::object::id<ProductReleaseCatalogV8>(arg0), &arg0.binding.bindings, &arg0.authority_ids);
        assert!(&v0 == &arg0.call_cap_set_commitment, 4);
        let v1 = derive_catalog_commitment(0x2::object::id<ProductReleaseCatalogV8>(arg0), arg0.protocol_config_id, arg0.protocol_config_revision, arg0.protocol_config_commitment, arg0.binding.commitment, arg0.call_cap_set_commitment, &arg0.authority_ids);
        assert!(&v1 == &arg0.catalog_commitment, 4);
        assert!(arg0.next_setup_role <= 6, 9);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg0.role_config_ids);
        let v3 = if (v2 == 0x1::vector::length<vector<u8>>(&arg0.role_config_commitments)) {
            if (v2 <= (arg0.next_setup_role as u64)) {
                (arg0.next_setup_role as u64) <= v2 + 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 9);
        let v4 = 0;
        while (v4 < v2) {
            assert_hash(0x1::vector::borrow<vector<u8>>(&arg0.role_config_commitments, v4));
            let v5 = 0;
            while (v5 < v4) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, v5) != *0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, v4), 9);
                v5 = v5 + 1;
            };
            v4 = v4 + 1;
        };
    }

    fun assert_distinct_bindings(arg0: &vector<ExactPackageBindingV8>) {
        assert!(0x1::vector::length<ExactPackageBindingV8>(arg0) == 7, 2);
        let v0 = 0;
        while (v0 < 7) {
            let v1 = v0 + 1;
            while (v1 < 7) {
                assert!(0x1::vector::borrow<ExactPackageBindingV8>(arg0, v0).original_package_id != 0x1::vector::borrow<ExactPackageBindingV8>(arg0, v1).original_package_id, 2);
                assert!(0x1::vector::borrow<ExactPackageBindingV8>(arg0, v0).callable_package_id != 0x1::vector::borrow<ExactPackageBindingV8>(arg0, v1).callable_package_id, 2);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun assert_exact_single_argument_type_v2<T0, T1>(arg0: &ExactPackageBindingV8, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(arg0.original_package_id == 0x2::object::id_from_address(0x1::type_name::original_id<T0>()) && arg0.callable_package_id == 0x2::object::id_from_address(0x1::type_name::defining_id<T0>()), 8);
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::module_string(&v0));
        let v3 = if (&v2 == arg1) {
            let v4 = 0x1::ascii::into_bytes(0x1::type_name::module_string(&v1));
            if (&v4 == arg1) {
                let v5 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&v0));
                if (&v5 == arg2) {
                    let v6 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&v1));
                    &v6 == arg2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 8);
        let v7 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        let v8 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        assert_single_argument_suffix(0x1::ascii::into_bytes(0x1::type_name::into_string(v0)), 0x1::vector::length<u8>(&v7) + 4 + 0x1::vector::length<u8>(arg1) + 0x1::vector::length<u8>(arg2), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>())));
        assert_single_argument_suffix(0x1::ascii::into_bytes(0x1::type_name::into_string(v1)), 0x1::vector::length<u8>(&v8) + 4 + 0x1::vector::length<u8>(arg1) + 0x1::vector::length<u8>(arg2), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
    }

    public fun assert_exact_witness_type_v2<T0>(arg0: &ExactPackageBindingV8, arg1: &vector<u8>, arg2: &vector<u8>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(arg0.original_package_id == 0x2::object::id_from_address(0x1::type_name::original_id<T0>()), 8);
        assert!(arg0.callable_package_id == 0x2::object::id_from_address(0x1::type_name::defining_id<T0>()), 8);
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::module_string(&v0));
        assert!(&v2 == arg1, 8);
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&v0));
        assert!(&v3 == arg2, 8);
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::module_string(&v1));
        assert!(&v4 == arg1, 8);
        let v5 = 0x1::ascii::into_bytes(0x1::type_name::datatype_string(&v1));
        assert!(&v5 == arg2, 8);
        let v6 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v0));
        let v7 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v1));
        let v8 = 0x1::ascii::into_bytes(0x1::type_name::into_string(v0));
        assert!(0x1::vector::length<u8>(&v8) == 0x1::vector::length<u8>(&v6) + 4 + 0x1::vector::length<u8>(arg1) + 0x1::vector::length<u8>(arg2), 8);
        let v9 = 0x1::ascii::into_bytes(0x1::type_name::into_string(v1));
        assert!(0x1::vector::length<u8>(&v9) == 0x1::vector::length<u8>(&v7) + 4 + 0x1::vector::length<u8>(arg1) + 0x1::vector::length<u8>(arg2), 8);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::is_nonzero_hash_v2(arg0), 0);
    }

    fun assert_optional_hash(arg0: &0x1::option::Option<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(arg0)) {
            assert_hash(0x1::option::borrow<vector<u8>>(arg0));
        };
    }

    fun assert_product_release_binding_well_formed_v8(arg0: 0x2::object::ID, arg1: &ProductReleaseBindingV8, arg2: &vector<u8>) {
        assert!(0x1::vector::length<ExactPackageBindingV8>(&arg1.bindings) == 7, 4);
        let v0 = 0;
        while (v0 < 7) {
            assert_binding_well_formed((v0 as u8), 0x1::vector::borrow<ExactPackageBindingV8>(&arg1.bindings, v0));
            v0 = v0 + 1;
        };
        assert_distinct_bindings(&arg1.bindings);
        let v1 = derive_tuple_commitment(arg0, &arg1.bindings, *arg2);
        assert!(&v1 == &arg1.commitment, 4);
    }

    public fun assert_replacement_current_v2(arg0: &FreshTupleReplacementBindingV2, arg1: &ProductReleaseCatalogV8) {
        assert_catalog_setup_complete_v2(arg1);
        assert!(arg0.version == 2, 10);
        assert!(arg0.catalog_id == 0x2::object::id<ProductReleaseCatalogV8>(arg1), 10);
        let v0 = FreshTupleReplacementBindingInputV2{
            core_binding_commitment     : arg0.core_binding_commitment,
            seal_binding_commitment     : arg0.seal_binding_commitment,
            runtime_binding_commitment  : arg0.runtime_binding_commitment,
            output_binding_commitment   : arg0.output_binding_commitment,
            physical_binding_commitment : arg0.physical_binding_commitment,
            market_binding_commitment   : arg0.market_binding_commitment,
            release_binding_commitment  : arg0.release_binding_commitment,
            package_tuple_commitment    : arg0.package_tuple_commitment,
            call_cap_set_commitment     : arg0.call_cap_set_commitment,
            runtime_config_id           : arg0.runtime_config_id,
            output_config_id            : arg0.output_config_id,
            market_config_id            : arg0.market_config_id,
            release_config_id           : arg0.release_config_id,
        };
        assert_replacement_input(arg1, &v0);
        let v1 = derive_replacement_binding_commitment(0x2::object::id<FreshTupleReplacementBindingV2>(arg0), 0x2::object::id<ProductReleaseCatalogV8>(arg1), &v0);
        assert!(&v1 == &arg0.binding_commitment, 10);
    }

    fun assert_replacement_input(arg0: &ProductReleaseCatalogV8, arg1: &FreshTupleReplacementBindingInputV2) {
        let v0 = replacement_input_from_catalog(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, (1 as u64)), *0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, (2 as u64)), *0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, (4 as u64)), *0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, (5 as u64)));
        assert!(arg1 == &v0, 10);
    }

    public fun assert_role_config_installation_v2(arg0: &ProductReleaseCatalogV8, arg1: u8, arg2: 0x2::object::ID, arg3: &vector<u8>) {
        assert_catalog_well_formed(arg0);
        assert!(arg1 >= 1 && arg1 <= 6, 9);
        let v0 = ((arg1 - 1) as u64);
        assert!(v0 < 0x1::vector::length<0x2::object::ID>(&arg0.role_config_ids) && v0 < 0x1::vector::length<vector<u8>>(&arg0.role_config_commitments), 9);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, v0) == arg2 && 0x1::vector::borrow<vector<u8>>(&arg0.role_config_commitments, v0) == arg3, 9);
    }

    public fun assert_runtime_caller_cap_v1(arg0: &RuntimeCallerCapV1, arg1: u8, arg2: &FreshTupleReplacementBindingV2, arg3: &ProductReleaseCatalogV8) {
        assert_replacement_current_v2(arg2, arg3);
        assert!(arg1 == 0 || arg1 == 1, 14);
        let v0 = if (arg1 == 0) {
            3
        } else {
            5
        };
        let v1 = 0x1::vector::borrow<ExactPackageBindingV8>(&arg3.binding.bindings, (v0 as u64));
        assert!(arg0.schema_revision == 2, 14);
        assert!(arg0.role == arg1, 14);
        assert!(arg0.catalog_id == 0x2::object::id<ProductReleaseCatalogV8>(arg3), 14);
        assert!(arg0.replacement_binding_id == 0x2::object::id<FreshTupleReplacementBindingV2>(arg2), 14);
        assert!(&arg0.package_tuple_commitment == &arg2.package_tuple_commitment, 14);
        assert!(arg0.caller_original_package_id == v1.original_package_id, 14);
        assert!(arg0.caller_callable_package_id == v1.callable_package_id, 14);
        assert!(&arg0.call_cap_set_commitment == &arg2.call_cap_set_commitment, 14);
        let v2 = derive_runtime_caller_cap_commitment(arg1, 0x2::object::id<ProductReleaseCatalogV8>(arg3), 0x2::object::id<FreshTupleReplacementBindingV2>(arg2), arg2.package_tuple_commitment, v1.original_package_id, v1.callable_package_id, arg2.call_cap_set_commitment);
        assert!(&v2 == &arg0.cap_commitment, 14);
    }

    fun assert_single_argument_suffix(arg0: vector<u8>, arg1: u64, arg2: vector<u8>) {
        let v0 = b"<";
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b">");
        assert!(0x1::vector::length<u8>(&arg0) == arg1 + 0x1::vector::length<u8>(&v0), 8);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, arg1 + v1) == *0x1::vector::borrow<u8>(&v0, v1), 8);
            v1 = v1 + 1;
        };
    }

    public fun begin_fresh_tuple_bootstrap_v2(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &FreshTupleReplacementBindingV2, arg3: &mut ProductReleaseCatalogV8, arg4: &mut 0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        assert_catalog_current_v8(arg0, arg3);
        assert_replacement_current_v2(arg2, arg3);
        let v0 = 0x2::object::new(arg4);
        let v1 = FreshTupleBootstrapSlotKeyV2{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<FreshTupleBootstrapSlotKeyV2, FreshTupleBootstrapSlotV2>(&mut arg3.id, v1);
        assert!(v2.state == 0, 11);
        assert!(v2.replacement_binding_id == 0x2::object::id<FreshTupleReplacementBindingV2>(arg2), 10);
        assert!(0x1::option::is_none<0x2::object::ID>(&v2.admin_id) && 0x1::option::is_none<0x2::object::ID>(&v2.certificate_id), 11);
        v2.state = 1;
        v2.admin_id = 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v0));
        let v3 = FreshTupleBootstrapAdminV2{
            id                       : v0,
            version                  : 2,
            protocol_admin_id        : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8>(arg1),
            replacement_binding_id   : 0x2::object::id<FreshTupleReplacementBindingV2>(arg2),
            catalog_id               : 0x2::object::id<ProductReleaseCatalogV8>(arg3),
            package_tuple_commitment : arg2.package_tuple_commitment,
            call_cap_set_commitment  : arg2.call_cap_set_commitment,
            caps_minted              : false,
            install_mask             : 0,
            install_mark_commitments : vector[],
            bootstrap_commitment     : b"",
        };
        v3.bootstrap_commitment = derive_bootstrap_admin_commitment(&v3);
        0x2::transfer::transfer<FreshTupleBootstrapAdminV2>(v3, 0x2::tx_context::sender(arg4));
    }

    public fun binding_at_v2(arg0: &ProductReleaseBindingV8, arg1: u8) : &ExactPackageBindingV8 {
        assert!(arg1 <= 6, 8);
        0x1::vector::borrow<ExactPackageBindingV8>(&arg0.bindings, (arg1 as u64))
    }

    public fun catalog_authority_id_v2(arg0: &ProductReleaseCatalogV8, arg1: u8) : 0x2::object::ID {
        assert!(arg1 < 6, 9);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.authority_ids, (arg1 as u64))
    }

    public fun catalog_binding_v8(arg0: &ProductReleaseCatalogV8) : &ProductReleaseBindingV8 {
        &arg0.binding
    }

    public fun catalog_id_v8(arg0: &ProductReleaseCatalogV8) : 0x2::object::ID {
        0x2::object::id<ProductReleaseCatalogV8>(arg0)
    }

    public fun catalog_terms_v2(arg0: &ProductReleaseCatalogV8) : (0x2::object::ID, u64, &vector<u8>, &ProductReleaseBindingV8, &vector<u8>, &vector<u8>) {
        (arg0.protocol_config_id, arg0.protocol_config_revision, &arg0.protocol_config_commitment, &arg0.binding, &arg0.call_cap_set_commitment, &arg0.catalog_commitment)
    }

    public(friend) fun catalog_uid_mut_v2(arg0: &mut ProductReleaseCatalogV8) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun catalog_uid_v2(arg0: &ProductReleaseCatalogV8) : &0x2::object::UID {
        &arg0.id
    }

    public fun certify_product_release_catalog_v8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: PackageCommitmentsV8, arg3: PackageCommitmentsV8, arg4: PackageCommitmentsV8, arg5: PackageCommitmentsV8, arg6: PackageCommitmentsV8, arg7: PackageCommitmentsV8, arg8: PackageCommitmentsV8, arg9: &mut 0x2::tx_context::TxContext) : ProductReleaseCatalogV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_enabled_v8(arg0);
        let v0 = 0x1::vector::empty<ExactPackageBindingV8>();
        let v1 = &mut v0;
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T0, T1>(0, arg2));
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T2, T3>(1, arg3));
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T4, T5>(2, arg4));
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T6, T7>(3, arg5));
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T8, T9>(4, arg6));
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T10, T11>(5, arg7));
        0x1::vector::push_back<ExactPackageBindingV8>(v1, new_exact_package_binding<T12, T13>(6, arg8));
        assert_distinct_bindings(&v0);
        assert!(0x1::vector::borrow<ExactPackageBindingV8>(&v0, (0 as u64)).original_package_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_core_original_package_id_v8(arg0), 3);
        assert!(0x1::vector::borrow<ExactPackageBindingV8>(&v0, (0 as u64)).callable_package_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_core_callable_package_id_v8(arg0), 3);
        let v2 = 0x2::object::new(arg9);
        let v3 = 0x2::object::uid_to_inner(&v2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::claim_product_release_catalog_v2(arg0, arg1, v3);
        let v4 = fresh_authority_id(arg9);
        let v5 = fresh_authority_id(arg9);
        let v6 = fresh_authority_id(arg9);
        let v7 = fresh_authority_id(arg9);
        let v8 = fresh_authority_id(arg9);
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x2::object::ID>(v10, v4);
        0x1::vector::push_back<0x2::object::ID>(v10, v5);
        0x1::vector::push_back<0x2::object::ID>(v10, v6);
        0x1::vector::push_back<0x2::object::ID>(v10, v7);
        0x1::vector::push_back<0x2::object::ID>(v10, v8);
        0x1::vector::push_back<0x2::object::ID>(v10, fresh_authority_id(arg9));
        let v11 = derive_call_cap_set_commitment(v3, &v0, &v9);
        let v12 = derive_tuple_commitment(v3, &v0, v11);
        let v13 = ProductReleaseBindingV8{
            bindings   : v0,
            commitment : v12,
        };
        let v14 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_id_v8(arg0);
        let v15 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_revision_v8(arg0);
        let v16 = *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::config_commitment_v8(arg0);
        ProductReleaseCatalogV8{
            id                         : v2,
            schema_revision            : 2,
            protocol_config_id         : v14,
            protocol_config_revision   : v15,
            protocol_config_commitment : v16,
            binding                    : v13,
            authority_ids              : v9,
            call_cap_set_commitment    : v11,
            catalog_commitment         : derive_catalog_commitment(v3, v14, v15, v16, v12, v11, &v9),
            next_setup_role            : 0,
            role_config_ids            : 0x1::vector::empty<0x2::object::ID>(),
            role_config_commitments    : vector[],
        }
    }

    fun consume_call_cap<T0, T1: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<T0>, arg2: T1, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: bool, arg8: 0x1::option::Option<vector<u8>>, arg9: 0x1::option::Option<vector<u8>>, arg10: 0x1::option::Option<vector<u8>>, arg11: 0x1::option::Option<0x2::object::ID>, arg12: 0x1::option::Option<0x2::object::ID>, arg13: 0x1::option::Option<0x2::object::ID>, arg14: 0x1::option::Option<vector<u8>>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: 0x1::option::Option<vector<u8>>) : vector<u8> {
        assert_catalog_well_formed(arg0);
        assert!(arg0.next_setup_role == arg3 + 1, 5);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.role_config_ids) == (arg3 as u64) && 0x1::vector::length<vector<u8>>(&arg0.role_config_commitments) == (arg3 as u64), 9);
        assert!(arg6 != 0x2::object::id<ProductReleaseCatalogV8>(arg0), 9);
        let v0 = 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, ((arg3 + 1) as u64));
        assert_exact_witness_type_v2<T1>(v0, &arg4, &arg5);
        let PackageCallCapV8 {
            role                     : v1,
            schema_revision          : v2,
            catalog_id               : v3,
            package_tuple_commitment : v4,
            call_cap_set_commitment  : v5,
            role_authority_id        : v6,
            role_binding_commitment  : v7,
        } = arg1;
        assert!(v1 == arg3 + 1 && v2 == 2, 8);
        let v8 = if (v3 == 0x2::object::id<ProductReleaseCatalogV8>(arg0)) {
            if (v4 == arg0.binding.commitment) {
                if (v5 == arg0.call_cap_set_commitment) {
                    if (v6 == *0x1::vector::borrow<0x2::object::ID>(&arg0.authority_ids, (arg3 as u64))) {
                        v7 == v0.commitment
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v8, 8);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&arg0.role_config_ids)) {
            assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.role_config_ids, v9) != arg6, 9);
            v9 = v9 + 1;
        };
        let v10 = derive_role_config_commitment(arg3 + 1, arg6, 0x2::object::id<ProductReleaseCatalogV8>(arg0), arg0.binding.commitment, arg0.call_cap_set_commitment, *0x1::vector::borrow<0x2::object::ID>(&arg0.authority_ids, (arg3 as u64)), arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.role_config_ids, arg6);
        0x1::vector::push_back<vector<u8>>(&mut arg0.role_config_commitments, v10);
        v10
    }

    public fun consume_fresh_tuple_bootstrap_use_witness_v2<T0: drop>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &FreshTupleReplacementBindingV2, arg2: &ProductReleaseCatalogV8, arg3: FreshTupleBootstrapUseWitnessV2, arg4: T0, arg5: 0x2::object::ID, arg6: vector<u8>) {
        assert_catalog_current_v8(arg0, arg2);
        assert_replacement_current_v2(arg1, arg2);
        assert_hash(&arg6);
        let v0 = 0x1::vector::borrow<ExactPackageBindingV8>(&arg2.binding.bindings, (6 as u64));
        let v1 = b"release_v8";
        let v2 = b"ReleaseBootstrapFinalizeWitnessV2";
        assert_exact_witness_type_v2<T0>(v0, &v1, &v2);
        let FreshTupleBootstrapUseWitnessV2 {
            replacement_binding_id           : v3,
            bootstrap_certificate_id         : _,
            bootstrap_certificate_commitment : v5,
            release_config_id                : v6,
            release_original_package_id      : v7,
        } = arg3;
        let v8 = v5;
        assert!(v3 == 0x2::object::id<FreshTupleReplacementBindingV2>(arg1), 10);
        assert_hash(&v8);
        assert!(v6 == arg5 && arg5 == arg1.release_config_id, 10);
        assert!(v7 == v0.original_package_id, 10);
    }

    public fun consume_market_call_cap_v8<T0: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<MarketRoleV8>, arg2: T0, arg3: 0x2::object::ID) : vector<u8> {
        consume_call_cap<MarketRoleV8, T0>(arg0, arg1, arg2, 4, b"market_v8", b"MarketSetupInstallWitnessV2", arg3, false, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>())
    }

    public fun consume_output_call_cap_v8<T0: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<OutputRoleV8>, arg2: T0, arg3: 0x2::object::ID) : vector<u8> {
        consume_call_cap<OutputRoleV8, T0>(arg0, arg1, arg2, 2, b"output_v8", b"OutputSetupInstallWitnessV2", arg3, false, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>())
    }

    public fun consume_physical_call_cap_v8<T0: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<PhysicalRoleV8>, arg2: T0, arg3: 0x2::object::ID) : vector<u8> {
        consume_call_cap<PhysicalRoleV8, T0>(arg0, arg1, arg2, 3, b"physical_v8", b"PhysicalSetupInstallWitnessV2", arg3, true, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>())
    }

    public fun consume_release_call_cap_v8<T0: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<ReleaseRoleV8>, arg2: T0, arg3: 0x2::object::ID) : vector<u8> {
        consume_call_cap<ReleaseRoleV8, T0>(arg0, arg1, arg2, 5, b"release_v8", b"ReleaseSetupInstallWitnessV2", arg3, false, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>())
    }

    public fun consume_runtime_call_cap_v8<T0: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<RuntimeRoleV8>, arg2: T0, arg3: 0x2::object::ID) : vector<u8> {
        consume_call_cap<RuntimeRoleV8, T0>(arg0, arg1, arg2, 1, b"runtime_v8", b"RuntimeSetupInstallWitnessV2", arg3, false, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>())
    }

    public fun consume_seal_call_cap_v8<T0: drop>(arg0: &mut ProductReleaseCatalogV8, arg1: PackageCallCapV8<SealRoleV8>, arg2: T0, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : vector<u8> {
        consume_call_cap<SealRoleV8, T0>(arg0, arg1, arg2, 0, b"seal_v8", b"SealSetupInstallWitnessV2", arg3, true, 0x1::option::some<vector<u8>>(arg4), 0x1::option::some<vector<u8>>(arg5), 0x1::option::some<vector<u8>>(arg6), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<vector<u8>>())
    }

    fun derive_bootstrap_admin_commitment(arg0: &FreshTupleBootstrapAdminV2) : vector<u8> {
        let v0 = FreshTupleBootstrapAdminCommitmentInputV2{
            domain                           : 0x1::string::utf8(b"animacraft-fresh-v8/core/fresh-tuple-bootstrap-admin/v2"),
            schema_revision                  : 2,
            admin_id                         : 0x2::object::id<FreshTupleBootstrapAdminV2>(arg0),
            protocol_admin_id                : arg0.protocol_admin_id,
            replacement_binding_id           : arg0.replacement_binding_id,
            catalog_id                       : arg0.catalog_id,
            package_tuple_commitment         : arg0.package_tuple_commitment,
            call_cap_set_commitment          : arg0.call_cap_set_commitment,
            caps_minted                      : arg0.caps_minted,
            install_mask                     : arg0.install_mask,
            ordered_install_mark_commitments : arg0.install_mark_commitments,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<FreshTupleBootstrapAdminCommitmentInputV2>(&v0))
    }

    fun derive_bootstrap_certificate_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<vector<u8>>) : vector<u8> {
        let v0 = FreshTupleBootstrapCertificateCommitmentInputV2{
            domain                           : 0x1::string::utf8(b"animacraft-fresh-v8/core/fresh-tuple-bootstrap-certificate/v2"),
            schema_revision                  : 2,
            certificate_id                   : arg0,
            replacement_binding_id           : arg1,
            catalog_id                       : arg2,
            package_tuple_commitment         : arg3,
            call_cap_set_commitment          : arg4,
            install_mask                     : arg5,
            ordered_install_mark_commitments : arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<FreshTupleBootstrapCertificateCommitmentInputV2>(&v0))
    }

    fun derive_call_cap_set_commitment(arg0: 0x2::object::ID, arg1: &vector<ExactPackageBindingV8>, arg2: &vector<0x2::object::ID>) : vector<u8> {
        assert!(0x1::vector::length<ExactPackageBindingV8>(arg1) == 7, 4);
        assert!(0x1::vector::length<0x2::object::ID>(arg2) == 6, 4);
        let v0 = PackageCallCapSetCommitmentInputV2{
            domain                      : 0x1::string::utf8(b"animacraft-fresh-v8/package/call-cap-set/v2"),
            schema_revision             : 2,
            catalog_id                  : arg0,
            core_binding_commitment     : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (0 as u64)).commitment,
            seal_binding_commitment     : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (1 as u64)).commitment,
            runtime_binding_commitment  : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (2 as u64)).commitment,
            output_binding_commitment   : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (3 as u64)).commitment,
            physical_binding_commitment : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (4 as u64)).commitment,
            market_binding_commitment   : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (5 as u64)).commitment,
            release_binding_commitment  : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (6 as u64)).commitment,
            seal_authority_id           : *0x1::vector::borrow<0x2::object::ID>(arg2, (0 as u64)),
            runtime_authority_id        : *0x1::vector::borrow<0x2::object::ID>(arg2, (1 as u64)),
            output_authority_id         : *0x1::vector::borrow<0x2::object::ID>(arg2, (2 as u64)),
            physical_authority_id       : *0x1::vector::borrow<0x2::object::ID>(arg2, (3 as u64)),
            market_authority_id         : *0x1::vector::borrow<0x2::object::ID>(arg2, (4 as u64)),
            release_authority_id        : *0x1::vector::borrow<0x2::object::ID>(arg2, (5 as u64)),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PackageCallCapSetCommitmentInputV2>(&v0))
    }

    fun derive_catalog_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &vector<0x2::object::ID>) : vector<u8> {
        let v0 = CatalogCommitmentInputV2{
            domain                     : 0x1::string::utf8(b"animacraft-fresh-v8/core/catalog/v2"),
            schema_revision            : 2,
            catalog_id                 : arg0,
            protocol_config_id         : arg1,
            protocol_config_revision   : arg2,
            protocol_config_commitment : arg3,
            package_tuple_commitment   : arg4,
            call_cap_set_commitment    : arg5,
            native_capability_mask     : 127,
            seal_authority_id          : *0x1::vector::borrow<0x2::object::ID>(arg6, (0 as u64)),
            runtime_authority_id       : *0x1::vector::borrow<0x2::object::ID>(arg6, (1 as u64)),
            output_authority_id        : *0x1::vector::borrow<0x2::object::ID>(arg6, (2 as u64)),
            physical_authority_id      : *0x1::vector::borrow<0x2::object::ID>(arg6, (3 as u64)),
            market_authority_id        : *0x1::vector::borrow<0x2::object::ID>(arg6, (4 as u64)),
            release_authority_id       : *0x1::vector::borrow<0x2::object::ID>(arg6, (5 as u64)),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CatalogCommitmentInputV2>(&v0))
    }

    fun derive_replacement_binding_commitment(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &FreshTupleReplacementBindingInputV2) : vector<u8> {
        let v0 = FreshTupleReplacementBindingCommitmentInputV2{
            domain                      : 0x1::string::utf8(b"animacraft-fresh-v8/core/fresh-tuple-replacement-binding/v2"),
            schema_revision             : 2,
            binding_id                  : arg0,
            catalog_id                  : arg1,
            core_binding_commitment     : arg2.core_binding_commitment,
            seal_binding_commitment     : arg2.seal_binding_commitment,
            runtime_binding_commitment  : arg2.runtime_binding_commitment,
            output_binding_commitment   : arg2.output_binding_commitment,
            physical_binding_commitment : arg2.physical_binding_commitment,
            market_binding_commitment   : arg2.market_binding_commitment,
            release_binding_commitment  : arg2.release_binding_commitment,
            package_tuple_commitment    : arg2.package_tuple_commitment,
            call_cap_set_commitment     : arg2.call_cap_set_commitment,
            runtime_config_id           : arg2.runtime_config_id,
            output_config_id            : arg2.output_config_id,
            market_config_id            : arg2.market_config_id,
            release_config_id           : arg2.release_config_id,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<FreshTupleReplacementBindingCommitmentInputV2>(&v0))
    }

    fun derive_role_config_commitment(arg0: u8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: bool, arg7: 0x1::option::Option<vector<u8>>, arg8: 0x1::option::Option<vector<u8>>, arg9: 0x1::option::Option<vector<u8>>, arg10: 0x1::option::Option<0x2::object::ID>, arg11: 0x1::option::Option<0x2::object::ID>, arg12: 0x1::option::Option<0x2::object::ID>, arg13: 0x1::option::Option<vector<u8>>, arg14: 0x1::option::Option<0x2::object::ID>, arg15: 0x1::option::Option<vector<u8>>) : vector<u8> {
        assert!(arg0 >= 1 && arg0 <= 6, 9);
        assert_hash(&arg3);
        assert_hash(&arg4);
        assert_optional_hash(&arg7);
        assert_optional_hash(&arg8);
        assert_optional_hash(&arg9);
        assert_optional_hash(&arg13);
        assert_optional_hash(&arg15);
        let v0 = RoleConfigCommitmentInputV2{
            domain                           : 0x1::string::utf8(b"animacraft-fresh-v8/package/role-config/v2"),
            schema_revision                  : 2,
            role                             : arg0,
            config_id                        : arg1,
            catalog_id                       : arg2,
            package_tuple_commitment         : arg3,
            call_cap_set_commitment          : arg4,
            authority_id                     : arg5,
            finalized                        : arg6,
            seal_policy_commitment           : arg7,
            key_server_set_commitment        : arg8,
            encryption_policy_commitment     : arg9,
            external_validator_policy_id     : arg10,
            external_validator_registry_id   : arg11,
            soul_binding_registry_id         : arg12,
            runtime_caller_cap_commitment    : arg13,
            bootstrap_certificate_id         : arg14,
            bootstrap_certificate_commitment : arg15,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RoleConfigCommitmentInputV2>(&v0))
    }

    fun derive_runtime_caller_cap_commitment(arg0: u8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>) : vector<u8> {
        let v0 = RuntimeCallerCapCommitmentInputV1{
            domain                     : 0x1::string::utf8(b"animacraft-fresh-v8/core/runtime-caller-cap/v1"),
            schema_revision            : 2,
            role                       : arg0,
            catalog_id                 : arg1,
            replacement_binding_id     : arg2,
            package_tuple_commitment   : arg3,
            caller_original_package_id : arg4,
            caller_callable_package_id : arg5,
            call_cap_set_commitment    : arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RuntimeCallerCapCommitmentInputV1>(&v0))
    }

    fun derive_tuple_commitment(arg0: 0x2::object::ID, arg1: &vector<ExactPackageBindingV8>, arg2: vector<u8>) : vector<u8> {
        let v0 = PackageTupleInputV2{
            domain                  : 0x1::string::utf8(b"animacraft-fresh-v8/package/product-tuple/v2"),
            schema_revision         : 2,
            catalog_id              : arg0,
            native_capability_mask  : 127,
            call_cap_set_commitment : arg2,
            core_binding            : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (0 as u64)).commitment,
            seal_binding            : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (1 as u64)).commitment,
            runtime_binding         : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (2 as u64)).commitment,
            output_binding          : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (3 as u64)).commitment,
            physical_binding        : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (4 as u64)).commitment,
            market_binding          : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (5 as u64)).commitment,
            release_binding         : 0x1::vector::borrow<ExactPackageBindingV8>(arg1, (6 as u64)).commitment,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PackageTupleInputV2>(&v0))
    }

    public fun exact_binding_terms_v2(arg0: &ExactPackageBindingV8) : (0x2::object::ID, 0x2::object::ID, &vector<u8>, &vector<u8>, &vector<u8>, &vector<u8>) {
        (arg0.original_package_id, arg0.callable_package_id, &arg0.source_commitment, &arg0.package_commitment, &arg0.abi_commitment, &arg0.commitment)
    }

    public fun finalize_fresh_tuple_bootstrap_v2(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: FreshTupleBootstrapAdminV2, arg2: &FreshTupleReplacementBindingV2, arg3: &mut ProductReleaseCatalogV8, arg4: &mut 0x2::tx_context::TxContext) {
        assert_catalog_current_v8(arg0, arg3);
        assert_replacement_current_v2(arg2, arg3);
        assert_bootstrap_admin(&arg1, arg2, arg3);
        assert!(arg1.caps_minted && arg1.install_mask == 12, 13);
        assert!(0x1::vector::length<vector<u8>>(&arg1.install_mark_commitments) == 2, 13);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = derive_bootstrap_certificate_commitment(v1, 0x2::object::id<FreshTupleReplacementBindingV2>(arg2), 0x2::object::id<ProductReleaseCatalogV8>(arg3), arg2.package_tuple_commitment, arg2.call_cap_set_commitment, arg1.install_mask, arg1.install_mark_commitments);
        let v3 = FreshTupleBootstrapSlotKeyV2{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<FreshTupleBootstrapSlotKeyV2, FreshTupleBootstrapSlotV2>(&mut arg3.id, v3);
        assert!(v4.state == 1, 11);
        assert!(v4.replacement_binding_id == 0x2::object::id<FreshTupleReplacementBindingV2>(arg2), 10);
        assert!(0x1::option::is_some<0x2::object::ID>(&v4.admin_id) && *0x1::option::borrow<0x2::object::ID>(&v4.admin_id) == 0x2::object::id<FreshTupleBootstrapAdminV2>(&arg1), 12);
        v4.state = 2;
        v4.admin_id = 0x1::option::none<0x2::object::ID>();
        v4.certificate_id = 0x1::option::some<0x2::object::ID>(v1);
        v4.certificate_commitment = 0x1::option::some<vector<u8>>(v2);
        let FreshTupleBootstrapAdminV2 {
            id                       : v5,
            version                  : _,
            protocol_admin_id        : _,
            replacement_binding_id   : _,
            catalog_id               : _,
            package_tuple_commitment : _,
            call_cap_set_commitment  : _,
            caps_minted              : _,
            install_mask             : v13,
            install_mark_commitments : v14,
            bootstrap_commitment     : _,
        } = arg1;
        0x2::object::delete(v5);
        let v16 = FreshTupleBootstrapCertificateV2{
            id                       : v0,
            version                  : 2,
            replacement_binding_id   : 0x2::object::id<FreshTupleReplacementBindingV2>(arg2),
            catalog_id               : 0x2::object::id<ProductReleaseCatalogV8>(arg3),
            package_tuple_commitment : arg2.package_tuple_commitment,
            call_cap_set_commitment  : arg2.call_cap_set_commitment,
            install_mask             : v13,
            install_mark_commitments : v14,
            certificate_commitment   : v2,
        };
        0x2::transfer::freeze_object<FreshTupleBootstrapCertificateV2>(v16);
    }

    fun fresh_authority_id(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    fun install_witness_rule(arg0: &FreshTupleReplacementBindingV2, arg1: u8) : (u8, u8, 0x2::object::ID, vector<u8>, vector<u8>) {
        if (arg1 == 4) {
            (3, 0, arg0.output_config_id, b"output_v8", b"OutputRuntimeCallerCapInstallWitnessV2")
        } else {
            assert!(arg1 == 8, 13);
            (5, 4, arg0.market_config_id, b"market_v8", b"MarketRuntimeCallerCapInstallWitnessV2")
        }
    }

    public fun issue_fresh_tuple_bootstrap_use_witness_v2(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &FreshTupleReplacementBindingV2, arg2: &FreshTupleBootstrapCertificateV2, arg3: &ProductReleaseCatalogV8, arg4: 0x2::object::ID) : FreshTupleBootstrapUseWitnessV2 {
        assert_catalog_current_v8(arg0, arg3);
        assert_replacement_current_v2(arg1, arg3);
        assert_bootstrap_certificate_v2(arg2, arg1, arg3);
        assert!(arg4 == arg1.release_config_id, 10);
        FreshTupleBootstrapUseWitnessV2{
            replacement_binding_id           : 0x2::object::id<FreshTupleReplacementBindingV2>(arg1),
            bootstrap_certificate_id         : 0x2::object::id<FreshTupleBootstrapCertificateV2>(arg2),
            bootstrap_certificate_commitment : arg2.certificate_commitment,
            release_config_id                : arg4,
            release_original_package_id      : 0x1::vector::borrow<ExactPackageBindingV8>(&arg3.binding.bindings, (6 as u64)).original_package_id,
        }
    }

    public fun mark_fresh_tuple_install_v2<T0: drop>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &mut FreshTupleBootstrapAdminV2, arg2: &FreshTupleReplacementBindingV2, arg3: &ProductReleaseCatalogV8, arg4: T0, arg5: u8, arg6: 0x2::object::ID, arg7: 0x1::option::Option<0x2::object::ID>, arg8: vector<u8>) {
        assert_catalog_current_v8(arg0, arg3);
        assert_replacement_current_v2(arg2, arg3);
        assert_bootstrap_admin(arg1, arg2, arg3);
        assert_bootstrap_slot_admin(arg3, arg1);
        assert!(arg1.caps_minted, 12);
        assert_hash(&arg8);
        let (v0, v1, v2, v3, v4) = install_witness_rule(arg2, arg5);
        let v5 = v4;
        let v6 = v3;
        assert!(arg1.install_mask == v1, 13);
        assert!(arg6 == v2, 13);
        assert_exact_witness_type_v2<T0>(0x1::vector::borrow<ExactPackageBindingV8>(&arg3.binding.bindings, (v0 as u64)), &v6, &v5);
        let v7 = TupleBootstrapInstallMarkCommitmentInputV2{
            domain                 : 0x1::string::utf8(b"animacraft-fresh-v8/core/fresh-tuple-bootstrap-install-mark/v2"),
            schema_revision        : 2,
            replacement_binding_id : 0x2::object::id<FreshTupleReplacementBindingV2>(arg2),
            role                   : v0,
            install_kind           : arg5,
            config_id              : arg6,
            installed_object_id    : arg7,
            installed_commitment   : arg8,
            role_witness_type_name : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())),
        };
        arg1.install_mask = v1 + arg5;
        0x1::vector::push_back<vector<u8>>(&mut arg1.install_mark_commitments, 0x1::hash::sha2_256(0x1::bcs::to_bytes<TupleBootstrapInstallMarkCommitmentInputV2>(&v7)));
        arg1.bootstrap_commitment = derive_bootstrap_admin_commitment(arg1);
    }

    public fun mint_runtime_caller_caps_v1(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &mut FreshTupleBootstrapAdminV2, arg2: &FreshTupleReplacementBindingV2, arg3: &ProductReleaseCatalogV8) : (RuntimeCallerCapV1, RuntimeCallerCapV1) {
        assert_catalog_current_v8(arg0, arg3);
        assert_replacement_current_v2(arg2, arg3);
        assert_bootstrap_admin(arg1, arg2, arg3);
        assert!(!arg1.caps_minted && arg1.install_mask == 0, 12);
        assert_bootstrap_slot_admin(arg3, arg1);
        arg1.caps_minted = true;
        arg1.bootstrap_commitment = derive_bootstrap_admin_commitment(arg1);
        (new_runtime_caller_cap(0, arg2, arg3, 0x1::vector::borrow<ExactPackageBindingV8>(&arg3.binding.bindings, (3 as u64))), new_runtime_caller_cap(1, arg2, arg3, 0x1::vector::borrow<ExactPackageBindingV8>(&arg3.binding.bindings, (5 as u64))))
    }

    fun new_binding(arg0: u8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: PackageCommitmentsV8) : ExactPackageBindingV8 {
        let PackageCommitmentsV8 {
            source_commitment  : v0,
            package_commitment : v1,
            abi_commitment     : v2,
        } = arg3;
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert_hash(&v5);
        assert_hash(&v4);
        assert_hash(&v3);
        let v6 = ExactPackageBindingInputV2{
            domain              : 0x1::string::utf8(b"animacraft-fresh-v8/package/exact-binding/v2"),
            schema_revision     : 2,
            role                : arg0,
            original_package_id : arg1,
            callable_package_id : arg2,
            source_commitment   : v5,
            package_commitment  : v4,
            abi_commitment      : v3,
        };
        ExactPackageBindingV8{
            original_package_id : arg1,
            callable_package_id : arg2,
            source_commitment   : v5,
            package_commitment  : v4,
            abi_commitment      : v3,
            commitment          : 0x1::hash::sha2_256(0x1::bcs::to_bytes<ExactPackageBindingInputV2>(&v6)),
        }
    }

    fun new_exact_package_binding<T0, T1>(arg0: u8, arg1: PackageCommitmentsV8) : ExactPackageBindingV8 {
        assert!(0x1::type_name::original_id<T0>() == 0x1::type_name::original_id<T1>(), 1);
        new_binding(arg0, 0x2::object::id_from_address(0x1::type_name::original_id<T0>()), 0x2::object::id_from_address(0x1::type_name::defining_id<T1>()), arg1)
    }

    public fun new_fresh_tuple_replacement_binding_input_v2(arg0: &ProductReleaseCatalogV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) : FreshTupleReplacementBindingInputV2 {
        assert_catalog_setup_complete_v2(arg0);
        replacement_input_from_catalog(arg0, arg1, arg2, arg3, arg4)
    }

    public fun new_package_commitments_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : PackageCommitmentsV8 {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        PackageCommitmentsV8{
            source_commitment  : arg0,
            package_commitment : arg1,
            abi_commitment     : arg2,
        }
    }

    fun new_runtime_caller_cap(arg0: u8, arg1: &FreshTupleReplacementBindingV2, arg2: &ProductReleaseCatalogV8, arg3: &ExactPackageBindingV8) : RuntimeCallerCapV1 {
        RuntimeCallerCapV1{
            schema_revision            : 2,
            role                       : arg0,
            catalog_id                 : 0x2::object::id<ProductReleaseCatalogV8>(arg2),
            replacement_binding_id     : 0x2::object::id<FreshTupleReplacementBindingV2>(arg1),
            package_tuple_commitment   : arg1.package_tuple_commitment,
            caller_original_package_id : arg3.original_package_id,
            caller_callable_package_id : arg3.callable_package_id,
            call_cap_set_commitment    : arg1.call_cap_set_commitment,
            cap_commitment             : derive_runtime_caller_cap_commitment(arg0, 0x2::object::id<ProductReleaseCatalogV8>(arg2), 0x2::object::id<FreshTupleReplacementBindingV2>(arg1), arg1.package_tuple_commitment, arg3.original_package_id, arg3.callable_package_id, arg1.call_cap_set_commitment),
        }
    }

    public fun product_binding_commitment_v8(arg0: &ProductReleaseBindingV8) : &vector<u8> {
        &arg0.commitment
    }

    fun replacement_input_from_catalog(arg0: &ProductReleaseCatalogV8, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) : FreshTupleReplacementBindingInputV2 {
        FreshTupleReplacementBindingInputV2{
            core_binding_commitment     : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (0 as u64)).commitment,
            seal_binding_commitment     : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (1 as u64)).commitment,
            runtime_binding_commitment  : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (2 as u64)).commitment,
            output_binding_commitment   : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (3 as u64)).commitment,
            physical_binding_commitment : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (4 as u64)).commitment,
            market_binding_commitment   : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (5 as u64)).commitment,
            release_binding_commitment  : 0x1::vector::borrow<ExactPackageBindingV8>(&arg0.binding.bindings, (6 as u64)).commitment,
            package_tuple_commitment    : arg0.binding.commitment,
            call_cap_set_commitment     : arg0.call_cap_set_commitment,
            runtime_config_id           : arg1,
            output_config_id            : arg2,
            market_config_id            : arg3,
            release_config_id           : arg4,
        }
    }

    public fun runtime_caller_cap_commitment_v2(arg0: &RuntimeCallerCapV1) : &vector<u8> {
        &arg0.cap_commitment
    }

    public fun seal_fresh_tuple_replacement_binding_v2(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8, arg3: FreshTupleReplacementBindingInputV2, arg4: &mut 0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        assert_catalog_current_v8(arg0, arg2);
        assert_catalog_setup_complete_v2(arg2);
        assert_replacement_input(arg2, &arg3);
        let v0 = FreshTupleBootstrapSlotKeyV2{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<FreshTupleBootstrapSlotKeyV2>(&arg2.id, v0), 11);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::id<ProductReleaseCatalogV8>(arg2);
        let FreshTupleReplacementBindingInputV2 {
            core_binding_commitment     : v4,
            seal_binding_commitment     : v5,
            runtime_binding_commitment  : v6,
            output_binding_commitment   : v7,
            physical_binding_commitment : v8,
            market_binding_commitment   : v9,
            release_binding_commitment  : v10,
            package_tuple_commitment    : v11,
            call_cap_set_commitment     : v12,
            runtime_config_id           : v13,
            output_config_id            : v14,
            market_config_id            : v15,
            release_config_id           : v16,
        } = arg3;
        let v17 = FreshTupleBootstrapSlotKeyV2{dummy_field: false};
        let v18 = FreshTupleBootstrapSlotV2{
            state                  : 0,
            replacement_binding_id : v2,
            admin_id               : 0x1::option::none<0x2::object::ID>(),
            certificate_id         : 0x1::option::none<0x2::object::ID>(),
            certificate_commitment : 0x1::option::none<vector<u8>>(),
        };
        0x2::dynamic_field::add<FreshTupleBootstrapSlotKeyV2, FreshTupleBootstrapSlotV2>(&mut arg2.id, v17, v18);
        let v19 = FreshTupleReplacementBindingV2{
            id                          : v1,
            version                     : 2,
            catalog_id                  : v3,
            core_binding_commitment     : v4,
            seal_binding_commitment     : v5,
            runtime_binding_commitment  : v6,
            output_binding_commitment   : v7,
            physical_binding_commitment : v8,
            market_binding_commitment   : v9,
            release_binding_commitment  : v10,
            package_tuple_commitment    : v11,
            call_cap_set_commitment     : v12,
            runtime_config_id           : v13,
            output_config_id            : v14,
            market_config_id            : v15,
            release_config_id           : v16,
            binding_commitment          : derive_replacement_binding_commitment(v2, v3, &arg3),
        };
        0x2::transfer::freeze_object<FreshTupleReplacementBindingV2>(v19);
    }

    public fun share_product_release_catalog_v8(arg0: ProductReleaseCatalogV8) {
        assert!(arg0.next_setup_role == 6, 6);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.role_config_ids) == (6 as u64) && 0x1::vector::length<vector<u8>>(&arg0.role_config_commitments) == (6 as u64), 6);
        assert_catalog_well_formed(&arg0);
        0x2::transfer::share_object<ProductReleaseCatalogV8>(arg0);
    }

    fun take_call_cap<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8, arg3: u8) : PackageCallCapV8<T0> {
        assert!(arg3 < 6, 8);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        assert_catalog_current_v8(arg0, arg2);
        assert!(arg2.next_setup_role == arg3, 5);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2.role_config_ids) == (arg3 as u64) && 0x1::vector::length<vector<u8>>(&arg2.role_config_commitments) == (arg3 as u64), 9);
        arg2.next_setup_role = arg3 + 1;
        PackageCallCapV8<T0>{
            role                     : arg3 + 1,
            schema_revision          : 2,
            catalog_id               : 0x2::object::id<ProductReleaseCatalogV8>(arg2),
            package_tuple_commitment : arg2.binding.commitment,
            call_cap_set_commitment  : arg2.call_cap_set_commitment,
            role_authority_id        : *0x1::vector::borrow<0x2::object::ID>(&arg2.authority_ids, (arg3 as u64)),
            role_binding_commitment  : 0x1::vector::borrow<ExactPackageBindingV8>(&arg2.binding.bindings, ((arg3 + 1) as u64)).commitment,
        }
    }

    public fun take_market_call_cap_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<MarketRoleV8> {
        take_call_cap<MarketRoleV8>(arg0, arg1, arg2, 4)
    }

    public fun take_output_call_cap_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<OutputRoleV8> {
        take_call_cap<OutputRoleV8>(arg0, arg1, arg2, 2)
    }

    public fun take_physical_call_cap_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<PhysicalRoleV8> {
        take_call_cap<PhysicalRoleV8>(arg0, arg1, arg2, 3)
    }

    public fun take_release_call_cap_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<ReleaseRoleV8> {
        take_call_cap<ReleaseRoleV8>(arg0, arg1, arg2, 5)
    }

    public fun take_runtime_call_cap_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<RuntimeRoleV8> {
        take_call_cap<RuntimeRoleV8>(arg0, arg1, arg2, 1)
    }

    public fun take_seal_call_cap_v8(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolAdminCapV8, arg2: &mut ProductReleaseCatalogV8) : PackageCallCapV8<SealRoleV8> {
        take_call_cap<SealRoleV8>(arg0, arg1, arg2, 0)
    }

    // decompiled from Move bytecode v7
}

