module 0x6ab96dd04bca43ba4f6ebda6bafcdd052c5ba326814fb592c8ff2c0c2bc9b0b3::seal_v8 {
    struct SealOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct SealCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct KeyServerBindingV8 has copy, drop, store {
        key_server_id: 0x2::object::ID,
        weight: u16,
    }

    struct SealPolicyConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_original_package_id: 0x2::object::ID,
        seal_callable_package_id: 0x2::object::ID,
        seal_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        seal_call_cap: 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::SealRoleV8>,
        key_servers: vector<KeyServerBindingV8>,
        threshold: u16,
        key_server_set_commitment: vector<u8>,
        encryption_policy_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct ProtectedAssetKeyV8 has copy, drop, store {
        scope_kind: u8,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
    }

    struct ProtectedAssetV8 has copy, drop, store {
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct ProtectedAssetSnapshotV8 has copy, drop, store {
        registry_id: 0x2::object::ID,
        registry_commitment: vector<u8>,
        runtime_revision: u64,
        runtime_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct SealRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        expected_base_count: u64,
        expected_pack_count: u64,
        expected_complete_count: u64,
        expected_count: u64,
        observed_base_count: u64,
        observed_pack_count: u64,
        observed_complete_count: u64,
        observed_count: u64,
        expected_commitment: vector<u8>,
        rolling_commitment: vector<u8>,
        sealed: bool,
        keys: vector<ProtectedAssetKeyV8>,
        assets: 0x2::table::Table<ProtectedAssetKeyV8, ProtectedAssetV8>,
        runtime_revision: u64,
        runtime_commitment: vector<u8>,
        runtime_keys: vector<ProtectedAssetKeyV8>,
        runtime_assets: 0x2::table::Table<ProtectedAssetKeyV8, ProtectedAssetV8>,
    }

    struct CiphertextCertificationV8 {
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        policy_config_id: 0x2::object::ID,
        policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
        certification_commitment: vector<u8>,
        seal_id: vector<u8>,
    }

    struct BaseDecryptProofV8 {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        entitlement_id: 0x2::object::ID,
        entitlement_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct PackDecryptProofV8 {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        base_entitlement_id: 0x2::object::ID,
        base_entitlement_commitment: vector<u8>,
        pack_entitlement_id: 0x2::object::ID,
        pack_entitlement_commitment: vector<u8>,
        pack_release_id: 0x2::object::ID,
        pack_content_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct CompleteDecryptProofV8 {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        receipt_id: 0x2::object::ID,
        output_id: 0x2::object::ID,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct PrivateSealReadinessWitnessV8 {
        registry_id: 0x2::object::ID,
        policy_config_id: 0x2::object::ID,
        key_server_ids: vector<0x2::object::ID>,
        key_server_set_commitment: vector<u8>,
        encryption_policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        registry_commitment: vector<u8>,
        base_count: u64,
        pack_count: u64,
        complete_count: u64,
        total_count: u64,
    }

    struct SealReadinessV8 {
        registry_id: 0x2::object::ID,
        policy_config_id: 0x2::object::ID,
        key_server_ids: vector<0x2::object::ID>,
        key_server_set_commitment: vector<u8>,
        encryption_policy_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        registry_commitment: vector<u8>,
        base_count: u64,
        pack_count: u64,
        complete_count: u64,
        total_count: u64,
    }

    struct SealPolicyCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        protocol_config_id: 0x2::object::ID,
        protocol_config_revision: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        seal_original_package_id: 0x2::object::ID,
        seal_callable_package_id: 0x2::object::ID,
        seal_binding_commitment: vector<u8>,
        seal_authority_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        key_servers: vector<KeyServerBindingV8>,
        threshold: u16,
        key_server_set_commitment: vector<u8>,
        encryption_policy_commitment: vector<u8>,
    }

    struct CiphertextCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        policy_commitment: vector<u8>,
        root_content_commitment: vector<u8>,
        maker_version: u64,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        scope_commitment: vector<u8>,
        asset_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        ciphertext_blob_id: 0x1::string::String,
        ciphertext_sha256: vector<u8>,
        ciphertext_blob_commitment: vector<u8>,
    }

    struct SealIdInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        product_binding_commitment: vector<u8>,
        policy_commitment: vector<u8>,
        root_content_commitment: vector<u8>,
        maker_version: u64,
        scope_kind: u8,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
    }

    struct EmptyRegistryCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        product_binding_commitment: vector<u8>,
        policy_commitment: vector<u8>,
        root_content_commitment: vector<u8>,
        maker_version: u64,
    }

    struct CompleteInstanceCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
    }

    struct RegistryRowCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
        maker_version: u64,
        sequence: u64,
        prior_commitment: vector<u8>,
        row: ProtectedAssetV8,
    }

    struct SealPolicyCreatedV8 has copy, drop {
        config_id: 0x2::object::ID,
        catalog_id: 0x2::object::ID,
        threshold: u16,
        key_server_set_commitment: vector<u8>,
        commitment: vector<u8>,
    }

    struct ProtectedAssetAppendedV8 has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        sequence: u64,
        scope_kind: u8,
        seal_id: vector<u8>,
        rolling_commitment: vector<u8>,
    }

    struct SealRegistrySealedV8 has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        total_count: u64,
        commitment: vector<u8>,
    }

    struct RuntimeProtectedAssetRegisteredV8 has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        previous_revision: u64,
        new_revision: u64,
        scope_kind: u8,
        seal_id: vector<u8>,
        runtime_commitment: vector<u8>,
    }

    public fun advance_registry_commitment_v8(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: ProtectedAssetV8) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg3);
        assert_valid_row(&arg4);
        let v0 = RegistryRowCommitmentInputV8{
            domain                  : b"animacraft-v8/seal/registry-row",
            version                 : 8,
            root_content_commitment : arg0,
            maker_version           : arg1,
            sequence                : arg2,
            prior_commitment        : arg3,
            row                     : arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RegistryRowCommitmentInputV8>(&v0))
    }

    public fun append_protected_asset_v8<T0>(arg0: &mut SealRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: &SealPolicyConfigV8, arg4: u64, arg5: CiphertextCertificationV8) : vector<u8> {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_binding<T0>(arg0, arg1, arg3);
        assert!(!arg0.sealed, 9);
        assert!(arg4 == arg0.observed_count, 7);
        assert!(arg4 < arg0.expected_count, 6);
        let v0 = consume_certification(arg5, arg0, arg3);
        assert_scope_count_available(arg0, v0.scope_kind);
        let v1 = ProtectedAssetKeyV8{
            scope_kind : v0.scope_kind,
            scope_key  : v0.scope_key,
            asset_key  : v0.asset_key,
        };
        assert!(!0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v1), 8);
        let v2 = advance_registry_commitment_v8(arg0.root_content_commitment, arg0.maker_version, arg4, arg0.rolling_commitment, v0);
        let v3 = v0.seal_id;
        let v4 = v0.scope_kind;
        0x2::table::add<ProtectedAssetKeyV8, ProtectedAssetV8>(&mut arg0.assets, v1, v0);
        0x1::vector::push_back<ProtectedAssetKeyV8>(&mut arg0.keys, v1);
        arg0.observed_count = arg0.observed_count + 1;
        if (v4 == 0) {
            arg0.observed_base_count = arg0.observed_base_count + 1;
        } else if (v4 == 1) {
            arg0.observed_pack_count = arg0.observed_pack_count + 1;
        } else {
            arg0.observed_complete_count = arg0.observed_complete_count + 1;
        };
        arg0.rolling_commitment = v2;
        let v5 = ProtectedAssetAppendedV8{
            registry_id        : 0x2::object::id<SealRegistryV8>(arg0),
            root_id            : arg0.root_id,
            sequence           : arg4,
            scope_kind         : v4,
            seal_id            : v3,
            rolling_commitment : v2,
        };
        0x2::event::emit<ProtectedAssetAppendedV8>(v5);
        v3
    }

    fun approval_registry_valid<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) : bool {
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_lifecycle_v8<T0>(arg2);
        if (v0 != 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_draft_v8()) {
            let v2 = if (v0 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_active_v8()) {
                true
            } else if (v0 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_paused_v8()) {
                true
            } else {
                v0 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_archived_v8()
            };
            if (v2) {
                if (arg0.sealed) {
                    if (registry_binding_matches<T0>(arg0, arg2, arg1)) {
                        if (arg0.observed_count == arg0.expected_count) {
                            arg0.rolling_commitment == arg0.expected_commitment
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
            }
        } else {
            false
        }
    }

    fun assert_catalog_root<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) {
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_id_v8(arg0) == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_catalog_id_v8<T0>(arg1), 15);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg0)) == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg1)), 15);
    }

    fun assert_counts_exact(arg0: &SealRegistryV8) {
        assert!(arg0.observed_base_count == arg0.expected_base_count, 6);
        assert!(arg0.observed_pack_count == arg0.expected_pack_count, 6);
        assert!(arg0.observed_complete_count == arg0.expected_complete_count, 6);
        assert!(arg0.observed_count == arg0.expected_count, 6);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 2);
        let v0 = false;
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 2);
    }

    fun assert_holder_and_proof_fields(arg0: address, arg1: &vector<u8>, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: &vector<u8>) {
        assert!(arg0 != @0x0, 13);
        assert_hash(arg1);
        assert_hash(arg4);
        assert_semantic_key(arg2, 256);
        assert_semantic_key(arg3, 512);
    }

    fun assert_non_empty_bounded(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= arg1, 5);
    }

    fun assert_policy_root<T0>(arg0: &SealPolicyConfigV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 0);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg1);
        let v1 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::seal_binding_v8(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<SealOriginalMarkerV8, SealCallableMarkerV8>(v1);
        assert!(arg0.catalog_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_catalog_id_v8<T0>(arg1), 15);
        assert!(&arg0.product_binding_commitment == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(v0), 1);
        assert!(arg0.seal_original_package_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::original_package_id_v8(v1), 1);
        assert!(arg0.seal_callable_package_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::callable_package_id_v8(v1), 1);
        assert!(&arg0.seal_binding_commitment == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::exact_binding_commitment_v8(v1), 1);
        let v2 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_call_cap_set_v8<T0>(arg1);
        assert!(arg0.seal_authority_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::seal_authority_id_v8(v2), 1);
        assert!(&arg0.call_cap_set_commitment == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::call_cap_set_commitment_v8(v2), 1);
        assert!(arg0.seal_authority_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::call_cap_authority_id_v8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::SealRoleV8>(&arg0.seal_call_cap), 1);
    }

    fun assert_registry_binding<T0>(arg0: &SealRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &SealPolicyConfigV8) {
        assert!(registry_binding_matches<T0>(arg0, arg1, arg2), 1);
    }

    fun assert_role_witness<T0, T1, T2>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ExactPackageBindingV8) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<T1, T2>(arg1);
    }

    fun assert_scope(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 4);
    }

    fun assert_scope_count_available(arg0: &SealRegistryV8, arg1: u8) {
        if (arg1 == 0) {
            assert!(arg0.observed_base_count < arg0.expected_base_count, 6);
        } else if (arg1 == 1) {
            assert!(arg0.observed_pack_count < arg0.expected_pack_count, 6);
        } else {
            assert!(arg0.observed_complete_count < arg0.expected_complete_count, 6);
        };
    }

    fun assert_semantic_key(arg0: &0x1::string::String, arg1: u64) {
        assert_non_empty_bounded(arg0, arg1);
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            assert!(*0x1::vector::borrow<u8>(v0, v1) != 0, 5);
            v1 = v1 + 1;
        };
    }

    fun assert_valid_row(arg0: &ProtectedAssetV8) {
        assert_scope(arg0.scope_kind);
        assert_semantic_key(&arg0.scope_key, 256);
        assert_semantic_key(&arg0.asset_key, 512);
        assert_non_empty_bounded(&arg0.ciphertext_blob_id, 512);
        assert_hash(&arg0.scope_commitment);
        assert_hash(&arg0.asset_content_commitment);
        assert_hash(&arg0.ciphertext_sha256);
        assert_hash(&arg0.ciphertext_blob_commitment);
        assert_hash(&arg0.certification_commitment);
        assert_hash(&arg0.seal_id);
    }

    public fun asset_seal_id_v8(arg0: &SealRegistryV8, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String) : &vector<u8> {
        let v0 = ProtectedAssetKeyV8{
            scope_kind : arg1,
            scope_key  : arg2,
            asset_key  : arg3,
        };
        if (0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)) {
            return &0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0).seal_id
        };
        &0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0).seal_id
    }

    public fun certify_activation_readiness_v8<T0>(arg0: SealReadinessV8, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8) : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8::SealReadinessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_seal_call_cap_v8(arg4, &arg2.seal_call_cap);
        assert_catalog_root<T0>(arg4, arg3);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::activation_v8::certify_seal_readiness_v8<T0, SealOriginalMarkerV8, SealCallableMarkerV8, SealPolicyConfigV8, SealRegistryV8>(arg3, arg4, &arg2.seal_call_cap, arg2, arg1, consume_local_readiness<T0>(arg0, arg1, arg2, arg3))
    }

    public fun certify_base_entitlement_v8<T0, T1, T2>(arg0: T2, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>) : (T2, BaseDecryptProofV8) {
        assert_catalog_root<T0>(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg2)));
        assert_holder_and_proof_fields(arg3, &arg5, &arg6, &arg7, &arg8);
        let v0 = BaseDecryptProofV8{
            root_id                 : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg2),
            maker_version           : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment : *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg2),
            holder                  : arg3,
            entitlement_id          : arg4,
            entitlement_commitment  : arg5,
            scope_key               : arg6,
            asset_key               : arg7,
            seal_id                 : arg8,
        };
        (arg0, v0)
    }

    public fun certify_ciphertext_v8<T0, T1, T2>(arg0: T2, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: &SealPolicyConfigV8, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>) : (T2, CiphertextCertificationV8) {
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_lifecycle_v8<T0>(arg4);
        assert!(v0 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_draft_v8() || v0 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_active_v8(), 14);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_current_protocol_config_v8<T0>(arg4, arg1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_catalog_current_v8(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg4, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::release_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg4)));
        assert_policy_root<T0>(arg3, arg4);
        assert_catalog_root<T0>(arg2, arg4);
        let v1 = arg3.catalog_id;
        let v2 = arg3.product_binding_commitment;
        let v3 = arg3.commitment;
        let v4 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg4);
        let v5 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg4);
        let v6 = CiphertextCertificationV8{
            catalog_id                 : v1,
            product_binding_commitment : v2,
            policy_config_id           : 0x2::object::id<SealPolicyConfigV8>(arg3),
            policy_commitment          : v3,
            root_id                    : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg4),
            maker_version              : v4,
            root_content_commitment    : v5,
            scope_kind                 : arg5,
            scope_key                  : arg6,
            scope_commitment           : arg7,
            asset_key                  : arg8,
            asset_content_commitment   : arg9,
            ciphertext_blob_id         : arg10,
            ciphertext_sha256          : arg11,
            ciphertext_blob_commitment : arg12,
            certification_commitment   : derive_ciphertext_certification_commitment_v8(v1, v2, v3, v5, v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12),
            seal_id                    : derive_seal_id_v8(v2, v3, v5, v4, arg5, arg6, arg8),
        };
        (arg0, v6)
    }

    public fun certify_complete_receipt_v8<T0, T1, T2>(arg0: T2, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: address, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>) : (T2, CompleteDecryptProofV8) {
        assert_catalog_root<T0>(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::release_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg2)));
        assert_holder_and_proof_fields(arg3, &arg9, &arg10, &arg11, &arg12);
        assert_hash(&arg6);
        assert_hash(&arg7);
        assert_hash(&arg8);
        let v0 = CompleteDecryptProofV8{
            root_id                 : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg2),
            maker_version           : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment : *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg2),
            holder                  : arg3,
            receipt_id              : arg4,
            output_id               : arg5,
            recipe_commitment       : arg6,
            render_commitment       : arg7,
            output_commitment       : arg8,
            receipt_commitment      : arg9,
            scope_key               : arg10,
            asset_key               : arg11,
            seal_id                 : arg12,
        };
        (arg0, v0)
    }

    public fun certify_pack_entitlement_v8<T0, T1, T2>(arg0: T2, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>) : (T2, PackDecryptProofV8) {
        assert_catalog_root<T0>(arg1, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg2)));
        assert_holder_and_proof_fields(arg3, &arg5, &arg10, &arg11, &arg12);
        assert_hash(&arg7);
        assert_hash(&arg9);
        let v0 = PackDecryptProofV8{
            root_id                     : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg2),
            maker_version               : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg2),
            root_content_commitment     : *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg2),
            holder                      : arg3,
            base_entitlement_id         : arg4,
            base_entitlement_commitment : arg5,
            pack_entitlement_id         : arg6,
            pack_entitlement_commitment : arg7,
            pack_release_id             : arg8,
            pack_content_commitment     : arg9,
            scope_key                   : arg10,
            asset_key                   : arg11,
            seal_id                     : arg12,
        };
        (arg0, v0)
    }

    fun check_base_access<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: &BaseDecryptProofV8, arg4: address, arg5: &vector<u8>) : bool {
        if (!approval_registry_valid<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (!proof_root_matches<T0>(arg2, arg3.root_id, arg3.maker_version, &arg3.root_content_commitment)) {
            return false
        };
        let v0 = if (arg4 == @0x0) {
            true
        } else if (arg3.holder != arg4) {
            true
        } else {
            &arg3.seal_id != arg5
        };
        if (v0) {
            return false
        };
        if (0x1::vector::length<u8>(&arg3.entitlement_commitment) != 32) {
            return false
        };
        row_matches(arg0, 0, arg3.scope_key, arg3.asset_key, arg5, arg5, 0)
    }

    fun check_complete_access<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: &CompleteDecryptProofV8, arg4: address, arg5: &vector<u8>) : bool {
        if (!approval_registry_valid<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (!proof_root_matches<T0>(arg2, arg3.root_id, arg3.maker_version, &arg3.root_content_commitment)) {
            return false
        };
        let v0 = if (arg4 == @0x0) {
            true
        } else if (arg3.holder != arg4) {
            true
        } else {
            &arg3.seal_id != arg5
        };
        if (v0) {
            return false
        };
        let v1 = if (0x1::vector::length<u8>(&arg3.recipe_commitment) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg3.render_commitment) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg3.output_commitment) != 32) {
            true
        } else {
            0x1::vector::length<u8>(&arg3.receipt_commitment) != 32
        };
        if (v1) {
            return false
        };
        let v2 = complete_instance_commitment_v8(arg3.recipe_commitment, arg3.render_commitment, arg3.output_commitment, arg3.receipt_commitment);
        row_matches(arg0, 2, arg3.scope_key, arg3.asset_key, arg5, &v2, 3)
    }

    fun check_pack_access<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: &PackDecryptProofV8, arg4: address, arg5: &vector<u8>) : bool {
        if (!approval_registry_valid<T0>(arg0, arg1, arg2)) {
            return false
        };
        if (!proof_root_matches<T0>(arg2, arg3.root_id, arg3.maker_version, &arg3.root_content_commitment)) {
            return false
        };
        let v0 = if (arg4 == @0x0) {
            true
        } else if (arg3.holder != arg4) {
            true
        } else {
            &arg3.seal_id != arg5
        };
        if (v0) {
            return false
        };
        let v1 = if (0x1::vector::length<u8>(&arg3.base_entitlement_commitment) != 32) {
            true
        } else if (0x1::vector::length<u8>(&arg3.pack_entitlement_commitment) != 32) {
            true
        } else {
            0x1::vector::length<u8>(&arg3.pack_content_commitment) != 32
        };
        if (v1) {
            return false
        };
        row_matches(arg0, 1, arg3.scope_key, arg3.asset_key, arg5, &arg3.pack_content_commitment, 1)
    }

    fun checked_total(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 6);
        let v1 = v0 + arg2;
        assert!(v1 >= v0, 6);
        v1
    }

    public fun complete_instance_commitment_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        assert_hash(&arg3);
        let v0 = CompleteInstanceCommitmentInputV8{
            domain             : b"animacraft-v8/seal/complete-instance",
            version            : 8,
            recipe_commitment  : arg0,
            render_commitment  : arg1,
            output_commitment  : arg2,
            receipt_commitment : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteInstanceCommitmentInputV8>(&v0))
    }

    fun consume_certification(arg0: CiphertextCertificationV8, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8) : ProtectedAssetV8 {
        let CiphertextCertificationV8 {
            catalog_id                 : v0,
            product_binding_commitment : v1,
            policy_config_id           : v2,
            policy_commitment          : v3,
            root_id                    : v4,
            maker_version              : v5,
            root_content_commitment    : v6,
            scope_kind                 : v7,
            scope_key                  : v8,
            scope_commitment           : v9,
            asset_key                  : v10,
            asset_content_commitment   : v11,
            ciphertext_blob_id         : v12,
            ciphertext_sha256          : v13,
            ciphertext_blob_commitment : v14,
            certification_commitment   : v15,
            seal_id                    : v16,
        } = arg0;
        assert!(v0 == arg1.catalog_id && v0 == arg2.catalog_id, 15);
        assert!(v1 == arg1.product_binding_commitment, 1);
        assert!(v2 == 0x2::object::id<SealPolicyConfigV8>(arg2) && v3 == arg2.commitment, 0);
        assert!(v4 == arg1.root_id && v5 == arg1.maker_version, 1);
        assert!(v6 == arg1.root_content_commitment, 1);
        assert!(v15 == derive_ciphertext_certification_commitment_v8(v0, v1, v3, v6, v5, v7, v8, v9, v10, v11, v12, v13, v14), 2);
        assert!(v16 == derive_seal_id_v8(v1, v3, v6, v5, v7, v8, v10), 2);
        ProtectedAssetV8{
            scope_kind                 : v7,
            scope_key                  : v8,
            scope_commitment           : v9,
            asset_key                  : v10,
            asset_content_commitment   : v11,
            ciphertext_blob_id         : v12,
            ciphertext_sha256          : v13,
            ciphertext_blob_commitment : v14,
            certification_commitment   : v15,
            seal_id                    : v16,
        }
    }

    public fun consume_complete_decrypt_proof_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg4: CompleteDecryptProofV8, arg5: &0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, vector<u8>, vector<u8>, vector<u8>, vector<u8>, 0x1::string::String, 0x1::string::String, vector<u8>) {
        assert!(check_complete_access<T0>(arg1, arg2, arg3, &arg4, 0x2::tx_context::sender(arg5), &arg0), 12);
        let CompleteDecryptProofV8 {
            root_id                 : _,
            maker_version           : _,
            root_content_commitment : _,
            holder                  : _,
            receipt_id              : v4,
            output_id               : v5,
            recipe_commitment       : v6,
            render_commitment       : v7,
            output_commitment       : v8,
            receipt_commitment      : v9,
            scope_key               : v10,
            asset_key               : v11,
            seal_id                 : v12,
        } = arg4;
        assert!(v12 == arg0, 13);
        (v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    fun consume_local_readiness<T0>(arg0: SealReadinessV8, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) : vector<u8> {
        let PrivateSealReadinessWitnessV8 {
            registry_id                  : v0,
            policy_config_id             : v1,
            key_server_ids               : v2,
            key_server_set_commitment    : v3,
            encryption_policy_commitment : v4,
            root_id                      : v5,
            maker_version                : v6,
            root_content_commitment      : v7,
            catalog_id                   : v8,
            product_binding_commitment   : v9,
            seal_authority_id            : v10,
            call_cap_set_commitment      : v11,
            registry_commitment          : v12,
            base_count                   : v13,
            pack_count                   : v14,
            complete_count               : v15,
            total_count                  : v16,
        } = new_private_readiness<T0>(arg1, arg2, arg3);
        let SealReadinessV8 {
            registry_id                  : v17,
            policy_config_id             : v18,
            key_server_ids               : v19,
            key_server_set_commitment    : v20,
            encryption_policy_commitment : v21,
            root_id                      : v22,
            maker_version                : v23,
            root_content_commitment      : v24,
            catalog_id                   : v25,
            product_binding_commitment   : v26,
            seal_authority_id            : v27,
            call_cap_set_commitment      : v28,
            registry_commitment          : v29,
            base_count                   : v30,
            pack_count                   : v31,
            complete_count               : v32,
            total_count                  : v33,
        } = arg0;
        assert!(v17 == v0 && v18 == v1, 13);
        assert!(v19 == v2, 13);
        assert!(v20 == v3, 13);
        assert!(v21 == v4, 13);
        assert!(v22 == v5 && v23 == v6, 13);
        assert!(v24 == v7, 13);
        assert!(v25 == v8, 13);
        assert!(v26 == v9, 13);
        assert!(v27 == v10, 13);
        assert!(v28 == v11, 13);
        assert!(v29 == v12, 13);
        assert!(v30 == v13 && v31 == v14, 13);
        assert!(v32 == v15 && v33 == v16, 13);
        local_readiness_commitment(&arg0)
    }

    public fun derive_ciphertext_certification_commitment_v8(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: 0x1::string::String, arg11: vector<u8>, arg12: vector<u8>) : vector<u8> {
        assert_scope(arg5);
        assert_semantic_key(&arg6, 256);
        assert_semantic_key(&arg8, 512);
        assert_non_empty_bounded(&arg10, 512);
        assert_hash(&arg1);
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_hash(&arg7);
        assert_hash(&arg9);
        assert_hash(&arg11);
        assert_hash(&arg12);
        assert!(arg4 > 0, 1);
        let v0 = CiphertextCommitmentInputV8{
            domain                     : b"animacraft-v8/seal/ciphertext-certification",
            version                    : 8,
            catalog_id                 : arg0,
            product_binding_commitment : arg1,
            policy_commitment          : arg2,
            root_content_commitment    : arg3,
            maker_version              : arg4,
            scope_kind                 : arg5,
            scope_key                  : arg6,
            scope_commitment           : arg7,
            asset_key                  : arg8,
            asset_content_commitment   : arg9,
            ciphertext_blob_id         : arg10,
            ciphertext_sha256          : arg11,
            ciphertext_blob_commitment : arg12,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CiphertextCommitmentInputV8>(&v0))
    }

    fun derive_policy_commitment(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: 0x2::object::ID, arg8: vector<u8>, arg9: vector<KeyServerBindingV8>, arg10: u16, arg11: vector<u8>, arg12: vector<u8>) : vector<u8> {
        let v0 = SealPolicyCommitmentInputV8{
            domain                       : b"animacraft-v8/seal/policy",
            version                      : 8,
            protocol_config_id           : arg0,
            protocol_config_revision     : arg1,
            catalog_id                   : arg2,
            product_binding_commitment   : arg3,
            seal_original_package_id     : arg4,
            seal_callable_package_id     : arg5,
            seal_binding_commitment      : arg6,
            seal_authority_id            : arg7,
            call_cap_set_commitment      : arg8,
            key_servers                  : arg9,
            threshold                    : arg10,
            key_server_set_commitment    : arg11,
            encryption_policy_commitment : arg12,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealPolicyCommitmentInputV8>(&v0))
    }

    public fun derive_seal_id_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String) : vector<u8> {
        assert_scope(arg4);
        assert_semantic_key(&arg5, 256);
        assert_semantic_key(&arg6, 512);
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        let v0 = SealIdInputV8{
            domain                     : b"animacraft-v8/seal/ciphertext-id",
            version                    : 8,
            product_binding_commitment : arg0,
            policy_commitment          : arg1,
            root_content_commitment    : arg2,
            maker_version              : arg3,
            scope_kind                 : arg4,
            scope_key                  : arg5,
            asset_key                  : arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealIdInputV8>(&v0))
    }

    public fun empty_registry_commitment_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        assert!(arg3 > 0, 1);
        let v0 = EmptyRegistryCommitmentInputV8{
            domain                     : b"animacraft-v8/seal/registry-empty",
            version                    : 8,
            product_binding_commitment : arg0,
            policy_commitment          : arg1,
            root_content_commitment    : arg2,
            maker_version              : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<EmptyRegistryCommitmentInputV8>(&v0))
    }

    public fun empty_runtime_commitment_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg1);
        assert_hash(&arg2);
        let v0 = EmptyRegistryCommitmentInputV8{
            domain                     : b"animacraft-v8/seal/runtime-empty",
            version                    : 8,
            product_binding_commitment : arg0,
            policy_commitment          : arg1,
            root_content_commitment    : arg2,
            maker_version              : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<EmptyRegistryCommitmentInputV8>(&v0))
    }

    public fun issue_seal_readiness_v8<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) : SealReadinessV8 {
        let PrivateSealReadinessWitnessV8 {
            registry_id                  : v0,
            policy_config_id             : v1,
            key_server_ids               : v2,
            key_server_set_commitment    : v3,
            encryption_policy_commitment : v4,
            root_id                      : v5,
            maker_version                : v6,
            root_content_commitment      : v7,
            catalog_id                   : v8,
            product_binding_commitment   : v9,
            seal_authority_id            : v10,
            call_cap_set_commitment      : v11,
            registry_commitment          : v12,
            base_count                   : v13,
            pack_count                   : v14,
            complete_count               : v15,
            total_count                  : v16,
        } = new_private_readiness<T0>(arg0, arg1, arg2);
        SealReadinessV8{
            registry_id                  : v0,
            policy_config_id             : v1,
            key_server_ids               : v2,
            key_server_set_commitment    : v3,
            encryption_policy_commitment : v4,
            root_id                      : v5,
            maker_version                : v6,
            root_content_commitment      : v7,
            catalog_id                   : v8,
            product_binding_commitment   : v9,
            seal_authority_id            : v10,
            call_cap_set_commitment      : v11,
            registry_commitment          : v12,
            base_count                   : v13,
            pack_count                   : v14,
            complete_count               : v15,
            total_count                  : v16,
        }
    }

    fun key_server_ids(arg0: &SealPolicyConfigV8) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<KeyServerBindingV8>(&arg0.key_servers)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x1::vector::borrow<KeyServerBindingV8>(&arg0.key_servers, v1).key_server_id);
            v1 = v1 + 1;
        };
        v0
    }

    fun lexicographically_less(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg0) == 0x1::vector::length<u8>(arg1), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v0) > *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        false
    }

    fun local_readiness_commitment(arg0: &SealReadinessV8) : vector<u8> {
        let v0 = b"animacraft-v8/seal/activation-readiness";
        let v1 = 8;
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<SealReadinessV8>(arg0));
        0x1::hash::sha2_256(v0)
    }

    fun new_private_readiness<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) : PrivateSealReadinessWitnessV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_v8<T0>(arg2);
        assert_registry_binding<T0>(arg0, arg2, arg1);
        assert!(arg0.sealed, 10);
        assert_counts_exact(arg0);
        assert!(arg0.rolling_commitment == arg0.expected_commitment, 2);
        PrivateSealReadinessWitnessV8{
            registry_id                  : 0x2::object::id<SealRegistryV8>(arg0),
            policy_config_id             : 0x2::object::id<SealPolicyConfigV8>(arg1),
            key_server_ids               : key_server_ids(arg1),
            key_server_set_commitment    : arg1.key_server_set_commitment,
            encryption_policy_commitment : arg1.encryption_policy_commitment,
            root_id                      : arg0.root_id,
            maker_version                : arg0.maker_version,
            root_content_commitment      : arg0.root_content_commitment,
            catalog_id                   : arg0.catalog_id,
            product_binding_commitment   : arg0.product_binding_commitment,
            seal_authority_id            : arg1.seal_authority_id,
            call_cap_set_commitment      : arg1.call_cap_set_commitment,
            registry_commitment          : arg0.rolling_commitment,
            base_count                   : arg0.observed_base_count,
            pack_count                   : arg0.observed_pack_count,
            complete_count               : arg0.observed_complete_count,
            total_count                  : arg0.observed_count,
        }
    }

    public fun new_seal_policy_config_v8(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolConfigV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::ProtocolAdminCapV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg3: 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::PackageCallCapV8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::SealRoleV8>, arg4: vector<0x2::object::ID>, arg5: vector<u16>, arg6: u16, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : SealPolicyConfigV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::assert_protocol_admin_v8(arg0, arg1);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_catalog_current_v8(arg0, arg2);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_seal_call_cap_v8(arg2, &arg3);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_binding_v8(arg2);
        let v1 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::seal_binding_v8(v0);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::assert_type_origins_v8<SealOriginalMarkerV8, SealCallableMarkerV8>(v1);
        let v2 = validate_key_servers(arg4, arg5, arg6);
        assert_hash(&arg7);
        assert_hash(&arg8);
        let v3 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::config_id_v8(arg0);
        let v4 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::protocol_config_v8::config_revision_v8(arg0);
        let v5 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_id_v8(arg2);
        let v6 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::product_binding_commitment_v8(v0);
        let v7 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::original_package_id_v8(v1);
        let v8 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::callable_package_id_v8(v1);
        let v9 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::exact_binding_commitment_v8(v1);
        let v10 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::call_cap_authority_id_v8<0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::SealRoleV8>(&arg3);
        let v11 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::call_cap_set_commitment_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::catalog_call_cap_set_v8(arg2));
        let v12 = derive_policy_commitment(v3, v4, v5, v6, v7, v8, v9, v10, v11, v2, arg6, arg7, arg8);
        let v13 = SealPolicyConfigV8{
            id                           : 0x2::object::new(arg9),
            version                      : 8,
            protocol_config_id           : v3,
            protocol_config_revision     : v4,
            catalog_id                   : v5,
            product_binding_commitment   : v6,
            seal_original_package_id     : v7,
            seal_callable_package_id     : v8,
            seal_binding_commitment      : v9,
            seal_authority_id            : v10,
            call_cap_set_commitment      : v11,
            seal_call_cap                : arg3,
            key_servers                  : v2,
            threshold                    : arg6,
            key_server_set_commitment    : arg7,
            encryption_policy_commitment : arg8,
            commitment                   : v12,
        };
        let v14 = SealPolicyCreatedV8{
            config_id                 : 0x2::object::id<SealPolicyConfigV8>(&v13),
            catalog_id                : v5,
            threshold                 : arg6,
            key_server_set_commitment : arg7,
            commitment                : v12,
        };
        0x2::event::emit<SealPolicyCreatedV8>(v14);
        v13
    }

    public fun new_seal_registry_v8<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: &SealPolicyConfigV8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : SealRegistryV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_policy_root<T0>(arg2, arg0);
        let v0 = checked_total(arg3, arg4, arg5);
        assert!(v0 <= 100000, 6);
        assert_hash(&arg6);
        let v1 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v2 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg0);
        let v3 = empty_registry_commitment_v8(arg2.product_binding_commitment, arg2.commitment, v1, v2);
        if (v0 == 0) {
            assert!(arg6 == v3, 2);
        };
        SealRegistryV8{
            id                         : 0x2::object::new(arg7),
            version                    : 8,
            root_id                    : 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : v2,
            root_content_commitment    : v1,
            catalog_id                 : arg2.catalog_id,
            product_binding_commitment : arg2.product_binding_commitment,
            policy_config_id           : 0x2::object::id<SealPolicyConfigV8>(arg2),
            policy_commitment          : arg2.commitment,
            expected_base_count        : arg3,
            expected_pack_count        : arg4,
            expected_complete_count    : arg5,
            expected_count             : v0,
            observed_base_count        : 0,
            observed_pack_count        : 0,
            observed_complete_count    : 0,
            observed_count             : 0,
            expected_commitment        : arg6,
            rolling_commitment         : v3,
            sealed                     : false,
            keys                       : 0x1::vector::empty<ProtectedAssetKeyV8>(),
            assets                     : 0x2::table::new<ProtectedAssetKeyV8, ProtectedAssetV8>(arg7),
            runtime_revision           : 0,
            runtime_commitment         : empty_runtime_commitment_v8(arg2.product_binding_commitment, arg2.commitment, v1, v2),
            runtime_keys               : 0x1::vector::empty<ProtectedAssetKeyV8>(),
            runtime_assets             : 0x2::table::new<ProtectedAssetKeyV8, ProtectedAssetV8>(arg7),
        }
    }

    public fun policy_call_cap_set_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.call_cap_set_commitment
    }

    public fun policy_catalog_id_v8(arg0: &SealPolicyConfigV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun policy_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.commitment
    }

    public fun policy_encryption_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.encryption_policy_commitment
    }

    public fun policy_id_v8(arg0: &SealPolicyConfigV8) : 0x2::object::ID {
        0x2::object::id<SealPolicyConfigV8>(arg0)
    }

    public fun policy_key_server_count_v8(arg0: &SealPolicyConfigV8) : u64 {
        0x1::vector::length<KeyServerBindingV8>(&arg0.key_servers)
    }

    public fun policy_key_server_id_v8(arg0: &SealPolicyConfigV8, arg1: u64) : 0x2::object::ID {
        0x1::vector::borrow<KeyServerBindingV8>(&arg0.key_servers, arg1).key_server_id
    }

    public fun policy_key_server_set_commitment_v8(arg0: &SealPolicyConfigV8) : &vector<u8> {
        &arg0.key_server_set_commitment
    }

    public fun policy_key_server_weight_v8(arg0: &SealPolicyConfigV8, arg1: u64) : u16 {
        0x1::vector::borrow<KeyServerBindingV8>(&arg0.key_servers, arg1).weight
    }

    public fun policy_seal_authority_id_v8(arg0: &SealPolicyConfigV8) : 0x2::object::ID {
        arg0.seal_authority_id
    }

    public fun policy_threshold_v8(arg0: &SealPolicyConfigV8) : u16 {
        arg0.threshold
    }

    fun proof_root_matches<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &vector<u8>) : bool {
        if (arg1 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg0)) {
            if (arg2 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg0)) {
                arg3 == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun protected_asset_snapshot_v8<T0>(arg0: &SealRegistryV8, arg1: &SealPolicyConfigV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: u8, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>) : ProtectedAssetSnapshotV8 {
        assert_registry_binding<T0>(arg0, arg2, arg1);
        assert!(arg0.sealed, 10);
        let v0 = ProtectedAssetKeyV8{
            scope_kind : arg3,
            scope_key  : arg4,
            asset_key  : arg6,
        };
        let v1 = if (0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)) {
            0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)
        } else {
            assert!(0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0), 11);
            0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0)
        };
        assert!(v1.scope_commitment == arg5, 2);
        assert!(v1.asset_content_commitment == arg7, 2);
        assert!(v1.ciphertext_blob_id == arg8, 2);
        assert!(v1.ciphertext_sha256 == arg9, 2);
        assert!(v1.ciphertext_blob_commitment == arg10, 2);
        assert!(v1.certification_commitment == arg11, 2);
        assert!(v1.seal_id == arg12, 2);
        assert!(arg12 == derive_seal_id_v8(arg0.product_binding_commitment, arg0.policy_commitment, arg0.root_content_commitment, arg0.maker_version, v1.scope_kind, v1.scope_key, v1.asset_key), 2);
        ProtectedAssetSnapshotV8{
            registry_id                : 0x2::object::id<SealRegistryV8>(arg0),
            registry_commitment        : arg0.rolling_commitment,
            runtime_revision           : arg0.runtime_revision,
            runtime_commitment         : arg0.runtime_commitment,
            policy_config_id           : 0x2::object::id<SealPolicyConfigV8>(arg1),
            policy_commitment          : arg1.commitment,
            root_id                    : arg0.root_id,
            maker_version              : arg0.maker_version,
            root_content_commitment    : arg0.root_content_commitment,
            scope_kind                 : v1.scope_kind,
            scope_key                  : v1.scope_key,
            scope_commitment           : v1.scope_commitment,
            asset_key                  : v1.asset_key,
            asset_content_commitment   : v1.asset_content_commitment,
            ciphertext_blob_id         : v1.ciphertext_blob_id,
            ciphertext_sha256          : v1.ciphertext_sha256,
            ciphertext_blob_commitment : v1.ciphertext_blob_commitment,
            certification_commitment   : v1.certification_commitment,
            seal_id                    : v1.seal_id,
        }
    }

    fun protected_row_matches(arg0: &ProtectedAssetV8, arg1: &SealRegistryV8, arg2: &vector<u8>, arg3: &vector<u8>, arg4: u8) : bool {
        if (&arg0.seal_id != arg2) {
            return false
        };
        if (arg4 == 1 && &arg0.scope_commitment != arg3) {
            return false
        };
        if (arg4 == 2 && &arg0.asset_content_commitment != arg3) {
            return false
        };
        if (arg4 == 3 && &arg0.scope_commitment != arg3) {
            return false
        };
        arg0.seal_id == derive_seal_id_v8(arg1.product_binding_commitment, arg1.policy_commitment, arg1.root_content_commitment, arg1.maker_version, arg0.scope_kind, arg0.scope_key, arg0.asset_key)
    }

    public fun register_complete_ciphertext_v8<T0, T1, T2>(arg0: T2, arg1: &mut SealRegistryV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: &SealPolicyConfigV8, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg5: u64, arg6: CiphertextCertificationV8) : (T2, vector<u8>) {
        assert_catalog_root<T0>(arg4, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::release_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg2)));
        (arg0, register_runtime_asset<T0>(arg1, arg2, arg3, arg5, arg6, 2))
    }

    public fun register_pack_ciphertext_v8<T0, T1, T2>(arg0: T2, arg1: &mut SealRegistryV8, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg3: &SealPolicyConfigV8, arg4: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::ProductReleaseCatalogV8, arg5: u64, arg6: CiphertextCertificationV8) : (T2, vector<u8>) {
        assert_catalog_root<T0>(arg4, arg2);
        assert_role_witness<T0, T1, T2>(arg2, 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::package_binding_v8::runtime_binding_v8(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_product_release_binding_v8<T0>(arg2)));
        (arg0, register_runtime_asset<T0>(arg1, arg2, arg3, arg5, arg6, 1))
    }

    fun register_runtime_asset<T0>(arg0: &mut SealRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &SealPolicyConfigV8, arg3: u64, arg4: CiphertextCertificationV8, arg5: u8) : vector<u8> {
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_lifecycle_v8<T0>(arg1) == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::lifecycle_active_v8(), 14);
        assert_registry_binding<T0>(arg0, arg1, arg2);
        assert!(arg0.sealed, 10);
        assert!(arg0.runtime_revision == arg3, 7);
        let v0 = consume_certification(arg4, arg0, arg2);
        assert!(v0.scope_kind == arg5, 4);
        let v1 = ProtectedAssetKeyV8{
            scope_kind : v0.scope_kind,
            scope_key  : v0.scope_key,
            asset_key  : v0.asset_key,
        };
        assert!(!0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v1) && !0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v1), 8);
        let v2 = advance_registry_commitment_v8(arg0.root_content_commitment, arg0.maker_version, arg3, arg0.runtime_commitment, v0);
        let v3 = v0.seal_id;
        0x2::table::add<ProtectedAssetKeyV8, ProtectedAssetV8>(&mut arg0.runtime_assets, v1, v0);
        0x1::vector::push_back<ProtectedAssetKeyV8>(&mut arg0.runtime_keys, v1);
        arg0.runtime_revision = arg3 + 1;
        arg0.runtime_commitment = v2;
        let v4 = RuntimeProtectedAssetRegisteredV8{
            registry_id        : 0x2::object::id<SealRegistryV8>(arg0),
            root_id            : arg0.root_id,
            previous_revision  : arg3,
            new_revision       : arg3 + 1,
            scope_kind         : v0.scope_kind,
            seal_id            : v3,
            runtime_commitment : v2,
        };
        0x2::event::emit<RuntimeProtectedAssetRegisteredV8>(v4);
        v3
    }

    fun registry_binding_matches<T0>(arg0: &SealRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &SealPolicyConfigV8) : bool {
        if (arg0.version == 8) {
            if (arg0.root_id == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg1)) {
                if (arg0.maker_version == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg1)) {
                    if (&arg0.root_content_commitment == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg1)) {
                        if (arg0.catalog_id == arg2.catalog_id) {
                            if (arg0.product_binding_commitment == arg2.product_binding_commitment) {
                                if (arg0.policy_config_id == 0x2::object::id<SealPolicyConfigV8>(arg2)) {
                                    arg0.policy_commitment == arg2.commitment
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
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun registry_commitment_v8(arg0: &SealRegistryV8) : &vector<u8> {
        &arg0.rolling_commitment
    }

    public fun registry_expected_commitment_v8(arg0: &SealRegistryV8) : &vector<u8> {
        &arg0.expected_commitment
    }

    public fun registry_expected_count_v8(arg0: &SealRegistryV8) : u64 {
        arg0.expected_count
    }

    public fun registry_id_v8(arg0: &SealRegistryV8) : 0x2::object::ID {
        0x2::object::id<SealRegistryV8>(arg0)
    }

    public fun registry_observed_count_v8(arg0: &SealRegistryV8) : u64 {
        arg0.observed_count
    }

    public fun registry_policy_config_id_v8(arg0: &SealRegistryV8) : 0x2::object::ID {
        arg0.policy_config_id
    }

    public fun registry_root_id_v8(arg0: &SealRegistryV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_runtime_commitment_v8(arg0: &SealRegistryV8) : &vector<u8> {
        &arg0.runtime_commitment
    }

    public fun registry_runtime_revision_v8(arg0: &SealRegistryV8) : u64 {
        arg0.runtime_revision
    }

    public fun registry_sealed_v8(arg0: &SealRegistryV8) : bool {
        arg0.sealed
    }

    fun row_matches(arg0: &SealRegistryV8, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &vector<u8>, arg5: &vector<u8>, arg6: u8) : bool {
        let v0 = ProtectedAssetKeyV8{
            scope_kind : arg1,
            scope_key  : arg2,
            asset_key  : arg3,
        };
        if (0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0)) {
            return protected_row_matches(0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.assets, v0), arg0, arg4, arg5, arg6)
        };
        if (!0x2::table::contains<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0)) {
            return false
        };
        protected_row_matches(0x2::table::borrow<ProtectedAssetKeyV8, ProtectedAssetV8>(&arg0.runtime_assets, v0), arg0, arg4, arg5, arg6)
    }

    public fun scope_base_v8() : u8 {
        0
    }

    public fun scope_complete_v8() : u8 {
        2
    }

    public fun scope_pack_v8() : u8 {
        1
    }

    entry fun seal_approve_base_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg4: BaseDecryptProofV8, arg5: &0x2::tx_context::TxContext) {
        assert!(check_base_access<T0>(arg1, arg2, arg3, &arg4, 0x2::tx_context::sender(arg5), &arg0), 12);
        let BaseDecryptProofV8 {
            root_id                 : _,
            maker_version           : _,
            root_content_commitment : _,
            holder                  : _,
            entitlement_id          : _,
            entitlement_commitment  : _,
            scope_key               : _,
            asset_key               : _,
            seal_id                 : _,
        } = arg4;
    }

    entry fun seal_approve_complete_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg4: CompleteDecryptProofV8, arg5: &0x2::tx_context::TxContext) {
        let (_, _, _, _, _, _, _, _, _) = consume_complete_decrypt_proof_v8<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    entry fun seal_approve_pack_v8<T0>(arg0: vector<u8>, arg1: &SealRegistryV8, arg2: &SealPolicyConfigV8, arg3: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg4: PackDecryptProofV8, arg5: &0x2::tx_context::TxContext) {
        assert!(check_pack_access<T0>(arg1, arg2, arg3, &arg4, 0x2::tx_context::sender(arg5), &arg0), 12);
        let PackDecryptProofV8 {
            root_id                     : _,
            maker_version               : _,
            root_content_commitment     : _,
            holder                      : _,
            base_entitlement_id         : _,
            base_entitlement_commitment : _,
            pack_entitlement_id         : _,
            pack_entitlement_commitment : _,
            pack_release_id             : _,
            pack_content_commitment     : _,
            scope_key                   : _,
            asset_key                   : _,
            seal_id                     : _,
        } = arg4;
    }

    public fun seal_registry_v8<T0>(arg0: &mut SealRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: &SealPolicyConfigV8) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_binding<T0>(arg0, arg1, arg3);
        assert!(!arg0.sealed, 9);
        assert_counts_exact(arg0);
        assert!(arg0.rolling_commitment == arg0.expected_commitment, 2);
        arg0.sealed = true;
        let v0 = SealRegistrySealedV8{
            registry_id : 0x2::object::id<SealRegistryV8>(arg0),
            root_id     : arg0.root_id,
            total_count : arg0.observed_count,
            commitment  : arg0.rolling_commitment,
        };
        0x2::event::emit<SealRegistrySealedV8>(v0);
    }

    public fun share_seal_policy_config_v8(arg0: SealPolicyConfigV8) {
        0x2::transfer::share_object<SealPolicyConfigV8>(arg0);
    }

    public fun share_seal_registry_v8(arg0: SealRegistryV8) {
        0x2::transfer::share_object<SealRegistryV8>(arg0);
    }

    public fun snapshot_asset_content_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.asset_content_commitment
    }

    public fun snapshot_asset_key_v8(arg0: &ProtectedAssetSnapshotV8) : &0x1::string::String {
        &arg0.asset_key
    }

    public fun snapshot_certification_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.certification_commitment
    }

    public fun snapshot_ciphertext_blob_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.ciphertext_blob_commitment
    }

    public fun snapshot_ciphertext_blob_id_v8(arg0: &ProtectedAssetSnapshotV8) : &0x1::string::String {
        &arg0.ciphertext_blob_id
    }

    public fun snapshot_ciphertext_sha256_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.ciphertext_sha256
    }

    public fun snapshot_maker_version_v8(arg0: &ProtectedAssetSnapshotV8) : u64 {
        arg0.maker_version
    }

    public fun snapshot_policy_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.policy_commitment
    }

    public fun snapshot_policy_config_id_v8(arg0: &ProtectedAssetSnapshotV8) : 0x2::object::ID {
        arg0.policy_config_id
    }

    public fun snapshot_registry_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.registry_commitment
    }

    public fun snapshot_registry_id_v8(arg0: &ProtectedAssetSnapshotV8) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun snapshot_root_content_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun snapshot_root_id_v8(arg0: &ProtectedAssetSnapshotV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun snapshot_runtime_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.runtime_commitment
    }

    public fun snapshot_runtime_revision_v8(arg0: &ProtectedAssetSnapshotV8) : u64 {
        arg0.runtime_revision
    }

    public fun snapshot_scope_commitment_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.scope_commitment
    }

    public fun snapshot_scope_key_v8(arg0: &ProtectedAssetSnapshotV8) : &0x1::string::String {
        &arg0.scope_key
    }

    public fun snapshot_scope_kind_v8(arg0: &ProtectedAssetSnapshotV8) : u8 {
        arg0.scope_kind
    }

    public fun snapshot_seal_id_v8(arg0: &ProtectedAssetSnapshotV8) : &vector<u8> {
        &arg0.seal_id
    }

    fun validate_key_servers(arg0: vector<0x2::object::ID>, arg1: vector<u16>, arg2: u16) : vector<KeyServerBindingV8> {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0);
        let v1 = if (v0 > 0) {
            if (v0 <= 64) {
                v0 == 0x1::vector::length<u16>(&arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = 0x1::vector::empty<KeyServerBindingV8>();
        let v3 = 0;
        let v4 = 0;
        let v5 = b"";
        while (v4 < v0) {
            let v6 = *0x1::vector::borrow<0x2::object::ID>(&arg0, v4);
            let v7 = *0x1::vector::borrow<u16>(&arg1, v4);
            v5 = 0x2::object::id_to_bytes(&v6);
            assert!(0x2::object::id_to_address(&v6) != @0x0 && v7 > 0, 3);
            if (v4 > 0) {
                assert!(lexicographically_less(&v5, &v5), 3);
            };
            v3 = v3 + (v7 as u64);
            let v8 = KeyServerBindingV8{
                key_server_id : v6,
                weight        : v7,
            };
            0x1::vector::push_back<KeyServerBindingV8>(&mut v2, v8);
            v4 = v4 + 1;
        };
        assert!(arg2 > 0 && (arg2 as u64) <= v3, 3);
        v2
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

