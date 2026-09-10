module 0xa07de1e7e9b2e4b089e78cd6eeefccc47c5a3257c88109520cfafadc7b171ed::physical_v8 {
    struct MakerCompanionBindingWitnessV2 has drop {
        dummy_field: bool,
    }

    struct PhysicalOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct PhysicalCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct PhysicalSetupInstallWitnessV2 has drop {
        dummy_field: bool,
    }

    struct PhysicalRuntimeWitnessV2 has drop {
        dummy_field: bool,
    }

    struct PhysicalPackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        installation_commitment: vector<u8>,
    }

    struct PhysicalPolicyKeyV8 has copy, drop, store {
        source_kind: u8,
        source_id: 0x2::object::ID,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
    }

    struct PhysicalSourceBindingV8 has copy, drop, store {
        source_kind: u8,
        source_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        source_content_commitment: vector<u8>,
        source_treasury_id: 0x1::option::Option<0x2::object::ID>,
        pack_registry_id: 0x1::option::Option<0x2::object::ID>,
        pack_registry_revision: u64,
        registered_pack_owner: 0x1::option::Option<address>,
        registered_pack_control_epoch: u64,
        registered_pack_admin_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PhysicalStyleDescriptorV8 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        style_asset_blob_id: 0x1::string::String,
        style_asset_sha256: vector<u8>,
        style_protected: bool,
    }

    struct PhysicalStylePolicyV8 has copy, drop, store {
        sequence: u64,
        source: PhysicalSourceBindingV8,
        style: PhysicalStyleDescriptorV8,
        style_payload_commitment: vector<u8>,
        style_seal_binding_commitment: vector<u8>,
        source_style_commitment: vector<u8>,
        style_identity_commitment: vector<u8>,
        material_policy_commitment: vector<u8>,
        issuance_kind: u8,
        proof_kind: u8,
        price_atomic: u64,
        max_supply: u64,
        transferable: bool,
        issued_count: u64,
        consumed_count: u64,
        row_commitment: vector<u8>,
    }

    struct PhysicalProofProvenanceV8 has copy, drop, store {
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        output_key: 0x1::string::String,
        output_policy_commitment: vector<u8>,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        soul_ownership_epoch: u64,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        soul_commitment: vector<u8>,
        materialization_key: 0x1::string::String,
        witness_commitment: vector<u8>,
    }

    struct PhysicalAssetV8 has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        source: PhysicalSourceBindingV8,
        style: PhysicalStyleDescriptorV8,
        style_seal_binding_commitment: vector<u8>,
        source_style_commitment: vector<u8>,
        style_identity_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
        material_policy_commitment: vector<u8>,
        policy_row_commitment: vector<u8>,
        issuance_kind: u8,
        proof_kind: u8,
        serial: u64,
        holder: address,
        ownership_epoch: u64,
        transferable: bool,
        authorization_key: vector<u8>,
        proof: 0x1::option::Option<PhysicalProofProvenanceV8>,
        provenance_commitment: vector<u8>,
    }

    struct PhysicalMarketCustodyBindingV8 has copy, drop, store {
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        market_authority_id: 0x2::object::ID,
        market_registry_id: 0x2::object::ID,
        market_treasury_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        physical_package_config_id: 0x2::object::ID,
        physical_registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        asset_id: 0x2::object::ID,
        asset_content_commitment: vector<u8>,
        source_kind: u8,
        source_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        source_content_commitment: vector<u8>,
        source_treasury_id: 0x2::object::ID,
        holder: address,
        ownership_epoch: u64,
        transferable: bool,
        provenance_commitment: vector<u8>,
    }

    struct PhysicalMarketCustodyTicketV8 {
        binding: PhysicalMarketCustodyBindingV8,
    }

    struct PhysicalSelectionEvidenceV8 has copy, drop {
        loadout_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_index: u64,
        selection_commitment: vector<u8>,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        source_class: u8,
        source_definition_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        source_content_commitment: vector<u8>,
        source_epoch: u64,
        pricing_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
    }

    struct PhysicalPackAccessBindingV8 has copy, drop {
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
        pack_registry_id: 0x2::object::ID,
        pack_registry_revision: u64,
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pack_treasury_id: 0x2::object::ID,
        pack_pass_id: 0x2::object::ID,
        pack_pass_commitment: vector<u8>,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_index: u64,
        selection_commitment: vector<u8>,
        pricing_commitment: vector<u8>,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        asset_content_commitment: vector<u8>,
        style_identity_commitment: vector<u8>,
    }

    struct PhysicalRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
        expected_base_policy_count: u64,
        observed_base_policy_count: u64,
        expected_base_policy_commitment: vector<u8>,
        rolling_base_policy_commitment: vector<u8>,
        base_sealed: bool,
        base_policy_keys: vector<PhysicalPolicyKeyV8>,
        base_policies: 0x2::table::Table<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>,
        revision: u64,
        pack_policy_count: u64,
        pack_policy_keys: vector<PhysicalPolicyKeyV8>,
        pack_policies: 0x2::table::Table<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>,
        total_issued: u64,
        total_free_claimed: u64,
        total_paid_purchased: u64,
        total_proof_materialized: u64,
        total_consumed: u64,
        gross_paid_atomic: u128,
        protocol_paid_atomic: u128,
        maker_paid_atomic: u128,
        pack_paid_atomic: u128,
        used_authorization_count: u64,
        used_authorizations: 0x2::table::Table<vector<u8>, bool>,
    }

    struct BaseStyleIdentityInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        protected: bool,
        payload_commitment: vector<u8>,
    }

    struct EmptyBasePolicyCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        product_binding_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
    }

    struct BasePolicyRowCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        product_binding_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
        sequence: u64,
        style_identity_commitment: vector<u8>,
        material_policy_commitment: vector<u8>,
        issuance_kind: u8,
        proof_kind: u8,
        price_atomic: u64,
        max_supply: u64,
        transferable: bool,
    }

    struct BasePolicyAdvanceCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        sequence: u64,
        prior_commitment: vector<u8>,
        row_commitment: vector<u8>,
    }

    struct PhysicalReadinessCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        catalog_id: 0x2::object::ID,
        package_config_id: 0x2::object::ID,
        call_cap_set_commitment: vector<u8>,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        base_registry_id: 0x2::object::ID,
        physical_registry_id: 0x2::object::ID,
        expected_base_policy_count: u64,
        observed_base_policy_count: u64,
        base_policy_commitment: vector<u8>,
        revision: u64,
        pack_policy_count: u64,
        total_issued: u64,
        total_consumed: u64,
        gross_paid_atomic: u128,
        protocol_paid_atomic: u128,
        maker_paid_atomic: u128,
        pack_paid_atomic: u128,
        used_authorization_count: u64,
    }

    struct PackPolicyRowCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        product_binding_commitment: vector<u8>,
        physical_registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        registry_revision: u64,
        pack_registry_id: 0x2::object::ID,
        pack_registry_revision: u64,
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pack_owner: address,
        pack_control_epoch: u64,
        pack_admin_cap_id: 0x2::object::ID,
        pack_treasury_id: 0x2::object::ID,
        style_index: u64,
        style_identity_commitment: vector<u8>,
        material_policy_commitment: vector<u8>,
        issuance_kind: u8,
        proof_kind: u8,
        price_atomic: u64,
        max_supply: u64,
        transferable: bool,
    }

    struct PhysicalAuthorizationKeyInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        source_kind: u8,
        source_id: 0x2::object::ID,
        policy_row_commitment: vector<u8>,
        holder: address,
        subject_id: 0x2::object::ID,
        subject_commitment: vector<u8>,
    }

    struct PhysicalAssetCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        source: PhysicalSourceBindingV8,
        style: PhysicalStyleDescriptorV8,
        style_seal_binding_commitment: vector<u8>,
        source_style_commitment: vector<u8>,
        style_identity_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
        material_policy_commitment: vector<u8>,
        policy_row_commitment: vector<u8>,
        issuance_kind: u8,
        proof_kind: u8,
        serial: u64,
        original_holder: address,
        transferable: bool,
        authorization_key: vector<u8>,
        proof: 0x1::option::Option<PhysicalProofProvenanceV8>,
    }

    struct PhysicalRegistrySealedV8 has copy, drop {
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        base_policy_count: u64,
        base_policy_commitment: vector<u8>,
    }

    struct PackPhysicalPolicyRegisteredV8 has copy, drop {
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        registry_revision: u64,
        pack_registry_id: 0x2::object::ID,
        pack_registry_revision: u64,
        release_id: 0x2::object::ID,
        pack_treasury_id: 0x2::object::ID,
        style_identity_commitment: vector<u8>,
        row_commitment: vector<u8>,
    }

    struct PhysicalAssetIssuedV8 has copy, drop {
        asset_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        source_kind: u8,
        source_id: 0x2::object::ID,
        serial: u64,
        holder: address,
        issuance_kind: u8,
        authorization_key: vector<u8>,
        provenance_commitment: vector<u8>,
    }

    struct PhysicalAssetTransferredV8 has copy, drop {
        asset_id: 0x2::object::ID,
        previous_holder: address,
        holder: address,
        ownership_epoch: u64,
    }

    struct PhysicalAssetConsumedV8 has copy, drop {
        asset_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        source_kind: u8,
        source_id: 0x2::object::ID,
        serial: u64,
        holder: address,
        provenance_commitment: vector<u8>,
    }

    struct PhysicalMarketCustodyTransitionV8 has copy, drop {
        action: u8,
        listing_id: 0x2::object::ID,
        asset_id: 0x2::object::ID,
        source_kind: u8,
        source_treasury_id: 0x2::object::ID,
        previous_holder: address,
        holder: address,
        previous_ownership_epoch: u64,
        ownership_epoch: u64,
        provenance_commitment: vector<u8>,
    }

    public fun advance_base_policy_commitment_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert_hash(&arg2);
        assert_hash(&arg3);
        let v0 = BasePolicyAdvanceCommitmentInputV8{
            domain                  : b"animacraft-v8/physical/base-row",
            version                 : 8,
            root_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            sequence                : arg1,
            prior_commitment        : arg2,
            row_commitment          : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BasePolicyAdvanceCommitmentInputV8>(&v0))
    }

    fun append_base_style_policy<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg3: &PhysicalPackageConfigV8, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: u8, arg10: u8, arg11: u64, arg12: u64, arg13: bool, arg14: vector<u8>) {
        assert!(!arg0.base_sealed, 7);
        assert!(arg4 == arg0.observed_base_policy_count, 4);
        assert!(arg4 < arg0.expected_base_policy_count, 3);
        assert!(arg14 == derive_base_policy_row_commitment_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 2);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::borrow_style_v2(arg2, arg5, arg6, arg7);
        let v1 = PhysicalPolicyKeyV8{
            source_kind : 0,
            source_id   : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg2),
            part_key    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_part_key_v2(v0),
            item_key    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_item_key_v2(v0),
            style_key   : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_key_v2(v0),
        };
        assert!(!0x2::table::contains<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.base_policies, v1), 6);
        let v2 = PhysicalSourceBindingV8{
            source_kind                   : 0,
            source_id                     : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg2),
            source_semantic_id            : 0x1::string::utf8(b""),
            source_content_commitment     : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg1),
            source_treasury_id            : 0x1::option::none<0x2::object::ID>(),
            pack_registry_id              : 0x1::option::none<0x2::object::ID>(),
            pack_registry_revision        : 0,
            registered_pack_owner         : 0x1::option::none<address>(),
            registered_pack_control_epoch : 0,
            registered_pack_admin_cap_id  : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = PhysicalStyleDescriptorV8{
            part_key            : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_part_key_v2(v0),
            item_key            : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_item_key_v2(v0),
            style_key           : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_key_v2(v0),
            layer_track_key     : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_layer_track_key_v2(v0),
            color_channel_key   : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_color_channel_key_v2(v0),
            default_swatch_key  : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_default_swatch_key_v2(v0),
            style_asset_blob_id : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_asset_blob_id_v2(v0),
            style_asset_sha256  : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_asset_sha256_v2(v0),
            style_protected     : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_protected_v2(v0),
        };
        let v4 = PhysicalStylePolicyV8{
            sequence                      : arg4,
            source                        : v2,
            style                         : v3,
            style_payload_commitment      : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_payload_commitment_v2(v0),
            style_seal_binding_commitment : b"",
            source_style_commitment       : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_payload_commitment_v2(v0),
            style_identity_commitment     : derive_style_identity<T0>(arg1, arg2, v0),
            material_policy_commitment    : arg8,
            issuance_kind                 : arg9,
            proof_kind                    : arg10,
            price_atomic                  : arg11,
            max_supply                    : arg12,
            transferable                  : arg13,
            issued_count                  : 0,
            consumed_count                : 0,
            row_commitment                : arg14,
        };
        0x2::table::add<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.base_policies, v1, v4);
        0x1::vector::push_back<PhysicalPolicyKeyV8>(&mut arg0.base_policy_keys, v1);
        arg0.observed_base_policy_count = arg0.observed_base_policy_count + 1;
        arg0.rolling_base_policy_commitment = advance_base_policy_commitment_v8<T0>(arg1, arg4, arg0.rolling_base_policy_commitment, arg14);
    }

    public fun append_base_style_policy_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &PhysicalPackageConfigV8, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: u8, arg12: u8, arg13: u64, arg14: u64, arg15: bool, arg16: vector<u8>) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_config(arg4, arg5);
        assert_registry_identity<T0>(arg0, arg1, arg3, arg5);
        append_base_style_policy<T0>(arg0, arg1, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    fun append_pack_policy_from_witness<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: u64, arg7: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimePhysicalPackPolicyWitnessV8, arg8: vector<u8>, arg9: u8, arg10: u8, arg11: u64, arg12: u64, arg13: bool) {
        let v0 = PhysicalRuntimeWitnessV2{dummy_field: false};
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26) = 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::consume_physical_pack_policy_witness_v8<T0, PhysicalRuntimeWitnessV2>(arg7, v0, arg1, arg2, arg3, arg4);
        assert!(arg0.revision == arg6, 10);
        assert!(v1 == arg0.root_id, 1);
        assert!(v2 == arg0.maker_version, 1);
        assert!(v3 == arg0.root_content_commitment, 1);
        let v27 = PhysicalPolicyKeyV8{
            source_kind : 1,
            source_id   : v6,
            part_key    : v14,
            item_key    : v15,
            style_key   : v16,
        };
        assert!(!0x2::table::contains<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.pack_policies, v27), 6);
        let v28 = arg6 + 1;
        let v29 = PackPolicyRowCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/pack-policy",
            version                    : 8,
            product_binding_commitment : arg0.product_binding_commitment,
            physical_registry_id       : 0x2::object::id<PhysicalRegistryV8>(arg0),
            root_id                    : v1,
            maker_version              : v2,
            root_content_commitment    : v3,
            registry_revision          : v28,
            pack_registry_id           : v4,
            pack_registry_revision     : v5,
            release_id                 : v6,
            semantic_pack_id           : v7,
            release_content_commitment : v8,
            pack_owner                 : v9,
            pack_control_epoch         : v10,
            pack_admin_cap_id          : v11,
            pack_treasury_id           : v12,
            style_index                : v13,
            style_identity_commitment  : v26,
            material_policy_commitment : arg8,
            issuance_kind              : arg9,
            proof_kind                 : arg10,
            price_atomic               : arg11,
            max_supply                 : arg12,
            transferable               : arg13,
        };
        let v30 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackPolicyRowCommitmentInputV8>(&v29));
        let v31 = PhysicalSourceBindingV8{
            source_kind                   : 1,
            source_id                     : v6,
            source_semantic_id            : v7,
            source_content_commitment     : v8,
            source_treasury_id            : 0x1::option::some<0x2::object::ID>(v12),
            pack_registry_id              : 0x1::option::some<0x2::object::ID>(v4),
            pack_registry_revision        : v5,
            registered_pack_owner         : 0x1::option::some<address>(v9),
            registered_pack_control_epoch : v10,
            registered_pack_admin_cap_id  : 0x1::option::some<0x2::object::ID>(v11),
        };
        let v32 = PhysicalStyleDescriptorV8{
            part_key            : v14,
            item_key            : v15,
            style_key           : v16,
            layer_track_key     : v17,
            color_channel_key   : v18,
            default_swatch_key  : v19,
            style_asset_blob_id : v20,
            style_asset_sha256  : v21,
            style_protected     : v23,
        };
        let v33 = PhysicalStylePolicyV8{
            sequence                      : arg0.expected_base_policy_count + arg0.pack_policy_count,
            source                        : v31,
            style                         : v32,
            style_payload_commitment      : v22,
            style_seal_binding_commitment : v24,
            source_style_commitment       : v25,
            style_identity_commitment     : v26,
            material_policy_commitment    : arg8,
            issuance_kind                 : arg9,
            proof_kind                    : arg10,
            price_atomic                  : arg11,
            max_supply                    : arg12,
            transferable                  : arg13,
            issued_count                  : 0,
            consumed_count                : 0,
            row_commitment                : v30,
        };
        0x2::table::add<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.pack_policies, v27, v33);
        0x1::vector::push_back<PhysicalPolicyKeyV8>(&mut arg0.pack_policy_keys, v27);
        arg0.pack_policy_count = arg0.pack_policy_count + 1;
        arg0.revision = v28;
        let v34 = PackPhysicalPolicyRegisteredV8{
            root_id                   : v1,
            registry_id               : 0x2::object::id<PhysicalRegistryV8>(arg0),
            registry_revision         : v28,
            pack_registry_id          : v4,
            pack_registry_revision    : v5,
            release_id                : v6,
            pack_treasury_id          : v12,
            style_identity_commitment : v26,
            row_commitment            : v30,
        };
        0x2::event::emit<PackPhysicalPolicyRegisteredV8>(v34);
    }

    fun assert_activation_ready(arg0: &PhysicalRegistryV8) {
        assert!(arg0.base_sealed, 8);
        assert!(arg0.observed_base_policy_count == arg0.expected_base_policy_count, 3);
        assert!(arg0.rolling_base_policy_commitment == arg0.expected_base_policy_commitment, 2);
        assert!(arg0.revision == 0, 9);
        assert!(arg0.pack_policy_count == 0, 9);
        assert!(0x1::vector::is_empty<PhysicalPolicyKeyV8>(&arg0.pack_policy_keys), 9);
        assert!(arg0.total_issued == 0, 9);
        assert!(arg0.total_free_claimed == 0, 9);
        assert!(arg0.total_paid_purchased == 0, 9);
        assert!(arg0.total_proof_materialized == 0, 9);
        assert!(arg0.total_consumed == 0, 9);
        assert!(arg0.gross_paid_atomic == 0, 9);
        assert!(arg0.protocol_paid_atomic == 0, 9);
        assert!(arg0.maker_paid_atomic == 0, 9);
        assert!(arg0.pack_paid_atomic == 0, 9);
        assert!(arg0.used_authorization_count == 0, 9);
        assert!(0x2::table::is_empty<vector<u8>, bool>(&arg0.used_authorizations), 9);
    }

    fun assert_active_registry<T0>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8) {
        assert_config(arg2, arg3);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_lifecycle_v8<T0>(arg1) == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::lifecycle_active_v8(), 9);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.version == 8, 1);
        assert!(arg0.base_sealed, 8);
        assert!(arg0.rolling_base_policy_commitment == arg0.expected_base_policy_commitment, 2);
        assert!(arg0.catalog_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2), 1);
        assert!(arg0.package_config_id == 0x2::object::id<PhysicalPackageConfigV8>(arg3), 1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_base_registry_identity_v8<T0>(arg1, arg0.base_registry_id, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::physical_registry_id_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg1)) == 0x2::object::id<PhysicalRegistryV8>(arg0), 1);
    }

    fun assert_asset_holder(arg0: &PhysicalAssetV8, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 8, 1);
        assert!(arg0.holder == 0x2::tx_context::sender(arg1) && arg0.holder != @0x0, 12);
    }

    fun assert_base_market_source<T0>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &PhysicalAssetV8, arg3: 0x2::object::ID) {
        assert!(arg2.source.source_kind == 0, 21);
        assert!(arg2.source.source_id == arg0.base_registry_id, 1);
        assert!(arg2.source.source_semantic_id == 0x1::string::utf8(b""), 1);
        assert!(&arg2.source.source_content_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg1), 2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_maker_treasury_identity_v8<T0>(arg1, arg3);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.pack_registry_id), 1);
        assert!(0x1::option::is_none<address>(&arg2.source.registered_pack_owner), 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.registered_pack_admin_cap_id), 1);
    }

    fun assert_base_registry<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_base_registry_identity_v8<T0>(arg0, 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg1), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_root_id_v2(arg1), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_maker_version_v2(arg1), 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_root_content_commitment_v2(arg1));
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::registry_sealed_v2(arg1), 9);
    }

    fun assert_complete_binding<T0>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalCompleteBindingV8, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_root_id_v8(arg2) == arg0.root_id, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_maker_version_v8(arg2) == arg0.maker_version, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_root_content_commitment_v8(arg2) == &arg0.root_content_commitment, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_holder_v8(arg2) == 0x2::tx_context::sender(arg3) && 0x2::tx_context::sender(arg3) != @0x0, 12);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg1, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_root_id_v8(arg2), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_maker_version_v8(arg2), 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_root_content_commitment_v8(arg2));
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg1);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::physical_registry_id_v2(v0) == 0x2::object::id<PhysicalRegistryV8>(arg0), 1);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::output_registry_id_v2(v0) == 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_output_registry_id_v8(arg2), 1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::soul_registry_id_v2(v0)
    }

    fun assert_config(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: &PhysicalPackageConfigV8) {
        assert_config_binding(arg0, arg1);
        let v0 = b"physical_v8";
        let v1 = b"PhysicalSetupInstallWitnessV2";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_witness_type_v2<PhysicalSetupInstallWitnessV2>(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg0), 4), &v0, &v1);
    }

    fun assert_config_binding(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: &PhysicalPackageConfigV8) {
        assert!(arg1.version == 8 && arg1.catalog_id == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8>(arg0), 0);
        let (_, _, _, v3, v4, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg0);
        assert!(&arg1.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v3) && &arg1.call_cap_set_commitment == v4, 0);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_role_config_installation_v2(arg0, 4, 0x2::object::id<PhysicalPackageConfigV8>(arg1), &arg1.installation_commitment);
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

    fun assert_issue_available(arg0: &PhysicalRegistryV8, arg1: &PhysicalStylePolicyV8, arg2: u64, arg3: &vector<u8>) {
        assert_hash(arg3);
        assert!(arg1.issued_count == arg2, 10);
        assert!(arg1.issued_count < arg1.max_supply, 15);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_authorizations, *arg3), 14);
        let v0 = if (arg1.source.source_kind == 0) {
            let v1 = PhysicalPolicyKeyV8{
                source_kind : arg1.source.source_kind,
                source_id   : arg1.source.source_id,
                part_key    : arg1.style.part_key,
                item_key    : arg1.style.item_key,
                style_key   : arg1.style.style_key,
            };
            0x2::table::borrow<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.base_policies, v1)
        } else {
            let v2 = PhysicalPolicyKeyV8{
                source_kind : arg1.source.source_kind,
                source_id   : arg1.source.source_id,
                part_key    : arg1.style.part_key,
                item_key    : arg1.style.item_key,
                style_key   : arg1.style.style_key,
            };
            0x2::table::borrow<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.pack_policies, v2)
        };
        assert!(v0.row_commitment == arg1.row_commitment, 1);
        assert!(v0.issued_count == arg2, 10);
    }

    fun assert_market_asset_registry_binding<T0>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &PhysicalAssetV8) {
        assert!(arg2.version == 8, 1);
        assert!(arg2.registry_id == 0x2::object::id<PhysicalRegistryV8>(arg0), 1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg1, arg2.root_id, arg2.maker_version, &arg2.root_content_commitment);
        assert!(arg0.root_id == arg2.root_id, 1);
        assert!(arg0.maker_version == arg2.maker_version, 1);
        assert!(arg0.root_content_commitment == arg2.root_content_commitment, 1);
        let v0 = PhysicalPolicyKeyV8{
            source_kind : arg2.source.source_kind,
            source_id   : arg2.source.source_id,
            part_key    : arg2.style.part_key,
            item_key    : arg2.style.item_key,
            style_key   : arg2.style.style_key,
        };
        let v1 = if (arg2.source.source_kind == 0) {
            0x2::table::borrow<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.base_policies, v0)
        } else {
            assert!(arg2.source.source_kind == 1, 1);
            0x2::table::borrow<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.pack_policies, v0)
        };
        assert!(v1.source.source_kind == arg2.source.source_kind, 1);
        assert!(v1.source.source_id == arg2.source.source_id, 1);
        assert!(v1.source.source_semantic_id == arg2.source.source_semantic_id, 1);
        assert!(v1.source.source_content_commitment == arg2.source.source_content_commitment, 1);
        assert!(v1.source.source_treasury_id == arg2.source.source_treasury_id, 17);
        assert!(v1.source.pack_registry_id == arg2.source.pack_registry_id, 1);
        assert!(v1.source.pack_registry_revision == arg2.source.pack_registry_revision, 1);
        assert!(v1.row_commitment == arg2.policy_row_commitment, 1);
        assert!(v1.style_payload_commitment == arg2.asset_content_commitment, 1);
        assert!(v1.transferable == arg2.transferable, 1);
        assert_hash(&arg2.provenance_commitment);
    }

    fun assert_market_authority<T0, T1: key, T2: key>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg5: &T1, arg6: &T2) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg3, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_runtime_caller_cap_v1(arg4, 1, arg3, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg0, arg2);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::binding_at_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_binding_v8(arg2), 5);
        let v1 = b"market_v8";
        let v2 = b"MarketRegistryV8";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_single_argument_type_v2<T1, T0>(v0, &v1, &v2);
        let v3 = b"market_v8";
        let v4 = b"MarketTreasuryV8";
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_exact_single_argument_type_v2<T2, T0>(v0, &v3, &v4);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::market_registry_id_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg0)) == 0x2::object::id<T1>(arg5), 20);
        assert!(0x2::object::id<T1>(arg5) != 0x2::object::id<T2>(arg6), 20);
    }

    fun assert_market_custody_asset<T0>(arg0: &PhysicalMarketCustodyBindingV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &PhysicalAssetV8) {
        assert!(arg0.asset_id == 0x2::object::id<PhysicalAssetV8>(arg2), 21);
        assert!(arg0.physical_registry_id == arg2.registry_id, 21);
        assert!(arg0.root_id == arg2.root_id, 21);
        assert!(arg0.maker_version == arg2.maker_version, 21);
        assert!(arg0.root_content_commitment == arg2.root_content_commitment, 21);
        assert!(arg0.asset_content_commitment == arg2.asset_content_commitment, 21);
        assert!(arg0.source_kind == arg2.source.source_kind, 21);
        assert!(arg0.source_id == arg2.source.source_id, 21);
        assert!(arg0.source_semantic_id == arg2.source.source_semantic_id, 21);
        assert!(arg0.source_content_commitment == arg2.source.source_content_commitment, 21);
        assert!(arg0.holder == arg2.holder, 12);
        assert!(arg0.ownership_epoch == arg2.ownership_epoch, 10);
        assert!(arg0.transferable == arg2.transferable, 16);
        assert!(arg0.transferable, 16);
        assert!(arg0.provenance_commitment == arg2.provenance_commitment, 2);
        if (arg2.source.source_kind == 0) {
            assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_maker_treasury_identity_v8<T0>(arg1, arg0.source_treasury_id);
        } else {
            assert!(arg2.source.source_kind == 1, 21);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
            assert!(arg0.source_treasury_id == *0x1::option::borrow<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
        };
    }

    fun assert_market_custody_current<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg7: &T1, arg8: &T2) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg2, arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg1, arg2);
        assert_active_registry<T0>(arg0, arg1, arg3, arg5);
        assert_market_authority<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6, arg7, arg8);
        assert!(&arg0.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_binding_commitment_v8<T0>(arg1), 20);
        assert!(&arg0.call_cap_set_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_product_release_call_cap_set_commitment_v8<T0>(arg1), 20);
    }

    fun assert_market_custody_live_binding<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg6: &T1, arg7: &T2, arg8: &0x2::object::UID, arg9: &PhysicalMarketCustodyBindingV8) {
        assert_market_authority<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let (_, _, _, v3, v4, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg3);
        assert!(arg9.version == 8, 21);
        assert!(arg9.catalog_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg3), 21);
        assert!(&arg9.product_binding_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v3), 21);
        assert!(&arg9.call_cap_set_commitment == v4, 21);
        assert!(arg9.market_authority_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_authority_id_v2(arg3, 4), 21);
        assert!(arg9.market_registry_id == 0x2::object::id<T1>(arg6), 21);
        assert!(arg9.market_treasury_id == 0x2::object::id<T2>(arg7), 21);
        assert!(arg9.listing_id == 0x2::object::uid_to_inner(arg8), 21);
        assert!(arg9.physical_package_config_id == arg0.package_config_id, 21);
        assert!(arg9.physical_registry_id == 0x2::object::id<PhysicalRegistryV8>(arg0), 21);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::physical_registry_id_v2(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_companion_registry_ids_v2<T0>(arg1)) == 0x2::object::id<PhysicalRegistryV8>(arg0), 20);
        assert!(arg9.root_id == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg1), 21);
        assert!(arg9.maker_version == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg1), 21);
        assert!(&arg9.root_content_commitment == 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg1), 21);
        assert!(arg9.transferable, 16);
        assert_hash(&arg9.asset_content_commitment);
        assert_hash(&arg9.source_content_commitment);
        assert_hash(&arg9.provenance_commitment);
    }

    fun assert_output_pack_selection_matches(arg0: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalSelectionBindingV8, arg1: &PhysicalPackAccessBindingV8) {
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_class_v8(arg0) == 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::source_pack_v8(), 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_loadout_id_v8(arg0) == arg1.loadout_id, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_loadout_revision_v8(arg0) == arg1.loadout_revision, 10);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_loadout_commitment_v8(arg0) == &arg1.loadout_commitment, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_index_v8(arg0) == arg1.selection_index, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_commitment_v8(arg0) == &arg1.selection_commitment, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_definition_id_v8(arg0) == arg1.release_id, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_semantic_id_v8(arg0) == &arg1.semantic_pack_id, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_content_commitment_v8(arg0) == &arg1.release_content_commitment, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_epoch_v8(arg0) == 0, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_pricing_commitment_v8(arg0) == &arg1.pricing_commitment, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_part_key_v8(arg0) == &arg1.part_key, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_item_key_v8(arg0) == &arg1.item_key, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_style_key_v8(arg0) == &arg1.style_key, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_layer_track_key_v8(arg0) == &arg1.layer_track_key, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_asset_content_commitment_v8(arg0) == &arg1.asset_content_commitment, 1);
    }

    fun assert_output_selection_current(arg0: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalCompleteBindingV8, arg1: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalSelectionBindingV8, arg2: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8) {
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_loadout_id_v8(arg1) == 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::loadout_id_v8(arg2), 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_loadout_revision_v8(arg1) == 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::loadout_revision_v8(arg2), 10);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_loadout_commitment_v8(arg1) == 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::loadout_commitment_v8(arg2), 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_holder_v8(arg0) != @0x0, 12);
    }

    fun assert_pack_market_source(arg0: &PhysicalAssetV8, arg1: 0x2::object::ID) {
        assert!(arg0.source.source_kind == 1, 21);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.source.source_treasury_id), 17);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.source.source_treasury_id) == arg1, 17);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.source.pack_registry_id), 1);
        assert!(0x1::option::is_some<address>(&arg0.source.registered_pack_owner), 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.source.registered_pack_admin_cap_id), 1);
    }

    fun assert_pack_selection_matches(arg0: &PhysicalSelectionEvidenceV8, arg1: &PhysicalPackAccessBindingV8) {
        assert!(arg0.source_class == 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::source_pack_v8(), 1);
        assert!(arg0.root_id == arg1.root_id, 1);
        assert!(arg0.maker_version == arg1.maker_version, 1);
        assert!(arg0.root_content_commitment == arg1.root_content_commitment, 1);
        assert!(arg0.holder == arg1.holder, 12);
        assert!(arg0.loadout_id == arg1.loadout_id, 1);
        assert!(arg0.loadout_revision == arg1.loadout_revision, 10);
        assert!(arg0.loadout_commitment == arg1.loadout_commitment, 1);
        assert!(arg0.selection_index == arg1.selection_index, 1);
        assert!(arg0.selection_commitment == arg1.selection_commitment, 1);
        assert!(arg0.source_definition_id == arg1.release_id, 1);
        assert!(arg0.source_semantic_id == arg1.semantic_pack_id, 1);
        assert!(arg0.source_content_commitment == arg1.release_content_commitment, 1);
        assert!(arg0.source_epoch == 0, 1);
        assert!(arg0.pricing_commitment == arg1.pricing_commitment, 1);
        assert!(arg0.part_key == arg1.part_key, 1);
        assert!(arg0.item_key == arg1.item_key, 1);
        assert!(arg0.style_key == arg1.style_key, 1);
        assert!(arg0.layer_track_key == arg1.layer_track_key, 1);
        assert!(arg0.asset_content_commitment == arg1.asset_content_commitment, 1);
    }

    fun assert_policy_terms(arg0: u8, arg1: u8, arg2: u64, arg3: u64) {
        assert!(arg3 > 0 && arg3 <= 1000000000, 5);
        if (arg0 == 0) {
            assert!(arg2 == 0 && arg1 == 0, 5);
            return
        };
        if (arg0 == 1) {
            assert!(arg2 > 0 && arg1 == 0, 5);
            return
        };
        assert!(arg0 == 2, 5);
        assert!(arg2 == 0, 5);
        assert!(arg1 == 2, 5);
    }

    fun assert_registry_identity<T0>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg3: &PhysicalPackageConfigV8) {
        assert!(arg0.version == 8, 1);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert_base_registry<T0>(arg1, arg2);
        assert!(arg0.base_registry_id == 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg2), 1);
        assert!(arg0.catalog_id == arg3.catalog_id, 1);
        assert!(arg0.package_config_id == 0x2::object::id<PhysicalPackageConfigV8>(arg3), 1);
        assert!(arg0.product_binding_commitment == arg3.product_binding_commitment, 1);
        assert!(arg0.call_cap_set_commitment == arg3.call_cap_set_commitment, 1);
    }

    fun assert_selection_root(arg0: &PhysicalRegistryV8, arg1: &PhysicalSelectionEvidenceV8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.root_id == arg0.root_id, 1);
        assert!(arg1.maker_version == arg0.maker_version, 1);
        assert!(arg1.root_content_commitment == arg0.root_content_commitment, 1);
        assert!(arg1.holder == 0x2::tx_context::sender(arg2) && arg1.holder != @0x0, 12);
    }

    public fun asset_authorization_key_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.authorization_key
    }

    public fun asset_color_channel_key_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<0x1::string::String> {
        &arg0.style.color_channel_key
    }

    public fun asset_content_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.asset_content_commitment
    }

    public fun asset_default_swatch_key_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<0x1::string::String> {
        &arg0.style.default_swatch_key
    }

    public fun asset_holder_v8(arg0: &PhysicalAssetV8) : address {
        arg0.holder
    }

    public fun asset_id_v8(arg0: &PhysicalAssetV8) : 0x2::object::ID {
        0x2::object::id<PhysicalAssetV8>(arg0)
    }

    public fun asset_issuance_kind_v8(arg0: &PhysicalAssetV8) : u8 {
        arg0.issuance_kind
    }

    public fun asset_item_key_v8(arg0: &PhysicalAssetV8) : &0x1::string::String {
        &arg0.style.item_key
    }

    public fun asset_layer_track_key_v8(arg0: &PhysicalAssetV8) : &0x1::string::String {
        &arg0.style.layer_track_key
    }

    public fun asset_maker_version_v8(arg0: &PhysicalAssetV8) : u64 {
        arg0.maker_version
    }

    public fun asset_material_policy_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.material_policy_commitment
    }

    public fun asset_ownership_epoch_v8(arg0: &PhysicalAssetV8) : u64 {
        arg0.ownership_epoch
    }

    public fun asset_pack_registry_id_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source.pack_registry_id
    }

    public fun asset_pack_registry_revision_v8(arg0: &PhysicalAssetV8) : u64 {
        arg0.source.pack_registry_revision
    }

    public fun asset_part_key_v8(arg0: &PhysicalAssetV8) : &0x1::string::String {
        &arg0.style.part_key
    }

    public fun asset_policy_row_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.policy_row_commitment
    }

    public fun asset_proof_kind_v8(arg0: &PhysicalAssetV8) : u8 {
        arg0.proof_kind
    }

    public fun asset_proof_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<PhysicalProofProvenanceV8> {
        &arg0.proof
    }

    public fun asset_provenance_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.provenance_commitment
    }

    public fun asset_registered_pack_admin_cap_id_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source.registered_pack_admin_cap_id
    }

    public fun asset_registered_pack_control_epoch_v8(arg0: &PhysicalAssetV8) : u64 {
        arg0.source.registered_pack_control_epoch
    }

    public fun asset_registered_pack_owner_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<address> {
        &arg0.source.registered_pack_owner
    }

    public fun asset_registry_id_v8(arg0: &PhysicalAssetV8) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun asset_root_content_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun asset_root_id_v8(arg0: &PhysicalAssetV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun asset_serial_v8(arg0: &PhysicalAssetV8) : u64 {
        arg0.serial
    }

    public fun asset_source_content_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.source.source_content_commitment
    }

    public fun asset_source_id_v8(arg0: &PhysicalAssetV8) : 0x2::object::ID {
        arg0.source.source_id
    }

    public fun asset_source_kind_v8(arg0: &PhysicalAssetV8) : u8 {
        arg0.source.source_kind
    }

    public fun asset_source_semantic_id_v8(arg0: &PhysicalAssetV8) : &0x1::string::String {
        &arg0.source.source_semantic_id
    }

    public fun asset_source_style_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.source_style_commitment
    }

    public fun asset_source_treasury_id_v8(arg0: &PhysicalAssetV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source.source_treasury_id
    }

    public fun asset_style_asset_blob_id_v8(arg0: &PhysicalAssetV8) : &0x1::string::String {
        &arg0.style.style_asset_blob_id
    }

    public fun asset_style_asset_sha256_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.style.style_asset_sha256
    }

    public fun asset_style_identity_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.style_identity_commitment
    }

    public fun asset_style_key_v8(arg0: &PhysicalAssetV8) : &0x1::string::String {
        &arg0.style.style_key
    }

    public fun asset_style_protected_v8(arg0: &PhysicalAssetV8) : bool {
        arg0.style.style_protected
    }

    public fun asset_style_seal_binding_commitment_v8(arg0: &PhysicalAssetV8) : &vector<u8> {
        &arg0.style_seal_binding_commitment
    }

    public fun asset_transferable_v8(arg0: &PhysicalAssetV8) : bool {
        arg0.transferable
    }

    public fun bind_maker_physical_companion_v2<T0>(arg0: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &PhysicalPackageConfigV8, arg7: &PhysicalRegistryV8, arg8: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg9: &0x2::tx_context::TxContext) : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::MakerRuntimeCompanionBindingBuilderV2<T0> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_companion_builder_root_v2<T0>(&arg0, arg1, arg2, arg9);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg3, arg4);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg5, arg4);
        assert_config(arg4, arg6);
        assert_registry_identity<T0>(arg7, arg1, arg8, arg6);
        assert_activation_ready(arg7);
        let v0 = MakerCompanionBindingWitnessV2{dummy_field: false};
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::companion_binding_v2::append_physical_v2<T0, MakerCompanionBindingWitnessV2>(arg0, v0, arg3, arg4, arg5, 0x2::object::id<PhysicalRegistryV8>(arg7), arg9)
    }

    fun borrow_base_policy_by_keys(arg0: &PhysicalRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : &PhysicalStylePolicyV8 {
        let v0 = PhysicalPolicyKeyV8{
            source_kind : 0,
            source_id   : arg0.base_registry_id,
            part_key    : arg1,
            item_key    : arg2,
            style_key   : arg3,
        };
        0x2::table::borrow<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.base_policies, v0)
    }

    fun borrow_base_policy_by_selection(arg0: &PhysicalRegistryV8, arg1: &PhysicalSelectionEvidenceV8) : &PhysicalStylePolicyV8 {
        assert!(arg1.source_class == 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::source_base_v8(), 1);
        assert!(arg1.source_definition_id == arg0.root_id, 1);
        assert!(0x1::string::is_empty(&arg1.source_semantic_id), 1);
        assert!(arg1.source_content_commitment == arg0.root_content_commitment, 1);
        assert!(arg1.source_epoch == 0, 1);
        let v0 = borrow_base_policy_by_keys(arg0, arg1.part_key, arg1.item_key, arg1.style_key);
        assert!(v0.style.layer_track_key == arg1.layer_track_key, 1);
        assert!(v0.style_payload_commitment == arg1.asset_content_commitment, 1);
        v0
    }

    public fun borrow_base_policy_v8(arg0: &PhysicalRegistryV8, arg1: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalSelectionBindingV8) : &PhysicalStylePolicyV8 {
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_class_v8(arg1) == 0, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_definition_id_v8(arg1) == arg0.root_id, 1);
        assert!(0x1::string::is_empty(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_semantic_id_v8(arg1)), 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_content_commitment_v8(arg1) == &arg0.root_content_commitment, 1);
        assert!(0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_source_epoch_v8(arg1) == 0, 1);
        let v0 = borrow_base_policy_by_keys(arg0, *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_part_key_v8(arg1), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_item_key_v8(arg1), *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_style_key_v8(arg1));
        assert!(&v0.style.layer_track_key == 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_layer_track_key_v8(arg1), 1);
        assert!(&v0.style_payload_commitment == 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_asset_content_commitment_v8(arg1), 1);
        v0
    }

    fun borrow_pack_policy_by_access(arg0: &PhysicalRegistryV8, arg1: &PhysicalPackAccessBindingV8) : &PhysicalStylePolicyV8 {
        assert!(arg1.root_id == arg0.root_id, 1);
        assert!(arg1.maker_version == arg0.maker_version, 1);
        assert!(arg1.root_content_commitment == arg0.root_content_commitment, 1);
        let v0 = PhysicalPolicyKeyV8{
            source_kind : 1,
            source_id   : arg1.release_id,
            part_key    : arg1.part_key,
            item_key    : arg1.item_key,
            style_key   : arg1.style_key,
        };
        let v1 = 0x2::table::borrow<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.pack_policies, v0);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1.source.pack_registry_id) == arg1.pack_registry_id, 1);
        assert!(arg1.pack_registry_revision >= v1.source.pack_registry_revision, 10);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v1.source.source_treasury_id) == arg1.pack_treasury_id, 17);
        assert_hash(&arg1.pack_pass_commitment);
        assert!(v1.source.source_semantic_id == arg1.semantic_pack_id, 1);
        assert!(v1.source.source_content_commitment == arg1.release_content_commitment, 1);
        assert!(v1.style.layer_track_key == arg1.layer_track_key, 1);
        assert!(v1.style_payload_commitment == arg1.asset_content_commitment, 1);
        assert!(v1.style_identity_commitment == arg1.style_identity_commitment, 1);
        v1
    }

    public fun borrow_physical_market_custody_ticket_binding_v8(arg0: &PhysicalMarketCustodyTicketV8) : &PhysicalMarketCustodyBindingV8 {
        &arg0.binding
    }

    fun certify_pack_access<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &PhysicalPackageConfigV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg10: u64, arg11: &0x2::tx_context::TxContext) : PhysicalPackAccessBindingV8 {
        let v0 = PhysicalRuntimeWitnessV2{dummy_field: false};
        let v1 = PhysicalRuntimeWitnessV2{dummy_field: false};
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25) = 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::consume_physical_pack_access_witness_v8<T0, PhysicalRuntimeWitnessV2>(0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::new_physical_pack_access_witness_v8<T0, PhysicalRuntimeWitnessV2>(arg0, v0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11), v1, arg0, arg1, arg2, arg3);
        PhysicalPackAccessBindingV8{
            root_id                    : v2,
            maker_version              : v3,
            root_content_commitment    : v4,
            holder                     : v5,
            pack_registry_id           : v6,
            pack_registry_revision     : v7,
            release_id                 : v8,
            semantic_pack_id           : v9,
            release_content_commitment : v10,
            pack_treasury_id           : v11,
            pack_pass_id               : v12,
            pack_pass_commitment       : v13,
            loadout_id                 : v14,
            loadout_revision           : v15,
            loadout_commitment         : v16,
            selection_index            : v17,
            selection_commitment       : v18,
            pricing_commitment         : v19,
            part_key                   : v20,
            item_key                   : v21,
            style_key                  : v22,
            layer_track_key            : v23,
            asset_content_commitment   : v24,
            style_identity_commitment  : v25,
        }
    }

    public fun claim_free_base_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg2, arg3, arg4);
        assert_active_registry<T0>(arg0, arg1, arg3, arg5);
        let v0 = consume_runtime_selection(arg6, arg7, arg9);
        assert_selection_root(arg0, &v0, arg9);
        let v1 = *borrow_base_policy_by_selection(arg0, &v0);
        assert!(v1.issuance_kind == 0, 18);
        let v2 = derive_authorization_key(b"animacraft-v8/physical/free-claim", arg0, &v1, v0.holder, v1.source.source_id, b"");
        issue_asset(arg0, v1, v0.holder, arg8, v2, 0x1::option::none<PhysicalProofProvenanceV8>(), arg9)
    }

    public fun claim_free_pack_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg10: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg11: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg2, arg3, arg4);
        assert_active_registry<T0>(arg0, arg1, arg3, arg5);
        let v0 = consume_runtime_selection(arg10, arg11, arg13);
        assert_selection_root(arg0, &v0, arg13);
        let v1 = certify_pack_access<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, v0.selection_index, arg13);
        assert_pack_selection_matches(&v0, &v1);
        let v2 = *borrow_pack_policy_by_access(arg0, &v1);
        assert!(v2.issuance_kind == 0, 18);
        let v3 = derive_authorization_key(b"animacraft-v8/physical/free-claim", arg0, &v2, v0.holder, v2.source.source_id, b"");
        issue_asset(arg0, v2, v0.holder, arg12, v3, 0x1::option::none<PhysicalProofProvenanceV8>(), arg13)
    }

    public fun config_id_v8(arg0: &PhysicalPackageConfigV8) : 0x2::object::ID {
        0x2::object::id<PhysicalPackageConfigV8>(arg0)
    }

    public fun consume_physical_asset_v8(arg0: &mut PhysicalRegistryV8, arg1: PhysicalAssetV8, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_asset_holder(&arg1, arg3);
        assert!(arg1.ownership_epoch == arg2, 10);
        assert!(arg1.registry_id == 0x2::object::id<PhysicalRegistryV8>(arg0), 1);
        assert!(arg1.root_id == arg0.root_id, 1);
        let v0 = PhysicalPolicyKeyV8{
            source_kind : arg1.source.source_kind,
            source_id   : arg1.source.source_id,
            part_key    : arg1.style.part_key,
            item_key    : arg1.style.item_key,
            style_key   : arg1.style.style_key,
        };
        let v1 = if (arg1.source.source_kind == 0) {
            0x2::table::borrow_mut<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.base_policies, v0)
        } else {
            assert!(arg1.source.source_kind == 1, 1);
            0x2::table::borrow_mut<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.pack_policies, v0)
        };
        assert!(v1.row_commitment == arg1.policy_row_commitment, 1);
        assert!(v1.consumed_count < v1.issued_count, 3);
        v1.consumed_count = v1.consumed_count + 1;
        arg0.total_consumed = arg0.total_consumed + 1;
        let PhysicalAssetV8 {
            id                            : v2,
            version                       : _,
            registry_id                   : _,
            root_id                       : _,
            maker_version                 : _,
            root_content_commitment       : _,
            source                        : _,
            style                         : _,
            style_seal_binding_commitment : _,
            source_style_commitment       : _,
            style_identity_commitment     : _,
            asset_content_commitment      : _,
            material_policy_commitment    : _,
            policy_row_commitment         : _,
            issuance_kind                 : _,
            proof_kind                    : _,
            serial                        : _,
            holder                        : _,
            ownership_epoch               : _,
            transferable                  : _,
            authorization_key             : _,
            proof                         : _,
            provenance_commitment         : _,
        } = arg1;
        0x2::object::delete(v2);
        let v25 = PhysicalAssetConsumedV8{
            asset_id              : 0x2::object::id<PhysicalAssetV8>(&arg1),
            root_id               : arg1.root_id,
            registry_id           : arg1.registry_id,
            source_kind           : arg1.source.source_kind,
            source_id             : arg1.source.source_id,
            serial                : arg1.serial,
            holder                : arg1.holder,
            provenance_commitment : arg1.provenance_commitment,
        };
        0x2::event::emit<PhysicalAssetConsumedV8>(v25);
    }

    public fun consume_physical_market_custody_ticket_v8(arg0: PhysicalMarketCustodyTicketV8) : PhysicalMarketCustodyBindingV8 {
        let PhysicalMarketCustodyTicketV8 { binding: v0 } = arg0;
        v0
    }

    fun consume_runtime_selection(arg0: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg1: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg2: &0x2::tx_context::TxContext) : PhysicalSelectionEvidenceV8 {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19) = 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::consume_physical_selection_witness_v8(arg0, arg1, arg2);
        PhysicalSelectionEvidenceV8{
            loadout_id                : v0,
            root_id                   : v1,
            maker_version             : v2,
            root_content_commitment   : v3,
            holder                    : v4,
            loadout_revision          : v5,
            loadout_commitment        : v6,
            selection_index           : v7,
            selection_commitment      : v8,
            part_key                  : v9,
            item_key                  : v10,
            style_key                 : v11,
            layer_track_key           : v12,
            source_class              : v13,
            source_definition_id      : v14,
            source_semantic_id        : v15,
            source_content_commitment : v16,
            source_epoch              : v17,
            pricing_commitment        : v18,
            asset_content_commitment  : v19,
        }
    }

    public fun custody_base_physical_for_market_v8<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg7: &T1, arg8: &T2, arg9: &mut 0x2::object::UID, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg11: PhysicalAssetV8, arg12: &0x2::tx_context::TxContext) : PhysicalMarketCustodyTicketV8 {
        assert_market_custody_current<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(arg1, arg10);
        assert_asset_holder(&arg11, arg12);
        assert!(arg11.transferable, 16);
        assert_market_asset_registry_binding<T0>(arg0, arg1, &arg11);
        let v0 = 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>>(arg10);
        assert_base_market_source<T0>(arg0, arg1, &arg11, v0);
        custody_physical_for_market<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, v0)
    }

    public fun custody_pack_physical_for_market_v8<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg7: &T1, arg8: &T2, arg9: &mut 0x2::object::UID, arg10: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg11: PhysicalAssetV8, arg12: &0x2::tx_context::TxContext) : PhysicalMarketCustodyTicketV8 {
        assert_market_custody_current<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        assert_asset_holder(&arg11, arg12);
        assert!(arg11.transferable, 16);
        assert_market_asset_registry_binding<T0>(arg0, arg1, &arg11);
        let v0 = 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>>(arg10);
        assert_pack_market_source(&arg11, v0);
        custody_physical_for_market<T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, v0)
    }

    fun custody_physical_for_market<T0: key, T1: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &PhysicalPackageConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg6: &T0, arg7: &T1, arg8: &mut 0x2::object::UID, arg9: PhysicalAssetV8, arg10: 0x2::object::ID) : PhysicalMarketCustodyTicketV8 {
        let v0 = new_physical_market_custody_binding<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, &arg9, arg10);
        let v1 = v0.listing_id;
        let v2 = PhysicalMarketCustodyTransitionV8{
            action                   : 0,
            listing_id               : v1,
            asset_id                 : v0.asset_id,
            source_kind              : v0.source_kind,
            source_treasury_id       : arg10,
            previous_holder          : v0.holder,
            holder                   : v0.holder,
            previous_ownership_epoch : v0.ownership_epoch,
            ownership_epoch          : v0.ownership_epoch,
            provenance_commitment    : v0.provenance_commitment,
        };
        0x2::event::emit<PhysicalMarketCustodyTransitionV8>(v2);
        0x2::transfer::transfer<PhysicalAssetV8>(arg9, 0x2::object::id_to_address(&v1));
        PhysicalMarketCustodyTicketV8{binding: v0}
    }

    fun derive_authorization_key(arg0: vector<u8>, arg1: &PhysicalRegistryV8, arg2: &PhysicalStylePolicyV8, arg3: address, arg4: 0x2::object::ID, arg5: vector<u8>) : vector<u8> {
        let v0 = PhysicalAuthorizationKeyInputV8{
            domain                : arg0,
            version               : 8,
            registry_id           : 0x2::object::id<PhysicalRegistryV8>(arg1),
            root_id               : arg1.root_id,
            source_kind           : arg2.source.source_kind,
            source_id             : arg2.source.source_id,
            policy_row_commitment : arg2.row_commitment,
            holder                : arg3,
            subject_id            : arg4,
            subject_commitment    : arg5,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PhysicalAuthorizationKeyInputV8>(&v0))
    }

    public fun derive_base_policy_row_commitment_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PhysicalPackageConfigV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: bool) : vector<u8> {
        assert_base_registry<T0>(arg0, arg1);
        assert_hash(&arg7);
        assert_policy_terms(arg8, arg9, arg10, arg11);
        let v0 = BasePolicyRowCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/base-policy",
            version                    : 8,
            product_binding_commitment : arg2.product_binding_commitment,
            root_id                    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id           : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg1),
            sequence                   : arg3,
            style_identity_commitment  : derive_style_identity<T0>(arg0, arg1, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::borrow_style_v2(arg1, arg4, arg5, arg6)),
            material_policy_commitment : arg7,
            issuance_kind              : arg8,
            proof_kind                 : arg9,
            price_atomic               : arg10,
            max_supply                 : arg11,
            transferable               : arg12,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BasePolicyRowCommitmentInputV8>(&v0))
    }

    public fun derive_base_style_identity_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) : vector<u8> {
        assert_base_registry<T0>(arg0, arg1);
        derive_style_identity<T0>(arg0, arg1, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::borrow_style_v2(arg1, arg2, arg3, arg4))
    }

    fun derive_readiness_commitment(arg0: &PhysicalRegistryV8) : vector<u8> {
        let v0 = PhysicalReadinessCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/readiness",
            version                    : 8,
            catalog_id                 : arg0.catalog_id,
            package_config_id          : arg0.package_config_id,
            call_cap_set_commitment    : arg0.call_cap_set_commitment,
            root_id                    : arg0.root_id,
            maker_version              : arg0.maker_version,
            root_content_commitment    : arg0.root_content_commitment,
            base_registry_id           : arg0.base_registry_id,
            physical_registry_id       : 0x2::object::id<PhysicalRegistryV8>(arg0),
            expected_base_policy_count : arg0.expected_base_policy_count,
            observed_base_policy_count : arg0.observed_base_policy_count,
            base_policy_commitment     : arg0.rolling_base_policy_commitment,
            revision                   : arg0.revision,
            pack_policy_count          : arg0.pack_policy_count,
            total_issued               : arg0.total_issued,
            total_consumed             : arg0.total_consumed,
            gross_paid_atomic          : arg0.gross_paid_atomic,
            protocol_paid_atomic       : arg0.protocol_paid_atomic,
            maker_paid_atomic          : arg0.maker_paid_atomic,
            pack_paid_atomic           : arg0.pack_paid_atomic,
            used_authorization_count   : arg0.used_authorization_count,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PhysicalReadinessCommitmentInputV8>(&v0))
    }

    fun derive_style_identity<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::StyleRowV2) : vector<u8> {
        let v0 = BaseStyleIdentityInputV8{
            domain                  : b"animacraft-v8/physical/base-style",
            version                 : 8,
            root_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id        : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg1),
            part_key                : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_part_key_v2(arg2),
            item_key                : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_item_key_v2(arg2),
            style_key               : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_key_v2(arg2),
            layer_track_key         : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_layer_track_key_v2(arg2),
            color_channel_key       : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_color_channel_key_v2(arg2),
            default_swatch_key      : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_default_swatch_key_v2(arg2),
            asset_blob_id           : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_asset_blob_id_v2(arg2),
            asset_sha256            : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_asset_sha256_v2(arg2),
            protected               : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_protected_v2(arg2),
            payload_commitment      : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::style_payload_commitment_v2(arg2),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BaseStyleIdentityInputV8>(&v0))
    }

    public fun empty_base_policy_commitment_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PhysicalPackageConfigV8) : vector<u8> {
        assert_base_registry<T0>(arg0, arg1);
        let v0 = EmptyBasePolicyCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/base-empty",
            version                    : 8,
            product_binding_commitment : arg2.product_binding_commitment,
            root_id                    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id           : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg1),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<EmptyBasePolicyCommitmentInputV8>(&v0))
    }

    fun issue_asset(arg0: &mut PhysicalRegistryV8, arg1: PhysicalStylePolicyV8, arg2: address, arg3: u64, arg4: vector<u8>, arg5: 0x1::option::Option<PhysicalProofProvenanceV8>, arg6: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_issue_available(arg0, &arg1, arg3, &arg4);
        if (arg1.proof_kind == 0) {
            assert!(0x1::option::is_none<PhysicalProofProvenanceV8>(&arg5), 18);
        } else {
            assert!(arg1.proof_kind == 2 && 0x1::option::is_some<PhysicalProofProvenanceV8>(&arg5), 18);
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_authorizations, arg4, true);
        arg0.used_authorization_count = arg0.used_authorization_count + 1;
        let v0 = if (arg1.source.source_kind == 0) {
            let v1 = PhysicalPolicyKeyV8{
                source_kind : arg1.source.source_kind,
                source_id   : arg1.source.source_id,
                part_key    : arg1.style.part_key,
                item_key    : arg1.style.item_key,
                style_key   : arg1.style.style_key,
            };
            0x2::table::borrow_mut<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.base_policies, v1)
        } else {
            let v2 = PhysicalPolicyKeyV8{
                source_kind : arg1.source.source_kind,
                source_id   : arg1.source.source_id,
                part_key    : arg1.style.part_key,
                item_key    : arg1.style.item_key,
                style_key   : arg1.style.style_key,
            };
            0x2::table::borrow_mut<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.pack_policies, v2)
        };
        assert!(v0.row_commitment == arg1.row_commitment, 1);
        assert!(v0.issued_count == arg3, 10);
        v0.issued_count = v0.issued_count + 1;
        let v3 = v0.issued_count;
        arg0.total_issued = arg0.total_issued + 1;
        if (arg1.issuance_kind == 0) {
            arg0.total_free_claimed = arg0.total_free_claimed + 1;
        } else if (arg1.issuance_kind == 1) {
            arg0.total_paid_purchased = arg0.total_paid_purchased + 1;
        } else {
            assert!(arg1.issuance_kind == 2, 18);
            arg0.total_proof_materialized = arg0.total_proof_materialized + 1;
        };
        let v4 = PhysicalAssetCommitmentInputV8{
            domain                        : b"animacraft-v8/physical/asset",
            version                       : 8,
            registry_id                   : 0x2::object::id<PhysicalRegistryV8>(arg0),
            root_id                       : arg0.root_id,
            maker_version                 : arg0.maker_version,
            root_content_commitment       : arg0.root_content_commitment,
            source                        : arg1.source,
            style                         : arg1.style,
            style_seal_binding_commitment : arg1.style_seal_binding_commitment,
            source_style_commitment       : arg1.source_style_commitment,
            style_identity_commitment     : arg1.style_identity_commitment,
            asset_content_commitment      : arg1.style_payload_commitment,
            material_policy_commitment    : arg1.material_policy_commitment,
            policy_row_commitment         : arg1.row_commitment,
            issuance_kind                 : arg1.issuance_kind,
            proof_kind                    : arg1.proof_kind,
            serial                        : v3,
            original_holder               : arg2,
            transferable                  : arg1.transferable,
            authorization_key             : arg4,
            proof                         : arg5,
        };
        let v5 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<PhysicalAssetCommitmentInputV8>(&v4));
        let v6 = PhysicalAssetV8{
            id                            : 0x2::object::new(arg6),
            version                       : 8,
            registry_id                   : 0x2::object::id<PhysicalRegistryV8>(arg0),
            root_id                       : arg0.root_id,
            maker_version                 : arg0.maker_version,
            root_content_commitment       : arg0.root_content_commitment,
            source                        : arg1.source,
            style                         : arg1.style,
            style_seal_binding_commitment : arg1.style_seal_binding_commitment,
            source_style_commitment       : arg1.source_style_commitment,
            style_identity_commitment     : arg1.style_identity_commitment,
            asset_content_commitment      : arg1.style_payload_commitment,
            material_policy_commitment    : arg1.material_policy_commitment,
            policy_row_commitment         : arg1.row_commitment,
            issuance_kind                 : arg1.issuance_kind,
            proof_kind                    : arg1.proof_kind,
            serial                        : v3,
            holder                        : arg2,
            ownership_epoch               : 0,
            transferable                  : arg1.transferable,
            authorization_key             : arg4,
            proof                         : arg5,
            provenance_commitment         : v5,
        };
        let v7 = PhysicalAssetIssuedV8{
            asset_id              : 0x2::object::id<PhysicalAssetV8>(&v6),
            root_id               : arg0.root_id,
            registry_id           : 0x2::object::id<PhysicalRegistryV8>(arg0),
            source_kind           : arg1.source.source_kind,
            source_id             : arg1.source.source_id,
            serial                : v3,
            holder                : arg2,
            issuance_kind         : arg1.issuance_kind,
            authorization_key     : arg4,
            provenance_commitment : v5,
        };
        0x2::event::emit<PhysicalAssetIssuedV8>(v7);
        v6
    }

    public fun issue_free_claim_v8() : u8 {
        0
    }

    public fun issue_paid_purchase_v8() : u8 {
        1
    }

    public fun issue_proof_materialize_v8() : u8 {
        2
    }

    public fun materialize_base_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalMaterializationWitnessV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg2, arg3, arg4);
        assert_active_registry<T0>(arg0, arg1, arg3, arg5);
        let v0 = PhysicalRuntimeWitnessV2{dummy_field: false};
        let (v1, v2, v3, v4) = 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::consume_physical_materialization_witness_v8<PhysicalRuntimeWitnessV2>(arg6, v0, arg2, arg3, arg4);
        let v5 = v2;
        let v6 = v1;
        assert_output_selection_current(&v6, &v5, arg7);
        let v7 = *borrow_base_policy_v8(arg0, &v5);
        assert!(v7.issuance_kind == 2, 18);
        let v8 = proof_provenance(&v6, assert_complete_binding<T0>(arg0, arg1, &v6, arg9), v3, v4);
        let v9 = derive_authorization_key(b"animacraft-v8/physical/proof-materialize", arg0, &v7, @0x0, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_soul_id_v8(&v6), v8.soul_commitment);
        issue_asset(arg0, v7, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_holder_v8(&v6), arg8, v9, 0x1::option::some<PhysicalProofProvenanceV8>(v8), arg9)
    }

    public fun materialize_pack_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg10: 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalMaterializationWitnessV8, arg11: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg2, arg3, arg4);
        assert_active_registry<T0>(arg0, arg1, arg3, arg5);
        let v0 = PhysicalRuntimeWitnessV2{dummy_field: false};
        let (v1, v2, v3, v4) = 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::consume_physical_materialization_witness_v8<PhysicalRuntimeWitnessV2>(arg10, v0, arg2, arg3, arg4);
        let v5 = v2;
        let v6 = v1;
        assert_output_selection_current(&v6, &v5, arg11);
        let v7 = certify_pack_access<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_selection_index_v8(&v5), arg13);
        assert_output_pack_selection_matches(&v5, &v7);
        let v8 = *borrow_pack_policy_by_access(arg0, &v7);
        assert!(v8.issuance_kind == 2, 18);
        let v9 = proof_provenance(&v6, assert_complete_binding<T0>(arg0, arg1, &v6, arg13), v3, v4);
        let v10 = derive_authorization_key(b"animacraft-v8/physical/proof-materialize", arg0, &v8, @0x0, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_soul_id_v8(&v6), v9.soul_commitment);
        issue_asset(arg0, v8, 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_holder_v8(&v6), arg12, v10, 0x1::option::some<PhysicalProofProvenanceV8>(v9), arg13)
    }

    fun new_physical_market_custody_binding<T0: key, T1: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &PhysicalPackageConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg6: &T0, arg7: &T1, arg8: &0x2::object::UID, arg9: &PhysicalAssetV8, arg10: 0x2::object::ID) : PhysicalMarketCustodyBindingV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_runtime_caller_cap_v1(arg5, 1, arg3, arg2);
        let (_, _, _, v3, v4, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg2);
        PhysicalMarketCustodyBindingV8{
            version                    : 8,
            catalog_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg2),
            product_binding_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v3),
            call_cap_set_commitment    : *v4,
            market_authority_id        : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_authority_id_v2(arg2, 4),
            market_registry_id         : 0x2::object::id<T0>(arg6),
            market_treasury_id         : 0x2::object::id<T1>(arg7),
            listing_id                 : 0x2::object::uid_to_inner(arg8),
            physical_package_config_id : 0x2::object::id<PhysicalPackageConfigV8>(arg4),
            physical_registry_id       : 0x2::object::id<PhysicalRegistryV8>(arg0),
            root_id                    : arg9.root_id,
            maker_version              : arg9.maker_version,
            root_content_commitment    : arg9.root_content_commitment,
            asset_id                   : 0x2::object::id<PhysicalAssetV8>(arg9),
            asset_content_commitment   : arg9.asset_content_commitment,
            source_kind                : arg9.source.source_kind,
            source_id                  : arg9.source.source_id,
            source_semantic_id         : arg9.source.source_semantic_id,
            source_content_commitment  : arg9.source.source_content_commitment,
            source_treasury_id         : arg10,
            holder                     : arg9.holder,
            ownership_epoch            : arg9.ownership_epoch,
            transferable               : arg9.transferable,
            provenance_commitment      : arg9.provenance_commitment,
        }
    }

    public fun new_physical_package_config_v8(arg0: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg1: 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::PackageCallCapV8<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::PhysicalRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : PhysicalPackageConfigV8 {
        let v0 = 0x2::object::new(arg2);
        let v1 = PhysicalSetupInstallWitnessV2{dummy_field: false};
        let (_, _, _, v5, v6, _) = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_terms_v2(arg0);
        PhysicalPackageConfigV8{
            id                         : v0,
            version                    : 8,
            catalog_id                 : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::catalog_id_v8(arg0),
            product_binding_commitment : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::product_binding_commitment_v8(v5),
            call_cap_set_commitment    : *v6,
            installation_commitment    : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::consume_physical_call_cap_v8<PhysicalSetupInstallWitnessV2>(arg0, arg1, v1, 0x2::object::uid_to_inner(&v0)),
        }
    }

    public fun new_physical_registry_v8<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : PhysicalRegistryV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_config(arg3, arg4);
        assert_base_registry<T0>(arg0, arg2);
        new_registry<T0>(arg0, arg2, arg4, arg5, arg6, arg7)
    }

    fun new_registry<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PhysicalPackageConfigV8, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : PhysicalRegistryV8 {
        assert!(arg3 <= 10000, 3);
        assert_hash(&arg4);
        let v0 = empty_base_policy_commitment_v8<T0>(arg0, arg1, arg2);
        if (arg3 == 0) {
            assert!(arg4 == v0, 2);
        };
        PhysicalRegistryV8{
            id                              : 0x2::object::new(arg5),
            version                         : 8,
            catalog_id                      : arg2.catalog_id,
            package_config_id               : 0x2::object::id<PhysicalPackageConfigV8>(arg2),
            product_binding_commitment      : arg2.product_binding_commitment,
            call_cap_set_commitment         : arg2.call_cap_set_commitment,
            root_id                         : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_id_v8<T0>(arg0),
            maker_version                   : 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment         : *0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id                : 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8>(arg1),
            expected_base_policy_count      : arg3,
            observed_base_policy_count      : 0,
            expected_base_policy_commitment : arg4,
            rolling_base_policy_commitment  : v0,
            base_sealed                     : false,
            base_policy_keys                : 0x1::vector::empty<PhysicalPolicyKeyV8>(),
            base_policies                   : 0x2::table::new<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(arg5),
            revision                        : 0,
            pack_policy_count               : 0,
            pack_policy_keys                : 0x1::vector::empty<PhysicalPolicyKeyV8>(),
            pack_policies                   : 0x2::table::new<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(arg5),
            total_issued                    : 0,
            total_free_claimed              : 0,
            total_paid_purchased            : 0,
            total_proof_materialized        : 0,
            total_consumed                  : 0,
            gross_paid_atomic               : 0,
            protocol_paid_atomic            : 0,
            maker_paid_atomic               : 0,
            pack_paid_atomic                : 0,
            used_authorization_count        : 0,
            used_authorizations             : 0x2::table::new<vector<u8>, bool>(arg5),
        }
    }

    public fun physical_market_custody_asset_content_commitment_v8(arg0: &PhysicalMarketCustodyBindingV8) : &vector<u8> {
        &arg0.asset_content_commitment
    }

    public fun physical_market_custody_asset_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.asset_id
    }

    public fun physical_market_custody_call_cap_set_commitment_v8(arg0: &PhysicalMarketCustodyBindingV8) : &vector<u8> {
        &arg0.call_cap_set_commitment
    }

    public fun physical_market_custody_catalog_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.catalog_id
    }

    public fun physical_market_custody_holder_v8(arg0: &PhysicalMarketCustodyBindingV8) : address {
        arg0.holder
    }

    public fun physical_market_custody_listing_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.listing_id
    }

    public fun physical_market_custody_maker_version_v8(arg0: &PhysicalMarketCustodyBindingV8) : u64 {
        arg0.maker_version
    }

    public fun physical_market_custody_market_authority_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.market_authority_id
    }

    public fun physical_market_custody_market_registry_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.market_registry_id
    }

    public fun physical_market_custody_market_treasury_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.market_treasury_id
    }

    public fun physical_market_custody_ownership_epoch_v8(arg0: &PhysicalMarketCustodyBindingV8) : u64 {
        arg0.ownership_epoch
    }

    public fun physical_market_custody_physical_package_config_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.physical_package_config_id
    }

    public fun physical_market_custody_physical_registry_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.physical_registry_id
    }

    public fun physical_market_custody_product_binding_commitment_v8(arg0: &PhysicalMarketCustodyBindingV8) : &vector<u8> {
        &arg0.product_binding_commitment
    }

    public fun physical_market_custody_provenance_commitment_v8(arg0: &PhysicalMarketCustodyBindingV8) : &vector<u8> {
        &arg0.provenance_commitment
    }

    public fun physical_market_custody_root_content_commitment_v8(arg0: &PhysicalMarketCustodyBindingV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun physical_market_custody_root_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun physical_market_custody_source_content_commitment_v8(arg0: &PhysicalMarketCustodyBindingV8) : &vector<u8> {
        &arg0.source_content_commitment
    }

    public fun physical_market_custody_source_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.source_id
    }

    public fun physical_market_custody_source_kind_v8(arg0: &PhysicalMarketCustodyBindingV8) : u8 {
        arg0.source_kind
    }

    public fun physical_market_custody_source_semantic_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : &0x1::string::String {
        &arg0.source_semantic_id
    }

    public fun physical_market_custody_source_treasury_id_v8(arg0: &PhysicalMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.source_treasury_id
    }

    public fun physical_market_custody_transferable_v8(arg0: &PhysicalMarketCustodyBindingV8) : bool {
        arg0.transferable
    }

    public fun physical_market_custody_version_v8(arg0: &PhysicalMarketCustodyBindingV8) : u64 {
        arg0.version
    }

    public fun policy_color_channel_key_v8(arg0: &PhysicalStylePolicyV8) : &0x1::option::Option<0x1::string::String> {
        &arg0.style.color_channel_key
    }

    public fun policy_consumed_count_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.consumed_count
    }

    public fun policy_default_swatch_key_v8(arg0: &PhysicalStylePolicyV8) : &0x1::option::Option<0x1::string::String> {
        &arg0.style.default_swatch_key
    }

    public fun policy_issuance_kind_v8(arg0: &PhysicalStylePolicyV8) : u8 {
        arg0.issuance_kind
    }

    public fun policy_issued_count_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.issued_count
    }

    public fun policy_item_key_v8(arg0: &PhysicalStylePolicyV8) : &0x1::string::String {
        &arg0.style.item_key
    }

    public fun policy_layer_track_key_v8(arg0: &PhysicalStylePolicyV8) : &0x1::string::String {
        &arg0.style.layer_track_key
    }

    public fun policy_material_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.material_policy_commitment
    }

    public fun policy_max_supply_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.max_supply
    }

    public fun policy_pack_registry_id_v8(arg0: &PhysicalStylePolicyV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source.pack_registry_id
    }

    public fun policy_pack_registry_revision_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.source.pack_registry_revision
    }

    public fun policy_part_key_v8(arg0: &PhysicalStylePolicyV8) : &0x1::string::String {
        &arg0.style.part_key
    }

    public fun policy_price_atomic_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.price_atomic
    }

    public fun policy_proof_kind_v8(arg0: &PhysicalStylePolicyV8) : u8 {
        arg0.proof_kind
    }

    public fun policy_registered_pack_admin_cap_id_v8(arg0: &PhysicalStylePolicyV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source.registered_pack_admin_cap_id
    }

    public fun policy_registered_pack_control_epoch_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.source.registered_pack_control_epoch
    }

    public fun policy_registered_pack_owner_v8(arg0: &PhysicalStylePolicyV8) : &0x1::option::Option<address> {
        &arg0.source.registered_pack_owner
    }

    public fun policy_row_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.row_commitment
    }

    public fun policy_sequence_v8(arg0: &PhysicalStylePolicyV8) : u64 {
        arg0.sequence
    }

    public fun policy_source_content_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.source.source_content_commitment
    }

    public fun policy_source_id_v8(arg0: &PhysicalStylePolicyV8) : 0x2::object::ID {
        arg0.source.source_id
    }

    public fun policy_source_kind_v8(arg0: &PhysicalStylePolicyV8) : u8 {
        arg0.source.source_kind
    }

    public fun policy_source_semantic_id_v8(arg0: &PhysicalStylePolicyV8) : &0x1::string::String {
        &arg0.source.source_semantic_id
    }

    public fun policy_source_style_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.source_style_commitment
    }

    public fun policy_source_treasury_id_v8(arg0: &PhysicalStylePolicyV8) : &0x1::option::Option<0x2::object::ID> {
        &arg0.source.source_treasury_id
    }

    public fun policy_style_asset_blob_id_v8(arg0: &PhysicalStylePolicyV8) : &0x1::string::String {
        &arg0.style.style_asset_blob_id
    }

    public fun policy_style_asset_sha256_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.style.style_asset_sha256
    }

    public fun policy_style_identity_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.style_identity_commitment
    }

    public fun policy_style_key_v8(arg0: &PhysicalStylePolicyV8) : &0x1::string::String {
        &arg0.style.style_key
    }

    public fun policy_style_payload_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.style_payload_commitment
    }

    public fun policy_style_protected_v8(arg0: &PhysicalStylePolicyV8) : bool {
        arg0.style.style_protected
    }

    public fun policy_style_seal_binding_commitment_v8(arg0: &PhysicalStylePolicyV8) : &vector<u8> {
        &arg0.style_seal_binding_commitment
    }

    public fun policy_transferable_v8(arg0: &PhysicalStylePolicyV8) : bool {
        arg0.transferable
    }

    public fun proof_canonical_soul_v8() : u8 {
        2
    }

    public fun proof_materialization_key_v8(arg0: &PhysicalProofProvenanceV8) : &0x1::string::String {
        &arg0.materialization_key
    }

    public fun proof_none_v8() : u8 {
        0
    }

    public fun proof_output_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.output_commitment
    }

    public fun proof_output_id_v8(arg0: &PhysicalProofProvenanceV8) : 0x2::object::ID {
        arg0.output_id
    }

    public fun proof_output_key_v8(arg0: &PhysicalProofProvenanceV8) : &0x1::string::String {
        &arg0.output_key
    }

    public fun proof_output_policy_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.output_policy_commitment
    }

    public fun proof_output_registry_id_v8(arg0: &PhysicalProofProvenanceV8) : 0x2::object::ID {
        arg0.output_registry_id
    }

    fun proof_provenance(arg0: &0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::PhysicalCompleteBindingV8, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: vector<u8>) : PhysicalProofProvenanceV8 {
        assert_hash(&arg3);
        PhysicalProofProvenanceV8{
            output_registry_id       : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_output_registry_id_v8(arg0),
            soul_registry_id         : arg1,
            output_key               : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_output_key_v8(arg0),
            output_policy_commitment : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_policy_commitment_v8(arg0),
            output_id                : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_output_id_v8(arg0),
            receipt_id               : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_receipt_id_v8(arg0),
            soul_id                  : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_soul_id_v8(arg0),
            soul_ownership_epoch     : 0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_soul_epoch_v8(arg0),
            recipe_commitment        : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_recipe_commitment_v8(arg0),
            render_commitment        : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_render_commitment_v8(arg0),
            output_commitment        : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_output_commitment_v8(arg0),
            receipt_commitment       : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_receipt_commitment_v8(arg0),
            soul_commitment          : *0xe3a54b021cba35c1221cc0fb5cf347ea8805da61f000fa5bfa5f5e4812fe5f0b::output_v8::physical_complete_soul_commitment_v8(arg0),
            materialization_key      : arg2,
            witness_commitment       : arg3,
        }
    }

    public fun proof_receipt_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.receipt_commitment
    }

    public fun proof_receipt_id_v8(arg0: &PhysicalProofProvenanceV8) : 0x2::object::ID {
        arg0.receipt_id
    }

    public fun proof_recipe_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.recipe_commitment
    }

    public fun proof_render_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.render_commitment
    }

    public fun proof_soul_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.soul_commitment
    }

    public fun proof_soul_id_v8(arg0: &PhysicalProofProvenanceV8) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun proof_soul_ownership_epoch_v8(arg0: &PhysicalProofProvenanceV8) : u64 {
        arg0.soul_ownership_epoch
    }

    public fun proof_soul_registry_id_v8(arg0: &PhysicalProofProvenanceV8) : 0x2::object::ID {
        arg0.soul_registry_id
    }

    public fun proof_witness_commitment_v8(arg0: &PhysicalProofProvenanceV8) : &vector<u8> {
        &arg0.witness_commitment
    }

    fun protocol_share(arg0: u64, arg1: u16) : u64 {
        assert!(arg1 <= 10000, 13);
        let v0 = (arg0 as u128) * (arg1 as u128) / 10000;
        assert!(arg1 == 0 || v0 > 0, 13);
        let v1 = (v0 as u64);
        assert!(v1 < arg0, 13);
        v1
    }

    public fun purchase_base_physical_from_market_v8<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg7: &T1, arg8: &T2, arg9: &mut 0x2::object::UID, arg10: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg11: 0x2::transfer::Receiving<PhysicalAssetV8>, arg12: &PhysicalMarketCustodyBindingV8, arg13: &0x2::tx_context::TxContext) {
        assert_market_custody_current<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(arg1, arg10);
        assert_market_custody_live_binding<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg12);
        let v0 = 0x2::object::id<0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>>(arg10);
        assert!(arg12.source_kind == 0, 21);
        assert!(arg12.source_treasury_id == v0, 17);
        let v1 = receive_and_assert_market_asset<T0>(arg0, arg1, arg9, arg11, arg12);
        assert_base_market_source<T0>(arg0, arg1, &v1, v0);
        purchase_received_market_asset(v1, arg12, arg13);
    }

    public fun purchase_base_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &PhysicalPackageConfigV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg6: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg7: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg8: 0x2::coin::Coin<T0>, arg9: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg10: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg5, arg2, arg3);
        assert_active_registry<T0>(arg0, arg1, arg2, arg4);
        let v0 = consume_runtime_selection(arg9, arg10, arg12);
        assert_selection_root(arg0, &v0, arg12);
        let v1 = *borrow_base_policy_by_selection(arg0, &v0);
        assert!(v1.issuance_kind == 1, 18);
        let v2 = derive_authorization_key(b"animacraft-v8/physical/paid-purchase", arg0, &v1, v0.holder, 0x2::object::id<0x2::coin::Coin<T0>>(&arg8), b"");
        assert_issue_available(arg0, &v1, arg11, &v2);
        let (v3, v4) = settle_base_payment<T0>(arg0, arg1, arg5, arg6, arg7, v1.price_atomic, arg8, arg12);
        assert!(v3 + v4 == v1.price_atomic, 13);
        issue_asset(arg0, v1, v0.holder, arg11, v2, 0x1::option::none<PhysicalProofProvenanceV8>(), arg12)
    }

    public fun purchase_pack_physical_from_market_v8<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg7: &T1, arg8: &T2, arg9: &mut 0x2::object::UID, arg10: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg11: 0x2::transfer::Receiving<PhysicalAssetV8>, arg12: &PhysicalMarketCustodyBindingV8, arg13: &0x2::tx_context::TxContext) {
        assert_market_custody_current<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        assert_market_custody_live_binding<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg12);
        let v0 = 0x2::object::id<0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>>(arg10);
        assert!(arg12.source_kind == 1, 21);
        assert!(arg12.source_treasury_id == v0, 17);
        let v1 = receive_and_assert_market_asset<T0>(arg0, arg1, arg9, arg11, arg12);
        assert_pack_market_source(&v1, v0);
        purchase_received_market_asset(v1, arg12, arg13);
    }

    public fun purchase_pack_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg4: &PhysicalPackageConfigV8, arg5: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg6: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg7: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackPassV8, arg9: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg10: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg11: 0x2::coin::Coin<T0>, arg12: 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg13: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::MakerLoadoutV8, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg9, arg2, arg3);
        assert_active_registry<T0>(arg0, arg1, arg2, arg4);
        let v0 = consume_runtime_selection(arg12, arg13, arg15);
        assert_selection_root(arg0, &v0, arg15);
        let v1 = certify_pack_access<T0>(arg1, arg9, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg13, v0.selection_index, arg15);
        assert_pack_selection_matches(&v0, &v1);
        let v2 = *borrow_pack_policy_by_access(arg0, &v1);
        assert!(v2.issuance_kind == 1, 18);
        let v3 = derive_authorization_key(b"animacraft-v8/physical/paid-purchase", arg0, &v2, v0.holder, 0x2::object::id<0x2::coin::Coin<T0>>(&arg11), b"");
        assert_issue_available(arg0, &v2, arg14, &v3);
        let (v4, v5) = settle_pack_payment<T0>(arg0, arg1, arg6, arg7, arg9, arg10, v2.price_atomic, arg11, arg15);
        assert!(v4 + v5 == v2.price_atomic, 13);
        issue_asset(arg0, v2, v0.holder, arg14, v3, 0x1::option::none<PhysicalProofProvenanceV8>(), arg15)
    }

    fun purchase_received_market_asset(arg0: PhysicalAssetV8, arg1: &PhysicalMarketCustodyBindingV8, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != @0x0 && v0 != arg0.holder, 19);
        assert!(arg0.ownership_epoch < 18446744073709551615, 22);
        let v1 = arg0.ownership_epoch;
        arg0.holder = v0;
        arg0.ownership_epoch = v1 + 1;
        let v2 = PhysicalMarketCustodyTransitionV8{
            action                   : 2,
            listing_id               : arg1.listing_id,
            asset_id                 : 0x2::object::id<PhysicalAssetV8>(&arg0),
            source_kind              : arg0.source.source_kind,
            source_treasury_id       : arg1.source_treasury_id,
            previous_holder          : arg0.holder,
            holder                   : v0,
            previous_ownership_epoch : v1,
            ownership_epoch          : arg0.ownership_epoch,
            provenance_commitment    : arg0.provenance_commitment,
        };
        0x2::event::emit<PhysicalMarketCustodyTransitionV8>(v2);
        0x2::transfer::transfer<PhysicalAssetV8>(arg0, v0);
    }

    fun receive_and_assert_market_asset<T0>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &mut 0x2::object::UID, arg3: 0x2::transfer::Receiving<PhysicalAssetV8>, arg4: &PhysicalMarketCustodyBindingV8) : PhysicalAssetV8 {
        assert!(0x2::transfer::receiving_object_id<PhysicalAssetV8>(&arg3) == arg4.asset_id, 21);
        let v0 = 0x2::transfer::receive<PhysicalAssetV8>(arg2, arg3);
        assert_market_asset_registry_binding<T0>(arg0, arg1, &v0);
        assert_market_custody_asset<T0>(arg4, arg1, &v0);
        v0
    }

    public fun register_pack_style_policy_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg6: &PhysicalPackageConfigV8, arg7: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackRegistryV8, arg8: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg9: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackAdminCapV8, arg10: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<u8>, arg16: u8, arg17: u8, arg18: u64, arg19: u64, arg20: bool, arg21: &0x2::tx_context::TxContext) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_active_live_authority_v2<T0>(arg1, arg3, arg4, arg5);
        assert_active_registry<T0>(arg0, arg1, arg4, arg6);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_admin_v8<T0>(arg1, arg2);
        assert!(0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_owner_v8<T0>(arg1) == 0x2::tx_context::sender(arg21), 12);
        assert!(arg0.revision == arg11, 10);
        assert!(arg0.observed_base_policy_count + arg0.pack_policy_count < 10000, 3);
        assert_hash(&arg15);
        assert_policy_terms(arg16, arg17, arg18, arg19);
        let v0 = PhysicalRuntimeWitnessV2{dummy_field: false};
        append_pack_policy_from_witness<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg11, 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::new_physical_pack_policy_witness_v8<T0, PhysicalRuntimeWitnessV2>(arg1, v0, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg12, arg13, arg14, arg21), arg15, arg16, arg17, arg18, arg19, arg20);
    }

    public fun registry_base_policy_commitment_v8(arg0: &PhysicalRegistryV8) : &vector<u8> {
        &arg0.rolling_base_policy_commitment
    }

    public fun registry_base_registry_id_v8(arg0: &PhysicalRegistryV8) : 0x2::object::ID {
        arg0.base_registry_id
    }

    public fun registry_base_sealed_v8(arg0: &PhysicalRegistryV8) : bool {
        arg0.base_sealed
    }

    public fun registry_expected_base_policy_count_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.expected_base_policy_count
    }

    public fun registry_gross_paid_atomic_v8(arg0: &PhysicalRegistryV8) : u128 {
        arg0.gross_paid_atomic
    }

    public fun registry_id_v8(arg0: &PhysicalRegistryV8) : 0x2::object::ID {
        0x2::object::id<PhysicalRegistryV8>(arg0)
    }

    public fun registry_maker_paid_atomic_v8(arg0: &PhysicalRegistryV8) : u128 {
        arg0.maker_paid_atomic
    }

    public fun registry_maker_version_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.maker_version
    }

    public fun registry_observed_base_policy_count_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.observed_base_policy_count
    }

    public fun registry_pack_paid_atomic_v8(arg0: &PhysicalRegistryV8) : u128 {
        arg0.pack_paid_atomic
    }

    public fun registry_pack_policy_count_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.pack_policy_count
    }

    public fun registry_protocol_paid_atomic_v8(arg0: &PhysicalRegistryV8) : u128 {
        arg0.protocol_paid_atomic
    }

    public fun registry_revision_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.revision
    }

    public fun registry_root_content_commitment_v8(arg0: &PhysicalRegistryV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun registry_root_id_v8(arg0: &PhysicalRegistryV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_total_consumed_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.total_consumed
    }

    public fun registry_total_free_claimed_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.total_free_claimed
    }

    public fun registry_total_issued_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.total_issued
    }

    public fun registry_total_paid_purchased_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.total_paid_purchased
    }

    public fun registry_total_proof_materialized_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.total_proof_materialized
    }

    public fun registry_used_authorization_count_v8(arg0: &PhysicalRegistryV8) : u64 {
        arg0.used_authorization_count
    }

    public fun return_physical_from_market_v8<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::RuntimeCallerCapV1, arg6: &T1, arg7: &T2, arg8: &mut 0x2::object::UID, arg9: 0x2::transfer::Receiving<PhysicalAssetV8>, arg10: &PhysicalMarketCustodyBindingV8) {
        assert_market_authority<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert_market_custody_live_binding<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10);
        let v0 = receive_and_assert_market_asset<T0>(arg0, arg1, arg8, arg9, arg10);
        let v1 = v0.holder;
        let v2 = v0.ownership_epoch;
        let v3 = PhysicalMarketCustodyTransitionV8{
            action                   : 1,
            listing_id               : arg10.listing_id,
            asset_id                 : 0x2::object::id<PhysicalAssetV8>(&v0),
            source_kind              : v0.source.source_kind,
            source_treasury_id       : arg10.source_treasury_id,
            previous_holder          : v1,
            holder                   : v1,
            previous_ownership_epoch : v2,
            ownership_epoch          : v2,
            provenance_commitment    : v0.provenance_commitment,
        };
        0x2::event::emit<PhysicalMarketCustodyTransitionV8>(v3);
        0x2::transfer::transfer<PhysicalAssetV8>(v0, v1);
    }

    public fun seal_physical_registry_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerAdminCapV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg5: &PhysicalPackageConfigV8) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_config(arg4, arg5);
        assert_registry_identity<T0>(arg0, arg1, arg3, arg5);
        seal_registry(arg0);
    }

    fun seal_registry(arg0: &mut PhysicalRegistryV8) {
        assert!(!arg0.base_sealed, 7);
        assert!(arg0.observed_base_policy_count == arg0.expected_base_policy_count, 3);
        assert!(0x1::vector::length<PhysicalPolicyKeyV8>(&arg0.base_policy_keys) == arg0.expected_base_policy_count, 3);
        assert!(arg0.rolling_base_policy_commitment == arg0.expected_base_policy_commitment, 2);
        arg0.base_sealed = true;
        let v0 = PhysicalRegistrySealedV8{
            root_id                : arg0.root_id,
            registry_id            : 0x2::object::id<PhysicalRegistryV8>(arg0),
            base_policy_count      : arg0.observed_base_policy_count,
            base_policy_commitment : arg0.rolling_base_policy_commitment,
        };
        0x2::event::emit<PhysicalRegistrySealedV8>(v0);
    }

    fun settle_base_payment<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg4: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::MakerTreasuryV8<T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg1, arg2);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::assert_maker_treasury_v8<T0>(arg1, arg4);
        assert!(0x2::coin::value<T0>(&arg6) == arg5 && arg5 > 0, 13);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_economics_v8<T0>(arg1);
        let v1 = protocol_share(arg5, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_primary_content_fee_bps_v8(&v0));
        let v2 = arg5 - v1;
        if (v1 > 0) {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg2, arg3, 0x2::coin::split<T0>(&mut arg6, v1, arg7));
        };
        assert!(0x2::coin::value<T0>(&arg6) == v2 && v2 > 0, 13);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::treasury_v8::deposit_maker_revenue_v8<T0>(arg1, arg4, arg2, arg6);
        arg0.gross_paid_atomic = arg0.gross_paid_atomic + (arg5 as u128);
        arg0.protocol_paid_atomic = arg0.protocol_paid_atomic + (v1 as u128);
        arg0.maker_paid_atomic = arg0.maker_paid_atomic + (v2 as u128);
        (v1, v2)
    }

    fun settle_pack_payment<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg2: &0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackReleaseV8<T0>, arg3: &mut 0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::PackTreasuryV8<T0>, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg5: &mut 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_current_protocol_config_v8<T0>(arg1, arg4);
        assert!(0x2::coin::value<T0>(&arg7) == arg6 && arg6 > 0, 13);
        let v0 = 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::root_economics_v8<T0>(arg1);
        let v1 = protocol_share(arg6, 0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::economics_primary_content_fee_bps_v8(&v0));
        let v2 = arg6 - v1;
        if (v1 > 0) {
            0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg4, arg5, 0x2::coin::split<T0>(&mut arg7, v1, arg8));
        };
        assert!(0x2::coin::value<T0>(&arg7) == v2 && v2 > 0, 13);
        0x9c88bca9969c4d7cadfb5ad491c0828acc2781efaff93b724e91104b15720b00::runtime_v8::deposit_pack_revenue_v8<T0>(arg2, arg3, arg7);
        arg0.gross_paid_atomic = arg0.gross_paid_atomic + (arg6 as u128);
        arg0.protocol_paid_atomic = arg0.protocol_paid_atomic + (v1 as u128);
        arg0.pack_paid_atomic = arg0.pack_paid_atomic + (v2 as u128);
        (v1, v2)
    }

    public fun share_physical_package_config_v8(arg0: PhysicalPackageConfigV8) {
        0x2::transfer::share_object<PhysicalPackageConfigV8>(arg0);
    }

    public fun share_physical_registry_v8(arg0: PhysicalRegistryV8) {
        0x2::transfer::share_object<PhysicalRegistryV8>(arg0);
    }

    public fun source_base_style_v8() : u8 {
        0
    }

    public fun source_pack_style_v8() : u8 {
        1
    }

    public fun transfer_new_physical_asset_to_holder_v8(arg0: PhysicalAssetV8) {
        0x2::transfer::transfer<PhysicalAssetV8>(arg0, arg0.holder);
    }

    public fun transfer_physical_asset_v8(arg0: PhysicalAssetV8, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_asset_holder(&arg0, arg3);
        assert!(arg0.transferable, 16);
        assert!(arg0.ownership_epoch == arg2, 10);
        assert!(arg1 != @0x0 && arg1 != arg0.holder, 19);
        arg0.holder = arg1;
        arg0.ownership_epoch = arg0.ownership_epoch + 1;
        let v0 = PhysicalAssetTransferredV8{
            asset_id        : 0x2::object::id<PhysicalAssetV8>(&arg0),
            previous_holder : arg0.holder,
            holder          : arg1,
            ownership_epoch : arg0.ownership_epoch,
        };
        0x2::event::emit<PhysicalAssetTransferredV8>(v0);
        0x2::transfer::transfer<PhysicalAssetV8>(arg0, arg1);
    }

    public fun validate_physical_activation_readiness_v2<T0>(arg0: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::MakerRootV8<T0>, arg1: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::base_registry_v8::BaseDefinitionRegistryV8, arg2: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::protocol_config_v8::ProtocolConfigV8, arg3: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::ProductReleaseCatalogV8, arg4: &0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::FreshTupleReplacementBindingV2, arg5: &PhysicalPackageConfigV8, arg6: &PhysicalRegistryV8) : vector<u8> {
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_catalog_current_v8(arg2, arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::package_binding_v8::assert_replacement_current_v2(arg4, arg3);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_product_release_catalog_v8<T0>(arg0, arg3);
        assert_config(arg3, arg5);
        assert_registry_identity<T0>(arg6, arg0, arg1, arg5);
        0xce6a5fa79a4583951a381484ba2b6c4f82746d6570183e3540a108d988d98902::maker_v8::assert_draft_v8<T0>(arg0);
        assert_activation_ready(arg6);
        derive_readiness_commitment(arg6)
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

