module 0x88abc74b3e3ba58f96cd3bc23ccccb774b489657ddd7f64b959210a08e056936::physical_v8 {
    struct PhysicalOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct PhysicalCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct PhysicalPackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        call_cap_set_commitment: vector<u8>,
        physical_call_cap: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>,
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

    public fun advance_base_policy_commitment_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert_hash(&arg2);
        assert_hash(&arg3);
        let v0 = BasePolicyAdvanceCommitmentInputV8{
            domain                  : b"animacraft-v8/physical/base-row",
            version                 : 8,
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            sequence                : arg1,
            prior_commitment        : arg2,
            row_commitment          : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BasePolicyAdvanceCommitmentInputV8>(&v0))
    }

    fun append_base_style_policy<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: &PhysicalPackageConfigV8, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<u8>, arg9: u8, arg10: u8, arg11: u64, arg12: u64, arg13: bool, arg14: vector<u8>) {
        assert!(!arg0.base_sealed, 7);
        assert!(arg4 == arg0.observed_base_policy_count, 4);
        assert!(arg4 < arg0.expected_base_policy_count, 3);
        assert!(arg14 == derive_base_policy_row_commitment_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13), 2);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg2, arg5, arg6, arg7);
        let v1 = PhysicalPolicyKeyV8{
            source_kind : 0,
            source_id   : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2),
            part_key    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_part_key_v8(v0),
            item_key    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_item_key_v8(v0),
            style_key   : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_key_v8(v0),
        };
        assert!(!0x2::table::contains<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.base_policies, v1), 6);
        let v2 = PhysicalSourceBindingV8{
            source_kind                   : 0,
            source_id                     : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2),
            source_semantic_id            : 0x1::string::utf8(b""),
            source_content_commitment     : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg1),
            source_treasury_id            : 0x1::option::none<0x2::object::ID>(),
            pack_registry_id              : 0x1::option::none<0x2::object::ID>(),
            pack_registry_revision        : 0,
            registered_pack_owner         : 0x1::option::none<address>(),
            registered_pack_control_epoch : 0,
            registered_pack_admin_cap_id  : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = PhysicalStyleDescriptorV8{
            part_key            : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_part_key_v8(v0),
            item_key            : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_item_key_v8(v0),
            style_key           : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_key_v8(v0),
            layer_track_key     : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_layer_track_key_v8(v0),
            color_channel_key   : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_color_channel_key_v8(v0),
            default_swatch_key  : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_default_swatch_key_v8(v0),
            style_asset_blob_id : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_blob_id_v8(v0),
            style_asset_sha256  : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_sha256_v8(v0),
            style_protected     : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(v0),
        };
        let v4 = PhysicalStylePolicyV8{
            sequence                      : arg4,
            source                        : v2,
            style                         : v3,
            style_payload_commitment      : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v0),
            style_seal_binding_commitment : b"",
            source_style_commitment       : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(v0),
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

    public fun append_base_style_policy_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg5: &PhysicalPackageConfigV8, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>, arg11: u8, arg12: u8, arg13: u64, arg14: u64, arg15: bool, arg16: vector<u8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_config(arg4, arg5);
        assert_registry_identity<T0>(arg0, arg1, arg3, arg5);
        append_base_style_policy<T0>(arg0, arg1, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    fun append_pack_policy_from_witness(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &PhysicalPackageConfigV8, arg3: u64, arg4: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalPackPolicyWitnessV8, arg5: vector<u8>, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::consume_physical_pack_policy_witness_v8<PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(arg4, arg1, &arg2.physical_call_cap);
        assert!(arg0.revision == arg3, 10);
        assert!(v0 == arg0.root_id, 1);
        assert!(v1 == arg0.maker_version, 1);
        assert!(v2 == arg0.root_content_commitment, 1);
        let v26 = PhysicalPolicyKeyV8{
            source_kind : 1,
            source_id   : v5,
            part_key    : v13,
            item_key    : v14,
            style_key   : v15,
        };
        assert!(!0x2::table::contains<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&arg0.pack_policies, v26), 6);
        let v27 = arg3 + 1;
        let v28 = PackPolicyRowCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/pack-policy",
            version                    : 8,
            product_binding_commitment : arg0.product_binding_commitment,
            physical_registry_id       : 0x2::object::id<PhysicalRegistryV8>(arg0),
            root_id                    : v0,
            maker_version              : v1,
            root_content_commitment    : v2,
            registry_revision          : v27,
            pack_registry_id           : v3,
            pack_registry_revision     : v4,
            release_id                 : v5,
            semantic_pack_id           : v6,
            release_content_commitment : v7,
            pack_owner                 : v8,
            pack_control_epoch         : v9,
            pack_admin_cap_id          : v10,
            pack_treasury_id           : v11,
            style_index                : v12,
            style_identity_commitment  : v25,
            material_policy_commitment : arg5,
            issuance_kind              : arg6,
            proof_kind                 : arg7,
            price_atomic               : arg8,
            max_supply                 : arg9,
            transferable               : arg10,
        };
        let v29 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<PackPolicyRowCommitmentInputV8>(&v28));
        let v30 = PhysicalSourceBindingV8{
            source_kind                   : 1,
            source_id                     : v5,
            source_semantic_id            : v6,
            source_content_commitment     : v7,
            source_treasury_id            : 0x1::option::some<0x2::object::ID>(v11),
            pack_registry_id              : 0x1::option::some<0x2::object::ID>(v3),
            pack_registry_revision        : v4,
            registered_pack_owner         : 0x1::option::some<address>(v8),
            registered_pack_control_epoch : v9,
            registered_pack_admin_cap_id  : 0x1::option::some<0x2::object::ID>(v10),
        };
        let v31 = PhysicalStyleDescriptorV8{
            part_key            : v13,
            item_key            : v14,
            style_key           : v15,
            layer_track_key     : v16,
            color_channel_key   : v17,
            default_swatch_key  : v18,
            style_asset_blob_id : v19,
            style_asset_sha256  : v20,
            style_protected     : v22,
        };
        let v32 = PhysicalStylePolicyV8{
            sequence                      : arg0.expected_base_policy_count + arg0.pack_policy_count,
            source                        : v30,
            style                         : v31,
            style_payload_commitment      : v21,
            style_seal_binding_commitment : v23,
            source_style_commitment       : v24,
            style_identity_commitment     : v25,
            material_policy_commitment    : arg5,
            issuance_kind                 : arg6,
            proof_kind                    : arg7,
            price_atomic                  : arg8,
            max_supply                    : arg9,
            transferable                  : arg10,
            issued_count                  : 0,
            consumed_count                : 0,
            row_commitment                : v29,
        };
        0x2::table::add<PhysicalPolicyKeyV8, PhysicalStylePolicyV8>(&mut arg0.pack_policies, v26, v32);
        0x1::vector::push_back<PhysicalPolicyKeyV8>(&mut arg0.pack_policy_keys, v26);
        arg0.pack_policy_count = arg0.pack_policy_count + 1;
        arg0.revision = v27;
        let v33 = PackPhysicalPolicyRegisteredV8{
            root_id                   : v0,
            registry_id               : 0x2::object::id<PhysicalRegistryV8>(arg0),
            registry_revision         : v27,
            pack_registry_id          : v3,
            pack_registry_revision    : v4,
            release_id                : v5,
            pack_treasury_id          : v11,
            style_identity_commitment : v25,
            row_commitment            : v29,
        };
        0x2::event::emit<PackPhysicalPolicyRegisteredV8>(v33);
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

    fun assert_active_registry<T0>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8) {
        assert_config(arg2, arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_active_capability_registry_v8<T0>(arg1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.version == 8, 1);
        assert!(arg0.base_sealed, 8);
        assert!(arg0.rolling_base_policy_commitment == arg0.expected_base_policy_commitment, 2);
        assert!(arg0.catalog_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg2), 1);
        assert!(arg0.package_config_id == 0x2::object::id<PhysicalPackageConfigV8>(arg3), 1);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_catalog_id_v8(v0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg2), 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_base_registry_id_v8(v0) == arg0.base_registry_id, 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_physical_registry_id_v8(v0) == 0x2::object::id<PhysicalRegistryV8>(arg0), 1);
    }

    fun assert_asset_holder(arg0: &PhysicalAssetV8, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 8, 1);
        assert!(arg0.holder == 0x2::tx_context::sender(arg1) && arg0.holder != @0x0, 12);
    }

    fun assert_base_market_source<T0>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &PhysicalAssetV8, arg3: 0x2::object::ID) {
        assert!(arg2.source.source_kind == 0, 21);
        assert!(arg2.source.source_id == arg0.base_registry_id, 1);
        assert!(arg2.source.source_semantic_id == 0x1::string::utf8(b""), 1);
        assert!(&arg2.source.source_content_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg1), 2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
        assert!(arg3 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_treasury_id_v8<T0>(arg1), 17);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.pack_registry_id), 1);
        assert!(0x1::option::is_none<address>(&arg2.source.registered_pack_owner), 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg2.source.registered_pack_admin_cap_id), 1);
    }

    fun assert_base_registry<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_base_registry_identity_v8<T0>(arg0, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg1), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_id_v8(arg1), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_maker_version_v8(arg1), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_root_content_commitment_v8(arg1));
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_sealed_v8(arg1), 9);
    }

    fun assert_complete_binding<T0>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalCompleteBindingV8, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_root_id_v8(arg2) == arg0.root_id, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_maker_version_v8(arg2) == arg0.maker_version, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_root_content_commitment_v8(arg2) == &arg0.root_content_commitment, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_holder_v8(arg2) == 0x2::tx_context::sender(arg3) && 0x2::tx_context::sender(arg3) != @0x0, 12);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_root_id_v8(arg2), 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_maker_version_v8(arg2), 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_root_content_commitment_v8(arg2));
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_output_registry_id_v8(v0) == 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_output_registry_id_v8(arg2), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_soul_registry_id_v8(v0)
    }

    fun assert_config(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg1: &PhysicalPackageConfigV8) {
        assert_config_binding(arg0, arg1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::physical_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg0)));
    }

    fun assert_config_binding(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg1: &PhysicalPackageConfigV8) {
        assert!(arg1.version == 8, 0);
        assert!(arg1.catalog_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg0), 0);
        assert!(&arg1.product_binding_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg0)), 0);
        assert!(&arg1.call_cap_set_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_set_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg0)), 0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_physical_call_cap_v8(arg0, &arg1.physical_call_cap);
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

    fun assert_market_asset_registry_binding<T0>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &PhysicalAssetV8) {
        assert!(arg2.version == 8, 1);
        assert!(arg2.registry_id == 0x2::object::id<PhysicalRegistryV8>(arg0), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, arg2.root_id, arg2.maker_version, &arg2.root_content_commitment);
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

    fun assert_market_authority<T0, T1, T2, T3: key, T4: key>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg3: &T3, arg4: &T4) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_market_call_cap_v8(arg1, arg2);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg1);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::market_binding_v8(v0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T1, T2>(v1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_original_v8<T3>(v1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_original_v8<T4>(v1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_catalog_id_v8<T0>(arg0) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg1), 20);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_binding_v8<T0>(arg0)) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(v0), 20);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_same_call_cap_set_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_call_cap_set_v8<T0>(arg0), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg1));
        let v2 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg0);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_catalog_id_v8(v2) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg1), 20);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_same_call_cap_set_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_call_cap_set_v8(v2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg1));
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_market_registry_id_v8(v2) == 0x2::object::id<T3>(arg3), 20);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_market_treasury_id_v8(v2) == 0x2::object::id<T4>(arg4), 20);
    }

    fun assert_market_custody_asset<T0>(arg0: &PhysicalMarketCustodyBindingV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &PhysicalAssetV8) {
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
            assert!(arg0.source_treasury_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_treasury_id_v8<T0>(arg1), 17);
        } else {
            assert!(arg2.source.source_kind == 1, 21);
            assert!(0x1::option::is_some<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
            assert!(arg0.source_treasury_id == *0x1::option::borrow<0x2::object::ID>(&arg2.source.source_treasury_id), 17);
        };
    }

    fun assert_market_custody_current<T0, T1, T2, T3: key, T4: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg6: &T3, arg7: &T4) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_catalog_current_v8(arg2, arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg1, arg2);
        assert_active_registry<T0>(arg0, arg1, arg3, arg4);
        assert_market_authority<T0, T1, T2, T3, T4>(arg1, arg3, arg5, arg6, arg7);
        assert!(arg0.product_binding_commitment == *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_binding_v8<T0>(arg1)), 20);
        assert!(arg0.call_cap_set_commitment == *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_set_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_call_cap_set_v8<T0>(arg1)), 20);
    }

    fun assert_market_custody_live_binding<T0, T1: key, T2: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg4: &T1, arg5: &T2, arg6: &0x2::object::UID, arg7: &PhysicalMarketCustodyBindingV8) {
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg2);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg2);
        let v2 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg1);
        assert!(arg7.version == 8, 21);
        assert!(arg7.catalog_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg2), 21);
        assert!(&arg7.product_binding_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(v0), 21);
        assert!(&arg7.call_cap_set_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_set_commitment_v8(v1), 21);
        assert!(arg7.market_authority_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_authority_id_v8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>(arg3), 21);
        assert!(arg7.market_registry_id == 0x2::object::id<T1>(arg4), 21);
        assert!(arg7.market_treasury_id == 0x2::object::id<T2>(arg5), 21);
        assert!(arg7.listing_id == 0x2::object::uid_to_inner(arg6), 21);
        assert!(arg7.physical_package_config_id == arg0.package_config_id, 21);
        assert!(arg7.physical_registry_id == 0x2::object::id<PhysicalRegistryV8>(arg0), 21);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_physical_registry_id_v8(v2) == 0x2::object::id<PhysicalRegistryV8>(arg0), 20);
        assert!(arg7.root_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg1), 21);
        assert!(arg7.maker_version == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg1), 21);
        assert!(&arg7.root_content_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg1), 21);
        assert!(arg7.transferable, 16);
        assert_hash(&arg7.asset_content_commitment);
        assert_hash(&arg7.source_content_commitment);
        assert_hash(&arg7.provenance_commitment);
    }

    fun assert_output_pack_selection_matches(arg0: &0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalSelectionBindingV8, arg1: &PhysicalPackAccessBindingV8) {
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_class_v8(arg0) == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::source_pack_v8(), 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_loadout_id_v8(arg0) == arg1.loadout_id, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_loadout_revision_v8(arg0) == arg1.loadout_revision, 10);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_loadout_commitment_v8(arg0) == &arg1.loadout_commitment, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_index_v8(arg0) == arg1.selection_index, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_commitment_v8(arg0) == &arg1.selection_commitment, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_definition_id_v8(arg0) == arg1.release_id, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_semantic_id_v8(arg0) == &arg1.semantic_pack_id, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_content_commitment_v8(arg0) == &arg1.release_content_commitment, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_epoch_v8(arg0) == 0, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_pricing_commitment_v8(arg0) == &arg1.pricing_commitment, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_part_key_v8(arg0) == &arg1.part_key, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_item_key_v8(arg0) == &arg1.item_key, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_style_key_v8(arg0) == &arg1.style_key, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_layer_track_key_v8(arg0) == &arg1.layer_track_key, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_asset_content_commitment_v8(arg0) == &arg1.asset_content_commitment, 1);
    }

    fun assert_output_selection_current(arg0: &0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalCompleteBindingV8, arg1: &0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalSelectionBindingV8, arg2: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8) {
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_loadout_id_v8(arg1) == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_id_v8(arg2), 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_loadout_revision_v8(arg1) == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_revision_v8(arg2), 10);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_loadout_commitment_v8(arg1) == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_commitment_v8(arg2), 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_holder_v8(arg0) != @0x0, 12);
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
        assert!(arg0.source_class == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::source_pack_v8(), 1);
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

    fun assert_registry_identity<T0>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: &PhysicalPackageConfigV8) {
        assert!(arg0.version == 8, 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert_base_registry<T0>(arg1, arg2);
        assert!(arg0.base_registry_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg2), 1);
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
        assert!(arg1.source_class == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::source_base_v8(), 1);
        assert!(arg1.source_definition_id == arg0.root_id, 1);
        assert!(0x1::string::is_empty(&arg1.source_semantic_id), 1);
        assert!(arg1.source_content_commitment == arg0.root_content_commitment, 1);
        assert!(arg1.source_epoch == 0, 1);
        let v0 = borrow_base_policy_by_keys(arg0, arg1.part_key, arg1.item_key, arg1.style_key);
        assert!(v0.style.layer_track_key == arg1.layer_track_key, 1);
        assert!(v0.style_payload_commitment == arg1.asset_content_commitment, 1);
        v0
    }

    public fun borrow_base_policy_v8(arg0: &PhysicalRegistryV8, arg1: &0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalSelectionBindingV8) : &PhysicalStylePolicyV8 {
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_class_v8(arg1) == 0, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_definition_id_v8(arg1) == arg0.root_id, 1);
        assert!(0x1::string::is_empty(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_semantic_id_v8(arg1)), 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_content_commitment_v8(arg1) == &arg0.root_content_commitment, 1);
        assert!(0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_source_epoch_v8(arg1) == 0, 1);
        let v0 = borrow_base_policy_by_keys(arg0, *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_part_key_v8(arg1), *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_item_key_v8(arg1), *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_style_key_v8(arg1));
        assert!(&v0.style.layer_track_key == 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_layer_track_key_v8(arg1), 1);
        assert!(&v0.style_payload_commitment == 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_asset_content_commitment_v8(arg1), 1);
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

    fun certify_pack_access<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &PhysicalPackageConfigV8, arg3: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg4: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg6: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackPassV8, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg8: u64, arg9: &0x2::tx_context::TxContext) : PhysicalPackAccessBindingV8 {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::consume_physical_pack_access_witness_v8<PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::new_physical_pack_access_witness_v8<T0, PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(arg0, arg1, &arg2.physical_call_cap, arg3, arg4, arg5, arg6, arg7, arg8, arg9), arg1, &arg2.physical_call_cap);
        PhysicalPackAccessBindingV8{
            root_id                    : v0,
            maker_version              : v1,
            root_content_commitment    : v2,
            holder                     : v3,
            pack_registry_id           : v4,
            pack_registry_revision     : v5,
            release_id                 : v6,
            semantic_pack_id           : v7,
            release_content_commitment : v8,
            pack_treasury_id           : v9,
            pack_pass_id               : v10,
            pack_pass_commitment       : v11,
            loadout_id                 : v12,
            loadout_revision           : v13,
            loadout_commitment         : v14,
            selection_index            : v15,
            selection_commitment       : v16,
            pricing_commitment         : v17,
            part_key                   : v18,
            item_key                   : v19,
            style_key                  : v20,
            layer_track_key            : v21,
            asset_content_commitment   : v22,
            style_identity_commitment  : v23,
        }
    }

    public fun certify_physical_activation_readiness_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: &PhysicalRegistryV8) : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::activation_v8::PhysicalReadinessV8 {
        assert_config(arg2, arg3);
        assert_registry_identity<T0>(arg4, arg0, arg1, arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_v8<T0>(arg0);
        assert_activation_ready(arg4);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::activation_v8::certify_physical_readiness_v8<T0, PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8, PhysicalRegistryV8>(arg0, arg2, &arg3.physical_call_cap, arg4, derive_readiness_commitment(arg4))
    }

    public fun claim_free_base_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_active_registry<T0>(arg0, arg1, arg2, arg3);
        let v0 = consume_runtime_selection(arg4, arg5, arg7);
        assert_selection_root(arg0, &v0, arg7);
        let v1 = *borrow_base_policy_by_selection(arg0, &v0);
        assert!(v1.issuance_kind == 0, 18);
        let v2 = derive_authorization_key(b"animacraft-v8/physical/free-claim", arg0, &v1, v0.holder, v1.source.source_id, b"");
        issue_asset(arg0, v1, v0.holder, arg6, v2, 0x1::option::none<PhysicalProofProvenanceV8>(), arg7)
    }

    public fun claim_free_pack_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg6: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackPassV8, arg8: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_active_registry<T0>(arg0, arg1, arg2, arg3);
        let v0 = consume_runtime_selection(arg8, arg9, arg11);
        assert_selection_root(arg0, &v0, arg11);
        let v1 = certify_pack_access<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, v0.selection_index, arg11);
        assert_pack_selection_matches(&v0, &v1);
        let v2 = *borrow_pack_policy_by_access(arg0, &v1);
        assert!(v2.issuance_kind == 0, 18);
        let v3 = derive_authorization_key(b"animacraft-v8/physical/free-claim", arg0, &v2, v0.holder, v2.source.source_id, b"");
        issue_asset(arg0, v2, v0.holder, arg10, v3, 0x1::option::none<PhysicalProofProvenanceV8>(), arg11)
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

    fun consume_runtime_selection(arg0: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg1: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg2: &0x2::tx_context::TxContext) : PhysicalSelectionEvidenceV8 {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::consume_physical_selection_witness_v8(arg0, arg1, arg2);
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

    public fun custody_base_physical_for_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg6: &T3, arg7: &T4, arg8: &mut 0x2::object::UID, arg9: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg10: PhysicalAssetV8, arg11: &0x2::tx_context::TxContext) : PhysicalMarketCustodyTicketV8 {
        assert_market_custody_current<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_treasury_v8<T0>(arg1, arg9);
        assert_asset_holder(&arg10, arg11);
        assert!(arg10.transferable, 16);
        assert_market_asset_registry_binding<T0>(arg0, arg1, &arg10);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_treasury_id_v8<T0>(arg9);
        assert_base_market_source<T0>(arg0, arg1, &arg10, v0);
        custody_physical_for_market<T3, T4>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg10, v0)
    }

    public fun custody_pack_physical_for_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg6: &T3, arg7: &T4, arg8: &mut 0x2::object::UID, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg10: PhysicalAssetV8, arg11: &0x2::tx_context::TxContext) : PhysicalMarketCustodyTicketV8 {
        assert_market_custody_current<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert_asset_holder(&arg10, arg11);
        assert!(arg10.transferable, 16);
        assert_market_asset_registry_binding<T0>(arg0, arg1, &arg10);
        let v0 = 0x2::object::id<0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>>(arg9);
        assert_pack_market_source(&arg10, v0);
        custody_physical_for_market<T3, T4>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg10, v0)
    }

    fun custody_physical_for_market<T0: key, T1: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &PhysicalPackageConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg4: &T0, arg5: &T1, arg6: &mut 0x2::object::UID, arg7: PhysicalAssetV8, arg8: 0x2::object::ID) : PhysicalMarketCustodyTicketV8 {
        let v0 = new_physical_market_custody_binding<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, &arg7, arg8);
        let v1 = v0.listing_id;
        let v2 = PhysicalMarketCustodyTransitionV8{
            action                   : 0,
            listing_id               : v1,
            asset_id                 : v0.asset_id,
            source_kind              : v0.source_kind,
            source_treasury_id       : arg8,
            previous_holder          : v0.holder,
            holder                   : v0.holder,
            previous_ownership_epoch : v0.ownership_epoch,
            ownership_epoch          : v0.ownership_epoch,
            provenance_commitment    : v0.provenance_commitment,
        };
        0x2::event::emit<PhysicalMarketCustodyTransitionV8>(v2);
        0x2::transfer::transfer<PhysicalAssetV8>(arg7, 0x2::object::id_to_address(&v1));
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

    public fun derive_base_policy_row_commitment_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PhysicalPackageConfigV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u8, arg9: u8, arg10: u64, arg11: u64, arg12: bool) : vector<u8> {
        assert_base_registry<T0>(arg0, arg1);
        assert_hash(&arg7);
        assert_policy_terms(arg8, arg9, arg10, arg11);
        let v0 = BasePolicyRowCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/base-policy",
            version                    : 8,
            product_binding_commitment : arg2.product_binding_commitment,
            root_id                    : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg1),
            sequence                   : arg3,
            style_identity_commitment  : derive_style_identity<T0>(arg0, arg1, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg1, arg4, arg5, arg6)),
            material_policy_commitment : arg7,
            issuance_kind              : arg8,
            proof_kind                 : arg9,
            price_atomic               : arg10,
            max_supply                 : arg11,
            transferable               : arg12,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BasePolicyRowCommitmentInputV8>(&v0))
    }

    public fun derive_base_style_identity_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) : vector<u8> {
        assert_base_registry<T0>(arg0, arg1);
        derive_style_identity<T0>(arg0, arg1, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::borrow_style_v8(arg1, arg2, arg3, arg4))
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

    fun derive_style_identity<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::StyleRowV8) : vector<u8> {
        let v0 = BaseStyleIdentityInputV8{
            domain                  : b"animacraft-v8/physical/base-style",
            version                 : 8,
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id        : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg1),
            part_key                : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_part_key_v8(arg2),
            item_key                : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_item_key_v8(arg2),
            style_key               : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_key_v8(arg2),
            layer_track_key         : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_layer_track_key_v8(arg2),
            color_channel_key       : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_color_channel_key_v8(arg2),
            default_swatch_key      : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_default_swatch_key_v8(arg2),
            asset_blob_id           : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_blob_id_v8(arg2),
            asset_sha256            : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_asset_sha256_v8(arg2),
            protected               : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_protected_v8(arg2),
            payload_commitment      : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::style_payload_commitment_v8(arg2),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BaseStyleIdentityInputV8>(&v0))
    }

    public fun empty_base_policy_commitment_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PhysicalPackageConfigV8) : vector<u8> {
        assert_base_registry<T0>(arg0, arg1);
        let v0 = EmptyBasePolicyCommitmentInputV8{
            domain                     : b"animacraft-v8/physical/base-empty",
            version                    : 8,
            product_binding_commitment : arg2.product_binding_commitment,
            root_id                    : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg1),
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

    public fun materialize_base_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalMaterializationWitnessV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_active_registry<T0>(arg0, arg1, arg2, arg3);
        let (v0, v1, v2, v3) = 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::consume_physical_materialization_witness_v8<PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(arg4, arg2, &arg3.physical_call_cap);
        let v4 = v1;
        let v5 = v0;
        assert_output_selection_current(&v5, &v4, arg5);
        let v6 = *borrow_base_policy_v8(arg0, &v4);
        assert!(v6.issuance_kind == 2, 18);
        let v7 = proof_provenance(&v5, assert_complete_binding<T0>(arg0, arg1, &v5, arg7), v2, v3);
        let v8 = derive_authorization_key(b"animacraft-v8/physical/proof-materialize", arg0, &v6, @0x0, 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_soul_id_v8(&v5), v7.soul_commitment);
        issue_asset(arg0, v6, 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_holder_v8(&v5), arg6, v8, 0x1::option::some<PhysicalProofProvenanceV8>(v7), arg7)
    }

    public fun materialize_pack_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg6: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackPassV8, arg8: 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalMaterializationWitnessV8, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_active_registry<T0>(arg0, arg1, arg2, arg3);
        let (v0, v1, v2, v3) = 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::consume_physical_materialization_witness_v8<PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(arg8, arg2, &arg3.physical_call_cap);
        let v4 = v1;
        let v5 = v0;
        assert_output_selection_current(&v5, &v4, arg9);
        let v6 = certify_pack_access<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_selection_index_v8(&v4), arg11);
        assert_output_pack_selection_matches(&v4, &v6);
        let v7 = *borrow_pack_policy_by_access(arg0, &v6);
        assert!(v7.issuance_kind == 2, 18);
        let v8 = proof_provenance(&v5, assert_complete_binding<T0>(arg0, arg1, &v5, arg11), v2, v3);
        let v9 = derive_authorization_key(b"animacraft-v8/physical/proof-materialize", arg0, &v7, @0x0, 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_soul_id_v8(&v5), v8.soul_commitment);
        issue_asset(arg0, v7, 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_holder_v8(&v5), arg10, v9, 0x1::option::some<PhysicalProofProvenanceV8>(v8), arg11)
    }

    fun new_physical_market_custody_binding<T0: key, T1: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &PhysicalPackageConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg4: &T0, arg5: &T1, arg6: &0x2::object::UID, arg7: &PhysicalAssetV8, arg8: 0x2::object::ID) : PhysicalMarketCustodyBindingV8 {
        PhysicalMarketCustodyBindingV8{
            version                    : 8,
            catalog_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg1),
            product_binding_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg1)),
            call_cap_set_commitment    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_set_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg1)),
            market_authority_id        : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_authority_id_v8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>(arg3),
            market_registry_id         : 0x2::object::id<T0>(arg4),
            market_treasury_id         : 0x2::object::id<T1>(arg5),
            listing_id                 : 0x2::object::uid_to_inner(arg6),
            physical_package_config_id : 0x2::object::id<PhysicalPackageConfigV8>(arg2),
            physical_registry_id       : 0x2::object::id<PhysicalRegistryV8>(arg0),
            root_id                    : arg7.root_id,
            maker_version              : arg7.maker_version,
            root_content_commitment    : arg7.root_content_commitment,
            asset_id                   : 0x2::object::id<PhysicalAssetV8>(arg7),
            asset_content_commitment   : arg7.asset_content_commitment,
            source_kind                : arg7.source.source_kind,
            source_id                  : arg7.source.source_id,
            source_semantic_id         : arg7.source.source_semantic_id,
            source_content_commitment  : arg7.source.source_content_commitment,
            source_treasury_id         : arg8,
            holder                     : arg7.holder,
            ownership_epoch            : arg7.ownership_epoch,
            transferable               : arg7.transferable,
            provenance_commitment      : arg7.provenance_commitment,
        }
    }

    public fun new_physical_package_config_v8(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg1: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : PhysicalPackageConfigV8 {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_physical_call_cap_v8(arg0, &arg1);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::physical_binding_v8(v0));
        PhysicalPackageConfigV8{
            id                         : 0x2::object::new(arg2),
            version                    : 8,
            catalog_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg0),
            product_binding_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(v0),
            call_cap_set_commitment    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::call_cap_set_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg0)),
            physical_call_cap          : arg1,
        }
    }

    public fun new_physical_registry_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : PhysicalRegistryV8 {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_config(arg3, arg4);
        assert_base_registry<T0>(arg0, arg2);
        new_registry<T0>(arg0, arg2, arg4, arg5, arg6, arg7)
    }

    fun new_registry<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg2: &PhysicalPackageConfigV8, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : PhysicalRegistryV8 {
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
            root_id                         : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version                   : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment         : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            base_registry_id                : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::registry_id_v8(arg1),
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

    fun proof_provenance(arg0: &0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::PhysicalCompleteBindingV8, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: vector<u8>) : PhysicalProofProvenanceV8 {
        assert_hash(&arg3);
        PhysicalProofProvenanceV8{
            output_registry_id       : 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_output_registry_id_v8(arg0),
            soul_registry_id         : arg1,
            output_key               : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_output_key_v8(arg0),
            output_policy_commitment : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_policy_commitment_v8(arg0),
            output_id                : 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_output_id_v8(arg0),
            receipt_id               : 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_receipt_id_v8(arg0),
            soul_id                  : 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_soul_id_v8(arg0),
            soul_ownership_epoch     : 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_soul_epoch_v8(arg0),
            recipe_commitment        : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_recipe_commitment_v8(arg0),
            render_commitment        : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_render_commitment_v8(arg0),
            output_commitment        : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_output_commitment_v8(arg0),
            receipt_commitment       : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_receipt_commitment_v8(arg0),
            soul_commitment          : *0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8::physical_complete_soul_commitment_v8(arg0),
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

    public fun purchase_base_physical_from_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg6: &T3, arg7: &T4, arg8: &mut 0x2::object::UID, arg9: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg10: 0x2::transfer::Receiving<PhysicalAssetV8>, arg11: &PhysicalMarketCustodyBindingV8, arg12: &0x2::tx_context::TxContext) {
        assert_market_custody_current<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_treasury_v8<T0>(arg1, arg9);
        assert_market_custody_live_binding<T0, T3, T4>(arg0, arg1, arg3, arg5, arg6, arg7, arg8, arg11);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::maker_treasury_id_v8<T0>(arg9);
        assert!(arg11.source_kind == 0, 21);
        assert!(arg11.source_treasury_id == v0, 17);
        let v1 = receive_and_assert_market_asset<T0>(arg0, arg1, arg8, arg10, arg11);
        assert_base_market_source<T0>(arg0, arg1, &v1, v0);
        purchase_received_market_asset(v1, arg11, arg12);
    }

    public fun purchase_base_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg5: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg7: 0x2::coin::Coin<T0>, arg8: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_active_registry<T0>(arg0, arg1, arg2, arg3);
        let v0 = consume_runtime_selection(arg8, arg9, arg11);
        assert_selection_root(arg0, &v0, arg11);
        let v1 = *borrow_base_policy_by_selection(arg0, &v0);
        assert!(v1.issuance_kind == 1, 18);
        let v2 = derive_authorization_key(b"animacraft-v8/physical/paid-purchase", arg0, &v1, v0.holder, 0x2::object::id<0x2::coin::Coin<T0>>(&arg7), b"");
        assert_issue_available(arg0, &v1, arg10, &v2);
        let (v3, v4) = settle_base_payment<T0>(arg0, arg1, arg4, arg5, arg6, v1.price_atomic, arg7, arg11);
        assert!(v3 + v4 == v1.price_atomic, 13);
        issue_asset(arg0, v1, v0.holder, arg10, v2, 0x1::option::none<PhysicalProofProvenanceV8>(), arg11)
    }

    public fun purchase_pack_physical_from_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg6: &T3, arg7: &T4, arg8: &mut 0x2::object::UID, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg10: 0x2::transfer::Receiving<PhysicalAssetV8>, arg11: &PhysicalMarketCustodyBindingV8, arg12: &0x2::tx_context::TxContext) {
        assert_market_custody_current<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        assert_market_custody_live_binding<T0, T3, T4>(arg0, arg1, arg3, arg5, arg6, arg7, arg8, arg11);
        let v0 = 0x2::object::id<0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>>(arg9);
        assert!(arg11.source_kind == 1, 21);
        assert!(arg11.source_treasury_id == v0, 17);
        let v1 = receive_and_assert_market_asset<T0>(arg0, arg1, arg8, arg10, arg11);
        assert_pack_market_source(&v1, v0);
        purchase_received_market_asset(v1, arg11, arg12);
    }

    public fun purchase_pack_style_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &PhysicalPackageConfigV8, arg4: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg6: &mut 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackPassV8, arg8: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg9: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg10: 0x2::coin::Coin<T0>, arg11: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg12: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) : PhysicalAssetV8 {
        assert_active_registry<T0>(arg0, arg1, arg2, arg3);
        let v0 = consume_runtime_selection(arg11, arg12, arg14);
        assert_selection_root(arg0, &v0, arg14);
        let v1 = certify_pack_access<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12, v0.selection_index, arg14);
        assert_pack_selection_matches(&v0, &v1);
        let v2 = *borrow_pack_policy_by_access(arg0, &v1);
        assert!(v2.issuance_kind == 1, 18);
        let v3 = derive_authorization_key(b"animacraft-v8/physical/paid-purchase", arg0, &v2, v0.holder, 0x2::object::id<0x2::coin::Coin<T0>>(&arg10), b"");
        assert_issue_available(arg0, &v2, arg13, &v3);
        let (v4, v5) = settle_pack_payment<T0>(arg0, arg1, arg5, arg6, arg8, arg9, v2.price_atomic, arg10, arg14);
        assert!(v4 + v5 == v2.price_atomic, 13);
        issue_asset(arg0, v2, v0.holder, arg13, v3, 0x1::option::none<PhysicalProofProvenanceV8>(), arg14)
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

    fun receive_and_assert_market_asset<T0>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &mut 0x2::object::UID, arg3: 0x2::transfer::Receiving<PhysicalAssetV8>, arg4: &PhysicalMarketCustodyBindingV8) : PhysicalAssetV8 {
        assert!(0x2::transfer::receiving_object_id<PhysicalAssetV8>(&arg3) == arg4.asset_id, 21);
        let v0 = 0x2::transfer::receive<PhysicalAssetV8>(arg2, arg3);
        assert_market_asset_registry_binding<T0>(arg0, arg1, &v0);
        assert_market_custody_asset<T0>(arg4, arg1, &v0);
        v0
    }

    public fun register_pack_style_policy_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &PhysicalPackageConfigV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg6: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackAdminCapV8, arg8: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: vector<u8>, arg14: u8, arg15: u8, arg16: u64, arg17: u64, arg18: bool, arg19: &0x2::tx_context::TxContext) {
        assert_active_registry<T0>(arg0, arg1, arg3, arg4);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_admin_v8<T0>(arg1, arg2);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_owner_v8<T0>(arg1) == 0x2::tx_context::sender(arg19), 12);
        assert!(arg0.revision == arg9, 10);
        assert!(arg0.observed_base_policy_count + arg0.pack_policy_count < 10000, 3);
        assert_hash(&arg13);
        assert_policy_terms(arg14, arg15, arg16, arg17);
        append_pack_policy_from_witness(arg0, arg3, arg4, arg9, 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::new_physical_pack_policy_witness_v8<T0, PhysicalOriginalMarkerV8, PhysicalCallableMarkerV8>(arg1, arg3, &arg4.physical_call_cap, arg5, arg6, arg7, arg8, arg10, arg11, arg12, arg19), arg13, arg14, arg15, arg16, arg17, arg18);
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

    public fun return_physical_from_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: &PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg4: &T3, arg5: &T4, arg6: &mut 0x2::object::UID, arg7: 0x2::transfer::Receiving<PhysicalAssetV8>, arg8: &PhysicalMarketCustodyBindingV8) {
        assert_market_authority<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg5);
        assert_market_custody_live_binding<T0, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
        let v0 = receive_and_assert_market_asset<T0>(arg0, arg1, arg6, arg7, arg8);
        let v1 = v0.holder;
        let v2 = v0.ownership_epoch;
        let v3 = PhysicalMarketCustodyTransitionV8{
            action                   : 1,
            listing_id               : arg8.listing_id,
            asset_id                 : 0x2::object::id<PhysicalAssetV8>(&v0),
            source_kind              : v0.source.source_kind,
            source_treasury_id       : arg8.source_treasury_id,
            previous_holder          : v1,
            holder                   : v1,
            previous_ownership_epoch : v2,
            ownership_epoch          : v2,
            provenance_commitment    : v0.provenance_commitment,
        };
        0x2::event::emit<PhysicalMarketCustodyTransitionV8>(v3);
        0x2::transfer::transfer<PhysicalAssetV8>(v0, v1);
    }

    public fun seal_physical_registry_v8<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::base_registry_v8::BaseDefinitionRegistryV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg5: &PhysicalPackageConfigV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
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

    fun settle_base_payment<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg3: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg4: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg1, arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_treasury_v8<T0>(arg1, arg4);
        assert!(0x2::coin::value<T0>(&arg6) == arg5 && arg5 > 0, 13);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg1);
        let v1 = protocol_share(arg5, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v0));
        let v2 = arg5 - v1;
        if (v1 > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg2, arg3, 0x2::coin::split<T0>(&mut arg6, v1, arg7));
        };
        assert!(0x2::coin::value<T0>(&arg6) == v2 && v2 > 0, 13);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::deposit_maker_revenue_v8<T0>(arg1, arg4, arg2, arg6);
        arg0.gross_paid_atomic = arg0.gross_paid_atomic + (arg5 as u128);
        arg0.protocol_paid_atomic = arg0.protocol_paid_atomic + (v1 as u128);
        arg0.maker_paid_atomic = arg0.maker_paid_atomic + (v2 as u128);
        (v1, v2)
    }

    fun settle_pack_payment<T0>(arg0: &mut PhysicalRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg3: &mut 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg5: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg1, arg4);
        assert!(0x2::coin::value<T0>(&arg7) == arg6 && arg6 > 0, 13);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg1);
        let v1 = protocol_share(arg6, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v0));
        let v2 = arg6 - v1;
        if (v1 > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg4, arg5, 0x2::coin::split<T0>(&mut arg7, v1, arg8));
        };
        assert!(0x2::coin::value<T0>(&arg7) == v2 && v2 > 0, 13);
        0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::deposit_pack_revenue_v8<T0>(arg2, arg3, arg7);
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

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

