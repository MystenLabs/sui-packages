module 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::base_registry_v8 {
    struct BaseDefinitionCountsV8 has copy, drop, store {
        tracks: u64,
        parts: u64,
        items: u64,
        styles: u64,
        colors: u64,
        rules: u64,
    }

    struct BaseDefinitionCommitmentsV8 has copy, drop, store {
        tracks: vector<u8>,
        parts: vector<u8>,
        items: vector<u8>,
        styles: vector<u8>,
        colors: vector<u8>,
        rules: vector<u8>,
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
        expected_commitments: BaseDefinitionCommitmentsV8,
        rolling_commitments: BaseDefinitionCommitmentsV8,
        next_sequence: u64,
        expected_sequence_count: u64,
        protected_style_count: u64,
        sealed: bool,
    }

    struct TrackKeyV8 has copy, drop, store {
        key: 0x1::string::String,
    }

    struct PartKeyV8 has copy, drop, store {
        key: 0x1::string::String,
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

    struct ColorKeyV8 has copy, drop, store {
        channel_key: 0x1::string::String,
        swatch_key: 0x1::string::String,
    }

    struct RuleKeyV8 has copy, drop, store {
        key: 0x1::string::String,
    }

    struct RuleIndexKeyV8 has copy, drop, store {
        index: u64,
    }

    struct TrackRowV8 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        label: 0x1::string::String,
        render_order: u64,
        payload_commitment: vector<u8>,
    }

    struct PartRowV8 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        label: 0x1::string::String,
        kind: u8,
        render_order: u64,
        required: bool,
        visible: bool,
        payload_commitment: vector<u8>,
    }

    struct ItemRowV8 has copy, drop, store {
        sequence: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        label: 0x1::string::String,
        gate_kind: u8,
        payload_commitment: vector<u8>,
    }

    struct StyleRowV8 has copy, drop, store {
        sequence: u64,
        part_key: 0x1::string::String,
        item_key: 0x1::string::String,
        style_key: 0x1::string::String,
        layer_track_key: 0x1::string::String,
        color_channel_key: 0x1::option::Option<0x1::string::String>,
        default_swatch_key: 0x1::option::Option<0x1::string::String>,
        label: 0x1::string::String,
        asset_blob_id: 0x1::string::String,
        asset_sha256: vector<u8>,
        protected: bool,
        payload_commitment: vector<u8>,
    }

    struct ColorRowV8 has copy, drop, store {
        sequence: u64,
        channel_key: 0x1::string::String,
        swatch_key: 0x1::string::String,
        label: 0x1::string::String,
        rgba: u32,
        payload_commitment: vector<u8>,
    }

    struct RuleRowV8 has copy, drop, store {
        sequence: u64,
        key: 0x1::string::String,
        kind: u8,
        left_part_key: 0x1::string::String,
        left_item_key: 0x1::string::String,
        right_part_key: 0x1::string::String,
        right_item_key: 0x1::string::String,
        payload_commitment: vector<u8>,
    }

    struct RollingCommitmentInputV8 has drop {
        domain: vector<u8>,
        version: u64,
        root_content_commitment: vector<u8>,
        category: u8,
        previous: vector<u8>,
        sequence: u64,
        row_bytes: vector<u8>,
    }

    struct BaseDefinitionRegistrySealedV8 has copy, drop {
        root_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        definition_count: u64,
        protected_style_count: u64,
        aggregate_commitment: vector<u8>,
    }

    fun advance_commitment_v8(arg0: vector<u8>, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: vector<u8>) : vector<u8> {
        assert_hash(&arg0);
        assert_hash(&arg2);
        assert_valid_category(arg1);
        assert!(0x1::vector::length<u8>(&arg4) > 0, 1);
        let v0 = RollingCommitmentInputV8{
            domain                  : b"animacraft-v8/base-append",
            version                 : 8,
            root_content_commitment : arg0,
            category                : arg1,
            previous                : arg2,
            sequence                : arg3,
            row_bytes               : arg4,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RollingCommitmentInputV8>(&v0))
    }

    fun advance_registry(arg0: &mut BaseDefinitionRegistryV8, arg1: u8, arg2: u64, arg3: vector<u8>) {
        if (arg1 == 0) {
            arg0.rolling_commitments.tracks = advance_commitment_v8(arg0.root_content_commitment, arg1, arg0.rolling_commitments.tracks, arg2, arg3);
        } else if (arg1 == 1) {
            arg0.rolling_commitments.parts = advance_commitment_v8(arg0.root_content_commitment, arg1, arg0.rolling_commitments.parts, arg2, arg3);
        } else if (arg1 == 2) {
            arg0.rolling_commitments.items = advance_commitment_v8(arg0.root_content_commitment, arg1, arg0.rolling_commitments.items, arg2, arg3);
        } else if (arg1 == 3) {
            arg0.rolling_commitments.styles = advance_commitment_v8(arg0.root_content_commitment, arg1, arg0.rolling_commitments.styles, arg2, arg3);
        } else if (arg1 == 4) {
            arg0.rolling_commitments.colors = advance_commitment_v8(arg0.root_content_commitment, arg1, arg0.rolling_commitments.colors, arg2, arg3);
        } else {
            assert!(arg1 == 5, 9);
            arg0.rolling_commitments.rules = advance_commitment_v8(arg0.root_content_commitment, arg1, arg0.rolling_commitments.rules, arg2, arg3);
        };
        arg0.rolling_commitments.aggregate = advance_commitment_v8(arg0.root_content_commitment, 255, arg0.rolling_commitments.aggregate, arg2, arg3);
        arg0.next_sequence = arg0.next_sequence + 1;
    }

    public fun aggregate_commitment_v8(arg0: &BaseDefinitionCommitmentsV8) : &vector<u8> {
        &arg0.aggregate
    }

    public fun append_color_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u32, arg8: vector<u8>) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 4, arg3);
        assert_non_empty_bounded(&arg4, 128);
        assert_non_empty_bounded(&arg5, 128);
        assert_non_empty_bounded(&arg6, 256);
        assert_hash(&arg8);
        let v0 = ColorKeyV8{
            channel_key : arg4,
            swatch_key  : arg5,
        };
        assert!(!0x2::dynamic_field::exists<ColorKeyV8>(&arg0.id, v0), 5);
        let v1 = ColorRowV8{
            sequence           : arg3,
            channel_key        : arg4,
            swatch_key         : arg5,
            label              : arg6,
            rgba               : arg7,
            payload_commitment : arg8,
        };
        0x2::dynamic_field::add<ColorKeyV8, ColorRowV8>(&mut arg0.id, v0, v1);
        arg0.observed_counts.colors = arg0.observed_counts.colors + 1;
        advance_registry(arg0, 4, arg3, 0x1::bcs::to_bytes<ColorRowV8>(&v1));
    }

    public fun append_item_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u8, arg8: vector<u8>) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 2, arg3);
        assert_non_empty_bounded(&arg4, 128);
        assert_non_empty_bounded(&arg5, 128);
        assert_non_empty_bounded(&arg6, 256);
        assert_hash(&arg8);
        assert!(arg7 == 0, 11);
        let v0 = PartKeyV8{key: arg4};
        assert!(0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v0), 6);
        let v1 = ItemKeyV8{
            part_key : arg4,
            item_key : arg5,
        };
        assert!(!0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v1), 5);
        let v2 = ItemRowV8{
            sequence           : arg3,
            part_key           : arg4,
            item_key           : arg5,
            label              : arg6,
            gate_kind          : arg7,
            payload_commitment : arg8,
        };
        0x2::dynamic_field::add<ItemKeyV8, ItemRowV8>(&mut arg0.id, v1, v2);
        arg0.observed_counts.items = arg0.observed_counts.items + 1;
        advance_registry(arg0, 2, arg3, 0x1::bcs::to_bytes<ItemRowV8>(&v2));
    }

    public fun append_part_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: bool, arg9: bool, arg10: vector<u8>) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 1, arg3);
        assert_non_empty_bounded(&arg4, 128);
        assert_non_empty_bounded(&arg5, 256);
        assert_hash(&arg10);
        assert_part_policy(arg6, arg8);
        let v0 = PartKeyV8{key: arg4};
        assert!(!0x2::dynamic_field::exists<PartKeyV8>(&arg0.id, v0), 5);
        let v1 = PartRowV8{
            sequence           : arg3,
            key                : arg4,
            label              : arg5,
            kind               : arg6,
            render_order       : arg7,
            required           : arg8,
            visible            : arg9,
            payload_commitment : arg10,
        };
        0x2::dynamic_field::add<PartKeyV8, PartRowV8>(&mut arg0.id, v0, v1);
        arg0.observed_counts.parts = arg0.observed_counts.parts + 1;
        advance_registry(arg0, 1, arg3, 0x1::bcs::to_bytes<PartRowV8>(&v1));
    }

    public fun append_rule_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: u8, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<u8>) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 5, arg3);
        assert_non_empty_bounded(&arg4, 128);
        assert_non_empty_bounded(&arg6, 128);
        assert_non_empty_bounded(&arg7, 128);
        assert_non_empty_bounded(&arg8, 128);
        assert_non_empty_bounded(&arg9, 128);
        assert_hash(&arg10);
        assert_rule_kind(arg5);
        let v0 = ItemKeyV8{
            part_key : arg6,
            item_key : arg7,
        };
        assert!(0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v0), 6);
        let v1 = ItemKeyV8{
            part_key : arg8,
            item_key : arg9,
        };
        assert!(0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v1), 6);
        let v2 = RuleKeyV8{key: arg4};
        assert!(!0x2::dynamic_field::exists<RuleKeyV8>(&arg0.id, v2), 5);
        let v3 = RuleRowV8{
            sequence           : arg3,
            key                : arg4,
            kind               : arg5,
            left_part_key      : arg6,
            left_item_key      : arg7,
            right_part_key     : arg8,
            right_item_key     : arg9,
            payload_commitment : arg10,
        };
        0x2::dynamic_field::add<RuleKeyV8, RuleRowV8>(&mut arg0.id, v2, v3);
        let v4 = RuleIndexKeyV8{index: arg0.observed_counts.rules};
        0x2::dynamic_field::add<RuleIndexKeyV8, RuleKeyV8>(&mut arg0.id, v4, v2);
        arg0.observed_counts.rules = arg0.observed_counts.rules + 1;
        advance_registry(arg0, 5, arg3, 0x1::bcs::to_bytes<RuleRowV8>(&v3));
    }

    public fun append_style_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::option::Option<0x1::string::String>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<u8>, arg13: bool, arg14: vector<u8>) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 3, arg3);
        assert_non_empty_bounded(&arg4, 128);
        assert_non_empty_bounded(&arg5, 128);
        assert_non_empty_bounded(&arg6, 128);
        assert_non_empty_bounded(&arg7, 128);
        assert!(0x1::option::is_some<0x1::string::String>(&arg8) == 0x1::option::is_some<0x1::string::String>(&arg9), 6);
        if (0x1::option::is_some<0x1::string::String>(&arg8)) {
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg8), 128);
            assert_non_empty_bounded(0x1::option::borrow<0x1::string::String>(&arg9), 128);
        };
        assert_non_empty_bounded(&arg10, 256);
        assert_non_empty_bounded(&arg11, 512);
        assert_hash(&arg12);
        assert_hash(&arg14);
        let v0 = ItemKeyV8{
            part_key : arg4,
            item_key : arg5,
        };
        assert!(0x2::dynamic_field::exists<ItemKeyV8>(&arg0.id, v0), 6);
        let v1 = TrackKeyV8{key: arg7};
        assert!(0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v1), 6);
        let v2 = StyleKeyV8{
            part_key  : arg4,
            item_key  : arg5,
            style_key : arg6,
        };
        assert!(!0x2::dynamic_field::exists<StyleKeyV8>(&arg0.id, v2), 5);
        let v3 = StyleRowV8{
            sequence           : arg3,
            part_key           : arg4,
            item_key           : arg5,
            style_key          : arg6,
            layer_track_key    : arg7,
            color_channel_key  : arg8,
            default_swatch_key : arg9,
            label              : arg10,
            asset_blob_id      : arg11,
            asset_sha256       : arg12,
            protected          : arg13,
            payload_commitment : arg14,
        };
        0x2::dynamic_field::add<StyleKeyV8, StyleRowV8>(&mut arg0.id, v2, v3);
        let v4 = StyleIndexKeyV8{index: arg0.observed_counts.styles};
        0x2::dynamic_field::add<StyleIndexKeyV8, StyleKeyV8>(&mut arg0.id, v4, v2);
        arg0.observed_counts.styles = arg0.observed_counts.styles + 1;
        if (arg13) {
            let v5 = ProtectedStyleIndexKeyV8{index: arg0.protected_style_count};
            0x2::dynamic_field::add<ProtectedStyleIndexKeyV8, StyleKeyV8>(&mut arg0.id, v5, v2);
            arg0.protected_style_count = arg0.protected_style_count + 1;
        };
        advance_registry(arg0, 3, arg3, 0x1::bcs::to_bytes<StyleRowV8>(&v3));
    }

    public fun append_track_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: vector<u8>) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert_category_sequence(arg0, 0, arg3);
        assert_non_empty_bounded(&arg4, 128);
        assert_non_empty_bounded(&arg5, 256);
        assert_hash(&arg7);
        let v0 = TrackKeyV8{key: arg4};
        assert!(!0x2::dynamic_field::exists<TrackKeyV8>(&arg0.id, v0), 5);
        let v1 = TrackRowV8{
            sequence           : arg3,
            key                : arg4,
            label              : arg5,
            render_order       : arg6,
            payload_commitment : arg7,
        };
        0x2::dynamic_field::add<TrackKeyV8, TrackRowV8>(&mut arg0.id, v0, v1);
        arg0.observed_counts.tracks = arg0.observed_counts.tracks + 1;
        advance_registry(arg0, 0, arg3, 0x1::bcs::to_bytes<TrackRowV8>(&v1));
    }

    public fun assert_activation_ready_v8<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) : (0x2::object::ID, vector<u8>, u64) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_v8<T0>(arg1);
        assert_registry_identity<T0>(arg0, arg1);
        assert!(arg0.sealed, 0);
        assert!(arg0.next_sequence == arg0.expected_sequence_count, 8);
        assert_counts_equal(&arg0.observed_counts, &arg0.expected_counts);
        assert_commitments_equal(&arg0.rolling_commitments, &arg0.expected_commitments);
        (0x2::object::id<BaseDefinitionRegistryV8>(arg0), arg0.rolling_commitments.aggregate, arg0.protected_style_count)
    }

    fun assert_category_sequence(arg0: &BaseDefinitionRegistryV8, arg1: u8, arg2: u64) {
        assert!(arg2 == arg0.next_sequence, 4);
        let (v0, v1) = category_range(&arg0.expected_counts, arg1);
        assert!(arg2 >= v0 && arg2 < v0 + v1, 4);
    }

    fun assert_commitments(arg0: &BaseDefinitionCommitmentsV8) {
        assert_hash(&arg0.tracks);
        assert_hash(&arg0.parts);
        assert_hash(&arg0.items);
        assert_hash(&arg0.styles);
        assert_hash(&arg0.colors);
        assert_hash(&arg0.rules);
        assert_hash(&arg0.aggregate);
    }

    fun assert_commitments_equal(arg0: &BaseDefinitionCommitmentsV8, arg1: &BaseDefinitionCommitmentsV8) {
        assert!(&arg0.tracks == &arg1.tracks, 7);
        assert!(&arg0.parts == &arg1.parts, 7);
        assert!(&arg0.items == &arg1.items, 7);
        assert!(&arg0.styles == &arg1.styles, 7);
        assert!(&arg0.colors == &arg1.colors, 7);
        assert!(&arg0.rules == &arg1.rules, 7);
        assert!(&arg0.aggregate == &arg1.aggregate, 7);
    }

    fun assert_counts_equal(arg0: &BaseDefinitionCountsV8, arg1: &BaseDefinitionCountsV8) {
        assert!(arg0.tracks == arg1.tracks, 8);
        assert!(arg0.parts == arg1.parts, 8);
        assert!(arg0.items == arg1.items, 8);
        assert!(arg0.styles == arg1.styles, 8);
        assert!(arg0.colors == arg1.colors, 8);
        assert!(arg0.rules == arg1.rules, 8);
    }

    public fun assert_draft_registry_identity_v8<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_identity<T0>(arg0, arg1);
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 1);
    }

    fun assert_non_empty_bounded(arg0: &0x1::string::String, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 > 0 && v0 <= arg1, 2);
    }

    fun assert_part_policy(arg0: u8, arg1: bool) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 11);
        if (arg0 == 2) {
            assert!(arg1, 11);
        };
    }

    fun assert_registry_identity<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>) {
        assert!(arg0.version == 8, 10);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_base_registry_identity_v8<T0>(arg1, 0x2::object::id<BaseDefinitionRegistryV8>(arg0), arg0.root_id, arg0.maker_version, &arg0.root_content_commitment);
        assert!(arg0.expected_sequence_count == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_base_definition_count_v8<T0>(arg1), 8);
        assert!(&arg0.expected_commitments.aggregate == 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_base_registry_commitment_v8<T0>(arg1), 7);
    }

    fun assert_rule_kind(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 11);
    }

    fun assert_style_color_references(arg0: &BaseDefinitionRegistryV8) {
        let v0 = 0;
        while (v0 < arg0.observed_counts.styles) {
            let v1 = StyleIndexKeyV8{index: v0};
            let v2 = 0x2::dynamic_field::borrow<StyleKeyV8, StyleRowV8>(&arg0.id, *0x2::dynamic_field::borrow<StyleIndexKeyV8, StyleKeyV8>(&arg0.id, v1));
            if (0x1::option::is_some<0x1::string::String>(&v2.color_channel_key)) {
                let v3 = ColorKeyV8{
                    channel_key : *0x1::option::borrow<0x1::string::String>(&v2.color_channel_key),
                    swatch_key  : *0x1::option::borrow<0x1::string::String>(&v2.default_swatch_key),
                };
                assert!(0x2::dynamic_field::exists<ColorKeyV8>(&arg0.id, v3), 6);
            };
            v0 = v0 + 1;
        };
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
        } else {
            arg0 == 255
        };
        assert!(v0, 9);
    }

    fun assert_valid_counts(arg0: &BaseDefinitionCountsV8) {
        assert!(arg0.tracks > 0 && arg0.tracks <= 256, 3);
        assert!(arg0.parts > 0 && arg0.parts <= 750, 3);
        assert!(arg0.items > 0 && arg0.items <= 5000, 3);
        assert!(arg0.styles > 0 && arg0.styles <= 10000, 3);
        assert!(arg0.colors <= 5000, 3);
        assert!(arg0.rules <= 1000, 3);
    }

    fun assert_writable<T0>(arg0: &BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8) {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg1, arg2);
        assert_registry_identity<T0>(arg0, arg1);
        assert!(!arg0.sealed, 0);
    }

    public fun borrow_color_v8(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String) : &ColorRowV8 {
        let v0 = ColorKeyV8{
            channel_key : arg1,
            swatch_key  : arg2,
        };
        0x2::dynamic_field::borrow<ColorKeyV8, ColorRowV8>(&arg0.id, v0)
    }

    public fun borrow_item_v8(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String) : &ItemRowV8 {
        let v0 = ItemKeyV8{
            part_key : arg1,
            item_key : arg2,
        };
        0x2::dynamic_field::borrow<ItemKeyV8, ItemRowV8>(&arg0.id, v0)
    }

    public fun borrow_part_v8(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String) : &PartRowV8 {
        let v0 = PartKeyV8{key: arg1};
        0x2::dynamic_field::borrow<PartKeyV8, PartRowV8>(&arg0.id, v0)
    }

    public fun borrow_protected_style_key_by_index_v8(arg0: &BaseDefinitionRegistryV8, arg1: u64) : &StyleKeyV8 {
        let v0 = ProtectedStyleIndexKeyV8{index: arg1};
        0x2::dynamic_field::borrow<ProtectedStyleIndexKeyV8, StyleKeyV8>(&arg0.id, v0)
    }

    public fun borrow_rule_at_v8(arg0: &BaseDefinitionRegistryV8, arg1: u64) : &RuleRowV8 {
        let v0 = RuleIndexKeyV8{index: arg1};
        0x2::dynamic_field::borrow<RuleKeyV8, RuleRowV8>(&arg0.id, *0x2::dynamic_field::borrow<RuleIndexKeyV8, RuleKeyV8>(&arg0.id, v0))
    }

    public fun borrow_style_key_by_index_v8(arg0: &BaseDefinitionRegistryV8, arg1: u64) : &StyleKeyV8 {
        let v0 = StyleIndexKeyV8{index: arg1};
        0x2::dynamic_field::borrow<StyleIndexKeyV8, StyleKeyV8>(&arg0.id, v0)
    }

    public fun borrow_style_v8(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : &StyleRowV8 {
        let v0 = StyleKeyV8{
            part_key  : arg1,
            item_key  : arg2,
            style_key : arg3,
        };
        0x2::dynamic_field::borrow<StyleKeyV8, StyleRowV8>(&arg0.id, v0)
    }

    public fun borrow_track_v8(arg0: &BaseDefinitionRegistryV8, arg1: 0x1::string::String) : &TrackRowV8 {
        let v0 = TrackKeyV8{key: arg1};
        0x2::dynamic_field::borrow<TrackKeyV8, TrackRowV8>(&arg0.id, v0)
    }

    public fun category_color_v8() : u8 {
        4
    }

    public fun category_item_v8() : u8 {
        2
    }

    public fun category_part_v8() : u8 {
        1
    }

    fun category_range(arg0: &BaseDefinitionCountsV8, arg1: u8) : (u64, u64) {
        if (arg1 == 0) {
            return (0, arg0.tracks)
        };
        if (arg1 == 1) {
            return (arg0.tracks, arg0.parts)
        };
        if (arg1 == 2) {
            return (arg0.tracks + arg0.parts, arg0.items)
        };
        if (arg1 == 3) {
            return (arg0.tracks + arg0.parts + arg0.items, arg0.styles)
        };
        if (arg1 == 4) {
            return (arg0.tracks + arg0.parts + arg0.items + arg0.styles, arg0.colors)
        };
        assert!(arg1 == 5, 9);
        (arg0.tracks + arg0.parts + arg0.items + arg0.styles + arg0.colors, arg0.rules)
    }

    public fun category_rule_v8() : u8 {
        5
    }

    public fun category_style_v8() : u8 {
        3
    }

    public fun category_track_v8() : u8 {
        0
    }

    public fun color_channel_key_v8(arg0: &ColorRowV8) : &0x1::string::String {
        &arg0.channel_key
    }

    public fun color_payload_commitment_v8(arg0: &ColorRowV8) : &vector<u8> {
        &arg0.payload_commitment
    }

    public fun color_rgba_v8(arg0: &ColorRowV8) : u32 {
        arg0.rgba
    }

    public fun color_swatch_key_v8(arg0: &ColorRowV8) : &0x1::string::String {
        &arg0.swatch_key
    }

    public fun empty_category_commitment_v8(arg0: vector<u8>, arg1: u8) : vector<u8> {
        assert_hash(&arg0);
        assert_valid_category(arg1);
        let v0 = RollingCommitmentInputV8{
            domain                  : b"animacraft-v8/base-empty",
            version                 : 8,
            root_content_commitment : arg0,
            category                : arg1,
            previous                : b"",
            sequence                : 0,
            row_bytes               : b"",
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<RollingCommitmentInputV8>(&v0))
    }

    fun empty_commitments(arg0: vector<u8>) : BaseDefinitionCommitmentsV8 {
        BaseDefinitionCommitmentsV8{
            tracks    : empty_category_commitment_v8(arg0, 0),
            parts     : empty_category_commitment_v8(arg0, 1),
            items     : empty_category_commitment_v8(arg0, 2),
            styles    : empty_category_commitment_v8(arg0, 3),
            colors    : empty_category_commitment_v8(arg0, 4),
            rules     : empty_category_commitment_v8(arg0, 5),
            aggregate : empty_category_commitment_v8(arg0, 255),
        }
    }

    public fun item_gate_kind_v8(arg0: &ItemRowV8) : u8 {
        arg0.gate_kind
    }

    public fun item_payload_commitment_v8(arg0: &ItemRowV8) : &vector<u8> {
        &arg0.payload_commitment
    }

    public fun new_base_definition_commitments_v8(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : BaseDefinitionCommitmentsV8 {
        let v0 = BaseDefinitionCommitmentsV8{
            tracks    : arg0,
            parts     : arg1,
            items     : arg2,
            styles    : arg3,
            colors    : arg4,
            rules     : arg5,
            aggregate : arg6,
        };
        assert_commitments(&v0);
        v0
    }

    public fun new_base_definition_counts_v8(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : BaseDefinitionCountsV8 {
        let v0 = BaseDefinitionCountsV8{
            tracks : arg0,
            parts  : arg1,
            items  : arg2,
            styles : arg3,
            colors : arg4,
            rules  : arg5,
        };
        assert_valid_counts(&v0);
        v0
    }

    public(friend) fun new_base_definition_registry_v8<T0>(arg0: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8, arg2: BaseDefinitionCountsV8, arg3: BaseDefinitionCommitmentsV8, arg4: &mut 0x2::tx_context::TxContext) : BaseDefinitionRegistryV8 {
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_draft_admin_v8<T0>(arg0, arg1);
        assert_valid_counts(&arg2);
        assert_commitments(&arg3);
        let v0 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_id_v8<T0>(arg0);
        let v1 = 0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_maker_version_v8<T0>(arg0);
        let v2 = *0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_content_commitment_v8<T0>(arg0);
        let v3 = total_count_v8(&arg2);
        0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::assert_root_identity_v8<T0>(arg0, v0, v1, &v2);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_base_definition_count_v8<T0>(arg0) == v3, 8);
        assert!(0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::root_expected_base_registry_commitment_v8<T0>(arg0) == &arg3.aggregate, 7);
        BaseDefinitionRegistryV8{
            id                      : 0x2::object::new(arg4),
            version                 : 8,
            root_id                 : v0,
            maker_version           : v1,
            root_content_commitment : v2,
            expected_counts         : arg2,
            observed_counts         : zero_counts(),
            expected_commitments    : arg3,
            rolling_commitments     : empty_commitments(v2),
            next_sequence           : 0,
            expected_sequence_count : v3,
            protected_style_count   : 0,
            sealed                  : false,
        }
    }

    public fun part_terms_v8(arg0: &PartRowV8) : (&0x1::string::String, u64, bool, &vector<u8>) {
        (&arg0.key, arg0.sequence, arg0.required, &arg0.payload_commitment)
    }

    public fun registry_id_v8(arg0: &BaseDefinitionRegistryV8) : 0x2::object::ID {
        0x2::object::id<BaseDefinitionRegistryV8>(arg0)
    }

    public fun registry_maker_version_v8(arg0: &BaseDefinitionRegistryV8) : u64 {
        arg0.maker_version
    }

    public fun registry_part_count_v8(arg0: &BaseDefinitionRegistryV8) : u64 {
        arg0.observed_counts.parts
    }

    public fun registry_root_content_commitment_v8(arg0: &BaseDefinitionRegistryV8) : &vector<u8> {
        &arg0.root_content_commitment
    }

    public fun registry_root_id_v8(arg0: &BaseDefinitionRegistryV8) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_sealed_v8(arg0: &BaseDefinitionRegistryV8) : bool {
        arg0.sealed
    }

    public fun registry_track_count_v8(arg0: &BaseDefinitionRegistryV8) : u64 {
        arg0.observed_counts.tracks
    }

    public fun rule_count_v8(arg0: &BaseDefinitionRegistryV8) : u64 {
        arg0.observed_counts.rules
    }

    public fun rule_terms_v8(arg0: &RuleRowV8) : (u8, &0x1::string::String, &0x1::string::String, &0x1::string::String, &0x1::string::String) {
        (arg0.kind, &arg0.left_part_key, &arg0.left_item_key, &arg0.right_part_key, &arg0.right_item_key)
    }

    public fun seal_base_definition_registry_v8<T0>(arg0: &mut BaseDefinitionRegistryV8, arg1: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerRootV8<T0>, arg2: &0x211d4c1acf858ed720026a83946f07d191349d4da4bdcb16201dccb38f1a019e::maker_v8::MakerAdminCapV8) {
        assert_writable<T0>(arg0, arg1, arg2);
        assert!(arg0.next_sequence == arg0.expected_sequence_count, 8);
        assert_counts_equal(&arg0.observed_counts, &arg0.expected_counts);
        assert_commitments_equal(&arg0.rolling_commitments, &arg0.expected_commitments);
        assert_style_color_references(arg0);
        arg0.sealed = true;
        let v0 = BaseDefinitionRegistrySealedV8{
            root_id               : arg0.root_id,
            registry_id           : 0x2::object::id<BaseDefinitionRegistryV8>(arg0),
            definition_count      : arg0.expected_sequence_count,
            protected_style_count : arg0.protected_style_count,
            aggregate_commitment  : arg0.rolling_commitments.aggregate,
        };
        0x2::event::emit<BaseDefinitionRegistrySealedV8>(v0);
    }

    public(friend) fun share_base_definition_registry_v8(arg0: BaseDefinitionRegistryV8) {
        0x2::transfer::share_object<BaseDefinitionRegistryV8>(arg0);
    }

    public fun style_asset_blob_id_v8(arg0: &StyleRowV8) : &0x1::string::String {
        &arg0.asset_blob_id
    }

    public fun style_asset_sha256_v8(arg0: &StyleRowV8) : &vector<u8> {
        &arg0.asset_sha256
    }

    public fun style_color_channel_key_v8(arg0: &StyleRowV8) : &0x1::option::Option<0x1::string::String> {
        &arg0.color_channel_key
    }

    public fun style_default_swatch_key_v8(arg0: &StyleRowV8) : &0x1::option::Option<0x1::string::String> {
        &arg0.default_swatch_key
    }

    public fun style_item_key_v8(arg0: &StyleRowV8) : &0x1::string::String {
        &arg0.item_key
    }

    public fun style_key_v8(arg0: &StyleRowV8) : &0x1::string::String {
        &arg0.style_key
    }

    public fun style_layer_track_key_v8(arg0: &StyleRowV8) : &0x1::string::String {
        &arg0.layer_track_key
    }

    public fun style_part_key_v8(arg0: &StyleRowV8) : &0x1::string::String {
        &arg0.part_key
    }

    public fun style_payload_commitment_v8(arg0: &StyleRowV8) : &vector<u8> {
        &arg0.payload_commitment
    }

    public fun style_protected_v8(arg0: &StyleRowV8) : bool {
        arg0.protected
    }

    public fun total_count_v8(arg0: &BaseDefinitionCountsV8) : u64 {
        arg0.tracks + arg0.parts + arg0.items + arg0.styles + arg0.colors + arg0.rules
    }

    public fun version_v8() : u64 {
        8
    }

    fun zero_counts() : BaseDefinitionCountsV8 {
        BaseDefinitionCountsV8{
            tracks : 0,
            parts  : 0,
            items  : 0,
            styles : 0,
            colors : 0,
            rules  : 0,
        }
    }

    // decompiled from Move bytecode v7
}

