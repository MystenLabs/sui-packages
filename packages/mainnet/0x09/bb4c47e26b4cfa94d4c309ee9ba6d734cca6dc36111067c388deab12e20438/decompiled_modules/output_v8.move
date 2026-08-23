module 0x9bb4c47e26b4cfa94d4c309ee9ba6d734cca6dc36111067c388deab12e20438::output_v8 {
    struct OutputOriginalMarkerV8 has drop {
        dummy_field: bool,
    }

    struct OutputCallableMarkerV8 has drop {
        dummy_field: bool,
    }

    struct OutputPackageConfigV8 has key {
        id: 0x2::object::UID,
        version: u64,
        catalog_id: 0x2::object::ID,
        product_binding_commitment: vector<u8>,
        output_call_cap: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::OutputRoleV8>,
    }

    struct WalletKeyV8 has copy, drop, store {
        holder: address,
    }

    struct MaterializationKeyV8 has copy, drop, store {
        soul_id: 0x2::object::ID,
        materialization_key: 0x1::string::String,
    }

    struct OutputPolicyKeyV8 has copy, drop, store {
        output_key: 0x1::string::String,
    }

    struct OutputPolicyRowV8 has copy, drop, store {
        sequence: u64,
        output_key: 0x1::string::String,
        protected_output: bool,
        complete_scope_key: 0x1::string::String,
        renderer_schema_commitment: vector<u8>,
        allowed_pack_policy: u8,
        allowed_semantic_pack_ids: vector<0x1::string::String>,
        row_commitment: vector<u8>,
    }

    struct OutputRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        soul_registry_id: 0x2::object::ID,
        expected_output_count: u64,
        observed_output_count: u64,
        expected_policy_commitment: vector<u8>,
        rolling_policy_commitment: vector<u8>,
        sealed: bool,
        policy_rows: 0x2::table::Table<OutputPolicyKeyV8, OutputPolicyRowV8>,
        policy_keys: vector<OutputPolicyKeyV8>,
        total_complete_count: u64,
        complete_by_wallet: 0x2::table::Table<WalletKeyV8, u64>,
        wallet_keys: vector<WalletKeyV8>,
        output_count: u64,
        outputs: 0x2::table::Table<0x2::object::ID, OutputRecordV8>,
        output_keys: vector<0x2::object::ID>,
        materialization_count: u64,
        materializations: 0x2::table::Table<MaterializationKeyV8, vector<u8>>,
        materialization_keys: vector<MaterializationKeyV8>,
    }

    struct SoulRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_registry_id: 0x2::object::ID,
        soul_count: u64,
        souls: 0x2::table::Table<0x2::object::ID, SoulRecordV8>,
        soul_keys: vector<0x2::object::ID>,
    }

    struct BaseCompleteLineV8 has copy, drop, store {
        ordinal: u64,
        base_gross_atomic: u64,
        base_protocol_atomic: u64,
        maker_atomic: u64,
        fixed_protocol_atomic: u64,
        total_atomic: u64,
    }

    struct PackPaymentLineV8 has copy, drop, store {
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        ordinal: u64,
        gross_atomic: u64,
        protocol_atomic: u64,
        pack_atomic: u64,
    }

    struct DerivedPackBindingV8 has copy, drop, store {
        release_id: 0x2::object::ID,
        semantic_pack_id: 0x1::string::String,
        release_content_commitment: vector<u8>,
        pricing_commitment: vector<u8>,
    }

    struct OutputRecordV8 has copy, drop, store {
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        output_key: 0x1::string::String,
        output_policy_commitment: vector<u8>,
        holder: address,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        protected: bool,
        seal_id: 0x1::option::Option<vector<u8>>,
    }

    struct SoulRecordV8 has copy, drop, store {
        soul_id: 0x2::object::ID,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        holder: address,
        ownership_epoch: u64,
        soul_commitment: vector<u8>,
    }

    struct CompleteSessionV8 {
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_key: 0x1::string::String,
        holder: address,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        authorization: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimeLoadoutAuthorizationV8,
        base_line: BaseCompleteLineV8,
        pack_lines: vector<PackPaymentLineV8>,
        total_paid_atomic: u128,
    }

    struct CompleteOutputV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_registry_id: 0x2::object::ID,
        output_key: 0x1::string::String,
        original_holder: address,
        holder: address,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        output_policy_commitment: vector<u8>,
        renderer_schema_commitment: vector<u8>,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        render_blob_id: 0x1::string::String,
        render_sha256: vector<u8>,
        render_blob_commitment: vector<u8>,
        output_commitment: vector<u8>,
        protected: bool,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: 0x1::option::Option<vector<u8>>,
        protection_binding_commitment: vector<u8>,
    }

    struct CompleteReceiptV8 has key {
        id: 0x2::object::UID,
        version: u64,
        output_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_key: 0x1::string::String,
        original_holder: address,
        holder: address,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        output_policy_commitment: vector<u8>,
        renderer_schema_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        base_line: BaseCompleteLineV8,
        pack_lines: vector<PackPaymentLineV8>,
        total_paid_atomic: u128,
        receipt_commitment: vector<u8>,
        protected: bool,
        seal_id: 0x1::option::Option<vector<u8>>,
    }

    struct ProtectedCompletePendingV8 {
        output: CompleteOutputV8,
        receipt: CompleteReceiptV8,
    }

    struct SoulMintAuthorizationV8 {
        output: CompleteOutputV8,
        receipt: CompleteReceiptV8,
        authorization_commitment: vector<u8>,
    }

    struct CanonicalSoulV8 has key {
        id: 0x2::object::UID,
        version: u64,
        soul_registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_key: 0x1::string::String,
        output_policy_commitment: vector<u8>,
        holder: address,
        ownership_epoch: u64,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        soul_creator_royalty_bps: u16,
        maker_source_royalty_bps: u16,
        soul_commitment: vector<u8>,
    }

    struct SoulMarketCustodyBindingV8 has copy, drop, store {
        listing_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        market_registry_id: 0x2::object::ID,
        market_treasury_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        soul_commitment: vector<u8>,
        seller: address,
        expected_soul_ownership_epoch: u64,
    }

    struct SoulMarketCustodyTicketV8 {
        binding: SoulMarketCustodyBindingV8,
    }

    struct PhysicalMaterializationWitnessV8 {
        complete: PhysicalCompleteBindingV8,
        selection: PhysicalSelectionBindingV8,
        materialization_key: 0x1::string::String,
        witness_commitment: vector<u8>,
    }

    struct PhysicalCompleteBindingV8 has copy, drop, store {
        output_registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        holder: address,
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
    }

    struct PhysicalSelectionBindingV8 has copy, drop, store {
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_index: u64,
        selection_commitment: vector<u8>,
        source_class: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        source_definition_id: 0x2::object::ID,
        source_semantic_id: 0x1::string::String,
        source_content_commitment: vector<u8>,
        source_epoch: u64,
        pricing_commitment: vector<u8>,
        asset_content_commitment: vector<u8>,
    }

    struct OutputPolicyRowCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        sequence: u64,
        output_key: 0x1::string::String,
        protected_output: bool,
        complete_scope_key: 0x1::string::String,
        allowed_pack_policy: u8,
        allowed_semantic_pack_ids: vector<0x1::string::String>,
        renderer_schema_commitment: vector<u8>,
    }

    struct OutputRegistryEmptyCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
    }

    struct OutputRegistryAdvanceCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        sequence: u64,
        prior_commitment: vector<u8>,
        row_commitment: vector<u8>,
    }

    struct OutputReadinessCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        output_registry_id: 0x2::object::ID,
        soul_registry_id: 0x2::object::ID,
        expected_output_count: u64,
        observed_output_count: u64,
        output_policy_commitment: vector<u8>,
    }

    struct RecipeCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        output_key: 0x1::string::String,
        renderer_schema_commitment: vector<u8>,
        output_policy_commitment: vector<u8>,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        selection_count: u64,
        ordered_selection_commitments: vector<vector<u8>>,
        ordered_pricing_commitments: vector<vector<u8>>,
        used_packs: vector<0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::UsedPackV8>,
    }

    struct RenderCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        recipe_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
        renderer_schema_commitment: vector<u8>,
        render_blob_id: 0x1::string::String,
        render_sha256: vector<u8>,
        render_blob_commitment: vector<u8>,
        protected: bool,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
    }

    struct CompleteOutputCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_registry_id: 0x2::object::ID,
        output_key: 0x1::string::String,
        original_holder: address,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        output_policy_commitment: vector<u8>,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        protected: bool,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
    }

    struct CompleteReceiptCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        original_holder: address,
        output_key: 0x1::string::String,
        loadout_id: 0x2::object::ID,
        loadout_revision: u64,
        loadout_commitment: vector<u8>,
        output_policy_commitment: vector<u8>,
        renderer_schema_commitment: vector<u8>,
        economics_commitment: vector<u8>,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        base_line: BaseCompleteLineV8,
        pack_lines: vector<PackPaymentLineV8>,
        total_paid_atomic: u128,
        protected: bool,
    }

    struct ProtectionBindingCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        scope_key: 0x1::string::String,
        asset_key: 0x1::string::String,
        seal_id: vector<u8>,
    }

    struct SoulAuthorizationCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        holder: address,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        protection_binding_commitment: vector<u8>,
    }

    struct SoulCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        soul_registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        output_key: 0x1::string::String,
        output_policy_commitment: vector<u8>,
        holder: address,
        ownership_epoch: u64,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        recipe_commitment: vector<u8>,
        render_commitment: vector<u8>,
        output_commitment: vector<u8>,
        receipt_commitment: vector<u8>,
        soul_creator_royalty_bps: u16,
        maker_source_royalty_bps: u16,
    }

    struct PhysicalWitnessCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        output_registry_id: 0x2::object::ID,
        complete: PhysicalCompleteBindingV8,
        selection: PhysicalSelectionBindingV8,
        materialization_key: 0x1::string::String,
    }

    struct CanonicalSoulCreatedV8 has copy, drop {
        soul_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        output_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        holder: address,
        soul_commitment: vector<u8>,
    }

    public fun advance_output_registry_commitment_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        assert_hash(&arg2);
        assert_hash(&arg3);
        let v0 = OutputRegistryAdvanceCommitmentInputV8{
            domain                  : b"animacraft-v8/output/registry-row",
            version                 : 8,
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            sequence                : arg1,
            prior_commitment        : arg2,
            row_commitment          : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<OutputRegistryAdvanceCommitmentInputV8>(&v0))
    }

    public fun allowed_all_admitted_v8() : u8 {
        0
    }

    public fun allowed_allowlist_v8() : u8 {
        1
    }

    public fun append_free_pack_complete_v8<T0>(arg0: &mut CompleteSessionV8, arg1: &OutputPackageConfigV8, arg2: &OutputRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_binding_v8::RuntimePackageConfigV8, arg6: &mut 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg8: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackPassV8, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg10: &mut 0x2::tx_context::TxContext) {
        assert_session_live<T0>(arg0, arg2, arg3, arg9, arg10);
        assert_config(arg4, arg1);
        let (v0, v1) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::consume_free_pack_complete_line_v8<T0>(0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_binding_v8::authorize_pack_complete_from_output_v8<T0, OutputRegistryV8>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::activation_v8::new_output_runtime_request_v8<T0, OutputOriginalMarkerV8, OutputCallableMarkerV8, OutputRegistryV8>(arg3, arg4, &arg1.output_call_cap, arg2, arg10), arg3, arg4, arg5, arg2, arg6, arg7, arg8, &arg0.authorization, arg9, arg10), arg6, arg3, arg10);
        append_pack_payment_line<T0>(arg0, arg6, v0, v1, 0, arg3);
    }

    public fun append_output_policy_v8<T0>(arg0: &mut OutputRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: bool, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u8, arg9: vector<0x1::string::String>, arg10: vector<u8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_identity<T0>(arg0, arg1);
        let v0 = derive_output_policy_row_commitment_v8<T0>(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        assert_row_commitment(&arg10, &v0);
        let v1 = advance_output_registry_commitment_v8<T0>(arg1, arg3, arg0.rolling_policy_commitment, arg10);
        append_policy_row(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v1);
    }

    fun append_pack_payment_line<T0>(arg0: &mut CompleteSessionV8, arg1: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert!(arg2 == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::pack_release_id_v8<T0>(arg1), 9);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg5);
        let v1 = protocol_share(arg4, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v0));
        let v2 = PackPaymentLineV8{
            release_id                 : arg2,
            semantic_pack_id           : *0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::pack_release_semantic_id_v8<T0>(arg1),
            release_content_commitment : *0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::pack_release_content_commitment_v8<T0>(arg1),
            ordinal                    : arg3,
            gross_atomic               : arg4,
            protocol_atomic            : v1,
            pack_atomic                : arg4 - v1,
        };
        0x1::vector::push_back<PackPaymentLineV8>(&mut arg0.pack_lines, v2);
        arg0.total_paid_atomic = arg0.total_paid_atomic + (arg4 as u128);
    }

    public fun append_paid_pack_complete_v8<T0>(arg0: &mut CompleteSessionV8, arg1: &OutputPackageConfigV8, arg2: &OutputRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_binding_v8::RuntimePackageConfigV8, arg6: &mut 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackReleaseV8<T0>, arg7: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackRegistryV8, arg8: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackPassV8, arg9: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg10: &mut 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::PackTreasuryV8<T0>, arg11: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg12: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg13: 0x2::coin::Coin<T0>, arg14: &mut 0x2::tx_context::TxContext) {
        assert_session_live<T0>(arg0, arg2, arg3, arg9, arg14);
        assert_config(arg4, arg1);
        let v0 = 0x2::coin::value<T0>(&arg13);
        assert!(v0 > 0, 8);
        let (v1, v2) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::settle_paid_pack_complete_line_v8<T0>(0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_binding_v8::authorize_pack_complete_from_output_v8<T0, OutputRegistryV8>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::activation_v8::new_output_runtime_request_v8<T0, OutputOriginalMarkerV8, OutputCallableMarkerV8, OutputRegistryV8>(arg3, arg4, &arg1.output_call_cap, arg2, arg14), arg3, arg4, arg5, arg2, arg6, arg7, arg8, &arg0.authorization, arg9, arg14), arg6, arg10, arg3, arg11, arg12, arg13, arg14);
        append_pack_payment_line<T0>(arg0, arg6, v1, v2, v0, arg3);
    }

    fun append_policy_row(arg0: &mut OutputRegistryV8, arg1: u64, arg2: 0x1::string::String, arg3: bool, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u8, arg7: vector<0x1::string::String>, arg8: vector<u8>, arg9: vector<u8>) {
        assert!(!arg0.sealed, 13);
        assert!(arg1 == arg0.observed_output_count, 12);
        assert!(arg1 < arg0.expected_output_count, 0);
        assert_semantic_key(&arg2);
        assert_scope_policy(arg3, &arg4);
        assert_hash(&arg5);
        assert_hash(&arg8);
        assert_hash(&arg9);
        validate_allowed_pack_policy(arg6, &arg7);
        let v0 = OutputPolicyKeyV8{output_key: arg2};
        assert!(!0x2::table::contains<OutputPolicyKeyV8, OutputPolicyRowV8>(&arg0.policy_rows, v0), 11);
        let v1 = OutputPolicyRowV8{
            sequence                   : arg1,
            output_key                 : arg2,
            protected_output           : arg3,
            complete_scope_key         : arg4,
            renderer_schema_commitment : arg5,
            allowed_pack_policy        : arg6,
            allowed_semantic_pack_ids  : arg7,
            row_commitment             : arg8,
        };
        0x2::table::add<OutputPolicyKeyV8, OutputPolicyRowV8>(&mut arg0.policy_rows, v0, v1);
        0x1::vector::push_back<OutputPolicyKeyV8>(&mut arg0.policy_keys, v0);
        arg0.observed_output_count = arg0.observed_output_count + 1;
        arg0.rolling_policy_commitment = arg9;
    }

    fun assert_active_lifecycle(arg0: u8) {
        assert!(arg0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::lifecycle_active_v8(), 5);
    }

    fun assert_active_output_registry<T0>(arg0: &OutputRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert_active_lifecycle(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg1));
        assert_registry_root<T0>(arg0, arg1);
        assert!(arg0.sealed, 14);
        assert!(arg0.rolling_policy_commitment == arg0.expected_policy_commitment, 4);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_output_registry_id_v8(v0) == 0x2::object::id<OutputRegistryV8>(arg0), 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_soul_registry_id_v8(v0) == arg0.soul_registry_id, 1);
    }

    fun assert_active_registry_pair<T0>(arg0: &OutputRegistryV8, arg1: &SoulRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert_active_output_registry<T0>(arg0, arg2);
        assert_registry_pair<T0>(arg2, arg0, arg1);
    }

    fun assert_active_soul_market_boundary<T0, T1, T2, T3: key, T4: key>(arg0: &OutputRegistryV8, arg1: &SoulRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg5: &T3, arg6: &T4, arg7: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg2, arg3);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_catalog_current_v8(arg3, arg4);
        assert_soul_market_boundary<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        assert_active_registry_pair<T0>(arg0, arg1, arg2);
    }

    fun assert_allowed_semantic(arg0: &OutputPolicyRowV8, arg1: &0x1::string::String) {
        if (arg0.allowed_pack_policy == 0) {
            return
        } else {
            let v0 = 0;
            while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.allowed_semantic_pack_ids)) {
                if (0x1::vector::borrow<0x1::string::String>(&arg0.allowed_semantic_pack_ids, v0) == arg1) {
                    return
                };
                v0 = v0 + 1;
            };
            abort 2
        };
    }

    fun assert_complete_root<T0>(arg0: &CompleteOutputV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert_active_lifecycle(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_lifecycle_v8<T0>(arg1));
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
    }

    fun assert_config(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg1: &OutputPackageConfigV8) {
        assert!(arg1.version == 8, 0);
        assert!(arg1.catalog_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg0), 0);
        assert!(&arg1.product_binding_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg0)), 0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_output_call_cap_v8(arg0, &arg1.output_call_cap);
    }

    fun assert_exact_holder(arg0: address, arg1: address) {
        assert!(arg0 == arg1 && arg1 != @0x0, 6);
    }

    fun assert_exact_pack_bindings(arg0: &OutputPolicyRowV8, arg1: &vector<PackPaymentLineV8>, arg2: &vector<DerivedPackBindingV8>) {
        assert!(0x1::vector::length<PackPaymentLineV8>(arg1) == 0x1::vector::length<DerivedPackBindingV8>(arg2), 9);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DerivedPackBindingV8>(arg2)) {
            let v1 = 0x1::vector::borrow<PackPaymentLineV8>(arg1, v0);
            let v2 = 0x1::vector::borrow<DerivedPackBindingV8>(arg2, v0);
            assert!(v1.release_id == v2.release_id, 9);
            assert!(v1.semantic_pack_id == v2.semantic_pack_id, 9);
            assert!(v1.release_content_commitment == v2.release_content_commitment, 9);
            assert_hash(&v2.pricing_commitment);
            assert_allowed_semantic(arg0, &v1.semantic_pack_id);
            v0 = v0 + 1;
        };
    }

    fun assert_exact_pack_lines(arg0: &OutputPolicyRowV8, arg1: &vector<PackPaymentLineV8>, arg2: &vector<0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::UsedPackV8>) {
        let v0 = 0x1::vector::empty<DerivedPackBindingV8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::UsedPackV8>(arg2)) {
            let v2 = 0x1::vector::borrow<0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::UsedPackV8>(arg2, v1);
            let v3 = DerivedPackBindingV8{
                release_id                 : 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::used_pack_release_id_v8(v2),
                semantic_pack_id           : *0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::used_pack_semantic_id_v8(v2),
                release_content_commitment : *0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::used_pack_content_commitment_v8(v2),
                pricing_commitment         : *0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::used_pack_pricing_commitment_v8(v2),
            };
            0x1::vector::push_back<DerivedPackBindingV8>(&mut v0, v3);
            v1 = v1 + 1;
        };
        assert_exact_pack_bindings(arg0, arg1, &v0);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 4);
        let v0 = false;
        let v1 = 0;
        while (v1 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 4);
    }

    fun assert_live_soul_bundle<T0>(arg0: &CompleteOutputV8, arg1: &CompleteReceiptV8, arg2: &CanonicalSoulV8, arg3: &OutputRegistryV8, arg4: &SoulRegistryV8, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg6: address, arg7: u64) {
        assert_registry_pair<T0>(arg5, arg3, arg4);
        let v0 = if (arg0.version == 8) {
            if (arg1.version == 8) {
                arg2.version == 8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert_exact_holder(arg0.holder, arg6);
        assert_exact_holder(arg1.holder, arg6);
        assert_exact_holder(arg2.holder, arg6);
        assert!(arg0.original_holder != @0x0 && arg0.original_holder == arg1.original_holder, 1);
        assert!(arg2.ownership_epoch == arg7, 17);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg5, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg1.root_id == arg0.root_id && arg2.root_id == arg0.root_id, 1);
        assert!(arg1.maker_version == arg0.maker_version && arg2.maker_version == arg0.maker_version, 1);
        assert!(arg1.root_content_commitment == arg0.root_content_commitment && arg2.root_content_commitment == arg0.root_content_commitment, 1);
        assert!(arg0.output_registry_id == 0x2::object::id<OutputRegistryV8>(arg3), 1);
        assert!(arg2.soul_registry_id == 0x2::object::id<SoulRegistryV8>(arg4), 1);
        let v1 = 0x2::object::id<CompleteOutputV8>(arg0);
        let v2 = 0x2::object::id<CompleteReceiptV8>(arg1);
        let v3 = 0x2::object::id<CanonicalSoulV8>(arg2);
        assert!(arg1.output_id == v1, 1);
        assert!(arg2.output_id == v1 && arg2.receipt_id == v2, 1);
        assert!(arg1.output_key == arg0.output_key && arg2.output_key == arg0.output_key, 1);
        let v4 = if (arg1.loadout_id == arg0.loadout_id) {
            if (arg1.loadout_revision == arg0.loadout_revision) {
                arg1.loadout_commitment == arg0.loadout_commitment
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 1);
        assert!(arg1.output_policy_commitment == arg0.output_policy_commitment && arg2.output_policy_commitment == arg0.output_policy_commitment, 1);
        assert!(arg1.renderer_schema_commitment == arg0.renderer_schema_commitment, 1);
        assert!(arg1.recipe_commitment == arg0.recipe_commitment && arg2.recipe_commitment == arg0.recipe_commitment, 1);
        assert!(arg1.render_commitment == arg0.render_commitment && arg2.render_commitment == arg0.render_commitment, 1);
        assert!(arg1.output_commitment == arg0.output_commitment && arg2.output_commitment == arg0.output_commitment, 1);
        assert!(arg2.receipt_commitment == arg1.receipt_commitment, 1);
        assert!(arg1.protected == arg0.protected, 1);
        let v5 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg5);
        assert!(arg1.economics_commitment == *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_commitment_v8(&v5), 1);
        let v6 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_rights_v8<T0>(arg5);
        assert!(arg2.soul_creator_royalty_bps == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::rights_soul_creator_royalty_bps_v8(&v6), 1);
        assert!(arg2.maker_source_royalty_bps == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::rights_maker_source_royalty_bps_v8(&v6), 1);
        assert!(borrow_policy(arg3, arg0.output_key).row_commitment == arg0.output_policy_commitment, 1);
        assert!(derive_current_output_commitment(arg0) == arg0.output_commitment, 4);
        assert!(derive_current_receipt_commitment(arg1) == arg1.receipt_commitment, 4);
        assert_protection_binding(arg0, arg1);
        assert!(derive_current_soul_commitment(arg2) == arg2.soul_commitment, 4);
        let v7 = 0x2::table::borrow<0x2::object::ID, OutputRecordV8>(&arg3.outputs, v1);
        let v8 = if (v7.output_id == v1) {
            if (v7.receipt_id == v2) {
                if (v7.soul_id == v3) {
                    if (v7.output_key == arg0.output_key) {
                        if (v7.output_policy_commitment == arg0.output_policy_commitment) {
                            if (v7.holder == arg6) {
                                if (v7.recipe_commitment == arg0.recipe_commitment) {
                                    if (v7.render_commitment == arg0.render_commitment) {
                                        if (v7.output_commitment == arg0.output_commitment) {
                                            if (v7.receipt_commitment == arg1.receipt_commitment) {
                                                if (v7.protected == arg0.protected) {
                                                    v7.seal_id == arg0.seal_id
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
        assert!(v8, 1);
        let v9 = 0x2::table::borrow<0x2::object::ID, SoulRecordV8>(&arg4.souls, v3);
        let v10 = if (v9.soul_id == v3) {
            if (v9.output_id == v1) {
                if (v9.receipt_id == v2) {
                    if (v9.holder == arg6) {
                        if (v9.ownership_epoch == arg7) {
                            v9.soul_commitment == arg2.soul_commitment
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
        };
        assert!(v10, 1);
    }

    fun assert_protected_proof_fields(arg0: &CompleteOutputV8, arg1: &CompleteReceiptV8, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>, arg7: &vector<u8>, arg8: &0x1::string::String, arg9: &0x1::string::String, arg10: &vector<u8>) {
        assert!(arg2 == 0x2::object::id<CompleteReceiptV8>(arg1), 10);
        assert!(arg3 == 0x2::object::id<CompleteOutputV8>(arg0), 10);
        assert!(arg4 == &arg0.recipe_commitment, 10);
        assert!(arg5 == &arg0.render_commitment, 10);
        assert!(arg6 == &arg0.output_commitment, 10);
        assert!(arg7 == &arg1.receipt_commitment, 10);
        assert!(arg8 == &arg0.scope_key, 10);
        assert!(arg9 == &arg0.asset_key, 10);
        assert_hash(arg10);
    }

    fun assert_protection_binding(arg0: &CompleteOutputV8, arg1: &CompleteReceiptV8) {
        assert!(arg0.protected == arg1.protected, 1);
        if (arg0.protected) {
            assert!(0x1::option::is_some<vector<u8>>(&arg0.seal_id) && 0x1::option::is_some<vector<u8>>(&arg1.seal_id), 1);
            assert!(arg0.seal_id == arg1.seal_id, 1);
            let v0 = ProtectionBindingCommitmentInputV8{
                domain             : b"animacraft-v8/output/protection",
                version            : 8,
                output_id          : 0x2::object::id<CompleteOutputV8>(arg0),
                receipt_id         : 0x2::object::id<CompleteReceiptV8>(arg1),
                output_commitment  : arg0.output_commitment,
                receipt_commitment : arg1.receipt_commitment,
                scope_key          : arg0.scope_key,
                asset_key          : arg0.asset_key,
                seal_id            : *0x1::option::borrow<vector<u8>>(&arg0.seal_id),
            };
            assert!(arg0.protection_binding_commitment == 0x1::hash::sha2_256(0x1::bcs::to_bytes<ProtectionBindingCommitmentInputV8>(&v0)), 4);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&arg0.seal_id) && 0x1::option::is_none<vector<u8>>(&arg1.seal_id), 1);
            assert!(0x1::vector::is_empty<u8>(&arg0.protection_binding_commitment), 4);
        };
    }

    fun assert_registry_identity<T0>(arg0: &OutputRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_v8<T0>(arg1);
        assert_registry_root<T0>(arg0, arg1);
    }

    fun assert_registry_pair<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &OutputRegistryV8, arg2: &SoulRegistryV8) {
        assert_registry_root<T0>(arg1, arg0);
        assert!(arg2.version == 8, 1);
        assert!(arg2.root_id == arg1.root_id, 1);
        assert!(arg2.maker_version == arg1.maker_version, 1);
        assert!(arg2.root_content_commitment == arg1.root_content_commitment, 1);
        assert!(arg1.soul_registry_id == 0x2::object::id<SoulRegistryV8>(arg2), 1);
        assert!(arg2.output_registry_id == 0x2::object::id<OutputRegistryV8>(arg1), 1);
    }

    fun assert_registry_ready(arg0: &OutputRegistryV8, arg1: &SoulRegistryV8) {
        assert!(arg0.sealed, 14);
        assert!(arg0.observed_output_count == arg0.expected_output_count, 0);
        assert!(arg0.rolling_policy_commitment == arg0.expected_policy_commitment, 4);
        assert!(arg0.total_complete_count == 0, 5);
        assert!(0x1::vector::is_empty<WalletKeyV8>(&arg0.wallet_keys), 5);
        assert!(arg0.output_count == 0 && 0x1::vector::is_empty<0x2::object::ID>(&arg0.output_keys), 5);
        assert!(arg0.materialization_count == 0 && 0x1::vector::is_empty<MaterializationKeyV8>(&arg0.materialization_keys), 5);
        assert!(arg1.soul_count == 0 && 0x1::vector::is_empty<0x2::object::ID>(&arg1.soul_keys), 5);
    }

    fun assert_registry_root<T0>(arg0: &OutputRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg1, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(&arg0.renderer_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_renderer_commitment_v8<T0>(arg1), 1);
        assert!(arg0.expected_output_count <= 256, 1);
        assert_hash(&arg0.expected_policy_commitment);
        assert_hash(&arg0.rolling_policy_commitment);
        assert!(arg0.observed_output_count <= arg0.expected_output_count, 1);
        assert!(0x1::vector::length<OutputPolicyKeyV8>(&arg0.policy_keys) == arg0.observed_output_count, 1);
    }

    fun assert_render_input(arg0: &0x1::string::String, arg1: &vector<u8>, arg2: &vector<u8>, arg3: bool, arg4: &0x1::string::String, arg5: &0x1::string::String) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= 512, 3);
        assert_hash(arg1);
        assert_hash(arg2);
        if (arg3) {
            let v1 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg4));
            let v2 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg5));
            assert!(v1 > 0 && v1 <= 128, 3);
            assert!(v2 > 0 && v2 <= 128, 3);
        } else {
            assert!(0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg4)), 2);
            assert!(0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg5)), 2);
        };
    }

    fun assert_row_commitment(arg0: &vector<u8>, arg1: &vector<u8>) {
        assert!(arg0 == arg1, 4);
    }

    fun assert_scope_policy(arg0: bool, arg1: &0x1::string::String) {
        if (arg0) {
            assert_semantic_key(arg1);
        } else {
            assert!(0x1::vector::is_empty<u8>(0x1::string::as_bytes(arg1)), 2);
        };
    }

    fun assert_semantic_key(arg0: &0x1::string::String) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= 128, 3);
    }

    fun assert_session_live<T0>(arg0: &CompleteSessionV8, arg1: &OutputRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg4: &0x2::tx_context::TxContext) {
        assert_active_output_registry<T0>(arg1, arg2);
        assert_exact_holder(arg0.holder, 0x2::tx_context::sender(arg4));
        assert!(arg0.output_registry_id == 0x2::object::id<OutputRegistryV8>(arg1), 1);
        assert!(arg0.root_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg2), 1);
        borrow_policy(arg1, arg0.output_key);
        assert!(arg0.maker_version == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg2), 1);
        assert!(&arg0.root_content_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg2), 1);
        assert!(arg0.loadout_id == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_id_v8(arg3), 10);
        assert!(arg0.loadout_revision == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_revision_v8(arg3), 10);
        assert!(&arg0.loadout_commitment == 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_commitment_v8(arg3), 10);
    }

    fun assert_soul_market_boundary<T0, T1, T2, T3: key, T4: key>(arg0: &OutputRegistryV8, arg1: &SoulRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg4: &T3, arg5: &T4, arg6: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_market_call_cap_v8(arg3, arg6);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_catalog_snapshot_v8(arg3, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_protocol_config_id_v8<T0>(arg2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_protocol_config_revision_v8<T0>(arg2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_protocol_config_commitment_v8<T0>(arg2));
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg3);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::market_binding_v8(v0);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T1, T2>(v1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_original_v8<T3>(v1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_original_v8<T4>(v1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_catalog_id_v8<T0>(arg2) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg3), 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_binding_v8<T0>(arg2)) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(v0), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_same_call_cap_set_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_call_cap_set_v8<T0>(arg2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg3));
        assert_registry_pair<T0>(arg2, arg0, arg1);
        let v2 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_capability_registry_binding_v8<T0>(arg2);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_catalog_id_v8(v2) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg3), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_same_call_cap_set_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_call_cap_set_v8(v2), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_call_cap_set_v8(arg3));
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_output_registry_id_v8(v2) == 0x2::object::id<OutputRegistryV8>(arg0), 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_soul_registry_id_v8(v2) == 0x2::object::id<SoulRegistryV8>(arg1), 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_market_registry_id_v8(v2) == 0x2::object::id<T3>(arg4), 1);
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::capability_market_treasury_id_v8(v2) == 0x2::object::id<T4>(arg5), 1);
    }

    fun assert_soul_market_custody_bundle(arg0: &SoulMarketCustodyBindingV8, arg1: &CompleteOutputV8, arg2: &CompleteReceiptV8, arg3: &CanonicalSoulV8) {
        let v0 = if (arg0.output_id == 0x2::object::id<CompleteOutputV8>(arg1)) {
            if (arg0.receipt_id == 0x2::object::id<CompleteReceiptV8>(arg2)) {
                arg0.soul_id == 0x2::object::id<CanonicalSoulV8>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 15);
        let v1 = if (arg0.output_commitment == arg1.output_commitment) {
            if (arg0.receipt_commitment == arg2.receipt_commitment) {
                arg0.soul_commitment == arg3.soul_commitment
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 4);
    }

    fun assert_soul_market_custody_header<T0, T1: key, T2: key>(arg0: &SoulMarketCustodyBindingV8, arg1: &0x2::object::UID, arg2: &OutputRegistryV8, arg3: &SoulRegistryV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &T1, arg6: &T2) {
        assert!(arg0.listing_id == 0x2::object::uid_to_inner(arg1), 1);
        assert!(arg0.output_registry_id == 0x2::object::id<OutputRegistryV8>(arg2), 1);
        assert!(arg0.soul_registry_id == 0x2::object::id<SoulRegistryV8>(arg3), 1);
        assert!(arg0.market_registry_id == 0x2::object::id<T1>(arg5), 1);
        assert!(arg0.market_treasury_id == 0x2::object::id<T2>(arg6), 1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_root_identity_v8<T0>(arg4, arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.seller != @0x0, 6);
        assert_hash(&arg0.output_commitment);
        assert_hash(&arg0.receipt_commitment);
        assert_hash(&arg0.soul_commitment);
    }

    fun assert_total_cap(arg0: u64, arg1: u64) {
        if (arg1 != 0) {
            assert!(arg0 < arg1, 7);
        };
    }

    public fun begin_complete_v8<T0>(arg0: &mut OutputRegistryV8, arg1: 0x1::string::String, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg4: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg5: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg6: 0x2::coin::Coin<T0>, arg7: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimeLoadoutAuthorizationV8, arg8: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg9: &mut 0x2::tx_context::TxContext) : CompleteSessionV8 {
        assert_active_output_registry<T0>(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = quote_base_complete_v8<T0>(arg0, arg2, arg1, v0);
        mutate_base_counter(arg0, v0, v1.ordinal);
        settle_base_payment<T0>(arg2, arg3, arg4, arg5, arg6, v1, arg9);
        CompleteSessionV8{
            output_registry_id      : 0x2::object::id<OutputRegistryV8>(arg0),
            soul_registry_id        : arg0.soul_registry_id,
            root_id                 : arg0.root_id,
            maker_version           : arg0.maker_version,
            root_content_commitment : arg0.root_content_commitment,
            output_key              : arg1,
            holder                  : v0,
            loadout_id              : 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_id_v8(arg8),
            loadout_revision        : 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_revision_v8(arg8),
            loadout_commitment      : *0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::loadout_commitment_v8(arg8),
            authorization           : arg7,
            base_line               : v1,
            pack_lines              : 0x1::vector::empty<PackPaymentLineV8>(),
            total_paid_atomic       : (v1.total_atomic as u128),
        }
    }

    fun borrow_policy(arg0: &OutputRegistryV8, arg1: 0x1::string::String) : &OutputPolicyRowV8 {
        let v0 = OutputPolicyKeyV8{output_key: arg1};
        assert!(0x2::table::contains<OutputPolicyKeyV8, OutputPolicyRowV8>(&arg0.policy_rows, v0), 3);
        0x2::table::borrow<OutputPolicyKeyV8, OutputPolicyRowV8>(&arg0.policy_rows, v0)
    }

    public fun certify_output_activation_readiness_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &OutputPackageConfigV8, arg3: &OutputRegistryV8, arg4: &SoulRegistryV8) : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::activation_v8::OutputReadinessV8 {
        assert_config(arg1, arg2);
        assert_registry_pair<T0>(arg0, arg3, arg4);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_v8<T0>(arg0);
        assert_registry_ready(arg3, arg4);
        let v0 = OutputReadinessCommitmentInputV8{
            domain                   : b"animacraft-v8/output/readiness",
            version                  : 8,
            root_id                  : arg3.root_id,
            output_registry_id       : 0x2::object::id<OutputRegistryV8>(arg3),
            soul_registry_id         : 0x2::object::id<SoulRegistryV8>(arg4),
            expected_output_count    : arg3.expected_output_count,
            observed_output_count    : arg3.observed_output_count,
            output_policy_commitment : arg3.rolling_policy_commitment,
        };
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::activation_v8::certify_output_readiness_v8<T0, OutputOriginalMarkerV8, OutputCallableMarkerV8, OutputRegistryV8, SoulRegistryV8>(arg0, arg1, &arg2.output_call_cap, arg3, arg4, 0x1::hash::sha2_256(0x1::bcs::to_bytes<OutputReadinessCommitmentInputV8>(&v0)))
    }

    public fun complete_output_commitment_v8(arg0: &CompleteOutputV8) : &vector<u8> {
        &arg0.output_commitment
    }

    public fun complete_output_holder_v8(arg0: &CompleteOutputV8) : address {
        arg0.holder
    }

    public fun complete_output_id_v8(arg0: &CompleteOutputV8) : 0x2::object::ID {
        0x2::object::id<CompleteOutputV8>(arg0)
    }

    public fun complete_output_original_holder_v8(arg0: &CompleteOutputV8) : address {
        arg0.original_holder
    }

    fun complete_price_for_ordinal(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::complete_unlimited_free_v8()) {
            return 0
        };
        if (arg0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::complete_free_quota_then_paid_v8()) {
            return if (arg3 < arg2) {
                0
            } else {
                arg1
            }
        };
        if (arg0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::complete_paid_every_time_v8()) {
            return arg1
        };
        assert!(arg0 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::complete_free_quota_then_block_v8(), 2);
        assert!(arg3 < arg2, 7);
        0
    }

    public fun consume_physical_materialization_witness_v8<T0, T1>(arg0: PhysicalMaterializationWitnessV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PhysicalRoleV8>) : (PhysicalCompleteBindingV8, PhysicalSelectionBindingV8, 0x1::string::String, vector<u8>) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_physical_call_cap_v8(arg1, arg2);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T0, T1>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::physical_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg1)));
        let PhysicalMaterializationWitnessV8 {
            complete            : v0,
            selection           : v1,
            materialization_key : v2,
            witness_commitment  : v3,
        } = arg0;
        let v4 = v0;
        assert!(v3 == derive_physical_witness_commitment(v4.output_registry_id, v4, v1, v2), 10);
        (v4, v1, v2, v3)
    }

    public fun consume_soul_market_custody_ticket_v8<T0, T1, T2, T3: key, T4: key>(arg0: SoulMarketCustodyTicketV8, arg1: &0x2::object::UID, arg2: &OutputRegistryV8, arg3: &SoulRegistryV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg6: &T3, arg7: &T4, arg8: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>) : SoulMarketCustodyBindingV8 {
        assert_soul_market_boundary<T0, T1, T2, T3, T4>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        assert_soul_market_custody_header<T0, T3, T4>(&arg0.binding, arg1, arg2, arg3, arg4, arg6, arg7);
        let SoulMarketCustodyTicketV8 { binding: v0 } = arg0;
        v0
    }

    public fun custody_soul_bundle_for_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: CompleteOutputV8, arg1: CompleteReceiptV8, arg2: CanonicalSoulV8, arg3: &mut 0x2::object::UID, arg4: &OutputRegistryV8, arg5: &SoulRegistryV8, arg6: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg7: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg8: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg9: &T3, arg10: &T4, arg11: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg12: &0x2::tx_context::TxContext) : SoulMarketCustodyTicketV8 {
        assert_active_soul_market_boundary<T0, T1, T2, T3, T4>(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v0 = 0x2::tx_context::sender(arg12);
        assert_live_soul_bundle<T0>(&arg0, &arg1, &arg2, arg4, arg5, arg6, v0, arg2.ownership_epoch);
        let v1 = SoulMarketCustodyBindingV8{
            listing_id                    : 0x2::object::uid_to_inner(arg3),
            output_registry_id            : 0x2::object::id<OutputRegistryV8>(arg4),
            soul_registry_id              : 0x2::object::id<SoulRegistryV8>(arg5),
            market_registry_id            : 0x2::object::id<T3>(arg9),
            market_treasury_id            : 0x2::object::id<T4>(arg10),
            root_id                       : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg6),
            maker_version                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg6),
            root_content_commitment       : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg6),
            output_id                     : 0x2::object::id<CompleteOutputV8>(&arg0),
            receipt_id                    : 0x2::object::id<CompleteReceiptV8>(&arg1),
            soul_id                       : 0x2::object::id<CanonicalSoulV8>(&arg2),
            output_commitment             : arg0.output_commitment,
            receipt_commitment            : arg1.receipt_commitment,
            soul_commitment               : arg2.soul_commitment,
            seller                        : v0,
            expected_soul_ownership_epoch : arg2.ownership_epoch,
        };
        let v2 = 0x2::object::uid_to_address(arg3);
        0x2::transfer::transfer<CompleteOutputV8>(arg0, v2);
        0x2::transfer::transfer<CompleteReceiptV8>(arg1, v2);
        0x2::transfer::transfer<CanonicalSoulV8>(arg2, v2);
        SoulMarketCustodyTicketV8{binding: v1}
    }

    fun derive_current_output_commitment(arg0: &CompleteOutputV8) : vector<u8> {
        let v0 = CompleteOutputCommitmentInputV8{
            domain                   : b"animacraft-v8/output/complete",
            version                  : 8,
            root_id                  : arg0.root_id,
            maker_version            : arg0.maker_version,
            root_content_commitment  : arg0.root_content_commitment,
            output_registry_id       : arg0.output_registry_id,
            output_key               : arg0.output_key,
            original_holder          : arg0.original_holder,
            loadout_id               : arg0.loadout_id,
            loadout_revision         : arg0.loadout_revision,
            loadout_commitment       : arg0.loadout_commitment,
            output_policy_commitment : arg0.output_policy_commitment,
            recipe_commitment        : arg0.recipe_commitment,
            render_commitment        : arg0.render_commitment,
            protected                : arg0.protected,
            scope_key                : arg0.scope_key,
            asset_key                : arg0.asset_key,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteOutputCommitmentInputV8>(&v0))
    }

    fun derive_current_receipt_commitment(arg0: &CompleteReceiptV8) : vector<u8> {
        let v0 = CompleteReceiptCommitmentInputV8{
            domain                     : b"animacraft-v8/output/receipt",
            version                    : 8,
            root_id                    : arg0.root_id,
            maker_version              : arg0.maker_version,
            root_content_commitment    : arg0.root_content_commitment,
            original_holder            : arg0.original_holder,
            output_key                 : arg0.output_key,
            loadout_id                 : arg0.loadout_id,
            loadout_revision           : arg0.loadout_revision,
            loadout_commitment         : arg0.loadout_commitment,
            output_policy_commitment   : arg0.output_policy_commitment,
            renderer_schema_commitment : arg0.renderer_schema_commitment,
            economics_commitment       : arg0.economics_commitment,
            recipe_commitment          : arg0.recipe_commitment,
            render_commitment          : arg0.render_commitment,
            output_commitment          : arg0.output_commitment,
            base_line                  : arg0.base_line,
            pack_lines                 : arg0.pack_lines,
            total_paid_atomic          : arg0.total_paid_atomic,
            protected                  : arg0.protected,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteReceiptCommitmentInputV8>(&v0))
    }

    fun derive_current_soul_commitment(arg0: &CanonicalSoulV8) : vector<u8> {
        let v0 = SoulCommitmentInputV8{
            domain                   : b"animacraft-v8/output/canonical-soul",
            version                  : 8,
            soul_registry_id         : arg0.soul_registry_id,
            root_id                  : arg0.root_id,
            maker_version            : arg0.maker_version,
            root_content_commitment  : arg0.root_content_commitment,
            output_key               : arg0.output_key,
            output_policy_commitment : arg0.output_policy_commitment,
            holder                   : arg0.holder,
            ownership_epoch          : arg0.ownership_epoch,
            output_id                : arg0.output_id,
            receipt_id               : arg0.receipt_id,
            recipe_commitment        : arg0.recipe_commitment,
            render_commitment        : arg0.render_commitment,
            output_commitment        : arg0.output_commitment,
            receipt_commitment       : arg0.receipt_commitment,
            soul_creator_royalty_bps : arg0.soul_creator_royalty_bps,
            maker_source_royalty_bps : arg0.maker_source_royalty_bps,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SoulCommitmentInputV8>(&v0))
    }

    public fun derive_output_policy_row_commitment_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: u64, arg2: 0x1::string::String, arg3: bool, arg4: 0x1::string::String, arg5: vector<u8>, arg6: u8, arg7: vector<0x1::string::String>) : vector<u8> {
        assert_semantic_key(&arg2);
        assert_scope_policy(arg3, &arg4);
        assert_hash(&arg5);
        validate_allowed_pack_policy(arg6, &arg7);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg0);
        let v1 = OutputPolicyRowCommitmentInputV8{
            domain                     : b"animacraft-v8/output/policy-row",
            version                    : 8,
            root_id                    : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version              : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment    : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            renderer_commitment        : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_renderer_commitment_v8<T0>(arg0),
            economics_commitment       : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_commitment_v8(&v0),
            sequence                   : arg1,
            output_key                 : arg2,
            protected_output           : arg3,
            complete_scope_key         : arg4,
            allowed_pack_policy        : arg6,
            allowed_semantic_pack_ids  : arg7,
            renderer_schema_commitment : arg5,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<OutputPolicyRowCommitmentInputV8>(&v1))
    }

    fun derive_physical_witness_commitment(arg0: 0x2::object::ID, arg1: PhysicalCompleteBindingV8, arg2: PhysicalSelectionBindingV8, arg3: 0x1::string::String) : vector<u8> {
        let v0 = PhysicalWitnessCommitmentInputV8{
            domain              : b"animacraft-v8/output/physical-materialization",
            version             : 8,
            output_registry_id  : arg0,
            complete            : arg1,
            selection           : arg2,
            materialization_key : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PhysicalWitnessCommitmentInputV8>(&v0))
    }

    fun derive_soul_authorization_commitment(arg0: &CompleteOutputV8, arg1: &CompleteReceiptV8) : vector<u8> {
        let v0 = SoulAuthorizationCommitmentInputV8{
            domain                        : b"animacraft-v8/output/soul-authorization",
            version                       : 8,
            output_id                     : 0x2::object::id<CompleteOutputV8>(arg0),
            receipt_id                    : 0x2::object::id<CompleteReceiptV8>(arg1),
            holder                        : arg0.holder,
            output_commitment             : arg0.output_commitment,
            receipt_commitment            : arg1.receipt_commitment,
            protection_binding_commitment : arg0.protection_binding_commitment,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SoulAuthorizationCommitmentInputV8>(&v0))
    }

    public fun empty_output_registry_commitment_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>) : vector<u8> {
        let v0 = OutputRegistryEmptyCommitmentInputV8{
            domain                  : b"animacraft-v8/output/registry-empty",
            version                 : 8,
            root_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0),
            maker_version           : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0),
            root_content_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0),
            renderer_commitment     : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_renderer_commitment_v8<T0>(arg0),
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<OutputRegistryEmptyCommitmentInputV8>(&v0))
    }

    public fun finalize_protected_complete_v8<T0>(arg0: ProtectedCompletePendingV8, arg1: vector<u8>, arg2: &0xf12dc22b720dc9d87cde8d76952ab252959cced372e8511abb54cbaa177e2a3::seal_v8::SealRegistryV8, arg3: &0xf12dc22b720dc9d87cde8d76952ab252959cced372e8511abb54cbaa177e2a3::seal_v8::SealPolicyConfigV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: 0xf12dc22b720dc9d87cde8d76952ab252959cced372e8511abb54cbaa177e2a3::seal_v8::CompleteDecryptProofV8, arg6: &0x2::tx_context::TxContext) : SoulMintAuthorizationV8 {
        let ProtectedCompletePendingV8 {
            output  : v0,
            receipt : v1,
        } = arg0;
        let v2 = v1;
        let v3 = v0;
        assert_exact_holder(v3.holder, 0x2::tx_context::sender(arg6));
        assert_exact_holder(v2.holder, 0x2::tx_context::sender(arg6));
        assert_complete_root<T0>(&v3, arg4);
        let (v4, v5, v6, v7, v8, v9, v10, v11, v12) = 0xf12dc22b720dc9d87cde8d76952ab252959cced372e8511abb54cbaa177e2a3::seal_v8::consume_complete_decrypt_proof_v8<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        let v16 = v9;
        let v17 = v8;
        let v18 = v7;
        let v19 = v6;
        assert_protected_proof_fields(&v3, &v2, v4, v5, &v19, &v18, &v17, &v16, &v15, &v14, &v13);
        assert!(v13 == arg1, 10);
        let v20 = ProtectionBindingCommitmentInputV8{
            domain             : b"animacraft-v8/output/protection",
            version            : 8,
            output_id          : v5,
            receipt_id         : v4,
            output_commitment  : v17,
            receipt_commitment : v16,
            scope_key          : v15,
            asset_key          : v14,
            seal_id            : v13,
        };
        v3.seal_id = 0x1::option::some<vector<u8>>(v13);
        v3.protection_binding_commitment = 0x1::hash::sha2_256(0x1::bcs::to_bytes<ProtectionBindingCommitmentInputV8>(&v20));
        v2.seal_id = 0x1::option::some<vector<u8>>(v13);
        SoulMintAuthorizationV8{
            output                   : v3,
            receipt                  : v2,
            authorization_commitment : derive_soul_authorization_commitment(&v3, &v2),
        }
    }

    fun finish_complete<T0>(arg0: CompleteSessionV8, arg1: &OutputRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : (CompleteOutputV8, CompleteReceiptV8) {
        assert_active_output_registry<T0>(arg1, arg2);
        assert_render_input(&arg4, &arg5, &arg6, arg7, &arg8, &arg9);
        let CompleteSessionV8 {
            output_registry_id      : v0,
            soul_registry_id        : v1,
            root_id                 : v2,
            maker_version           : v3,
            root_content_commitment : v4,
            output_key              : v5,
            holder                  : v6,
            loadout_id              : v7,
            loadout_revision        : v8,
            loadout_commitment      : v9,
            authorization           : v10,
            base_line               : v11,
            pack_lines              : v12,
            total_paid_atomic       : v13,
        } = arg0;
        let v14 = v12;
        let v15 = v4;
        assert_exact_holder(v6, 0x2::tx_context::sender(arg10));
        assert!(v0 == 0x2::object::id<OutputRegistryV8>(arg1), 1);
        assert!(v1 == arg1.soul_registry_id, 1);
        let v16 = borrow_policy(arg1, v5);
        assert!(v16.protected_output == arg7, 2);
        if (arg7) {
            assert!(v16.complete_scope_key == arg8, 2);
        };
        let (v17, v18, v19, v20, v21, v22, v23, v24, v25, v26) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::consume_loadout_authorization_v8(v10, arg3);
        let v27 = v26;
        assert!(v2 == v18 && v2 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg2), 10);
        assert!(v3 == v19 && v3 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg2), 10);
        assert!(v15 == v20 && &v15 == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg2), 10);
        assert!(v7 == v17, 10);
        assert!(v8 == v21, 10);
        assert!(v9 == v22, 10);
        assert_exact_pack_lines(v16, &v14, &v27);
        let v28 = RecipeCommitmentInputV8{
            domain                        : b"animacraft-v8/output/recipe",
            version                       : 8,
            root_id                       : v2,
            maker_version                 : v3,
            root_content_commitment       : v15,
            renderer_commitment           : arg1.renderer_commitment,
            output_key                    : v5,
            renderer_schema_commitment    : v16.renderer_schema_commitment,
            output_policy_commitment      : v16.row_commitment,
            loadout_id                    : v17,
            loadout_revision              : v21,
            loadout_commitment            : v22,
            selection_count               : v23,
            ordered_selection_commitments : v24,
            ordered_pricing_commitments   : v25,
            used_packs                    : v27,
        };
        let v29 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<RecipeCommitmentInputV8>(&v28));
        let v30 = RenderCommitmentInputV8{
            domain                     : b"animacraft-v8/output/render",
            version                    : 8,
            recipe_commitment          : v29,
            renderer_commitment        : arg1.renderer_commitment,
            renderer_schema_commitment : v16.renderer_schema_commitment,
            render_blob_id             : arg4,
            render_sha256              : arg5,
            render_blob_commitment     : arg6,
            protected                  : arg7,
            scope_key                  : arg8,
            asset_key                  : arg9,
        };
        let v31 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<RenderCommitmentInputV8>(&v30));
        let v32 = CompleteOutputCommitmentInputV8{
            domain                   : b"animacraft-v8/output/complete",
            version                  : 8,
            root_id                  : v2,
            maker_version            : v3,
            root_content_commitment  : v15,
            output_registry_id       : v0,
            output_key               : v5,
            original_holder          : v6,
            loadout_id               : v17,
            loadout_revision         : v21,
            loadout_commitment       : v22,
            output_policy_commitment : v16.row_commitment,
            recipe_commitment        : v29,
            render_commitment        : v31,
            protected                : arg7,
            scope_key                : arg8,
            asset_key                : arg9,
        };
        let v33 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteOutputCommitmentInputV8>(&v32));
        let v34 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg2);
        let v35 = CompleteReceiptCommitmentInputV8{
            domain                     : b"animacraft-v8/output/receipt",
            version                    : 8,
            root_id                    : v2,
            maker_version              : v3,
            root_content_commitment    : v15,
            original_holder            : v6,
            output_key                 : v5,
            loadout_id                 : v17,
            loadout_revision           : v21,
            loadout_commitment         : v22,
            output_policy_commitment   : v16.row_commitment,
            renderer_schema_commitment : v16.renderer_schema_commitment,
            economics_commitment       : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_commitment_v8(&v34),
            recipe_commitment          : v29,
            render_commitment          : v31,
            output_commitment          : v33,
            base_line                  : v11,
            pack_lines                 : v14,
            total_paid_atomic          : v13,
            protected                  : arg7,
        };
        let v36 = 0x2::object::new(arg10);
        let v37 = CompleteOutputV8{
            id                            : v36,
            version                       : 8,
            root_id                       : v2,
            maker_version                 : v3,
            root_content_commitment       : v15,
            output_registry_id            : v0,
            output_key                    : v5,
            original_holder               : v6,
            holder                        : v6,
            loadout_id                    : v17,
            loadout_revision              : v21,
            loadout_commitment            : v22,
            output_policy_commitment      : v16.row_commitment,
            renderer_schema_commitment    : v16.renderer_schema_commitment,
            recipe_commitment             : v29,
            render_commitment             : v31,
            render_blob_id                : arg4,
            render_sha256                 : arg5,
            render_blob_commitment        : arg6,
            output_commitment             : v33,
            protected                     : arg7,
            scope_key                     : arg8,
            asset_key                     : arg9,
            seal_id                       : 0x1::option::none<vector<u8>>(),
            protection_binding_commitment : b"",
        };
        let v38 = CompleteReceiptV8{
            id                         : 0x2::object::new(arg10),
            version                    : 8,
            output_id                  : 0x2::object::uid_to_inner(&v36),
            root_id                    : v2,
            maker_version              : v3,
            root_content_commitment    : v15,
            output_key                 : v5,
            original_holder            : v6,
            holder                     : v6,
            loadout_id                 : v17,
            loadout_revision           : v21,
            loadout_commitment         : v22,
            output_policy_commitment   : v16.row_commitment,
            renderer_schema_commitment : v16.renderer_schema_commitment,
            economics_commitment       : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_commitment_v8(&v34),
            recipe_commitment          : v29,
            render_commitment          : v31,
            output_commitment          : v33,
            base_line                  : v11,
            pack_lines                 : v14,
            total_paid_atomic          : v13,
            receipt_commitment         : 0x1::hash::sha2_256(0x1::bcs::to_bytes<CompleteReceiptCommitmentInputV8>(&v35)),
            protected                  : arg7,
            seal_id                    : 0x1::option::none<vector<u8>>(),
        };
        (v37, v38)
    }

    public fun finish_protected_complete_v8<T0>(arg0: CompleteSessionV8, arg1: &OutputRegistryV8, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg3: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : ProtectedCompletePendingV8 {
        let v0 = borrow_policy(arg1, arg0.output_key);
        assert!(v0.protected_output, 2);
        assert!(arg7 == v0.complete_scope_key, 2);
        let (v1, v2) = finish_complete<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, arg7, arg8, arg9);
        ProtectedCompletePendingV8{
            output  : v1,
            receipt : v2,
        }
    }

    public fun finish_unprotected_complete_v8<T0, T1, T2>(arg0: T2, arg1: CompleteSessionV8, arg2: &OutputRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg6: 0x1::string::String, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : (T2, SoulMintAuthorizationV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<T1, T2>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::release_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg4)));
        assert!(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg4) == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_product_release_catalog_id_v8<T0>(arg3), 1);
        assert!(!borrow_policy(arg2, arg1.output_key).protected_output, 2);
        let (v0, v1) = finish_complete<T0>(arg1, arg2, arg3, arg5, arg6, arg7, arg8, false, 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg9);
        let v2 = v1;
        let v3 = v0;
        v3.protection_binding_commitment = b"";
        let v4 = SoulMintAuthorizationV8{
            output                   : v3,
            receipt                  : v2,
            authorization_commitment : derive_soul_authorization_commitment(&v3, &v2),
        };
        (arg0, v4)
    }

    fun lexicographically_less(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        let v1 = if (0x1::vector::length<u8>(arg0) < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::length<u8>(arg0)
        } else {
            0x1::vector::length<u8>(arg1)
        };
        while (v0 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)) {
                return true
            };
            if (*0x1::vector::borrow<u8>(arg0, v0) > *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        0x1::vector::length<u8>(arg0) < 0x1::vector::length<u8>(arg1)
    }

    public fun mint_canonical_soul_v8<T0>(arg0: SoulMintAuthorizationV8, arg1: &mut OutputRegistryV8, arg2: &mut SoulRegistryV8, arg3: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active_registry_pair<T0>(arg1, arg2, arg3);
        let SoulMintAuthorizationV8 {
            output                   : v0,
            receipt                  : v1,
            authorization_commitment : v2,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        assert_exact_holder(v4.holder, 0x2::tx_context::sender(arg4));
        assert_exact_holder(v3.holder, 0x2::tx_context::sender(arg4));
        assert_complete_root<T0>(&v4, arg3);
        assert!(v3.output_id == 0x2::object::id<CompleteOutputV8>(&v4), 1);
        assert!(v3.output_key == v4.output_key, 1);
        let v5 = if (v3.loadout_id == v4.loadout_id) {
            if (v3.loadout_revision == v4.loadout_revision) {
                v3.loadout_commitment == v4.loadout_commitment
            } else {
                false
            }
        } else {
            false
        };
        assert!(v5, 1);
        assert!(v3.output_policy_commitment == v4.output_policy_commitment && v3.renderer_schema_commitment == v4.renderer_schema_commitment, 1);
        assert!(v2 == derive_soul_authorization_commitment(&v4, &v3), 10);
        if (v4.protected) {
            assert!(0x1::option::is_some<vector<u8>>(&v4.seal_id) && 0x1::option::is_some<vector<u8>>(&v3.seal_id), 10);
            assert!(!0x1::vector::is_empty<u8>(&v4.protection_binding_commitment), 10);
            assert!(v4.seal_id == v3.seal_id, 10);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&v4.seal_id) && 0x1::option::is_none<vector<u8>>(&v3.seal_id), 10);
            assert!(0x1::vector::is_empty<u8>(&v4.protection_binding_commitment), 10);
        };
        let v6 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_rights_v8<T0>(arg3);
        let v7 = 0x2::object::new(arg4);
        let v8 = 0x2::object::uid_to_inner(&v7);
        let v9 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::rights_soul_creator_royalty_bps_v8(&v6);
        let v10 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::rights_maker_source_royalty_bps_v8(&v6);
        let v11 = SoulCommitmentInputV8{
            domain                   : b"animacraft-v8/output/canonical-soul",
            version                  : 8,
            soul_registry_id         : 0x2::object::id<SoulRegistryV8>(arg2),
            root_id                  : v4.root_id,
            maker_version            : v4.maker_version,
            root_content_commitment  : v4.root_content_commitment,
            output_key               : v4.output_key,
            output_policy_commitment : v4.output_policy_commitment,
            holder                   : v4.holder,
            ownership_epoch          : 0,
            output_id                : 0x2::object::id<CompleteOutputV8>(&v4),
            receipt_id               : 0x2::object::id<CompleteReceiptV8>(&v3),
            recipe_commitment        : v4.recipe_commitment,
            render_commitment        : v4.render_commitment,
            output_commitment        : v4.output_commitment,
            receipt_commitment       : v3.receipt_commitment,
            soul_creator_royalty_bps : v9,
            maker_source_royalty_bps : v10,
        };
        let v12 = 0x1::hash::sha2_256(0x1::bcs::to_bytes<SoulCommitmentInputV8>(&v11));
        let v13 = CanonicalSoulV8{
            id                       : v7,
            version                  : 8,
            soul_registry_id         : 0x2::object::id<SoulRegistryV8>(arg2),
            root_id                  : v4.root_id,
            maker_version            : v4.maker_version,
            root_content_commitment  : v4.root_content_commitment,
            output_key               : v4.output_key,
            output_policy_commitment : v4.output_policy_commitment,
            holder                   : v4.holder,
            ownership_epoch          : 0,
            output_id                : 0x2::object::id<CompleteOutputV8>(&v4),
            receipt_id               : 0x2::object::id<CompleteReceiptV8>(&v3),
            recipe_commitment        : v4.recipe_commitment,
            render_commitment        : v4.render_commitment,
            output_commitment        : v4.output_commitment,
            receipt_commitment       : v3.receipt_commitment,
            soul_creator_royalty_bps : v9,
            maker_source_royalty_bps : v10,
            soul_commitment          : v12,
        };
        record_finished_output(arg1, &v4, &v3, v8);
        record_soul(arg2, &v13);
        let v14 = CanonicalSoulCreatedV8{
            soul_id         : v8,
            root_id         : v4.root_id,
            output_id       : 0x2::object::id<CompleteOutputV8>(&v4),
            receipt_id      : 0x2::object::id<CompleteReceiptV8>(&v3),
            holder          : v4.holder,
            soul_commitment : v12,
        };
        0x2::event::emit<CanonicalSoulCreatedV8>(v14);
        let v15 = v4.holder;
        0x2::transfer::transfer<CompleteOutputV8>(v4, v15);
        0x2::transfer::transfer<CompleteReceiptV8>(v3, v15);
        0x2::transfer::transfer<CanonicalSoulV8>(v13, v15);
    }

    fun mutate_base_counter(arg0: &mut OutputRegistryV8, arg1: address, arg2: u64) {
        let v0 = WalletKeyV8{holder: arg1};
        if (0x2::table::contains<WalletKeyV8, u64>(&arg0.complete_by_wallet, v0)) {
            assert!(*0x2::table::borrow<WalletKeyV8, u64>(&arg0.complete_by_wallet, v0) == arg2, 1);
            *0x2::table::borrow_mut<WalletKeyV8, u64>(&mut arg0.complete_by_wallet, v0) = arg2 + 1;
        } else {
            assert!(arg2 == 0, 1);
            0x2::table::add<WalletKeyV8, u64>(&mut arg0.complete_by_wallet, v0, 1);
            0x1::vector::push_back<WalletKeyV8>(&mut arg0.wallet_keys, v0);
        };
        arg0.total_complete_count = arg0.total_complete_count + 1;
    }

    public fun new_output_package_config_v8(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg1: 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::OutputRoleV8>, arg2: &mut 0x2::tx_context::TxContext) : OutputPackageConfigV8 {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_output_call_cap_v8(arg0, &arg1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::assert_type_origins_v8<OutputOriginalMarkerV8, OutputCallableMarkerV8>(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::output_binding_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg0)));
        OutputPackageConfigV8{
            id                         : 0x2::object::new(arg2),
            version                    : 8,
            catalog_id                 : 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_id_v8(arg0),
            product_binding_commitment : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::product_binding_commitment_v8(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::catalog_binding_v8(arg0)),
            output_call_cap            : arg1,
        }
    }

    public fun new_output_registries_v8<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : (OutputRegistryV8, SoulRegistryV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert!(arg2 <= 256, 0);
        assert_hash(&arg3);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg0);
        let v1 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg0);
        let v2 = *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v3 = empty_output_registry_commitment_v8<T0>(arg0);
        if (arg2 == 0) {
            assert!(arg3 == v3, 4);
        };
        let v4 = 0x2::object::new(arg4);
        let v5 = 0x2::object::new(arg4);
        let v6 = OutputRegistryV8{
            id                         : v4,
            version                    : 8,
            root_id                    : v0,
            maker_version              : v1,
            root_content_commitment    : v2,
            renderer_commitment        : *0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_renderer_commitment_v8<T0>(arg0),
            soul_registry_id           : 0x2::object::uid_to_inner(&v5),
            expected_output_count      : arg2,
            observed_output_count      : 0,
            expected_policy_commitment : arg3,
            rolling_policy_commitment  : v3,
            sealed                     : false,
            policy_rows                : 0x2::table::new<OutputPolicyKeyV8, OutputPolicyRowV8>(arg4),
            policy_keys                : 0x1::vector::empty<OutputPolicyKeyV8>(),
            total_complete_count       : 0,
            complete_by_wallet         : 0x2::table::new<WalletKeyV8, u64>(arg4),
            wallet_keys                : 0x1::vector::empty<WalletKeyV8>(),
            output_count               : 0,
            outputs                    : 0x2::table::new<0x2::object::ID, OutputRecordV8>(arg4),
            output_keys                : 0x1::vector::empty<0x2::object::ID>(),
            materialization_count      : 0,
            materializations           : 0x2::table::new<MaterializationKeyV8, vector<u8>>(arg4),
            materialization_keys       : 0x1::vector::empty<MaterializationKeyV8>(),
        };
        let v7 = SoulRegistryV8{
            id                      : v5,
            version                 : 8,
            root_id                 : v0,
            maker_version           : v1,
            root_content_commitment : v2,
            output_registry_id      : 0x2::object::uid_to_inner(&v4),
            soul_count              : 0,
            souls                   : 0x2::table::new<0x2::object::ID, SoulRecordV8>(arg4),
            soul_keys               : 0x1::vector::empty<0x2::object::ID>(),
        };
        (v6, v7)
    }

    public fun new_physical_materialization_witness_v8<T0>(arg0: &mut OutputRegistryV8, arg1: &SoulRegistryV8, arg2: &CompleteReceiptV8, arg3: &CanonicalSoulV8, arg4: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg5: &0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::MakerLoadoutV8, arg6: 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::RuntimePhysicalSelectionWitnessV8, arg7: 0x1::string::String, arg8: &0x2::tx_context::TxContext) : PhysicalMaterializationWitnessV8 {
        assert_active_registry_pair<T0>(arg0, arg1, arg4);
        assert_semantic_key(&arg7);
        let v0 = 0x2::tx_context::sender(arg8);
        assert_exact_holder(arg2.holder, v0);
        assert_exact_holder(arg3.holder, v0);
        assert!(arg2.root_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg4) && arg3.root_id == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_id_v8<T0>(arg4), 1);
        assert!(arg2.maker_version == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg4) && arg3.maker_version == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_maker_version_v8<T0>(arg4), 1);
        assert!(&arg2.root_content_commitment == 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_content_commitment_v8<T0>(arg4), 1);
        assert!(arg2.root_content_commitment == arg3.root_content_commitment, 1);
        assert!(arg3.soul_registry_id == 0x2::object::id<SoulRegistryV8>(arg1), 1);
        let v1 = 0x2::object::id<CompleteReceiptV8>(arg2);
        let v2 = 0x2::object::id<CanonicalSoulV8>(arg3);
        assert!(arg3.receipt_id == v1 && arg3.output_id == arg2.output_id, 1);
        assert!(arg3.output_key == arg2.output_key && arg3.output_policy_commitment == arg2.output_policy_commitment, 1);
        let v3 = if (arg3.recipe_commitment == arg2.recipe_commitment) {
            if (arg3.render_commitment == arg2.render_commitment) {
                if (arg3.output_commitment == arg2.output_commitment) {
                    arg3.receipt_commitment == arg2.receipt_commitment
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 1);
        assert!(borrow_policy(arg0, arg2.output_key).row_commitment == arg2.output_policy_commitment, 1);
        let v4 = 0x2::table::borrow<0x2::object::ID, OutputRecordV8>(&arg0.outputs, arg2.output_id);
        let v5 = if (v4.receipt_id == v1) {
            if (v4.soul_id == v2) {
                if (v4.holder == v0) {
                    if (v4.output_key == arg2.output_key) {
                        if (v4.output_policy_commitment == arg2.output_policy_commitment) {
                            if (v4.recipe_commitment == arg2.recipe_commitment) {
                                if (v4.render_commitment == arg2.render_commitment) {
                                    if (v4.output_commitment == arg2.output_commitment) {
                                        v4.receipt_commitment == arg2.receipt_commitment
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
        } else {
            false
        };
        assert!(v5, 1);
        let v6 = 0x2::table::borrow<0x2::object::ID, SoulRecordV8>(&arg1.souls, v2);
        let v7 = if (v6.output_id == arg2.output_id) {
            if (v6.receipt_id == v1) {
                if (v6.holder == v0) {
                    if (v6.ownership_epoch == arg3.ownership_epoch) {
                        v6.soul_commitment == arg3.soul_commitment
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
        assert!(v7, 1);
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27) = 0xa2d7c3c289d884d5899eb0afdfae8abca7555fb8640b493016502196a7500476::runtime_v8::consume_physical_selection_witness_v8(arg6, arg5, arg8);
        let v28 = if (v9 == arg2.root_id) {
            if (v10 == arg2.maker_version) {
                v11 == arg2.root_content_commitment
            } else {
                false
            }
        } else {
            false
        };
        assert!(v28, 10);
        assert!(v12 == v0, 6);
        let v29 = if (v8 == arg2.loadout_id) {
            if (v13 == arg2.loadout_revision) {
                v14 == arg2.loadout_commitment
            } else {
                false
            }
        } else {
            false
        };
        assert!(v29, 10);
        let v30 = PhysicalCompleteBindingV8{
            output_registry_id       : 0x2::object::id<OutputRegistryV8>(arg0),
            root_id                  : arg2.root_id,
            maker_version            : arg2.maker_version,
            root_content_commitment  : arg2.root_content_commitment,
            holder                   : v0,
            output_key               : arg2.output_key,
            output_policy_commitment : arg2.output_policy_commitment,
            output_id                : arg2.output_id,
            receipt_id               : v1,
            soul_id                  : v2,
            soul_ownership_epoch     : arg3.ownership_epoch,
            recipe_commitment        : arg2.recipe_commitment,
            render_commitment        : arg2.render_commitment,
            output_commitment        : arg2.output_commitment,
            receipt_commitment       : arg2.receipt_commitment,
            soul_commitment          : arg3.soul_commitment,
        };
        let v31 = PhysicalSelectionBindingV8{
            loadout_id                : v8,
            loadout_revision          : v13,
            loadout_commitment        : v14,
            selection_index           : v15,
            selection_commitment      : v16,
            source_class              : v21,
            part_key                  : v17,
            item_key                  : v18,
            style_key                 : v19,
            layer_track_key           : v20,
            source_definition_id      : v22,
            source_semantic_id        : v23,
            source_content_commitment : v24,
            source_epoch              : v25,
            pricing_commitment        : v26,
            asset_content_commitment  : v27,
        };
        let v32 = derive_physical_witness_commitment(0x2::object::id<OutputRegistryV8>(arg0), v30, v31, arg7);
        let v33 = MaterializationKeyV8{
            soul_id             : v2,
            materialization_key : arg7,
        };
        reserve_materialization(arg0, v33, v32);
        PhysicalMaterializationWitnessV8{
            complete            : v30,
            selection           : v31,
            materialization_key : arg7,
            witness_commitment  : v32,
        }
    }

    public fun output_policy_allowed_pack_kind_v8(arg0: &OutputPolicyRowV8) : u8 {
        arg0.allowed_pack_policy
    }

    public fun output_policy_allowlist_count_v8(arg0: &OutputPolicyRowV8) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.allowed_semantic_pack_ids)
    }

    public fun output_policy_allowlist_id_v8(arg0: &OutputPolicyRowV8, arg1: u64) : &0x1::string::String {
        0x1::vector::borrow<0x1::string::String>(&arg0.allowed_semantic_pack_ids, arg1)
    }

    public fun output_policy_output_key_v8(arg0: &OutputPolicyRowV8) : &0x1::string::String {
        &arg0.output_key
    }

    public fun output_policy_protected_v8(arg0: &OutputPolicyRowV8) : bool {
        arg0.protected_output
    }

    public fun output_policy_renderer_schema_commitment_v8(arg0: &OutputPolicyRowV8) : &vector<u8> {
        &arg0.renderer_schema_commitment
    }

    public fun output_policy_row_commitment_v8(arg0: &OutputPolicyRowV8) : &vector<u8> {
        &arg0.row_commitment
    }

    public fun output_policy_row_v8(arg0: &OutputRegistryV8, arg1: 0x1::string::String) : &OutputPolicyRowV8 {
        borrow_policy(arg0, arg1)
    }

    public fun output_policy_scope_key_v8(arg0: &OutputPolicyRowV8) : &0x1::string::String {
        &arg0.complete_scope_key
    }

    public fun output_policy_sequence_v8(arg0: &OutputPolicyRowV8) : u64 {
        arg0.sequence
    }

    public fun output_record_holder_v8(arg0: &OutputRecordV8) : address {
        arg0.holder
    }

    public fun output_record_output_key_v8(arg0: &OutputRecordV8) : &0x1::string::String {
        &arg0.output_key
    }

    public fun output_record_policy_commitment_v8(arg0: &OutputRecordV8) : &vector<u8> {
        &arg0.output_policy_commitment
    }

    public fun output_record_v8(arg0: &OutputRegistryV8, arg1: 0x2::object::ID) : &OutputRecordV8 {
        0x2::table::borrow<0x2::object::ID, OutputRecordV8>(&arg0.outputs, arg1)
    }

    public fun output_registry_expected_policy_count_v8(arg0: &OutputRegistryV8) : u64 {
        arg0.expected_output_count
    }

    public fun output_registry_id_v8(arg0: &OutputRegistryV8) : 0x2::object::ID {
        0x2::object::id<OutputRegistryV8>(arg0)
    }

    public fun output_registry_materialization_commitment_v8(arg0: &OutputRegistryV8, arg1: 0x2::object::ID, arg2: 0x1::string::String) : &vector<u8> {
        let v0 = MaterializationKeyV8{
            soul_id             : arg1,
            materialization_key : arg2,
        };
        0x2::table::borrow<MaterializationKeyV8, vector<u8>>(&arg0.materializations, v0)
    }

    public fun output_registry_materialization_count_v8(arg0: &OutputRegistryV8) : u64 {
        arg0.materialization_count
    }

    public fun output_registry_observed_policy_count_v8(arg0: &OutputRegistryV8) : u64 {
        arg0.observed_output_count
    }

    public fun output_registry_output_count_v8(arg0: &OutputRegistryV8) : u64 {
        arg0.output_count
    }

    public fun output_registry_policy_commitment_v8(arg0: &OutputRegistryV8) : &vector<u8> {
        &arg0.rolling_policy_commitment
    }

    public fun output_registry_sealed_v8(arg0: &OutputRegistryV8) : bool {
        arg0.sealed
    }

    public fun output_registry_soul_registry_id_v8(arg0: &OutputRegistryV8) : 0x2::object::ID {
        arg0.soul_registry_id
    }

    public fun output_registry_total_complete_count_v8(arg0: &OutputRegistryV8) : u64 {
        arg0.total_complete_count
    }

    public fun output_registry_wallet_complete_count_v8(arg0: &OutputRegistryV8, arg1: address) : u64 {
        let v0 = WalletKeyV8{holder: arg1};
        if (0x2::table::contains<WalletKeyV8, u64>(&arg0.complete_by_wallet, v0)) {
            *0x2::table::borrow<WalletKeyV8, u64>(&arg0.complete_by_wallet, v0)
        } else {
            0
        }
    }

    public fun pending_asset_key_v8(arg0: &ProtectedCompletePendingV8) : &0x1::string::String {
        &arg0.output.asset_key
    }

    public fun pending_complete_instance_commitment_v8(arg0: &ProtectedCompletePendingV8) : vector<u8> {
        0xf12dc22b720dc9d87cde8d76952ab252959cced372e8511abb54cbaa177e2a3::seal_v8::complete_instance_commitment_v8(arg0.output.recipe_commitment, arg0.output.render_commitment, arg0.output.output_commitment, arg0.receipt.receipt_commitment)
    }

    public fun pending_output_commitment_v8(arg0: &ProtectedCompletePendingV8) : &vector<u8> {
        &arg0.output.output_commitment
    }

    public fun pending_output_id_v8(arg0: &ProtectedCompletePendingV8) : 0x2::object::ID {
        0x2::object::id<CompleteOutputV8>(&arg0.output)
    }

    public fun pending_receipt_commitment_v8(arg0: &ProtectedCompletePendingV8) : &vector<u8> {
        &arg0.receipt.receipt_commitment
    }

    public fun pending_receipt_id_v8(arg0: &ProtectedCompletePendingV8) : 0x2::object::ID {
        0x2::object::id<CompleteReceiptV8>(&arg0.receipt)
    }

    public fun pending_recipe_commitment_v8(arg0: &ProtectedCompletePendingV8) : &vector<u8> {
        &arg0.output.recipe_commitment
    }

    public fun pending_render_commitment_v8(arg0: &ProtectedCompletePendingV8) : &vector<u8> {
        &arg0.output.render_commitment
    }

    public fun pending_scope_key_v8(arg0: &ProtectedCompletePendingV8) : &0x1::string::String {
        &arg0.output.scope_key
    }

    public fun physical_complete_holder_v8(arg0: &PhysicalCompleteBindingV8) : address {
        arg0.holder
    }

    public fun physical_complete_maker_version_v8(arg0: &PhysicalCompleteBindingV8) : u64 {
        arg0.maker_version
    }

    public fun physical_complete_output_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.output_commitment
    }

    public fun physical_complete_output_id_v8(arg0: &PhysicalCompleteBindingV8) : 0x2::object::ID {
        arg0.output_id
    }

    public fun physical_complete_output_key_v8(arg0: &PhysicalCompleteBindingV8) : &0x1::string::String {
        &arg0.output_key
    }

    public fun physical_complete_output_registry_id_v8(arg0: &PhysicalCompleteBindingV8) : 0x2::object::ID {
        arg0.output_registry_id
    }

    public fun physical_complete_policy_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.output_policy_commitment
    }

    public fun physical_complete_receipt_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.receipt_commitment
    }

    public fun physical_complete_receipt_id_v8(arg0: &PhysicalCompleteBindingV8) : 0x2::object::ID {
        arg0.receipt_id
    }

    public fun physical_complete_recipe_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.recipe_commitment
    }

    public fun physical_complete_render_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.render_commitment
    }

    public fun physical_complete_root_content_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun physical_complete_root_id_v8(arg0: &PhysicalCompleteBindingV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun physical_complete_soul_commitment_v8(arg0: &PhysicalCompleteBindingV8) : &vector<u8> {
        &arg0.soul_commitment
    }

    public fun physical_complete_soul_epoch_v8(arg0: &PhysicalCompleteBindingV8) : u64 {
        arg0.soul_ownership_epoch
    }

    public fun physical_complete_soul_id_v8(arg0: &PhysicalCompleteBindingV8) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun physical_selection_asset_content_commitment_v8(arg0: &PhysicalSelectionBindingV8) : &vector<u8> {
        &arg0.asset_content_commitment
    }

    public fun physical_selection_commitment_v8(arg0: &PhysicalSelectionBindingV8) : &vector<u8> {
        &arg0.selection_commitment
    }

    public fun physical_selection_index_v8(arg0: &PhysicalSelectionBindingV8) : u64 {
        arg0.selection_index
    }

    public fun physical_selection_item_key_v8(arg0: &PhysicalSelectionBindingV8) : &0x1::string::String {
        &arg0.item_key
    }

    public fun physical_selection_layer_track_key_v8(arg0: &PhysicalSelectionBindingV8) : &0x1::string::String {
        &arg0.layer_track_key
    }

    public fun physical_selection_loadout_commitment_v8(arg0: &PhysicalSelectionBindingV8) : &vector<u8> {
        &arg0.loadout_commitment
    }

    public fun physical_selection_loadout_id_v8(arg0: &PhysicalSelectionBindingV8) : 0x2::object::ID {
        arg0.loadout_id
    }

    public fun physical_selection_loadout_revision_v8(arg0: &PhysicalSelectionBindingV8) : u64 {
        arg0.loadout_revision
    }

    public fun physical_selection_part_key_v8(arg0: &PhysicalSelectionBindingV8) : &0x1::string::String {
        &arg0.part_key
    }

    public fun physical_selection_pricing_commitment_v8(arg0: &PhysicalSelectionBindingV8) : &vector<u8> {
        &arg0.pricing_commitment
    }

    public fun physical_selection_source_class_v8(arg0: &PhysicalSelectionBindingV8) : u8 {
        arg0.source_class
    }

    public fun physical_selection_source_content_commitment_v8(arg0: &PhysicalSelectionBindingV8) : &vector<u8> {
        &arg0.source_content_commitment
    }

    public fun physical_selection_source_definition_id_v8(arg0: &PhysicalSelectionBindingV8) : 0x2::object::ID {
        arg0.source_definition_id
    }

    public fun physical_selection_source_epoch_v8(arg0: &PhysicalSelectionBindingV8) : u64 {
        arg0.source_epoch
    }

    public fun physical_selection_source_semantic_id_v8(arg0: &PhysicalSelectionBindingV8) : &0x1::string::String {
        &arg0.source_semantic_id
    }

    public fun physical_selection_style_key_v8(arg0: &PhysicalSelectionBindingV8) : &0x1::string::String {
        &arg0.style_key
    }

    fun protocol_share(arg0: u64, arg1: u16) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        assert!(v0 > 0, 8);
        v0
    }

    fun purchase_received_soul_bundle<T0>(arg0: 0x2::transfer::Receiving<CompleteOutputV8>, arg1: 0x2::transfer::Receiving<CompleteReceiptV8>, arg2: 0x2::transfer::Receiving<CanonicalSoulV8>, arg3: &mut 0x2::object::UID, arg4: &SoulMarketCustodyBindingV8, arg5: &mut OutputRegistryV8, arg6: &mut SoulRegistryV8, arg7: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg8: address) {
        assert!(arg8 != @0x0 && arg8 != arg4.seller, 16);
        let (v0, v1, v2) = receive_soul_market_bundle(arg3, arg4, arg0, arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert_live_soul_bundle<T0>(&v5, &v4, &v3, arg5, arg6, arg7, arg4.seller, arg4.expected_soul_ownership_epoch);
        assert_soul_market_custody_bundle(arg4, &v5, &v4, &v3);
        let v6 = arg4.expected_soul_ownership_epoch + 1;
        v5.holder = arg8;
        v4.holder = arg8;
        v3.holder = arg8;
        v3.ownership_epoch = v6;
        v3.soul_commitment = derive_current_soul_commitment(&v3);
        0x2::table::borrow_mut<0x2::object::ID, OutputRecordV8>(&mut arg5.outputs, arg4.output_id).holder = arg8;
        let v7 = 0x2::table::borrow_mut<0x2::object::ID, SoulRecordV8>(&mut arg6.souls, arg4.soul_id);
        v7.holder = arg8;
        v7.ownership_epoch = v6;
        v7.soul_commitment = v3.soul_commitment;
        0x2::transfer::transfer<CompleteOutputV8>(v5, arg8);
        0x2::transfer::transfer<CompleteReceiptV8>(v4, arg8);
        0x2::transfer::transfer<CanonicalSoulV8>(v3, arg8);
    }

    public fun purchase_soul_bundle_from_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: 0x2::transfer::Receiving<CompleteOutputV8>, arg1: 0x2::transfer::Receiving<CompleteReceiptV8>, arg2: 0x2::transfer::Receiving<CanonicalSoulV8>, arg3: &mut 0x2::object::UID, arg4: &SoulMarketCustodyBindingV8, arg5: &mut OutputRegistryV8, arg6: &mut SoulRegistryV8, arg7: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg8: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg9: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg10: &T3, arg11: &T4, arg12: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>, arg13: address) {
        assert_active_soul_market_boundary<T0, T1, T2, T3, T4>(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        assert_soul_market_custody_header<T0, T3, T4>(arg4, arg3, arg5, arg6, arg7, arg10, arg11);
        purchase_received_soul_bundle<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg13);
    }

    public fun quote_base_complete_v8<T0>(arg0: &OutputRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: 0x1::string::String, arg3: address) : BaseCompleteLineV8 {
        assert!(arg3 != @0x0, 6);
        assert_registry_root<T0>(arg0, arg1);
        assert!(arg0.sealed, 14);
        borrow_policy(arg0, arg2);
        let v0 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::root_economics_v8<T0>(arg1);
        let v1 = WalletKeyV8{holder: arg3};
        let v2 = if (0x2::table::contains<WalletKeyV8, u64>(&arg0.complete_by_wallet, v1)) {
            *0x2::table::borrow<WalletKeyV8, u64>(&arg0.complete_by_wallet, v1)
        } else {
            0
        };
        assert_total_cap(arg0.total_complete_count, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_complete_total_cap_v8(&v0));
        let v3 = complete_price_for_ordinal(0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_complete_mode_v8(&v0), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_complete_price_atomic_v8(&v0), 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_complete_free_quota_per_wallet_v8(&v0), v2);
        let v4 = protocol_share(v3, 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_primary_content_fee_bps_v8(&v0));
        let v5 = 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::economics_fixed_complete_fee_atomic_v8(&v0);
        BaseCompleteLineV8{
            ordinal               : v2,
            base_gross_atomic     : v3,
            base_protocol_atomic  : v4,
            maker_atomic          : v3 - v4,
            fixed_protocol_atomic : v5,
            total_atomic          : v3 + v5,
        }
    }

    public fun receipt_commitment_v8(arg0: &CompleteReceiptV8) : &vector<u8> {
        &arg0.receipt_commitment
    }

    public fun receipt_holder_v8(arg0: &CompleteReceiptV8) : address {
        arg0.holder
    }

    public fun receipt_id_v8(arg0: &CompleteReceiptV8) : 0x2::object::ID {
        0x2::object::id<CompleteReceiptV8>(arg0)
    }

    public fun receipt_loadout_commitment_v8(arg0: &CompleteReceiptV8) : &vector<u8> {
        &arg0.loadout_commitment
    }

    public fun receipt_loadout_id_v8(arg0: &CompleteReceiptV8) : 0x2::object::ID {
        arg0.loadout_id
    }

    public fun receipt_loadout_revision_v8(arg0: &CompleteReceiptV8) : u64 {
        arg0.loadout_revision
    }

    public fun receipt_original_holder_v8(arg0: &CompleteReceiptV8) : address {
        arg0.original_holder
    }

    public fun receipt_output_key_v8(arg0: &CompleteReceiptV8) : &0x1::string::String {
        &arg0.output_key
    }

    public fun receipt_output_policy_commitment_v8(arg0: &CompleteReceiptV8) : &vector<u8> {
        &arg0.output_policy_commitment
    }

    public fun receipt_recipe_commitment_v8(arg0: &CompleteReceiptV8) : &vector<u8> {
        &arg0.recipe_commitment
    }

    public fun receipt_render_commitment_v8(arg0: &CompleteReceiptV8) : &vector<u8> {
        &arg0.render_commitment
    }

    fun receive_soul_market_bundle(arg0: &mut 0x2::object::UID, arg1: &SoulMarketCustodyBindingV8, arg2: 0x2::transfer::Receiving<CompleteOutputV8>, arg3: 0x2::transfer::Receiving<CompleteReceiptV8>, arg4: 0x2::transfer::Receiving<CanonicalSoulV8>) : (CompleteOutputV8, CompleteReceiptV8, CanonicalSoulV8) {
        assert!(0x2::transfer::receiving_object_id<CompleteOutputV8>(&arg2) == arg1.output_id, 15);
        assert!(0x2::transfer::receiving_object_id<CompleteReceiptV8>(&arg3) == arg1.receipt_id, 15);
        assert!(0x2::transfer::receiving_object_id<CanonicalSoulV8>(&arg4) == arg1.soul_id, 15);
        let v0 = 0x2::transfer::receive<CompleteOutputV8>(arg0, arg2);
        let v1 = 0x2::transfer::receive<CompleteReceiptV8>(arg0, arg3);
        let v2 = 0x2::transfer::receive<CanonicalSoulV8>(arg0, arg4);
        assert_soul_market_custody_bundle(arg1, &v0, &v1, &v2);
        (v0, v1, v2)
    }

    fun record_finished_output(arg0: &mut OutputRegistryV8, arg1: &CompleteOutputV8, arg2: &CompleteReceiptV8, arg3: 0x2::object::ID) {
        let v0 = 0x2::object::id<CompleteOutputV8>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, OutputRecordV8>(&arg0.outputs, v0), 11);
        let v1 = OutputRecordV8{
            output_id                : v0,
            receipt_id               : 0x2::object::id<CompleteReceiptV8>(arg2),
            soul_id                  : arg3,
            output_key               : arg1.output_key,
            output_policy_commitment : arg1.output_policy_commitment,
            holder                   : arg1.holder,
            recipe_commitment        : arg1.recipe_commitment,
            render_commitment        : arg1.render_commitment,
            output_commitment        : arg1.output_commitment,
            receipt_commitment       : arg2.receipt_commitment,
            protected                : arg1.protected,
            seal_id                  : arg1.seal_id,
        };
        0x2::table::add<0x2::object::ID, OutputRecordV8>(&mut arg0.outputs, v0, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.output_keys, v0);
        arg0.output_count = arg0.output_count + 1;
    }

    fun record_soul(arg0: &mut SoulRegistryV8, arg1: &CanonicalSoulV8) {
        let v0 = 0x2::object::id<CanonicalSoulV8>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, SoulRecordV8>(&arg0.souls, v0), 11);
        let v1 = SoulRecordV8{
            soul_id         : v0,
            output_id       : arg1.output_id,
            receipt_id      : arg1.receipt_id,
            holder          : arg1.holder,
            ownership_epoch : arg1.ownership_epoch,
            soul_commitment : arg1.soul_commitment,
        };
        0x2::table::add<0x2::object::ID, SoulRecordV8>(&mut arg0.souls, v0, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.soul_keys, v0);
        arg0.soul_count = arg0.soul_count + 1;
    }

    fun reserve_materialization(arg0: &mut OutputRegistryV8, arg1: MaterializationKeyV8, arg2: vector<u8>) {
        assert_hash(&arg2);
        assert!(!0x2::table::contains<MaterializationKeyV8, vector<u8>>(&arg0.materializations, arg1), 11);
        0x2::table::add<MaterializationKeyV8, vector<u8>>(&mut arg0.materializations, arg1, arg2);
        0x1::vector::push_back<MaterializationKeyV8>(&mut arg0.materialization_keys, arg1);
        arg0.materialization_count = arg0.materialization_count + 1;
    }

    public fun return_soul_bundle_from_market_v8<T0, T1, T2, T3: key, T4: key>(arg0: 0x2::transfer::Receiving<CompleteOutputV8>, arg1: 0x2::transfer::Receiving<CompleteReceiptV8>, arg2: 0x2::transfer::Receiving<CanonicalSoulV8>, arg3: &mut 0x2::object::UID, arg4: &SoulMarketCustodyBindingV8, arg5: &OutputRegistryV8, arg6: &SoulRegistryV8, arg7: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg8: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::ProductReleaseCatalogV8, arg9: &T3, arg10: &T4, arg11: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::PackageCallCapV8<0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::package_binding_v8::MarketRoleV8>) {
        assert_soul_market_boundary<T0, T1, T2, T3, T4>(arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        assert_soul_market_custody_header<T0, T3, T4>(arg4, arg3, arg5, arg6, arg7, arg9, arg10);
        let (v0, v1, v2) = receive_soul_market_bundle(arg3, arg4, arg0, arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert_live_soul_bundle<T0>(&v5, &v4, &v3, arg5, arg6, arg7, arg4.seller, arg4.expected_soul_ownership_epoch);
        assert_soul_market_custody_bundle(arg4, &v5, &v4, &v3);
        0x2::transfer::transfer<CompleteOutputV8>(v5, arg4.seller);
        0x2::transfer::transfer<CompleteReceiptV8>(v4, arg4.seller);
        0x2::transfer::transfer<CanonicalSoulV8>(v3, arg4.seller);
    }

    public fun seal_output_registry_v8<T0>(arg0: &mut OutputRegistryV8, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg2: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerAdminCapV8) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_identity<T0>(arg0, arg1);
        seal_policy_rows(arg0);
    }

    fun seal_policy_rows(arg0: &mut OutputRegistryV8) {
        assert!(!arg0.sealed, 13);
        assert!(arg0.observed_output_count == arg0.expected_output_count, 0);
        assert!(0x1::vector::length<OutputPolicyKeyV8>(&arg0.policy_keys) == arg0.expected_output_count, 0);
        assert!(arg0.rolling_policy_commitment == arg0.expected_policy_commitment, 4);
        arg0.sealed = true;
    }

    fun settle_base_payment<T0>(arg0: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::MakerRootV8<T0>, arg1: &0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolConfigV8, arg2: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::MakerTreasuryV8<T0>, arg3: &mut 0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::ProtocolTreasuryV8<T0>, arg4: 0x2::coin::Coin<T0>, arg5: BaseCompleteLineV8, arg6: &mut 0x2::tx_context::TxContext) {
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::maker_v8::assert_current_protocol_config_v8<T0>(arg0, arg1);
        0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::assert_maker_treasury_v8<T0>(arg0, arg2);
        assert!(0x2::coin::value<T0>(&arg4) == arg5.total_atomic, 8);
        if (arg5.fixed_protocol_atomic > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg1, arg3, 0x2::coin::split<T0>(&mut arg4, arg5.fixed_protocol_atomic, arg6));
        };
        if (arg5.base_protocol_atomic > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::protocol_config_v8::deposit_protocol_revenue_v8<T0>(arg1, arg3, 0x2::coin::split<T0>(&mut arg4, arg5.base_protocol_atomic, arg6));
        };
        assert!(0x2::coin::value<T0>(&arg4) == arg5.maker_atomic, 8);
        if (arg5.maker_atomic > 0) {
            0xca762c5432604d6680fbdc87367c3956a2e7536eb2d12222eb929945d97c9e6e::treasury_v8::deposit_maker_revenue_v8<T0>(arg0, arg2, arg1, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(arg4);
        };
    }

    public fun share_output_package_config_v8(arg0: OutputPackageConfigV8) {
        0x2::transfer::share_object<OutputPackageConfigV8>(arg0);
    }

    public fun share_output_registries_v8(arg0: OutputRegistryV8, arg1: SoulRegistryV8) {
        assert!(arg0.soul_registry_id == 0x2::object::id<SoulRegistryV8>(&arg1), 1);
        assert!(arg1.output_registry_id == 0x2::object::id<OutputRegistryV8>(&arg0), 1);
        0x2::transfer::share_object<OutputRegistryV8>(arg0);
        0x2::transfer::share_object<SoulRegistryV8>(arg1);
    }

    public fun soul_commitment_v8(arg0: &CanonicalSoulV8) : &vector<u8> {
        &arg0.soul_commitment
    }

    public fun soul_holder_v8(arg0: &CanonicalSoulV8) : address {
        arg0.holder
    }

    public fun soul_maker_version_v8(arg0: &CanonicalSoulV8) : u64 {
        arg0.maker_version
    }

    public fun soul_market_custody_ticket_binding_v8(arg0: &SoulMarketCustodyTicketV8) : &SoulMarketCustodyBindingV8 {
        &arg0.binding
    }

    public fun soul_market_expected_epoch_v8(arg0: &SoulMarketCustodyBindingV8) : u64 {
        arg0.expected_soul_ownership_epoch
    }

    public fun soul_market_listing_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.listing_id
    }

    public fun soul_market_maker_version_v8(arg0: &SoulMarketCustodyBindingV8) : u64 {
        arg0.maker_version
    }

    public fun soul_market_market_registry_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.market_registry_id
    }

    public fun soul_market_market_treasury_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.market_treasury_id
    }

    public fun soul_market_output_commitment_v8(arg0: &SoulMarketCustodyBindingV8) : &vector<u8> {
        &arg0.output_commitment
    }

    public fun soul_market_output_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.output_id
    }

    public fun soul_market_output_registry_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.output_registry_id
    }

    public fun soul_market_receipt_commitment_v8(arg0: &SoulMarketCustodyBindingV8) : &vector<u8> {
        &arg0.receipt_commitment
    }

    public fun soul_market_receipt_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.receipt_id
    }

    public fun soul_market_root_content_commitment_v8(arg0: &SoulMarketCustodyBindingV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun soul_market_root_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun soul_market_seller_v8(arg0: &SoulMarketCustodyBindingV8) : address {
        arg0.seller
    }

    public fun soul_market_soul_commitment_v8(arg0: &SoulMarketCustodyBindingV8) : &vector<u8> {
        &arg0.soul_commitment
    }

    public fun soul_market_soul_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun soul_market_soul_registry_id_v8(arg0: &SoulMarketCustodyBindingV8) : 0x2::object::ID {
        arg0.soul_registry_id
    }

    public fun soul_output_id_v8(arg0: &CanonicalSoulV8) : 0x2::object::ID {
        arg0.output_id
    }

    public fun soul_output_key_v8(arg0: &CanonicalSoulV8) : &0x1::string::String {
        &arg0.output_key
    }

    public fun soul_output_policy_commitment_v8(arg0: &CanonicalSoulV8) : &vector<u8> {
        &arg0.output_policy_commitment
    }

    public fun soul_ownership_epoch_v8(arg0: &CanonicalSoulV8) : u64 {
        arg0.ownership_epoch
    }

    public fun soul_receipt_id_v8(arg0: &CanonicalSoulV8) : 0x2::object::ID {
        arg0.receipt_id
    }

    public fun soul_record_commitment_v8(arg0: &SoulRecordV8) : &vector<u8> {
        &arg0.soul_commitment
    }

    public fun soul_record_holder_v8(arg0: &SoulRecordV8) : address {
        arg0.holder
    }

    public fun soul_record_ownership_epoch_v8(arg0: &SoulRecordV8) : u64 {
        arg0.ownership_epoch
    }

    public fun soul_record_v8(arg0: &SoulRegistryV8, arg1: 0x2::object::ID) : &SoulRecordV8 {
        0x2::table::borrow<0x2::object::ID, SoulRecordV8>(&arg0.souls, arg1)
    }

    public fun soul_registry_id_v8(arg0: &SoulRegistryV8) : 0x2::object::ID {
        0x2::object::id<SoulRegistryV8>(arg0)
    }

    public fun soul_registry_soul_count_v8(arg0: &SoulRegistryV8) : u64 {
        arg0.soul_count
    }

    public fun soul_root_content_commitment_v8(arg0: &CanonicalSoulV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun soul_root_id_v8(arg0: &CanonicalSoulV8) : 0x2::object::ID {
        arg0.root_id
    }

    fun validate_allowed_pack_policy(arg0: u8, arg1: &vector<0x1::string::String>) {
        assert!(arg0 == 0 || arg0 == 1, 2);
        assert!(0x1::vector::length<0x1::string::String>(arg1) <= 64, 2);
        if (arg0 == 0) {
            assert!(0x1::vector::is_empty<0x1::string::String>(arg1), 2);
            return
        };
        assert!(!0x1::vector::is_empty<0x1::string::String>(arg1), 2);
        let v0 = 0;
        let v1 = b"";
        while (v0 < 0x1::vector::length<0x1::string::String>(arg1)) {
            let v2 = 0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg1, v0));
            assert!(0x1::vector::length<u8>(v2) > 0 && 0x1::vector::length<u8>(v2) <= 128, 3);
            if (v0 > 0) {
                assert!(lexicographically_less(&v1, v2), 2);
            };
            v1 = *v2;
            v0 = v0 + 1;
        };
    }

    public fun version_v8() : u64 {
        8
    }

    // decompiled from Move bytecode v7
}

