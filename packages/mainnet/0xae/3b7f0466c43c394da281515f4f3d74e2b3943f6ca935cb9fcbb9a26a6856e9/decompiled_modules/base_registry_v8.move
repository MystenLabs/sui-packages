module 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::base_registry_v8 {
    struct BaseDefinitionCountsV8 has copy, drop, store {
        tracks: u64,
        colors: u64,
        parts: u64,
        items: u64,
        styles: u64,
        rules: u64,
        assets: u64,
    }

    struct BaseDefinitionCommitmentsV8 has copy, drop, store {
        tracks: vector<u8>,
        colors: vector<u8>,
        parts: vector<u8>,
        items: vector<u8>,
        styles: vector<u8>,
        rules: vector<u8>,
        assets: vector<u8>,
        aggregate: vector<u8>,
    }

    struct BaseDefinitionRegistryV8 has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        maker_version: u64,
        root_content_commitment: vector<u8>,
        expected_counts: BaseDefinitionCountsV8,
        observed_counts: BaseDefinitionCountsV8,
        initial_commitments: BaseDefinitionCommitmentsV8,
        rolling_commitments: BaseDefinitionCommitmentsV8,
        sealed_commitments: 0x1::option::Option<BaseDefinitionCommitmentsV8>,
        next_sequence: u64,
        expected_sequence_count: u64,
        protected_style_count: u64,
        color_swatch_count: u64,
        total_capacity: u64,
        rule_selector_count: u64,
        visibility_leaf_count: u64,
        author_rows_rolling_commitment: vector<u8>,
        sealed: bool,
    }

    struct TrackKeyV8 has copy, drop, store {
        key: 0x1::string::String,
    }

    struct PartKeyV8 has copy, drop, store {
        key: 0x1::string::String,
    }

    struct PartIndexKeyV8 has copy, drop, store {
        index: u64,
    }

    struct ItemKeyV8 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
    }

    struct StyleKeyV8 has copy, drop, store {
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
    }

    struct StyleIndexKeyV8 has copy, drop, store {
        index: u64,
    }

    struct ProtectedStyleIndexKeyV8 has copy, drop, store {
        index: u64,
    }

    struct ItemIndexKeyV8 has copy, drop, store {
        index: u64,
    }

    struct ColorKeyV8 has copy, drop, store {
        channel_key: 0x1::string::String,
    }

    struct AssetKeyV2 has copy, drop, store {
        asset_id: 0x1::string::String,
    }

    struct RuleKeyV8 has copy, drop, store {
        key: 0x1::string::String,
    }

    struct RuleIndexKeyV8 has copy, drop, store {
        index: u64,
    }

    struct TrackRowV2 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        label: 0x1::string::String,
        render_order: u64,
        locked: bool,
    }

    struct PackVisibilityRowV2 has copy, drop, store {
        subject: u8,
        definition_source: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::option::Option<0x1::string::String>,
        visibility_tokens: vector<VisibilityTokenV1>,
        visibility_commitment: vector<u8>,
    }

    struct PackDefinitionRowsV2 has copy, drop, store {
        semantic_pack_id: 0x1::string::String,
        tracks: vector<TrackRowV2>,
        colors: vector<ColorChannelRowV2>,
        parts: vector<PartRowV2>,
        rules: vector<RuleRowV2>,
        visibility: vector<PackVisibilityRowV2>,
    }

    struct ColorStopV2 has copy, drop, store {
        offset_ppm: u64,
        rgba: u32,
    }

    struct ColorSwatchV2 has copy, drop, store {
        key: 0x1::string::String,
        label: 0x1::string::String,
        rgba: u32,
        stops: vector<ColorStopV2>,
    }

    struct ColorChannelRowV2 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        label: 0x1::string::String,
        default_swatch_key: 0x1::string::String,
        swatches: vector<ColorSwatchV2>,
    }

    struct ColorChannelDraftV2 has store {
        sequence: u64,
        key: 0x1::string::String,
        label: 0x1::string::String,
        default_swatch_key: 0x1::string::String,
        expected_swatches: u64,
        swatches: vector<ColorSwatchV2>,
    }

    struct SemanticSelectorV2 has copy, drop, store {
        source: u8,
        source_key: 0x1::option::Option<0x1::string::String>,
        part_key: 0x1::string::String,
        item_key: 0x1::option::Option<0x1::string::String>,
        style_key: 0x1::option::Option<0x1::string::String>,
    }

    struct VisibilityTokenV1 has copy, drop, store {
        opcode: u8,
        selector: 0x1::option::Option<SemanticSelectorV2>,
        arity: u16,
    }

    struct SignedMilliV1 has copy, drop, store {
        negative: bool,
        magnitude: u64,
    }

    struct TransformFixedV1 has copy, drop, store {
        x_milli: SignedMilliV1,
        y_milli: SignedMilliV1,
        scale_ppm: u64,
        rotation_millidegrees: SignedMilliV1,
    }

    struct PhysicalPolicyV1 has copy, drop, store {
        material: 0x1::string::String,
        issuance: u8,
        proof: u8,
        price_atomic: u64,
        max_supply: u64,
        transferable: bool,
    }

    struct PartRowV2 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        label: 0x1::string::String,
        kind: u8,
        render_order: u64,
        menu_order: u64,
        visible: bool,
        required: bool,
        slot_mode: u8,
        capacity: u64,
        track_keys: vector<0x1::string::String>,
        visibility_tokens: vector<VisibilityTokenV1>,
        visibility_commitment: vector<u8>,
        payload_commitment: vector<u8>,
    }

    struct ItemRowV2 has copy, drop, store {
        sequence: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        label: 0x1::string::String,
        status: u8,
        display_order: u64,
        default_style_key: 0x1::string::String,
        visibility_tokens: vector<VisibilityTokenV1>,
        visibility_commitment: vector<u8>,
        payload_commitment: vector<u8>,
    }

    struct StyleRowV2 has copy, drop, store {
        sequence: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        label: 0x1::string::String,
        display_order: u64,
        track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        asset_id: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        protected: bool,
        transform: TransformFixedV1,
        opacity_ppm: u64,
        blend_mode: u8,
        physical: 0x1::option::Option<PhysicalPolicyV1>,
        visibility_tokens: vector<VisibilityTokenV1>,
        visibility_commitment: vector<u8>,
        payload_commitment: vector<u8>,
    }

    struct AssetRowV2 has copy, drop, store {
        sequence: u64,
        asset_id: 0x1::string::String,
        kind: 0x1::string::String,
        media_type: 0x1::string::String,
        byte_length: u64,
        sha256: vector<u8>,
    }

    struct RuleRowV2 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        kind: u8,
        trigger: SemanticSelectorV2,
        target_mode: u8,
        targets: vector<SemanticSelectorV2>,
        payload_commitment: vector<u8>,
    }

    struct SemanticSelectorCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        selector: SemanticSelectorV2,
    }

    struct RuleRowCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        definition_source: u8,
        definition_source_key: 0x1::option::Option<0x1::string::String>,
        sequence: u64,
        key: 0x1::string::String,
        kind: u8,
        trigger_selector_commitment: vector<u8>,
        target_mode: u8,
        ordered_target_selector_commitments: vector<vector<u8>>,
        payload_commitment: vector<u8>,
    }

    struct VisibilityProgramCommitmentInputV1 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        definition_source: u8,
        definition_source_key: 0x1::option::Option<0x1::string::String>,
        subject_level: u8,
        part_key: 0x1::string::String,
        item_key: 0x1::option::Option<0x1::string::String>,
        style_key: 0x1::option::Option<0x1::string::String>,
        tokens: vector<VisibilityTokenV1>,
    }

    struct RegistryRowCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        category_tag: u8,
        sequence: u64,
        row_bcs: vector<u8>,
    }

    struct AuthorRowsEmptyCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
    }

    struct AuthorRowsAdvanceCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        category_tag: u8,
        sequence: u64,
        aggregate_sequence: u64,
        prior_commitment: vector<u8>,
        row_bcs: vector<u8>,
    }

    struct AuthorRowsSealCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        ordered_counts: vector<u64>,
        final_rolling_commitment: vector<u8>,
    }

    struct RegistryAdvanceCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        registry_id: 0x2::object::ID,
        category_tag: u8,
        sequence: u64,
        prior_rolling_commitment: vector<u8>,
        row_commitment: vector<u8>,
    }

    struct RegistryEmptyCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        category_tag: u8,
    }

    struct RegistryCategorySealCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        category_tag: u8,
        count: u64,
        initial_commitment: vector<u8>,
        final_rolling_commitment: vector<u8>,
    }

    struct RegistrySealCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        maker_version: u64,
        ordered_category_tags: vector<u8>,
        ordered_category_commitments: vector<vector<u8>>,
        aggregate_count: u64,
    }

    struct BaseDefinitionCommitmentInputV2 has drop {
        domain: 0x1::string::String,
        schema_revision: u64,
        maker_key: 0x1::string::String,
        maker_version: u64,
        maker_document_commitment: vector<u8>,
        composition_commitment: vector<u8>,
        track_category_commitment: vector<u8>,
        color_category_commitment: vector<u8>,
        part_category_commitment: vector<u8>,
        item_category_commitment: vector<u8>,
        style_category_commitment: vector<u8>,
        rule_category_commitment: vector<u8>,
        asset_category_commitment: vector<u8>,
        output_category_commitment: vector<u8>,
        physical_category_commitment: vector<u8>,
        creator_defaults_commitment: vector<u8>,
        renderer_commitment: vector<u8>,
    }

    struct BaseDefinitionRegistrySealedV8 has copy, drop {
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        definition_count: u64,
        protected_style_count: u64,
        aggregate_commitment: vector<u8>,
    }

    fun advance_author_rows(arg0: &mut BaseDefinitionRegistryV8, arg1: u8, arg2: u64, arg3: vector<u8>) {
        arg0.author_rows_rolling_commitment = author_rows_advance_commitment_v2(arg1, arg2, arg0.next_sequence, arg0.author_rows_rolling_commitment, arg3);
    }

    fun advance_registry(arg0: &mut BaseDefinitionRegistryV8, arg1: u8, arg2: u64, arg3: vector<u8>) {
        let v0 = 0x2::object::id<BaseDefinitionRegistryV8>(arg0);
        let v1 = if (arg1 == 0) {
            &mut arg0.rolling_commitments.tracks
        } else if (arg1 == 1) {
            &mut arg0.rolling_commitments.colors
        } else if (arg1 == 2) {
            &mut arg0.rolling_commitments.parts
        } else if (arg1 == 3) {
            &mut arg0.rolling_commitments.items
        } else if (arg1 == 4) {
            &mut arg0.rolling_commitments.styles
        } else if (arg1 == 5) {
            &mut arg0.rolling_commitments.rules
        } else {
            assert!(arg1 == 6, 9);
            &mut arg0.rolling_commitments.assets
        };
        *v1 = registry_advance_commitment_v2(v0, arg1, arg2, *v1, arg3);
        arg0.rolling_commitments.aggregate = registry_advance_commitment_v2(v0, 255, arg0.next_sequence, arg0.rolling_commitments.aggregate, arg3);
        arg0.next_sequence = arg0.next_sequence + 1;
    }

    public fun append_asset_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: AssetRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 6, arg3.sequence);
        assert_asset_row(&arg3);
        let v0 = AssetKeyV2{asset_id: arg3.asset_id};
        assert!(!0x2::dynamic_field::exists<AssetKeyV2>(&arg0.id, v0), 5);
        let v1 = arg3.sequence;
        let v2 = 0x1::bcs::to_bytes<AssetRowV2>(&arg3);
        0x2::dynamic_field::add<AssetKeyV2, AssetRowV2>(&mut arg0.id, v0, arg3);
        arg0.observed_counts.assets = arg0.observed_counts.assets + 1;
        advance_author_rows(arg0, 6, v1, v2);
        let v3 = registry_row_commitment(arg0, 6, v1, v2);
        advance_registry(arg0, 6, v1, v3);
    }

    public fun append_color_channel_draft_v2(arg0: &mut ColorChannelDraftV2, arg1: u64, arg2: vector<ColorSwatchV2>) {
        assert!(0x1::vector::length<ColorSwatchV2>(&arg0.swatches) == arg1, 4);
        assert!(!0x1::vector::is_empty<ColorSwatchV2>(&arg2) && arg1 + 0x1::vector::length<ColorSwatchV2>(&arg2) <= arg0.expected_swatches, 3);
        0x1::vector::reverse<ColorSwatchV2>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<ColorSwatchV2>(&arg2)) {
            let v1 = 0x1::vector::pop_back<ColorSwatchV2>(&mut arg2);
            assert_color_swatch(&v1);
            let v2 = &arg0.swatches;
            let v3 = 0;
            while (v3 < 0x1::vector::length<ColorSwatchV2>(v2)) {
                assert!(0x1::vector::borrow<ColorSwatchV2>(v2, v3).key != v1.key, 5);
                v3 = v3 + 1;
            };
            0x1::vector::push_back<ColorSwatchV2>(&mut arg0.swatches, v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<ColorSwatchV2>(arg2);
    }

    public fun append_color_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: ColorChannelRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 1, arg3.sequence);
        assert_color_channel_row(&arg3);
        assert!(arg0.color_swatch_count + 0x1::vector::length<ColorSwatchV2>(&arg3.swatches) <= 5000, 3);
        let v0 = ColorKeyV8{channel_key: arg3.key};
        assert!(!0x2::dynamic_field::exists<ColorKeyV8>(&arg0.id, v0), 5);
        let v1 = arg3.sequence;
        let v2 = 0x1::bcs::to_bytes<ColorChannelRowV2>(&arg3);
        0x2::dynamic_field::add<ColorKeyV8, ColorChannelRowV2>(&mut arg0.id, v0, arg3);
        arg0.observed_counts.colors = arg0.observed_counts.colors + 1;
        arg0.color_swatch_count = arg0.color_swatch_count + 0x1::vector::length<ColorSwatchV2>(&arg3.swatches);
        advance_author_rows(arg0, 1, v1, v2);
        let v3 = registry_row_commitment(arg0, 1, v1, v2);
        advance_registry(arg0, 1, v1, v3);
    }

    public fun append_item_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: ItemRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 3, arg3.sequence);
        assert_item_row(&arg3);
        let v0 = PartKeyV8{key: arg3.part_key};
        assert!(0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v0), 6);
        let v1 = visibility_program_commitment_v1(1, 0x1::option::none<0x1::string::String>(), 1, arg3.part_key, 0x1::option::some<0x1::string::String>(arg3.item_key), 0x1::option::none<0x1::string::String>(), &arg3.visibility_tokens);
        assert!(&v1 == &arg3.visibility_commitment, 7);
        let v2 = validate_visibility_program_v1(&arg3.visibility_tokens);
        assert!(arg0.visibility_leaf_count + v2 <= 32000, 3);
        let v3 = ItemKeyV8{
            part_key : arg3.part_key,
            item_key : arg3.item_key,
        };
        assert!(!0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v3), 5);
        let v4 = arg3.sequence;
        let v5 = 0x1::bcs::to_bytes<ItemRowV2>(&arg3);
        let v6 = ItemIndexKeyV8{index: arg0.observed_counts.items};
        0x2::dynamic_field::add<ItemIndexKeyV8, ItemKeyV8>(&mut arg0.id, v6, v3);
        arg0.observed_counts.items = arg0.observed_counts.items + 1;
        arg0.visibility_leaf_count = arg0.visibility_leaf_count + v2;
        advance_author_rows(arg0, 3, v4, v5);
        let v7 = registry_row_commitment(arg0, 3, v4, v5);
        advance_registry(arg0, 3, v4, v7);
        0x2::dynamic_field::add<ItemKeyV8, ItemRowV2>(&mut arg0.id, v3, arg3);
    }

    public fun append_pack_definition_rows_v2(arg0: &mut PackDefinitionRowsV2, arg1: vector<TrackRowV2>, arg2: vector<ColorChannelRowV2>, arg3: vector<PartRowV2>, arg4: vector<RuleRowV2>, arg5: vector<PackVisibilityRowV2>) {
        let v0 = if (!0x1::vector::is_empty<TrackRowV2>(&arg1)) {
            true
        } else if (!0x1::vector::is_empty<ColorChannelRowV2>(&arg2)) {
            true
        } else if (!0x1::vector::is_empty<PartRowV2>(&arg3)) {
            true
        } else if (!0x1::vector::is_empty<RuleRowV2>(&arg4)) {
            true
        } else {
            !0x1::vector::is_empty<PackVisibilityRowV2>(&arg5)
        };
        assert!(v0, 3);
        let v1 = arg0.tracks;
        0x1::vector::append<TrackRowV2>(&mut v1, arg1);
        let v2 = arg0.colors;
        0x1::vector::append<ColorChannelRowV2>(&mut v2, arg2);
        let v3 = arg0.parts;
        0x1::vector::append<PartRowV2>(&mut v3, arg3);
        let v4 = arg0.rules;
        0x1::vector::append<RuleRowV2>(&mut v4, arg4);
        let v5 = arg0.visibility;
        0x1::vector::append<PackVisibilityRowV2>(&mut v5, arg5);
        *arg0 = new_pack_definition_rows_v2(arg0.semantic_pack_id, v1, v2, v3, v4, v5);
    }

    public fun append_part_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: PartRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 2, arg3.sequence);
        assert_part_row(&arg3);
        let v0 = visibility_program_commitment_v1(1, 0x1::option::none<0x1::string::String>(), 0, arg3.key, 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), &arg3.visibility_tokens);
        assert!(&v0 == &arg3.visibility_commitment, 7);
        let v1 = validate_visibility_program_v1(&arg3.visibility_tokens);
        assert!(arg0.visibility_leaf_count + v1 <= 32000, 3);
        assert!(arg0.total_capacity + arg3.capacity <= 500, 3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3.track_keys)) {
            let v3 = *0x1::vector::borrow<0x1::string::String>(&arg3.track_keys, v2);
            assert_non_empty_bounded(&v3, 128);
            let v4 = TrackKeyV8{key: v3};
            assert!(0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v4), 6);
            let v5 = 0;
            while (v5 < v2) {
                assert!(0x1::vector::borrow<0x1::string::String>(&arg3.track_keys, v5) != 0x1::vector::borrow<0x1::string::String>(&arg3.track_keys, v2), 11);
                v5 = v5 + 1;
            };
            v2 = v2 + 1;
        };
        let v6 = PartKeyV8{key: arg3.key};
        assert!(!0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v6), 5);
        let v7 = arg3.sequence;
        let v8 = 0x1::bcs::to_bytes<PartRowV2>(&arg3);
        let v9 = PartIndexKeyV8{index: arg0.observed_counts.parts};
        0x2::dynamic_field::add<PartIndexKeyV8, PartKeyV8>(&mut arg0.id, v9, v6);
        arg0.observed_counts.parts = arg0.observed_counts.parts + 1;
        arg0.total_capacity = arg0.total_capacity + arg3.capacity;
        arg0.visibility_leaf_count = arg0.visibility_leaf_count + v1;
        advance_author_rows(arg0, 2, v7, v8);
        let v10 = registry_row_commitment(arg0, 2, v7, v8);
        advance_registry(arg0, 2, v7, v10);
        0x2::dynamic_field::add<PartKeyV8, PartRowV2>(&mut arg0.id, v6, arg3);
    }

    public fun append_rule_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: RuleRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 5, arg3.sequence);
        assert_rule_row(&arg3);
        assert_base_selector_resolves_if_needed(arg0, &arg3.trigger);
        let v0 = 0;
        while (v0 < 0x1::vector::length<SemanticSelectorV2>(&arg3.targets)) {
            assert_base_selector_resolves_if_needed(arg0, 0x1::vector::borrow<SemanticSelectorV2>(&arg3.targets, v0));
            v0 = v0 + 1;
        };
        let v1 = 1 + 0x1::vector::length<SemanticSelectorV2>(&arg3.targets);
        assert!(arg0.rule_selector_count + v1 <= 33000, 3);
        let v2 = RuleKeyV8{key: arg3.key};
        assert!(!0x2::dynamic_field::exists<RuleKeyV8>(&arg0.id, v2), 5);
        let v3 = arg3.sequence;
        advance_author_rows(arg0, 5, v3, 0x1::bcs::to_bytes<RuleRowV2>(&arg3));
        let v4 = RuleIndexKeyV8{index: arg0.observed_counts.rules};
        0x2::dynamic_field::add<RuleIndexKeyV8, RuleKeyV8>(&mut arg0.id, v4, v2);
        arg0.observed_counts.rules = arg0.observed_counts.rules + 1;
        arg0.rule_selector_count = arg0.rule_selector_count + v1;
        advance_registry(arg0, 5, v3, rule_row_commitment_v2(1, 0x1::option::none<0x1::string::String>(), &arg3));
        0x2::dynamic_field::add<RuleKeyV8, RuleRowV2>(&mut arg0.id, v2, arg3);
    }

    public fun append_style_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: StyleRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 4, arg3.sequence);
        assert_style_row(&arg3);
        let v0 = ItemKeyV8{
            part_key : arg3.part_key,
            item_key : arg3.item_key,
        };
        assert!(0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v0), 6);
        let v1 = TrackKeyV8{key: arg3.track_key};
        assert!(0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v1), 6);
        let v2 = visibility_program_commitment_v1(1, 0x1::option::none<0x1::string::String>(), 2, arg3.part_key, 0x1::option::some<0x1::string::String>(arg3.item_key), 0x1::option::some<0x1::string::String>(arg3.style_key), &arg3.visibility_tokens);
        assert!(&v2 == &arg3.visibility_commitment, 7);
        let v3 = validate_visibility_program_v1(&arg3.visibility_tokens);
        assert!(arg0.visibility_leaf_count + v3 <= 32000, 3);
        let v4 = StyleKeyV8{
            part_key  : arg3.part_key,
            item_key  : arg3.item_key,
            style_key : arg3.style_key,
        };
        assert!(!0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v4), 5);
        let v5 = arg3.sequence;
        let v6 = 0x1::bcs::to_bytes<StyleRowV2>(&arg3);
        let v7 = StyleIndexKeyV8{index: arg0.observed_counts.styles};
        0x2::dynamic_field::add<StyleIndexKeyV8, StyleKeyV8>(&mut arg0.id, v7, v4);
        arg0.observed_counts.styles = arg0.observed_counts.styles + 1;
        if (arg3.protected) {
            let v8 = ProtectedStyleIndexKeyV8{index: arg0.protected_style_count};
            0x2::dynamic_field::add<ProtectedStyleIndexKeyV8, StyleKeyV8>(&mut arg0.id, v8, v4);
            arg0.protected_style_count = arg0.protected_style_count + 1;
        };
        arg0.visibility_leaf_count = arg0.visibility_leaf_count + v3;
        advance_author_rows(arg0, 4, v5, v6);
        let v9 = registry_row_commitment(arg0, 4, v5, v6);
        advance_registry(arg0, 4, v5, v9);
        0x2::dynamic_field::add<StyleKeyV8, StyleRowV2>(&mut arg0.id, v4, arg3);
    }

    public fun append_track_v2<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg3: TrackRowV2) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 0, arg3.sequence);
        assert_track_row(&arg3);
        let v0 = TrackKeyV8{key: arg3.key};
        assert!(!0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v0), 5);
        let v1 = arg3.sequence;
        let v2 = 0x1::bcs::to_bytes<TrackRowV2>(&arg3);
        0x2::dynamic_field::add<TrackKeyV8, TrackRowV2>(&mut arg0.id, v0, arg3);
        arg0.observed_counts.tracks = arg0.observed_counts.tracks + 1;
        advance_author_rows(arg0, 0, v1, v2);
        let v3 = registry_row_commitment(arg0, 0, v1, v2);
        advance_registry(arg0, 0, v1, v3);
    }

    public fun assert_activation_ready_v8<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>) : (0x2::object::ID, vector<u8>, u64) {
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::assert_draft_v8<T0>(arg1);
        assert_registry_identity<T0>(arg0, arg1);
        assert!(arg0.sealed, 0);
        assert!(arg0.next_sequence == arg0.expected_sequence_count, 8);
        assert_counts_equal(&arg0.observed_counts, &arg0.expected_counts);
        assert!(0x1::option::is_some<BaseDefinitionCommitmentsV8>(&arg0.sealed_commitments), 7);
        let v0 = derive_sealed_commitments(arg0);
        assert!(0x1::option::borrow<BaseDefinitionCommitmentsV8>(&arg0.sealed_commitments) == &v0, 7);
        assert!(&v0.aggregate == 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_sealed_base_registry_commitment_v2<T0>(arg1), 7);
        (0x2::object::id<BaseDefinitionRegistryV8>(arg0), v0.aggregate, arg0.protected_style_count)
    }

    fun assert_asset_row(arg0: &AssetRowV2) {
        assert_non_empty_bounded(&arg0.asset_id, 128);
        assert_non_empty_bounded(&arg0.kind, 256);
        assert_non_empty_bounded(&arg0.media_type, 256);
        assert!(arg0.byte_length > 0 && arg0.byte_length <= 8388608, 11);
        assert_hash(&arg0.sha256);
    }

    fun assert_base_selector_resolves_if_needed(arg0: &BaseDefinitionRegistryV8, arg1: &SemanticSelectorV2) {
        if (arg1.source != 1) {
            return
        };
        if (0x1::option::is_none<0x1::string::String>(&arg1.item_key)) {
            let v0 = PartKeyV8{key: arg1.part_key};
            assert!(0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v0), 6);
        } else if (0x1::option::is_none<0x1::string::String>(&arg1.style_key)) {
            let v1 = ItemKeyV8{
                part_key : arg1.part_key,
                item_key : *0x1::option::borrow<0x1::string::String>(&arg1.item_key),
            };
            assert!(0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v1), 6);
        } else {
            let v2 = StyleKeyV8{
                part_key  : arg1.part_key,
                item_key  : *0x1::option::borrow<0x1::string::String>(&arg1.item_key),
                style_key : *0x1::option::borrow<0x1::string::String>(&arg1.style_key),
            };
            assert!(0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v2), 6);
        };
    }

    fun assert_category_sequence(arg0: &BaseDefinitionRegistryV8, arg1: u8, arg2: u64) {
        assert!(arg1 <= 6, 9);
        let v0 = count_vector(&arg0.expected_counts);
        let v1 = count_vector(&arg0.observed_counts);
        let v2 = (arg1 as u64);
        assert!(arg2 == *0x1::vector::borrow<u64>(&v1, v2) && arg2 < *0x1::vector::borrow<u64>(&v0, v2), 4);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u64>(&v1, v3) == *0x1::vector::borrow<u64>(&v0, v3), 4);
            v3 = v3 + 1;
        };
    }

    fun assert_color_channel_row(arg0: &ColorChannelRowV2) {
        assert_non_empty_bounded(&arg0.key, 128);
        assert_non_empty_bounded(&arg0.label, 256);
        assert_non_empty_bounded(&arg0.default_swatch_key, 128);
        assert!(!0x1::vector::is_empty<ColorSwatchV2>(&arg0.swatches) && 0x1::vector::length<ColorSwatchV2>(&arg0.swatches) <= 5000, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<ColorSwatchV2>(&arg0.swatches)) {
            let v2 = 0x1::vector::borrow<ColorSwatchV2>(&arg0.swatches, v1);
            assert_color_swatch(v2);
            if (&v2.key == &arg0.default_swatch_key) {
                v0 = true;
            };
            let v3 = 0;
            while (v3 < v1) {
                assert!(&0x1::vector::borrow<ColorSwatchV2>(&arg0.swatches, v3).key != &v2.key, 11);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 11);
    }

    fun assert_color_stop(arg0: &ColorStopV2) {
        assert!(arg0.offset_ppm <= 1000000, 11);
    }

    fun assert_color_swatch(arg0: &ColorSwatchV2) {
        assert_non_empty_bounded(&arg0.key, 128);
        assert_non_empty_bounded(&arg0.label, 256);
        let v0 = 0;
        while (v0 < 0x1::vector::length<ColorStopV2>(&arg0.stops)) {
            assert_color_stop(0x1::vector::borrow<ColorStopV2>(&arg0.stops, v0));
            if (v0 > 0) {
                assert!(0x1::vector::borrow<ColorStopV2>(&arg0.stops, v0 - 1).offset_ppm <= 0x1::vector::borrow<ColorStopV2>(&arg0.stops, v0).offset_ppm, 11);
            };
            v0 = v0 + 1;
        };
    }

    fun assert_commitments(arg0: &BaseDefinitionCommitmentsV8) {
        assert_hash(&arg0.tracks);
        assert_hash(&arg0.colors);
        assert_hash(&arg0.parts);
        assert_hash(&arg0.items);
        assert_hash(&arg0.styles);
        assert_hash(&arg0.rules);
        assert_hash(&arg0.assets);
        assert_hash(&arg0.aggregate);
    }

    fun assert_counts_equal(arg0: &BaseDefinitionCountsV8, arg1: &BaseDefinitionCountsV8) {
        assert!(arg0 == arg1, 8);
    }

    fun assert_definition_scope(arg0: u8, arg1: &0x1::option::Option<0x1::string::String>) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0 && 0x1::option::is_some<0x1::string::String>(arg1) == arg0 != 1, 11);
        if (arg0 != 1) {
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(arg1), 128);
        };
    }

    public fun assert_draft_registry_identity_v8<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8) {
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_identity<T0>(arg0, arg1);
    }

    fun assert_external_product_key(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = if (0x1::vector::length<u8>(v0) == 66) {
            if (*0x1::vector::borrow<u8>(v0, 0) == 48) {
                *0x1::vector::borrow<u8>(v0, 1) == 120
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 11);
        let v2 = 2;
        let v3 = false;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            let v4 = *0x1::vector::borrow<u8>(v0, v2);
            assert!(v4 >= 48 && v4 <= 57 || v4 >= 97 && v4 <= 102, 11);
            let v5 = v3 || v4 != 48;
            v3 = v5;
            v2 = v2 + 1;
        };
        assert!(v3, 11);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::protocol_config_v8::is_nonzero_hash_v2(arg0), 1);
    }

    fun assert_item_default_styles(arg0: &BaseDefinitionRegistryV8) {
        let v0 = 0;
        while (v0 < arg0.observed_counts.items) {
            let v1 = ItemIndexKeyV8{index: v0};
            let v2 = 0x2::dynamic_field::borrow<ItemKeyV8, ItemRowV2>(&arg0.id, *0x2::dynamic_field::borrow<ItemIndexKeyV8, ItemKeyV8>(&arg0.id, v1));
            let v3 = StyleKeyV8{
                part_key  : v2.part_key,
                item_key  : v2.item_key,
                style_key : v2.default_style_key,
            };
            assert!(0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v3), 6);
            v0 = v0 + 1;
        };
    }

    fun assert_item_row(arg0: &ItemRowV2) {
        assert_non_empty_bounded(&arg0.part_key, 128);
        assert_non_empty_bounded(&arg0.item_key, 128);
        assert_non_empty_bounded(&arg0.label, 256);
        assert!(arg0.status == 0 || arg0.status == 1, 11);
        assert_non_empty_bounded(&arg0.default_style_key, 128);
        assert_hash(&arg0.visibility_commitment);
        assert_hash(&arg0.payload_commitment);
        validate_visibility_program_v1(&arg0.visibility_tokens);
    }

    fun assert_non_empty_bounded(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= arg1, 2);
    }

    fun assert_ordered_category_tags(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 9);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            assert_valid_category(*0x1::vector::borrow<u8>(arg0, v0));
            if (v0 > 0) {
                assert!(*0x1::vector::borrow<u8>(arg0, v0 - 1) < *0x1::vector::borrow<u8>(arg0, v0), 9);
            };
            v0 = v0 + 1;
        };
    }

    public fun assert_pack_additive_definitions_v2(arg0: &BaseDefinitionRegistryV8, arg1: &PackDefinitionRowsV2) {
        assert!(arg0.sealed, 0);
        let v0 = &arg1.tracks;
        let v1 = 0;
        while (v1 < 0x1::vector::length<TrackRowV2>(v0)) {
            let v2 = TrackKeyV8{key: 0x1::vector::borrow<TrackRowV2>(v0, v1).key};
            assert!(!0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v2), 5);
            v1 = v1 + 1;
        };
        let v3 = &arg1.colors;
        let v4 = 0;
        while (v4 < 0x1::vector::length<ColorChannelRowV2>(v3)) {
            let v5 = ColorKeyV8{channel_key: 0x1::vector::borrow<ColorChannelRowV2>(v3, v4).key};
            assert!(!0x2::dynamic_field::exists<ColorKeyV8>(&arg0.id, v5), 5);
            v4 = v4 + 1;
        };
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &arg1.parts;
        let v8 = 0;
        while (v8 < 0x1::vector::length<PartRowV2>(v7)) {
            let v9 = 0x1::vector::borrow<PartRowV2>(v7, v8);
            let v10 = PartKeyV8{key: v9.key};
            assert!(!0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v10), 5);
            0x1::vector::push_back<0x1::string::String>(&mut v6, v9.key);
            v8 = v8 + 1;
        };
        let v11 = &arg1.rules;
        let v12 = 0;
        while (v12 < 0x1::vector::length<RuleRowV2>(v11)) {
            let v13 = RuleKeyV8{key: 0x1::vector::borrow<RuleRowV2>(v11, v12).key};
            assert!(!0x2::dynamic_field::exists<RuleKeyV8>(&arg0.id, v13), 5);
            v12 = v12 + 1;
        };
        let v14 = &arg1.visibility;
        let v15 = 0;
        while (v15 < 0x1::vector::length<PackVisibilityRowV2>(v14)) {
            let v16 = 0x1::vector::borrow<PackVisibilityRowV2>(v14, v15);
            let v17 = if (0x1::vector::contains<0x1::string::String>(&v6, &v16.part_key)) {
                true
            } else {
                let v18 = PartKeyV8{key: v16.part_key};
                0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v18)
            };
            assert!(v17, 6);
            let v19 = ItemKeyV8{
                part_key : v16.part_key,
                item_key : v16.item_key,
            };
            let v20 = 0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v19);
            if (v16.subject == 1) {
                let v21 = if (v20) {
                    1
                } else {
                    2
                };
                assert!(v16.definition_source == v21, 11);
                if (v20) {
                    let v22 = ItemKeyV8{
                        part_key : v16.part_key,
                        item_key : v16.item_key,
                    };
                    assert!(v16.visibility_tokens == 0x2::dynamic_field::borrow<ItemKeyV8, ItemRowV2>(&arg0.id, v22).visibility_tokens, 11);
                };
            } else {
                let v23 = StyleKeyV8{
                    part_key  : v16.part_key,
                    item_key  : v16.item_key,
                    style_key : *0x1::option::borrow<0x1::string::String>(&v16.style_key),
                };
                assert!(!0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v23), 5);
                borrow_pack_visibility_v2(arg1, 1, v16.part_key, v16.item_key, 0x1::option::none<0x1::string::String>());
            };
            v15 = v15 + 1;
        };
        let v24 = &arg1.rules;
        let v25 = 0;
        while (v25 < 0x1::vector::length<RuleRowV2>(v24)) {
            let v26 = &0x1::vector::borrow<RuleRowV2>(v24, v25).trigger;
            assert!(v26.source == 0 || v26.source == 1, 11);
            if (0x1::option::is_none<0x1::string::String>(&v26.item_key)) {
                assert!(0x1::vector::contains<0x1::string::String>(&v6, &v26.part_key), 11);
            } else {
                let v27 = if (0x1::option::is_some<0x1::string::String>(&v26.style_key)) {
                    2
                } else {
                    1
                };
                assert!(borrow_pack_visibility_v2(arg1, v27, v26.part_key, *0x1::option::borrow<0x1::string::String>(&v26.item_key), v26.style_key).definition_source == 2, 11);
            };
            v25 = v25 + 1;
        };
    }

    fun assert_part_policy(arg0: u8, arg1: bool) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0 && (arg0 != 2 || arg1), 11);
    }

    fun assert_part_row(arg0: &PartRowV2) {
        assert_non_empty_bounded(&arg0.key, 128);
        assert_non_empty_bounded(&arg0.label, 256);
        assert_hash(&arg0.visibility_commitment);
        assert_hash(&arg0.payload_commitment);
        assert_part_policy(arg0.kind, arg0.required);
        assert!(arg0.slot_mode == 0 || arg0.slot_mode == 1, 11);
        assert!(arg0.capacity > 0 && arg0.capacity <= 64, 11);
        assert!(0x1::vector::length<0x1::string::String>(&arg0.track_keys) <= 256, 11);
        validate_visibility_program_v1(&arg0.visibility_tokens);
    }

    fun assert_physical_policy(arg0: &PhysicalPolicyV1) {
        assert_non_empty_bounded(&arg0.material, 256);
        let v0 = if (arg0.issuance == 0) {
            true
        } else if (arg0.issuance == 1) {
            true
        } else {
            arg0.issuance == 2
        };
        let v1 = if (v0) {
            if (arg0.proof == 0 || arg0.proof == 1) {
                arg0.max_supply > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 11);
    }

    public fun assert_public_item_v2(arg0: &ItemRowV2) {
        assert!(arg0.status == 0, 12);
    }

    fun assert_registry_identity<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 10);
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::assert_base_registry_identity_v8<T0>(arg1, 0x2::object::id<BaseDefinitionRegistryV8>(arg0), arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.expected_sequence_count == 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_expected_base_definition_count_v8<T0>(arg1), 8);
    }

    fun assert_rule_kind(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 11);
    }

    fun assert_rule_row(arg0: &RuleRowV2) {
        assert_non_empty_bounded(&arg0.key, 128);
        assert_rule_kind(arg0.kind);
        assert!(arg0.target_mode == 0 || arg0.target_mode == 1, 11);
        assert!(arg0.kind != 1 || arg0.target_mode == 1, 11);
        assert_semantic_selector(&arg0.trigger);
        assert!(0x1::vector::length<SemanticSelectorV2>(&arg0.targets) > 0 && 0x1::vector::length<SemanticSelectorV2>(&arg0.targets) <= 32, 11);
        let v0 = 0;
        while (v0 < 0x1::vector::length<SemanticSelectorV2>(&arg0.targets)) {
            assert_semantic_selector(0x1::vector::borrow<SemanticSelectorV2>(&arg0.targets, v0));
            v0 = v0 + 1;
        };
        assert_hash(&arg0.payload_commitment);
    }

    fun assert_semantic_selector(arg0: &SemanticSelectorV2) {
        assert!(arg0.source <= 3, 11);
        if (arg0.source == 0 || arg0.source == 1) {
            assert!(0x1::option::is_none<0x1::string::String>(&arg0.source_key), 11);
        } else {
            assert!(0x1::option::is_some<0x1::string::String>(&arg0.source_key), 11);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg0.source_key), 128);
            if (arg0.source == 3) {
                assert_external_product_key(0x1::option::borrow<0x1::string::String>(&arg0.source_key));
            };
        };
        assert_non_empty_bounded(&arg0.part_key, 128);
        if (0x1::option::is_some<0x1::string::String>(&arg0.item_key)) {
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg0.item_key), 128);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg0.style_key)) {
            assert!(0x1::option::is_some<0x1::string::String>(&arg0.item_key), 11);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg0.style_key), 128);
        };
    }

    fun assert_signed_milli(arg0: &SignedMilliV1, arg1: u64) {
        assert!(arg0.magnitude <= arg1 && (arg0.magnitude != 0 || !arg0.negative), 11);
    }

    fun assert_style_assets(arg0: &BaseDefinitionRegistryV8) {
        let v0 = 0;
        while (v0 < arg0.observed_counts.styles) {
            let v1 = StyleIndexKeyV8{index: v0};
            let v2 = AssetKeyV2{asset_id: 0x2::dynamic_field::borrow<StyleKeyV8, StyleRowV2>(&arg0.id, *0x2::dynamic_field::borrow<StyleIndexKeyV8, StyleKeyV8>(&arg0.id, v1)).asset_id};
            assert!(0x2::dynamic_field::exists<AssetKeyV2>(&arg0.id, v2), 6);
            v0 = v0 + 1;
        };
    }

    fun assert_style_color_references(arg0: &BaseDefinitionRegistryV8) {
        let v0 = 0;
        while (v0 < arg0.observed_counts.styles) {
            let v1 = StyleIndexKeyV8{index: v0};
            let v2 = 0x2::dynamic_field::borrow<StyleKeyV8, StyleRowV2>(&arg0.id, *0x2::dynamic_field::borrow<StyleIndexKeyV8, StyleKeyV8>(&arg0.id, v1));
            if (0x1::option::is_some<0x1::string::String>(&v2.color_channel_key)) {
                let v3 = ColorKeyV8{channel_key: *0x1::option::borrow<0x1::string::String>(&v2.color_channel_key)};
                assert!(0x2::dynamic_field::exists<ColorKeyV8>(&arg0.id, v3), 6);
                assert!(has_swatch(0x2::dynamic_field::borrow<ColorKeyV8, ColorChannelRowV2>(&arg0.id, v3), 0x1::option::borrow<0x1::string::String>(&v2.default_swatch_key)), 6);
            };
            v0 = v0 + 1;
        };
    }

    fun assert_style_row(arg0: &StyleRowV2) {
        assert_non_empty_bounded(&arg0.part_key, 128);
        assert_non_empty_bounded(&arg0.item_key, 128);
        assert_non_empty_bounded(&arg0.style_key, 128);
        assert_non_empty_bounded(&arg0.label, 256);
        assert_non_empty_bounded(&arg0.track_key, 128);
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.color_channel_key) == 0x1::option::is_some<0x1::string::String>(&arg0.default_swatch_key), 6);
        if (0x1::option::is_some<0x1::string::String>(&arg0.color_channel_key)) {
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg0.color_channel_key), 128);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg0.default_swatch_key), 128);
        };
        assert_non_empty_bounded(&arg0.asset_id, 128);
        assert_non_empty_bounded(&arg0.asset_blob_id, 512);
        assert_hash(&arg0.asset_sha256);
        assert_transform(&arg0.transform);
        assert!(arg0.opacity_ppm <= 1000000, 11);
        let v0 = if (arg0.blend_mode == 0) {
            true
        } else if (arg0.blend_mode == 1) {
            true
        } else if (arg0.blend_mode == 2) {
            true
        } else if (arg0.blend_mode == 3) {
            true
        } else if (arg0.blend_mode == 4) {
            true
        } else if (arg0.blend_mode == 5) {
            true
        } else if (arg0.blend_mode == 6) {
            true
        } else if (arg0.blend_mode == 7) {
            true
        } else if (arg0.blend_mode == 8) {
            true
        } else if (arg0.blend_mode == 9) {
            true
        } else if (arg0.blend_mode == 10) {
            true
        } else if (arg0.blend_mode == 11) {
            true
        } else if (arg0.blend_mode == 12) {
            true
        } else if (arg0.blend_mode == 13) {
            true
        } else if (arg0.blend_mode == 14) {
            true
        } else if (arg0.blend_mode == 15) {
            true
        } else {
            arg0.blend_mode == 16
        };
        assert!(v0, 11);
        if (0x1::option::is_some<PhysicalPolicyV1>(&arg0.physical)) {
            assert_physical_policy(0x1::option::borrow<PhysicalPolicyV1>(&arg0.physical));
        };
        assert_hash(&arg0.visibility_commitment);
        assert_hash(&arg0.payload_commitment);
        validate_visibility_program_v1(&arg0.visibility_tokens);
    }

    fun assert_subject_path(arg0: u8, arg1: &0x1::string::String, arg2: &0x1::option::Option<0x1::string::String>, arg3: &0x1::option::Option<0x1::string::String>) {
        assert_non_empty_bounded(arg1, 128);
        if (arg0 == 0) {
            assert!(0x1::option::is_none<0x1::string::String>(arg2) && 0x1::option::is_none<0x1::string::String>(arg3), 11);
        } else if (arg0 == 1) {
            assert!(0x1::option::is_some<0x1::string::String>(arg2) && 0x1::option::is_none<0x1::string::String>(arg3), 11);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(arg2), 128);
        } else {
            assert!(arg0 == 2, 11);
            assert!(0x1::option::is_some<0x1::string::String>(arg2) && 0x1::option::is_some<0x1::string::String>(arg3), 11);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(arg2), 128);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(arg3), 128);
        };
    }

    fun assert_track_row(arg0: &TrackRowV2) {
        assert_non_empty_bounded(&arg0.key, 128);
        assert_non_empty_bounded(&arg0.label, 256);
    }

    fun assert_transform(arg0: &TransformFixedV1) {
        assert_signed_milli(&arg0.x_milli, 8192000);
        assert_signed_milli(&arg0.y_milli, 8192000);
        assert_signed_milli(&arg0.rotation_millidegrees, 360000);
        assert!(arg0.scale_ppm > 0 && arg0.scale_ppm <= 100000000, 11);
    }

    fun assert_valid_category(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else {
            arg0 == 255
        };
        assert!(v0, 9);
    }

    fun assert_valid_counts(arg0: &BaseDefinitionCountsV8) {
        let v0 = if (arg0.tracks > 0) {
            if (arg0.tracks <= 256) {
                if (arg0.colors <= 5000) {
                    if (arg0.parts > 0) {
                        if (arg0.parts <= 750) {
                            if (arg0.items > 0) {
                                if (arg0.items <= 5000) {
                                    if (arg0.styles > 0) {
                                        if (arg0.styles <= 500) {
                                            if (arg0.rules <= 1000) {
                                                if (arg0.assets > 0) {
                                                    arg0.assets <= 4999
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
        assert!(v0, 3);
    }

    fun assert_valid_row_category(arg0: u8) {
        assert_valid_category(arg0);
        assert!(arg0 != 5 && arg0 != 255, 9);
    }

    fun assert_visibility_program_references(arg0: &BaseDefinitionRegistryV8, arg1: &vector<VisibilityTokenV1>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VisibilityTokenV1>(arg1)) {
            let v1 = 0x1::vector::borrow<VisibilityTokenV1>(arg1, v0);
            if (0x1::option::is_some<SemanticSelectorV2>(&v1.selector)) {
                let v2 = 0x1::option::borrow<SemanticSelectorV2>(&v1.selector);
                let v3 = PartKeyV8{key: v2.part_key};
                assert!(0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v3), 6);
                if (v2.source == 1 && 0x1::option::is_some<0x1::string::String>(&v2.item_key)) {
                    let v4 = ItemKeyV8{
                        part_key : v2.part_key,
                        item_key : *0x1::option::borrow<0x1::string::String>(&v2.item_key),
                    };
                    assert!(0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v4), 6);
                    if (0x1::option::is_some<0x1::string::String>(&v2.style_key)) {
                        let v5 = StyleKeyV8{
                            part_key  : v2.part_key,
                            item_key  : *0x1::option::borrow<0x1::string::String>(&v2.item_key),
                            style_key : *0x1::option::borrow<0x1::string::String>(&v2.style_key),
                        };
                        assert!(0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v5), 6);
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    fun assert_visibility_references(arg0: &BaseDefinitionRegistryV8) {
        let v0 = 0;
        while (v0 < arg0.observed_counts.parts) {
            let v1 = PartIndexKeyV8{index: v0};
            assert_visibility_program_references(arg0, &0x2::dynamic_field::borrow<PartKeyV8, PartRowV2>(&arg0.id, *0x2::dynamic_field::borrow<PartIndexKeyV8, PartKeyV8>(&arg0.id, v1)).visibility_tokens);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < arg0.observed_counts.items) {
            let v2 = ItemIndexKeyV8{index: v0};
            assert_visibility_program_references(arg0, &0x2::dynamic_field::borrow<ItemKeyV8, ItemRowV2>(&arg0.id, *0x2::dynamic_field::borrow<ItemIndexKeyV8, ItemKeyV8>(&arg0.id, v2)).visibility_tokens);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < arg0.observed_counts.styles) {
            let v3 = StyleIndexKeyV8{index: v0};
            assert_visibility_program_references(arg0, &0x2::dynamic_field::borrow<StyleKeyV8, StyleRowV2>(&arg0.id, *0x2::dynamic_field::borrow<StyleIndexKeyV8, StyleKeyV8>(&arg0.id, v3)).visibility_tokens);
            v0 = v0 + 1;
        };
    }

    fun assert_visibility_token(arg0: &VisibilityTokenV1) {
        if (arg0.opcode == 0) {
            assert!(0x1::option::is_some<SemanticSelectorV2>(&arg0.selector) && arg0.arity == 0, 11);
            assert_semantic_selector(0x1::option::borrow<SemanticSelectorV2>(&arg0.selector));
        } else if (arg0.opcode == 1) {
            assert!(0x1::option::is_none<SemanticSelectorV2>(&arg0.selector) && arg0.arity == 1, 11);
        } else {
            assert!(arg0.opcode == 2 || arg0.opcode == 3, 11);
            let v0 = if (0x1::option::is_none<SemanticSelectorV2>(&arg0.selector)) {
                if (arg0.arity > 0) {
                    (arg0.arity as u64) <= 32
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 11);
        };
    }

    fun assert_writable<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8) {
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_identity<T0>(arg0, arg1);
        assert!(!arg0.sealed, 0);
    }

    public fun author_rows_advance_commitment_v2(arg0: u8, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        assert!(arg0 <= 6, 9);
        assert_hash(&arg3);
        let v0 = AuthorRowsAdvanceCommitmentInputV2{
            domain             : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/author-rows-advance/v2"),
            schema_revision    : 2,
            category_tag       : arg0,
            sequence           : arg1,
            aggregate_sequence : arg2,
            prior_commitment   : arg3,
            row_bcs            : arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<AuthorRowsAdvanceCommitmentInputV2>(&v0))
    }

    public fun author_rows_empty_commitment_v2() : vector<u8> {
        let v0 = AuthorRowsEmptyCommitmentInputV2{
            domain          : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/author-rows-empty/v2"),
            schema_revision : 2,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<AuthorRowsEmptyCommitmentInputV2>(&v0))
    }

    public fun author_rows_seal_commitment_v2(arg0: vector<u64>, arg1: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u64>(&arg0) == 7, 3);
        assert_hash(&arg1);
        let v0 = AuthorRowsSealCommitmentInputV2{
            domain                   : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/author-rows-seal/v2"),
            schema_revision          : 2,
            ordered_counts           : arg0,
            final_rolling_commitment : arg1,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<AuthorRowsSealCommitmentInputV2>(&v0))
    }

    public fun base_definition_commitment_v2(arg0: 0x1::string::String, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>) : vector<u8> {
        assert_non_empty_bounded(&arg0, 128);
        assert!(arg1 > 0, 11);
        assert_hash(&arg2);
        assert_hash(&arg3);
        assert_hash(&arg4);
        assert_hash(&arg5);
        assert_hash(&arg6);
        assert_hash(&arg7);
        assert_hash(&arg8);
        assert_hash(&arg9);
        assert_hash(&arg10);
        assert_hash(&arg11);
        assert_hash(&arg12);
        assert_hash(&arg13);
        assert_hash(&arg14);
        let v0 = BaseDefinitionCommitmentInputV2{
            domain                       : 0x1::string::utf8(b"animacraft-fresh-v8/core/base-definition/v2"),
            schema_revision              : 2,
            maker_key                    : arg0,
            maker_version                : arg1,
            maker_document_commitment    : arg2,
            composition_commitment       : arg3,
            track_category_commitment    : arg4,
            color_category_commitment    : arg5,
            part_category_commitment     : arg6,
            item_category_commitment     : arg7,
            style_category_commitment    : arg8,
            rule_category_commitment     : arg9,
            asset_category_commitment    : arg10,
            output_category_commitment   : arg11,
            physical_category_commitment : arg12,
            creator_defaults_commitment  : arg13,
            renderer_commitment          : arg14,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<BaseDefinitionCommitmentInputV2>(&v0))
    }

    public fun borrow_color_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String) : &ColorSwatchV2 {
        assert!(arg0.sealed, 0);
        let v0 = ColorKeyV8{channel_key: arg1};
        assert!(0x2::dynamic_field::exists<ColorKeyV8>(&arg0.id, v0), 6);
        let v1 = 0x2::dynamic_field::borrow<ColorKeyV8, ColorChannelRowV2>(&arg0.id, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<ColorSwatchV2>(&v1.swatches)) {
            if (0x1::vector::borrow<ColorSwatchV2>(&v1.swatches, v2).key == arg2) {
                return 0x1::vector::borrow<ColorSwatchV2>(&v1.swatches, v2)
            };
            v2 = v2 + 1;
        };
        abort 6
    }

    public fun borrow_item_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String) : &ItemRowV2 {
        assert!(arg0.sealed, 0);
        let v0 = ItemKeyV8{
            part_key : arg1,
            item_key : arg2,
        };
        0x2::dynamic_field::borrow<ItemKeyV8, ItemRowV2>(&arg0.id, v0)
    }

    public fun borrow_pack_color_v2(arg0: &PackDefinitionRowsV2, arg1: 0x1::string::String, arg2: 0x1::string::String) : &ColorSwatchV2 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ColorChannelRowV2>(&arg0.colors)) {
            let v1 = 0x1::vector::borrow<ColorChannelRowV2>(&arg0.colors, v0);
            if (v1.key == arg1) {
                let v2 = 0;
                while (v2 < 0x1::vector::length<ColorSwatchV2>(&v1.swatches)) {
                    if (0x1::vector::borrow<ColorSwatchV2>(&v1.swatches, v2).key == arg2) {
                        return 0x1::vector::borrow<ColorSwatchV2>(&v1.swatches, v2)
                    };
                    v2 = v2 + 1;
                };
                abort 6
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun borrow_pack_part_v2(arg0: &PackDefinitionRowsV2, arg1: 0x1::string::String) : &PartRowV2 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PartRowV2>(&arg0.parts)) {
            if (0x1::vector::borrow<PartRowV2>(&arg0.parts, v0).key == arg1) {
                return 0x1::vector::borrow<PartRowV2>(&arg0.parts, v0)
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun borrow_pack_track_v2(arg0: &PackDefinitionRowsV2, arg1: 0x1::string::String) : &TrackRowV2 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TrackRowV2>(&arg0.tracks)) {
            if (0x1::vector::borrow<TrackRowV2>(&arg0.tracks, v0).key == arg1) {
                return 0x1::vector::borrow<TrackRowV2>(&arg0.tracks, v0)
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun borrow_pack_visibility_v2(arg0: &PackDefinitionRowsV2, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>) : &PackVisibilityRowV2 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PackVisibilityRowV2>(&arg0.visibility)) {
            let v1 = 0x1::vector::borrow<PackVisibilityRowV2>(&arg0.visibility, v0);
            let v2 = if (v1.subject == arg1) {
                if (v1.part_key == arg2) {
                    if (v1.item_key == arg3) {
                        v1.style_key == arg4
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    public fun borrow_part_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String) : &PartRowV2 {
        assert!(arg0.sealed, 0);
        let v0 = PartKeyV8{key: arg1};
        0x2::dynamic_field::borrow<PartKeyV8, PartRowV2>(&arg0.id, v0)
    }

    public fun borrow_rule_at_v2(arg0: &BaseDefinitionRegistryV8, arg1: u64) : &RuleRowV2 {
        assert!(arg0.sealed, 0);
        assert!(arg1 < arg0.observed_counts.rules, 8);
        let v0 = RuleIndexKeyV8{index: arg1};
        0x2::dynamic_field::borrow<RuleKeyV8, RuleRowV2>(&arg0.id, *0x2::dynamic_field::borrow<RuleIndexKeyV8, RuleKeyV8>(&arg0.id, v0))
    }

    public fun borrow_style_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : &StyleRowV2 {
        assert!(arg0.sealed, 0);
        let v0 = StyleKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::dynamic_field::borrow<StyleKeyV8, StyleRowV2>(&arg0.id, v0)
    }

    public fun borrow_track_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String) : &TrackRowV2 {
        assert!(arg0.sealed, 0);
        let v0 = TrackKeyV8{key: arg1};
        assert!(0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v0), 6);
        0x2::dynamic_field::borrow<TrackKeyV8, TrackRowV2>(&arg0.id, v0)
    }

    fun category_tags() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 3);
        0x1::vector::push_back<u8>(v1, 4);
        0x1::vector::push_back<u8>(v1, 5);
        0x1::vector::push_back<u8>(v1, 6);
        0x1::vector::push_back<u8>(v1, 255);
        v0
    }

    public fun contains_item_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        assert!(arg0.sealed, 0);
        let v0 = ItemKeyV8{
            part_key : arg1,
            item_key : arg2,
        };
        0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v0)
    }

    public fun contains_style_v2(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : bool {
        assert!(arg0.sealed, 0);
        let v0 = StyleKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v0)
    }

    fun count_vector(arg0: &BaseDefinitionCountsV8) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.tracks);
        0x1::vector::push_back<u64>(v1, arg0.colors);
        0x1::vector::push_back<u64>(v1, arg0.parts);
        0x1::vector::push_back<u64>(v1, arg0.items);
        0x1::vector::push_back<u64>(v1, arg0.styles);
        0x1::vector::push_back<u64>(v1, arg0.rules);
        0x1::vector::push_back<u64>(v1, arg0.assets);
        v0
    }

    public fun definition_count_v2(arg0: &BaseDefinitionCountsV8) : u64 {
        assert_valid_counts(arg0);
        arg0.tracks + arg0.colors + arg0.parts + arg0.items + arg0.styles + arg0.rules + arg0.assets
    }

    fun derive_sealed_commitments(arg0: &BaseDefinitionRegistryV8) : BaseDefinitionCommitmentsV8 {
        let v0 = seal_category(arg0, 0, arg0.observed_counts.tracks, arg0.initial_commitments.tracks, arg0.rolling_commitments.tracks);
        let v1 = seal_category(arg0, 1, arg0.observed_counts.colors, arg0.initial_commitments.colors, arg0.rolling_commitments.colors);
        let v2 = seal_category(arg0, 2, arg0.observed_counts.parts, arg0.initial_commitments.parts, arg0.rolling_commitments.parts);
        let v3 = seal_category(arg0, 3, arg0.observed_counts.items, arg0.initial_commitments.items, arg0.rolling_commitments.items);
        let v4 = seal_category(arg0, 4, arg0.observed_counts.styles, arg0.initial_commitments.styles, arg0.rolling_commitments.styles);
        let v5 = seal_category(arg0, 5, arg0.observed_counts.rules, arg0.initial_commitments.rules, arg0.rolling_commitments.rules);
        let v6 = seal_category(arg0, 6, arg0.observed_counts.assets, arg0.initial_commitments.assets, arg0.rolling_commitments.assets);
        let v7 = 0x1::vector::empty<vector<u8>>();
        let v8 = &mut v7;
        0x1::vector::push_back<vector<u8>>(v8, v0);
        0x1::vector::push_back<vector<u8>>(v8, v1);
        0x1::vector::push_back<vector<u8>>(v8, v2);
        0x1::vector::push_back<vector<u8>>(v8, v3);
        0x1::vector::push_back<vector<u8>>(v8, v4);
        0x1::vector::push_back<vector<u8>>(v8, v5);
        0x1::vector::push_back<vector<u8>>(v8, v6);
        0x1::vector::push_back<vector<u8>>(v8, seal_category(arg0, 255, arg0.next_sequence, arg0.initial_commitments.aggregate, arg0.rolling_commitments.aggregate));
        BaseDefinitionCommitmentsV8{
            tracks    : v0,
            colors    : v1,
            parts     : v2,
            items     : v3,
            styles    : v4,
            rules     : v5,
            assets    : v6,
            aggregate : registry_seal_commitment_v2(0x2::object::id<BaseDefinitionRegistryV8>(arg0), arg0.root_id, arg0.maker_version, category_tags(), v7, arg0.next_sequence),
        }
    }

    fun empty_commitments(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) : BaseDefinitionCommitmentsV8 {
        BaseDefinitionCommitmentsV8{
            tracks    : registry_empty_commitment_v2(arg0, arg1, arg2, 0),
            colors    : registry_empty_commitment_v2(arg0, arg1, arg2, 1),
            parts     : registry_empty_commitment_v2(arg0, arg1, arg2, 2),
            items     : registry_empty_commitment_v2(arg0, arg1, arg2, 3),
            styles    : registry_empty_commitment_v2(arg0, arg1, arg2, 4),
            rules     : registry_empty_commitment_v2(arg0, arg1, arg2, 5),
            assets    : registry_empty_commitment_v2(arg0, arg1, arg2, 6),
            aggregate : registry_empty_commitment_v2(arg0, arg1, arg2, 255),
        }
    }

    public fun finish_color_channel_draft_v2(arg0: ColorChannelDraftV2) : ColorChannelRowV2 {
        let ColorChannelDraftV2 {
            sequence           : v0,
            key                : v1,
            label              : v2,
            default_swatch_key : v3,
            expected_swatches  : v4,
            swatches           : v5,
        } = arg0;
        let v6 = v5;
        assert!(0x1::vector::length<ColorSwatchV2>(&v6) == v4, 8);
        new_color_channel_row_v2(v0, v1, v2, v3, v6)
    }

    fun has_swatch(arg0: &ColorChannelRowV2, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ColorSwatchV2>(&arg0.swatches)) {
            if (&0x1::vector::borrow<ColorSwatchV2>(&arg0.swatches, v0).key == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun item_payload_commitment_v2(arg0: &ItemRowV2) : &vector<u8> {
        &arg0.payload_commitment
    }

    public fun item_visibility_tokens_v1(arg0: &ItemRowV2) : &vector<VisibilityTokenV1> {
        &arg0.visibility_tokens
    }

    public fun new_asset_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<u8>) : AssetRowV2 {
        let v0 = AssetRowV2{
            sequence    : arg0,
            asset_id    : arg1,
            kind        : arg2,
            media_type  : arg3,
            byte_length : arg4,
            sha256      : arg5,
        };
        assert_asset_row(&v0);
        v0
    }

    public fun new_base_definition_commitments_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) : BaseDefinitionCommitmentsV8 {
        let v0 = BaseDefinitionCommitmentsV8{
            tracks    : arg0,
            colors    : arg1,
            parts     : arg2,
            items     : arg3,
            styles    : arg4,
            rules     : arg5,
            assets    : arg6,
            aggregate : arg7,
        };
        assert_commitments(&v0);
        v0
    }

    public fun new_base_definition_counts_v8(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : BaseDefinitionCountsV8 {
        let v0 = BaseDefinitionCountsV8{
            tracks : arg0,
            colors : arg1,
            parts  : arg2,
            items  : arg3,
            styles : arg4,
            rules  : arg5,
            assets : arg6,
        };
        assert_valid_counts(&v0);
        v0
    }

    public(friend) fun new_base_definition_registry_v8<T0>(arg0: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg1: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8, arg2: BaseDefinitionCountsV8, arg3: &mut 0x2::tx_context::TxContext) : BaseDefinitionRegistryV8 {
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_valid_counts(&arg2);
        let v0 = 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_id_v8<T0>(arg0);
        let v1 = 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_maker_version_v8<T0>(arg0);
        let v2 = *0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v3 = arg2.tracks + arg2.colors + arg2.parts + arg2.items + arg2.styles + arg2.rules + arg2.assets;
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::assert_root_identity_v8<T0>(arg0, v0, v1, &v2);
        assert!(0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_expected_base_definition_count_v8<T0>(arg0) == v3, 8);
        let v4 = 0x2::object::new(arg3);
        let v5 = empty_commitments(0x2::object::uid_to_inner(&v4), v0, v1);
        BaseDefinitionRegistryV8{
            id                             : v4,
            version                        : 8,
            root_id                        : v0,
            maker_version                  : v1,
            root_content_commitment        : v2,
            expected_counts                : arg2,
            observed_counts                : zero_counts(),
            initial_commitments            : v5,
            rolling_commitments            : v5,
            sealed_commitments             : 0x1::option::none<BaseDefinitionCommitmentsV8>(),
            next_sequence                  : 0,
            expected_sequence_count        : v3,
            protected_style_count          : 0,
            color_swatch_count             : 0,
            total_capacity                 : 0,
            rule_selector_count            : 0,
            visibility_leaf_count          : 0,
            author_rows_rolling_commitment : author_rows_empty_commitment_v2(),
            sealed                         : false,
        }
    }

    public fun new_color_channel_draft_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64) : ColorChannelDraftV2 {
        assert_non_empty_bounded(&arg1, 128);
        assert_non_empty_bounded(&arg2, 256);
        assert_non_empty_bounded(&arg3, 128);
        assert!(arg4 > 0 && arg4 <= 5000, 3);
        ColorChannelDraftV2{
            sequence           : arg0,
            key                : arg1,
            label              : arg2,
            default_swatch_key : arg3,
            expected_swatches  : arg4,
            swatches           : 0x1::vector::empty<ColorSwatchV2>(),
        }
    }

    public fun new_color_channel_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<ColorSwatchV2>) : ColorChannelRowV2 {
        let v0 = ColorChannelRowV2{
            sequence           : arg0,
            key                : arg1,
            label              : arg2,
            default_swatch_key : arg3,
            swatches           : arg4,
        };
        assert_color_channel_row(&v0);
        v0
    }

    public fun new_color_stop_v2(arg0: u64, arg1: u32) : ColorStopV2 {
        let v0 = ColorStopV2{
            offset_ppm : arg0,
            rgba       : arg1,
        };
        assert_color_stop(&v0);
        v0
    }

    public fun new_color_swatch_v2(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u32, arg3: vector<ColorStopV2>) : ColorSwatchV2 {
        let v0 = ColorSwatchV2{
            key   : arg0,
            label : arg1,
            rgba  : arg2,
            stops : arg3,
        };
        assert_color_swatch(&v0);
        v0
    }

    public fun new_color_swatches_v2(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>, arg2: vector<u32>, arg3: vector<vector<u64>>, arg4: vector<vector<u32>>) : vector<ColorSwatchV2> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        let v1 = if (v0 <= 5000) {
            if (0x1::vector::length<0x1::string::String>(&arg1) == v0) {
                if (0x1::vector::length<u32>(&arg2) == v0) {
                    if (0x1::vector::length<vector<u64>>(&arg3) == v0) {
                        0x1::vector::length<vector<u32>>(&arg4) == v0
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
        assert!(v1, 3);
        let v2 = 0x1::vector::empty<ColorSwatchV2>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<vector<u64>>(&arg3, v3);
            let v5 = 0x1::vector::borrow<vector<u32>>(&arg4, v3);
            assert!(0x1::vector::length<u64>(v4) == 0x1::vector::length<u32>(v5), 3);
            let v6 = 0x1::vector::empty<ColorStopV2>();
            let v7 = 0;
            while (v7 < 0x1::vector::length<u64>(v4)) {
                0x1::vector::push_back<ColorStopV2>(&mut v6, new_color_stop_v2(*0x1::vector::borrow<u64>(v4, v7), *0x1::vector::borrow<u32>(v5, v7)));
                v7 = v7 + 1;
            };
            0x1::vector::push_back<ColorSwatchV2>(&mut v2, new_color_swatch_v2(*0x1::vector::borrow<0x1::string::String>(&arg0, v3), *0x1::vector::borrow<0x1::string::String>(&arg1, v3), *0x1::vector::borrow<u32>(&arg2, v3), v6));
            v3 = v3 + 1;
        };
        v2
    }

    public fun new_item_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: 0x1::string::String, arg7: vector<VisibilityTokenV1>, arg8: vector<u8>, arg9: vector<u8>) : ItemRowV2 {
        let v0 = ItemRowV2{
            sequence              : arg0,
            part_key              : arg1,
            item_key              : arg2,
            label                 : arg3,
            status                : arg4,
            display_order         : arg5,
            default_style_key     : arg6,
            visibility_tokens     : arg7,
            visibility_commitment : arg8,
            payload_commitment    : arg9,
        };
        assert_item_row(&v0);
        v0
    }

    public fun new_pack_definition_rows_v2(arg0: 0x1::string::String, arg1: vector<TrackRowV2>, arg2: vector<ColorChannelRowV2>, arg3: vector<PartRowV2>, arg4: vector<RuleRowV2>, arg5: vector<PackVisibilityRowV2>) : PackDefinitionRowsV2 {
        assert_non_empty_bounded(&arg0, 128);
        let v0 = if (0x1::vector::length<TrackRowV2>(&arg1) <= 256) {
            if (0x1::vector::length<ColorChannelRowV2>(&arg2) <= 5000) {
                if (0x1::vector::length<PartRowV2>(&arg3) <= 750) {
                    if (0x1::vector::length<RuleRowV2>(&arg4) <= 1000) {
                        0x1::vector::length<PackVisibilityRowV2>(&arg5) <= 5000 + 500
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
        assert!(v0, 3);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        let v3 = &arg1;
        let v4 = 0;
        while (v4 < 0x1::vector::length<TrackRowV2>(v3)) {
            let v5 = 0x1::vector::borrow<TrackRowV2>(v3, v4);
            assert_track_row(v5);
            assert!(v5.sequence == v2, 4);
            assert!(!0x1::vector::contains<0x1::string::String>(&v1, &v5.key), 5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v5.key);
            v2 = v2 + 1;
            v4 = v4 + 1;
        };
        v1 = 0x1::vector::empty<0x1::string::String>();
        v2 = 0;
        let v6 = 0;
        let v7 = &arg2;
        let v8 = 0;
        while (v8 < 0x1::vector::length<ColorChannelRowV2>(v7)) {
            let v9 = 0x1::vector::borrow<ColorChannelRowV2>(v7, v8);
            assert_color_channel_row(v9);
            let v10 = v6 + 0x1::vector::length<ColorSwatchV2>(&v9.swatches);
            v6 = v10;
            assert!(v10 <= 5000, 3);
            assert!(v9.sequence == v2, 4);
            assert!(!0x1::vector::contains<0x1::string::String>(&v1, &v9.key), 5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v9.key);
            v2 = v2 + 1;
            v8 = v8 + 1;
        };
        v1 = 0x1::vector::empty<0x1::string::String>();
        v2 = 0;
        let v11 = 0;
        let v12 = 0;
        let v13 = &arg3;
        let v14 = 0;
        while (v14 < 0x1::vector::length<PartRowV2>(v13)) {
            let v15 = 0x1::vector::borrow<PartRowV2>(v13, v14);
            assert_part_row(v15);
            assert!(v15.kind == 0 && !v15.required, 11);
            assert!(v15.visibility_commitment == visibility_program_commitment_v1(2, 0x1::option::some<0x1::string::String>(arg0), 0, v15.key, 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), &v15.visibility_tokens), 7);
            let v16 = v12 + validate_visibility_program_v1(&v15.visibility_tokens);
            v12 = v16;
            assert!(v16 <= 32000, 3);
            assert!(v15.sequence == v2, 4);
            assert!(!0x1::vector::contains<0x1::string::String>(&v1, &v15.key), 5);
            let v17 = v11 + v15.capacity;
            v11 = v17;
            assert!(v17 <= 500, 3);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v15.key);
            v2 = v2 + 1;
            v14 = v14 + 1;
        };
        v1 = 0x1::vector::empty<0x1::string::String>();
        v2 = 0;
        let v18 = 0;
        let v19 = &arg4;
        let v20 = 0;
        while (v20 < 0x1::vector::length<RuleRowV2>(v19)) {
            let v21 = 0x1::vector::borrow<RuleRowV2>(v19, v20);
            assert_rule_row(v21);
            let v22 = v18 + 1 + 0x1::vector::length<SemanticSelectorV2>(&v21.targets);
            v18 = v22;
            assert!(v22 <= 33000, 3);
            assert!(v21.sequence == v2, 4);
            assert!(!0x1::vector::contains<0x1::string::String>(&v1, &v21.key), 5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v21.key);
            v2 = v2 + 1;
            v20 = v20 + 1;
        };
        v2 = 0;
        let v23 = &arg5;
        let v24 = 0;
        while (v24 < 0x1::vector::length<PackVisibilityRowV2>(v23)) {
            let v25 = 0x1::vector::borrow<PackVisibilityRowV2>(v23, v24);
            let v26 = 0;
            while (v26 < v2) {
                let v27 = 0x1::vector::borrow<PackVisibilityRowV2>(&arg5, v26);
                let v28 = if (v25.subject != v27.subject) {
                    true
                } else if (v25.part_key != v27.part_key) {
                    true
                } else if (v25.item_key != v27.item_key) {
                    true
                } else {
                    v25.style_key != v27.style_key
                };
                assert!(v28, 5);
                v26 = v26 + 1;
            };
            v2 = v2 + 1;
            let v29 = if (v25.definition_source == 1) {
                0x1::option::none<0x1::string::String>()
            } else {
                0x1::option::some<0x1::string::String>(arg0)
            };
            assert!(v25.visibility_commitment == visibility_program_commitment_v1(v25.definition_source, v29, v25.subject, v25.part_key, 0x1::option::some<0x1::string::String>(v25.item_key), v25.style_key, &v25.visibility_tokens), 7);
            let v30 = v12 + validate_visibility_program_v1(&v25.visibility_tokens);
            v12 = v30;
            assert!(v30 <= 32000, 3);
            v24 = v24 + 1;
        };
        PackDefinitionRowsV2{
            semantic_pack_id : arg0,
            tracks           : arg1,
            colors           : arg2,
            parts            : arg3,
            rules            : arg4,
            visibility       : arg5,
        }
    }

    public fun new_pack_visibility_row_v2(arg0: u8, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: vector<VisibilityTokenV1>, arg6: vector<u8>) : PackVisibilityRowV2 {
        assert!(arg0 == 1 || arg0 == 2, 11);
        assert!(arg1 == 1 || arg1 == 2, 11);
        assert!(arg0 != 2 || arg1 == 2, 11);
        let v0 = 0x1::option::some<0x1::string::String>(arg3);
        assert_subject_path(arg0, &arg2, &v0, &arg4);
        assert_hash(&arg6);
        validate_visibility_program_v1(&arg5);
        PackVisibilityRowV2{
            subject               : arg0,
            definition_source     : arg1,
            part_key              : arg2,
            item_key              : arg3,
            style_key             : arg4,
            visibility_tokens     : arg5,
            visibility_commitment : arg6,
        }
    }

    public fun new_part_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: u8, arg9: u64, arg10: vector<0x1::string::String>, arg11: vector<VisibilityTokenV1>, arg12: vector<u8>, arg13: vector<u8>) : PartRowV2 {
        let v0 = PartRowV2{
            sequence              : arg0,
            key                   : arg1,
            label                 : arg2,
            kind                  : arg3,
            render_order          : arg4,
            menu_order            : arg5,
            visible               : arg6,
            required              : arg7,
            slot_mode             : arg8,
            capacity              : arg9,
            track_keys            : arg10,
            visibility_tokens     : arg11,
            visibility_commitment : arg12,
            payload_commitment    : arg13,
        };
        assert_part_row(&v0);
        v0
    }

    public fun new_physical_policy_v1(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: bool) : PhysicalPolicyV1 {
        let v0 = PhysicalPolicyV1{
            material     : arg0,
            issuance     : arg1,
            proof        : arg2,
            price_atomic : arg3,
            max_supply   : arg4,
            transferable : arg5,
        };
        assert_physical_policy(&v0);
        v0
    }

    public fun new_rule_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: u8, arg3: SemanticSelectorV2, arg4: u8, arg5: vector<SemanticSelectorV2>, arg6: vector<u8>) : RuleRowV2 {
        let v0 = RuleRowV2{
            sequence           : arg0,
            key                : arg1,
            kind               : arg2,
            trigger            : arg3,
            target_mode        : arg4,
            targets            : arg5,
            payload_commitment : arg6,
        };
        assert_rule_row(&v0);
        v0
    }

    public fun new_semantic_selector_v2(arg0: u8, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>) : SemanticSelectorV2 {
        let v0 = SemanticSelectorV2{
            source     : arg0,
            source_key : arg1,
            part_key   : arg2,
            item_key   : arg3,
            style_key  : arg4,
        };
        assert_semantic_selector(&v0);
        v0
    }

    public fun new_signed_milli_v1(arg0: bool, arg1: u64) : SignedMilliV1 {
        let v0 = SignedMilliV1{
            negative  : arg0,
            magnitude : arg1,
        };
        assert_signed_milli(&v0, 18446744073709551615);
        v0
    }

    public fun new_style_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::option::Option<0x1::string::String>, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<u8>, arg12: bool, arg13: TransformFixedV1, arg14: u64, arg15: u8, arg16: 0x1::option::Option<PhysicalPolicyV1>, arg17: vector<VisibilityTokenV1>, arg18: vector<u8>, arg19: vector<u8>) : StyleRowV2 {
        let v0 = StyleRowV2{
            sequence              : arg0,
            part_key              : arg1,
            item_key              : arg2,
            style_key             : arg3,
            label                 : arg4,
            display_order         : arg5,
            track_key             : arg6,
            color_channel_key     : arg7,
            default_swatch_key    : arg8,
            asset_id              : arg9,
            asset_blob_id         : arg10,
            asset_sha256          : arg11,
            protected             : arg12,
            transform             : arg13,
            opacity_ppm           : arg14,
            blend_mode            : arg15,
            physical              : arg16,
            visibility_tokens     : arg17,
            visibility_commitment : arg18,
            payload_commitment    : arg19,
        };
        assert_style_row(&v0);
        v0
    }

    public fun new_track_row_v2(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: bool) : TrackRowV2 {
        let v0 = TrackRowV2{
            sequence     : arg0,
            key          : arg1,
            label        : arg2,
            render_order : arg3,
            locked       : arg4,
        };
        assert_track_row(&v0);
        v0
    }

    public fun new_transform_fixed_v1(arg0: SignedMilliV1, arg1: SignedMilliV1, arg2: u64, arg3: SignedMilliV1) : TransformFixedV1 {
        let v0 = TransformFixedV1{
            x_milli               : arg0,
            y_milli               : arg1,
            scale_ppm             : arg2,
            rotation_millidegrees : arg3,
        };
        assert_transform(&v0);
        v0
    }

    public fun new_visibility_program_v1(arg0: vector<u8>, arg1: vector<u16>, arg2: vector<u8>, arg3: vector<0x1::option::Option<0x1::string::String>>, arg4: vector<0x1::string::String>, arg5: vector<0x1::option::Option<0x1::string::String>>, arg6: vector<0x1::option::Option<0x1::string::String>>) : vector<VisibilityTokenV1> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = 0x1::vector::length<u8>(&arg2);
        let v2 = if (v0 <= 288) {
            if (v1 <= 32) {
                if (0x1::vector::length<u16>(&arg1) == v0) {
                    if (0x1::vector::length<0x1::option::Option<0x1::string::String>>(&arg3) == v1) {
                        if (0x1::vector::length<0x1::string::String>(&arg4) == v1) {
                            if (0x1::vector::length<0x1::option::Option<0x1::string::String>>(&arg5) == v1) {
                                0x1::vector::length<0x1::option::Option<0x1::string::String>>(&arg6) == v1
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
        assert!(v2, 11);
        let v3 = 0x1::vector::empty<VisibilityTokenV1>();
        let v4 = 0;
        let v5 = 0;
        while (v4 < v0) {
            let v6 = *0x1::vector::borrow<u8>(&arg0, v4);
            let v7 = if (v6 == 0) {
                assert!(v5 < v1, 11);
                let v8 = new_semantic_selector_v2(*0x1::vector::borrow<u8>(&arg2, v5), *0x1::vector::borrow<0x1::option::Option<0x1::string::String>>(&arg3, v5), *0x1::vector::borrow<0x1::string::String>(&arg4, v5), *0x1::vector::borrow<0x1::option::Option<0x1::string::String>>(&arg5, v5), *0x1::vector::borrow<0x1::option::Option<0x1::string::String>>(&arg6, v5));
                v5 = v5 + 1;
                0x1::option::some<SemanticSelectorV2>(v8)
            } else {
                0x1::option::none<SemanticSelectorV2>()
            };
            0x1::vector::push_back<VisibilityTokenV1>(&mut v3, new_visibility_token_v1(v6, v7, *0x1::vector::borrow<u16>(&arg1, v4)));
            v4 = v4 + 1;
        };
        assert!(v5 == v1, 11);
        assert!(validate_visibility_program_v1(&v3) == v1, 11);
        v3
    }

    public fun new_visibility_token_v1(arg0: u8, arg1: 0x1::option::Option<SemanticSelectorV2>, arg2: u16) : VisibilityTokenV1 {
        let v0 = VisibilityTokenV1{
            opcode   : arg0,
            selector : arg1,
            arity    : arg2,
        };
        assert_visibility_token(&v0);
        v0
    }

    public fun pack_colors_v2(arg0: &PackDefinitionRowsV2) : &vector<ColorChannelRowV2> {
        &arg0.colors
    }

    public fun pack_parts_v2(arg0: &PackDefinitionRowsV2) : &vector<PartRowV2> {
        &arg0.parts
    }

    public fun pack_rules_v2(arg0: &PackDefinitionRowsV2) : &vector<RuleRowV2> {
        &arg0.rules
    }

    public fun pack_semantic_id_v2(arg0: &PackDefinitionRowsV2) : &0x1::string::String {
        &arg0.semantic_pack_id
    }

    public fun pack_tracks_v2(arg0: &PackDefinitionRowsV2) : &vector<TrackRowV2> {
        &arg0.tracks
    }

    public fun pack_visibility_terms_v2(arg0: &PackVisibilityRowV2) : (u8, &vector<VisibilityTokenV1>, &vector<u8>) {
        (arg0.definition_source, &arg0.visibility_tokens, &arg0.visibility_commitment)
    }

    public fun pack_visibility_v2(arg0: &PackDefinitionRowsV2) : &vector<PackVisibilityRowV2> {
        &arg0.visibility
    }

    public fun part_identity_terms_v2(arg0: &PartRowV2) : (&0x1::string::String, u64, bool, &vector<u8>) {
        (&arg0.key, arg0.sequence, arg0.required, &arg0.payload_commitment)
    }

    public fun part_slot_terms_v2(arg0: &PartRowV2) : (u8, u64) {
        (arg0.slot_mode, arg0.capacity)
    }

    public fun part_visibility_tokens_v1(arg0: &PartRowV2) : &vector<VisibilityTokenV1> {
        &arg0.visibility_tokens
    }

    public fun registry_advance_commitment_v2(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        assert_valid_category(arg1);
        assert_hash(&arg3);
        assert_hash(&arg4);
        let v0 = RegistryAdvanceCommitmentInputV2{
            domain                   : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/registry-advance/v2"),
            schema_revision          : 2,
            registry_id              : arg0,
            category_tag             : arg1,
            sequence                 : arg2,
            prior_rolling_commitment : arg3,
            row_commitment           : arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RegistryAdvanceCommitmentInputV2>(&v0))
    }

    public fun registry_category_seal_commitment_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) : vector<u8> {
        assert_valid_category(arg3);
        assert_hash(&arg5);
        assert_hash(&arg6);
        let v0 = RegistryCategorySealCommitmentInputV2{
            domain                   : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/registry-category-seal/v2"),
            schema_revision          : 2,
            registry_id              : arg0,
            root_id                  : arg1,
            maker_version            : arg2,
            category_tag             : arg3,
            count                    : arg4,
            initial_commitment       : arg5,
            final_rolling_commitment : arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RegistryCategorySealCommitmentInputV2>(&v0))
    }

    public fun registry_empty_commitment_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8) : vector<u8> {
        assert!(arg0 != arg1 && arg2 > 0, 10);
        assert_valid_category(arg3);
        let v0 = RegistryEmptyCommitmentInputV2{
            domain          : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/registry-empty/v2"),
            schema_revision : 2,
            registry_id     : arg0,
            root_id         : arg1,
            maker_version   : arg2,
            category_tag    : arg3,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RegistryEmptyCommitmentInputV2>(&v0))
    }

    public fun registry_maker_version_v2(arg0: &BaseDefinitionRegistryV8) : u64 {
        arg0.maker_version
    }

    public fun registry_part_count_v2(arg0: &BaseDefinitionRegistryV8) : u64 {
        assert!(arg0.sealed, 0);
        arg0.observed_counts.parts
    }

    public fun registry_root_content_commitment_v2(arg0: &BaseDefinitionRegistryV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun registry_root_id_v2(arg0: &BaseDefinitionRegistryV8) : 0x2::object::ID {
        arg0.root_id
    }

    fun registry_row_commitment(arg0: &BaseDefinitionRegistryV8, arg1: u8, arg2: u64, arg3: vector<u8>) : vector<u8> {
        registry_row_commitment_v2(0x2::object::id<BaseDefinitionRegistryV8>(arg0), arg0.root_id, arg0.maker_version, arg1, arg2, arg3)
    }

    public fun registry_row_commitment_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: u64, arg5: vector<u8>) : vector<u8> {
        assert!(arg0 != arg1 && arg2 > 0, 10);
        assert_valid_row_category(arg3);
        assert!(!0x1::vector::is_empty<u8>(&arg5), 1);
        let v0 = RegistryRowCommitmentInputV2{
            domain          : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/registry-row/v2"),
            schema_revision : 2,
            registry_id     : arg0,
            root_id         : arg1,
            maker_version   : arg2,
            category_tag    : arg3,
            sequence        : arg4,
            row_bcs         : arg5,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RegistryRowCommitmentInputV2>(&v0))
    }

    public fun registry_rule_count_v2(arg0: &BaseDefinitionRegistryV8) : u64 {
        assert!(arg0.sealed, 0);
        arg0.observed_counts.rules
    }

    public fun registry_seal_commitment_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64) : vector<u8> {
        assert_ordered_category_tags(&arg3);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<u8>(&arg3), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg4)) {
            assert_hash(0x1::vector::borrow<vector<u8>>(&arg4, v0));
            v0 = v0 + 1;
        };
        let v1 = RegistrySealCommitmentInputV2{
            domain                       : 0x1::string::utf8(b"animacraft-fresh-v8/compiler/registry-seal/v2"),
            schema_revision              : 2,
            registry_id                  : arg0,
            root_id                      : arg1,
            maker_version                : arg2,
            ordered_category_tags        : arg3,
            ordered_category_commitments : arg4,
            aggregate_count              : arg5,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RegistrySealCommitmentInputV2>(&v1))
    }

    public fun registry_sealed_v2(arg0: &BaseDefinitionRegistryV8) : bool {
        arg0.sealed
    }

    public fun registry_track_count_v2(arg0: &BaseDefinitionRegistryV8) : u64 {
        assert!(arg0.sealed, 0);
        arg0.observed_counts.tracks
    }

    public fun rule_is_satisfied_v2(arg0: &RuleRowV2, arg1: bool, arg2: &vector<bool>) : bool {
        assert!(0x1::vector::length<bool>(arg2) == 0x1::vector::length<SemanticSelectorV2>(&arg0.targets), 8);
        if (!arg1) {
            return true
        };
        let v0 = false;
        let v1 = true;
        let v2 = 0;
        while (v2 < 0x1::vector::length<bool>(arg2)) {
            let v3 = v0 || *0x1::vector::borrow<bool>(arg2, v2);
            v0 = v3;
            let v4 = v1 && *0x1::vector::borrow<bool>(arg2, v2);
            v1 = v4;
            v2 = v2 + 1;
        };
        arg0.kind == 1 && !v0 || arg0.target_mode == 0 && v1 || v0
    }

    public fun rule_row_commitment_v2(arg0: u8, arg1: 0x1::option::Option<0x1::string::String>, arg2: &RuleRowV2) : vector<u8> {
        assert_definition_scope(arg0, &arg1);
        assert_rule_row(arg2);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<SemanticSelectorV2>(&arg2.targets)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, semantic_selector_commitment_v2(0x1::vector::borrow<SemanticSelectorV2>(&arg2.targets, v1)));
            v1 = v1 + 1;
        };
        let v2 = RuleRowCommitmentInputV2{
            domain                              : 0x1::string::utf8(b"animacraft-fresh-v8/core/rule-row/v2"),
            schema_revision                     : 8,
            definition_source                   : arg0,
            definition_source_key               : arg1,
            sequence                            : arg2.sequence,
            key                                 : arg2.key,
            kind                                : arg2.kind,
            trigger_selector_commitment         : semantic_selector_commitment_v2(&arg2.trigger),
            target_mode                         : arg2.target_mode,
            ordered_target_selector_commitments : v0,
            payload_commitment                  : arg2.payload_commitment,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RuleRowCommitmentInputV2>(&v2))
    }

    public fun rule_terms_v2(arg0: &RuleRowV2) : (u8, &SemanticSelectorV2, u8, &vector<SemanticSelectorV2>, &vector<u8>) {
        (arg0.kind, &arg0.trigger, arg0.target_mode, &arg0.targets, &arg0.payload_commitment)
    }

    public fun seal_base_definition_registry_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &mut 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerRootV8<T0>, arg2: &0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::MakerAdminCapV8) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert!(arg0.next_sequence == arg0.expected_sequence_count, 8);
        assert_counts_equal(&arg0.observed_counts, &arg0.expected_counts);
        assert_style_color_references(arg0);
        assert_item_default_styles(arg0);
        assert_style_assets(arg0);
        assert_visibility_references(arg0);
        let v0 = author_rows_seal_commitment_v2(count_vector(&arg0.observed_counts), arg0.author_rows_rolling_commitment);
        assert!(&v0 == 0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::root_expected_base_registry_commitment_v8<T0>(arg1), 7);
        let v1 = derive_sealed_commitments(arg0);
        0xae3b7f0466c43c394da281515f4f3d74e2b3943f6ca935cb9fcbb9a26a6856e9::maker_v8::install_sealed_base_registry_commitment_v2<T0>(arg1, arg2, 0x2::object::id<BaseDefinitionRegistryV8>(arg0), v1.aggregate);
        arg0.sealed_commitments = 0x1::option::some<BaseDefinitionCommitmentsV8>(v1);
        arg0.sealed = true;
        let v2 = BaseDefinitionRegistrySealedV8{
            root_id               : arg0.root_id,
            registry_id           : 0x2::object::id<BaseDefinitionRegistryV8>(arg0),
            definition_count      : arg0.expected_sequence_count,
            protected_style_count : arg0.protected_style_count,
            aggregate_commitment  : v1.aggregate,
        };
        0x2::event::emit<BaseDefinitionRegistrySealedV8>(v2);
    }

    fun seal_category(arg0: &BaseDefinitionRegistryV8, arg1: u8, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        registry_category_seal_commitment_v2(0x2::object::id<BaseDefinitionRegistryV8>(arg0), arg0.root_id, arg0.maker_version, arg1, arg2, arg3, arg4)
    }

    public fun semantic_selector_commitment_v2(arg0: &SemanticSelectorV2) : vector<u8> {
        assert_semantic_selector(arg0);
        let v0 = SemanticSelectorCommitmentInputV2{
            domain          : 0x1::string::utf8(b"animacraft-fresh-v8/core/semantic-selector/v2"),
            schema_revision : 8,
            selector        : *arg0,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SemanticSelectorCommitmentInputV2>(&v0))
    }

    public fun semantic_selector_matches_v2(arg0: &SemanticSelectorV2, arg1: u8, arg2: &0x1::option::Option<0x1::string::String>, arg3: &0x1::string::String, arg4: &0x1::string::String, arg5: &0x1::string::String) : bool {
        assert!(arg1 >= 1 && arg1 <= 3, 11);
        if (arg0.source != 0 && arg0.source != arg1) {
            return false
        };
        if ((arg0.source == 2 || arg0.source == 3) && &arg0.source_key != arg2) {
            return false
        };
        if (&arg0.part_key == arg3) {
            if (0x1::option::is_none<0x1::string::String>(&arg0.item_key) || 0x1::option::borrow<0x1::string::String>(&arg0.item_key) == arg4) {
                0x1::option::is_none<0x1::string::String>(&arg0.style_key) || 0x1::option::borrow<0x1::string::String>(&arg0.style_key) == arg5
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun semantic_selector_terms_v2(arg0: &SemanticSelectorV2) : (u8, &0x1::option::Option<0x1::string::String>, &0x1::string::String, &0x1::option::Option<0x1::string::String>, &0x1::option::Option<0x1::string::String>) {
        (arg0.source, &arg0.source_key, &arg0.part_key, &arg0.item_key, &arg0.style_key)
    }

    public(friend) fun share_base_definition_registry_v8(arg0: BaseDefinitionRegistryV8) {
        0x2::transfer::share_object<BaseDefinitionRegistryV8>(arg0);
    }

    public fun style_asset_blob_id_v2(arg0: &StyleRowV2) : &0x1::string::String {
        &arg0.asset_blob_id
    }

    public fun style_asset_sha256_v2(arg0: &StyleRowV2) : &vector<u8> {
        &arg0.asset_sha256
    }

    public fun style_color_channel_key_v2(arg0: &StyleRowV2) : &0x1::option::Option<0x1::string::String> {
        &arg0.color_channel_key
    }

    public fun style_default_swatch_key_v2(arg0: &StyleRowV2) : &0x1::option::Option<0x1::string::String> {
        &arg0.default_swatch_key
    }

    public fun style_item_key_v2(arg0: &StyleRowV2) : &0x1::string::String {
        &arg0.item_key
    }

    public fun style_key_v2(arg0: &StyleRowV2) : &0x1::string::String {
        &arg0.style_key
    }

    public fun style_layer_track_key_v2(arg0: &StyleRowV2) : &0x1::string::String {
        &arg0.track_key
    }

    public fun style_part_key_v2(arg0: &StyleRowV2) : &0x1::string::String {
        &arg0.part_key
    }

    public fun style_payload_commitment_v2(arg0: &StyleRowV2) : &vector<u8> {
        &arg0.payload_commitment
    }

    public fun style_protected_v2(arg0: &StyleRowV2) : bool {
        arg0.protected
    }

    public fun style_visibility_tokens_v1(arg0: &StyleRowV2) : &vector<VisibilityTokenV1> {
        &arg0.visibility_tokens
    }

    public fun validate_visibility_program_v1(arg0: &vector<VisibilityTokenV1>) : u64 {
        assert!(0x1::vector::length<VisibilityTokenV1>(arg0) <= 288, 11);
        if (0x1::vector::is_empty<VisibilityTokenV1>(arg0)) {
            return 0
        };
        let v0 = vector[];
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<VisibilityTokenV1>(arg0)) {
            let v3 = 0x1::vector::borrow<VisibilityTokenV1>(arg0, v2);
            assert_visibility_token(v3);
            if (v3.opcode == 0) {
                let v4 = v1 + 1;
                v1 = v4;
                assert!(v4 <= 32, 11);
                0x1::vector::push_back<u64>(&mut v0, 1);
            } else if (v3.opcode == 1) {
                assert!(0x1::vector::length<u64>(&v0) >= 1, 11);
                let v5 = 0x1::vector::pop_back<u64>(&mut v0) + 1;
                assert!(v5 <= 8, 11);
                0x1::vector::push_back<u64>(&mut v0, v5);
            } else {
                let v6 = (v3.arity as u64);
                assert!(0x1::vector::length<u64>(&v0) >= v6, 11);
                let v7 = 0;
                let v8 = v7;
                let v9 = 0;
                while (v9 < v6) {
                    let v10 = 0x1::vector::pop_back<u64>(&mut v0);
                    if (v10 > v7) {
                        v8 = v10;
                    };
                    v9 = v9 + 1;
                };
                let v11 = v8 + 1;
                assert!(v11 <= 8, 11);
                0x1::vector::push_back<u64>(&mut v0, v11);
            };
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<u64>(&v0) == 1, 11);
        v1
    }

    public fun visibility_is_satisfied_v1(arg0: &vector<VisibilityTokenV1>, arg1: &vector<bool>) : bool {
        assert!(validate_visibility_program_v1(arg0) == 0x1::vector::length<bool>(arg1), 8);
        if (0x1::vector::is_empty<VisibilityTokenV1>(arg0)) {
            return true
        };
        let v0 = vector[];
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<VisibilityTokenV1>(arg0)) {
            let v3 = 0x1::vector::borrow<VisibilityTokenV1>(arg0, v2);
            if (v3.opcode == 0) {
                0x1::vector::push_back<bool>(&mut v0, *0x1::vector::borrow<bool>(arg1, v1));
                v1 = v1 + 1;
            } else if (v3.opcode == 1) {
                0x1::vector::push_back<bool>(&mut v0, !0x1::vector::pop_back<bool>(&mut v0));
            } else {
                let v4 = v3.opcode == 2;
                let v5 = 0;
                while (v5 < (v3.arity as u64)) {
                    let v6 = v3.opcode == 2 && v4 && 0x1::vector::pop_back<bool>(&mut v0) || v4 || 0x1::vector::pop_back<bool>(&mut v0);
                    v4 = v6;
                    v5 = v5 + 1;
                };
                0x1::vector::push_back<bool>(&mut v0, v4);
            };
            v2 = v2 + 1;
        };
        0x1::vector::pop_back<bool>(&mut v0)
    }

    public fun visibility_program_commitment_v1(arg0: u8, arg1: 0x1::option::Option<0x1::string::String>, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: &vector<VisibilityTokenV1>) : vector<u8> {
        assert_definition_scope(arg0, &arg1);
        assert_subject_path(arg2, &arg3, &arg4, &arg5);
        validate_visibility_program_v1(arg6);
        let v0 = VisibilityProgramCommitmentInputV1{
            domain                : 0x1::string::utf8(b"animacraft-fresh-v8/core/visibility-program/v1"),
            schema_revision       : 1,
            definition_source     : arg0,
            definition_source_key : arg1,
            subject_level         : arg2,
            part_key              : arg3,
            item_key              : arg4,
            style_key             : arg5,
            tokens                : *arg6,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<VisibilityProgramCommitmentInputV1>(&v0))
    }

    public fun visibility_token_selector_v1(arg0: &VisibilityTokenV1) : &0x1::option::Option<SemanticSelectorV2> {
        &arg0.selector
    }

    fun zero_counts() : BaseDefinitionCountsV8 {
        BaseDefinitionCountsV8{
            tracks : 0,
            colors : 0,
            parts  : 0,
            items  : 0,
            styles : 0,
            rules  : 0,
            assets : 0,
        }
    }

    // decompiled from Move bytecode v7
}

