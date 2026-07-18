module 0xed543939741867249ac6075ad9995b47fe3bca5cd9cdf09c3b168d512e6d73a3::controller {
    struct ControllerNFT has store, key {
        id: 0x2::object::UID,
        version: u64,
        series_id: 0x2::object::ID,
        artifact_code: 0x1::string::String,
        artifact_type_name: 0x1::string::String,
        control_right: 0x1::string::String,
        authority_mode_name: 0x1::string::String,
        image_url: 0x1::string::String,
        artifact_type: u8,
        control_record_id: 0x2::object::ID,
        issued_at_ms: u64,
    }

    struct ArtifactControlRecord has key {
        id: 0x2::object::UID,
        version: u64,
        series_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        artifact_type: u8,
        controller_nft_id: 0x2::object::ID,
        current_controller_mirror: address,
        legacy_series_owner_mirror: address,
        legacy_comments_owner_mirror: address,
        authority_mode: u8,
        transfer_locked: bool,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct SeriesControlStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TreeControlStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SeriesControlState has copy, drop, store {
        control_record_id: 0x2::object::ID,
        controller_nft_id: 0x2::object::ID,
        artifact_type: u8,
        authority_mode: u8,
    }

    struct TreeControlState has copy, drop, store {
        control_record_id: 0x2::object::ID,
        controller_nft_id: 0x2::object::ID,
        series_id: 0x2::object::ID,
        artifact_type: u8,
        authority_mode: u8,
    }

    struct ControllerNftMintedForSeriesEvent has copy, drop {
        series_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        artifact_type: u8,
        controller_nft_id: 0x2::object::ID,
        control_record_id: 0x2::object::ID,
        minted_to: address,
        authority_mode: u8,
        created_at_ms: u64,
    }

    struct ArtifactControlRecordCreatedEvent has copy, drop {
        series_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        artifact_type: u8,
        control_record_id: 0x2::object::ID,
        controller_nft_id: 0x2::object::ID,
        current_controller_mirror: address,
        authority_mode: u8,
        created_at_ms: u64,
    }

    struct ArtifactControllerModeChangedEvent has copy, drop {
        series_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        artifact_type: u8,
        control_record_id: 0x2::object::ID,
        controller_nft_id: 0x2::object::ID,
        changed_by: address,
        old_mode: u8,
        new_mode: u8,
        changed_at_ms: u64,
    }

    struct ArtifactControllerMirrorSyncedEvent has copy, drop {
        series_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        artifact_type: u8,
        control_record_id: 0x2::object::ID,
        controller_nft_id: 0x2::object::ID,
        synced_by: address,
        controller_mirror: address,
        legacy_series_owner_mirror: address,
        legacy_comments_owner_mirror: address,
        synced_at_ms: u64,
    }

    struct ArtifactControllerMirrorRepairEvent has copy, drop {
        series_id: 0x2::object::ID,
        comments_tree_id: 0x2::object::ID,
        artifact_type: u8,
        control_record_id: 0x2::object::ID,
        controller_nft_id: 0x2::object::ID,
        repaired_by: address,
        controller_mirror: address,
        legacy_series_owner_mirror: address,
        legacy_comments_owner_mirror: address,
        repaired_at_ms: u64,
    }

    public fun assert_controller_for_series(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: u8, arg3: &ArtifactControlRecord, arg4: &ControllerNFT, arg5: &0x2::tx_context::TxContext) {
        assert_current_record(arg3);
        assert_current_nft(arg4);
        assert!(is_series_control_enabled(arg0), 4);
        let v0 = SeriesControlStateKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<SeriesControlStateKey, SeriesControlState>(arg0, v0);
        assert!(v1.control_record_id == 0x2::object::id<ArtifactControlRecord>(arg3), 7);
        assert!(v1.controller_nft_id == 0x2::object::id<ControllerNFT>(arg4), 8);
        assert!(v1.artifact_type == arg2, 8);
        assert!(arg3.series_id == arg1, 7);
        assert!(arg3.artifact_type == arg2, 7);
        assert!(arg3.controller_nft_id == 0x2::object::id<ControllerNFT>(arg4), 7);
        assert!(arg3.authority_mode == v1.authority_mode, 7);
        assert!(arg4.series_id == arg1, 8);
        assert!(arg4.artifact_type == arg2, 8);
        assert!(arg4.control_record_id == 0x2::object::id<ArtifactControlRecord>(arg3), 8);
        assert!(arg3.authority_mode != 0, 5);
        assert!(!arg3.transfer_locked, 9);
    }

    public fun assert_controller_for_tree(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: &ArtifactControlRecord, arg5: &ControllerNFT, arg6: &0x2::tx_context::TxContext) {
        assert_current_record(arg4);
        assert_current_nft(arg5);
        assert!(is_tree_control_enabled(arg0), 4);
        let v0 = TreeControlStateKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<TreeControlStateKey, TreeControlState>(arg0, v0);
        assert!(v1.control_record_id == 0x2::object::id<ArtifactControlRecord>(arg4), 7);
        assert!(v1.controller_nft_id == 0x2::object::id<ControllerNFT>(arg5), 8);
        assert!(v1.series_id == arg2, 10);
        assert!(v1.artifact_type == arg3, 10);
        assert!(arg4.comments_tree_id == arg1, 10);
        assert!(arg4.series_id == arg2, 7);
        assert!(arg4.artifact_type == arg3, 7);
        assert!(arg4.controller_nft_id == 0x2::object::id<ControllerNFT>(arg5), 7);
        assert!(arg4.authority_mode == v1.authority_mode, 7);
        assert!(arg5.series_id == arg2, 8);
        assert!(arg5.artifact_type == arg3, 8);
        assert!(arg5.control_record_id == 0x2::object::id<ArtifactControlRecord>(arg4), 8);
        assert!(arg4.authority_mode != 0, 5);
        assert!(!arg4.transfer_locked, 9);
    }

    fun assert_current_nft(arg0: &ControllerNFT) {
        assert!(arg0.version == 1, 1);
    }

    fun assert_current_record(arg0: &ArtifactControlRecord) {
        assert!(arg0.version == 1, 2);
    }

    public fun assert_series_legacy_write_allowed(arg0: &0x2::object::UID) {
        if (is_series_control_enabled(arg0)) {
            let v0 = SeriesControlStateKey{dummy_field: false};
            let v1 = 0x2::dynamic_field::borrow<SeriesControlStateKey, SeriesControlState>(arg0, v0);
            assert!(v1.authority_mode == 0 || v1.authority_mode == 1, 6);
        };
    }

    public fun assert_tree_legacy_write_allowed(arg0: &0x2::object::UID) {
        if (is_tree_control_enabled(arg0)) {
            let v0 = TreeControlStateKey{dummy_field: false};
            let v1 = 0x2::dynamic_field::borrow<TreeControlStateKey, TreeControlState>(arg0, v0);
            assert!(v1.authority_mode == 0 || v1.authority_mode == 1, 6);
        };
    }

    fun assert_valid_authority_mode(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 5);
    }

    public fun authority_mode_controller_only() : u8 {
        3
    }

    public fun authority_mode_controller_primary() : u8 {
        2
    }

    public fun authority_mode_dual() : u8 {
        1
    }

    public fun authority_mode_legacy_owner_only() : u8 {
        0
    }

    fun authority_mode_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"legacy_owner_only")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"dual_mode")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"controller_primary")
        } else {
            assert!(arg0 == 3, 5);
            0x1::string::utf8(b"controller_only")
        }
    }

    public fun control_record_artifact_type(arg0: &ArtifactControlRecord) : u8 {
        arg0.artifact_type
    }

    public fun control_record_authority_mode(arg0: &ArtifactControlRecord) : u8 {
        arg0.authority_mode
    }

    public fun control_record_comments_tree_id(arg0: &ArtifactControlRecord) : 0x2::object::ID {
        arg0.comments_tree_id
    }

    public fun control_record_controller_nft_id(arg0: &ArtifactControlRecord) : 0x2::object::ID {
        arg0.controller_nft_id
    }

    public fun control_record_created_at_ms(arg0: &ArtifactControlRecord) : u64 {
        arg0.created_at_ms
    }

    public fun control_record_current_controller_mirror(arg0: &ArtifactControlRecord) : address {
        arg0.current_controller_mirror
    }

    public fun control_record_legacy_comments_owner_mirror(arg0: &ArtifactControlRecord) : address {
        arg0.legacy_comments_owner_mirror
    }

    public fun control_record_legacy_series_owner_mirror(arg0: &ArtifactControlRecord) : address {
        arg0.legacy_series_owner_mirror
    }

    public fun control_record_series_id(arg0: &ArtifactControlRecord) : 0x2::object::ID {
        arg0.series_id
    }

    public fun control_record_transfer_locked(arg0: &ArtifactControlRecord) : bool {
        arg0.transfer_locked
    }

    public fun control_record_updated_at_ms(arg0: &ArtifactControlRecord) : u64 {
        arg0.updated_at_ms
    }

    public fun controller_nft_artifact_code(arg0: &ControllerNFT) : 0x1::string::String {
        arg0.artifact_code
    }

    public fun controller_nft_artifact_type(arg0: &ControllerNFT) : u8 {
        arg0.artifact_type
    }

    public fun controller_nft_artifact_type_name(arg0: &ControllerNFT) : 0x1::string::String {
        arg0.artifact_type_name
    }

    public fun controller_nft_authority_mode_name(arg0: &ControllerNFT) : 0x1::string::String {
        arg0.authority_mode_name
    }

    public fun controller_nft_control_record_id(arg0: &ControllerNFT) : 0x2::object::ID {
        arg0.control_record_id
    }

    public fun controller_nft_control_right(arg0: &ControllerNFT) : 0x1::string::String {
        arg0.control_right
    }

    public fun controller_nft_image_url(arg0: &ControllerNFT) : 0x1::string::String {
        arg0.image_url
    }

    public fun controller_nft_issued_at_ms(arg0: &ControllerNFT) : u64 {
        arg0.issued_at_ms
    }

    public fun controller_nft_name(arg0: &ControllerNFT) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"PaperProof Artifact Controller: ");
        0x1::string::append(&mut v0, arg0.artifact_code);
        v0
    }

    public fun controller_nft_series_id(arg0: &ControllerNFT) : 0x2::object::ID {
        arg0.series_id
    }

    public fun enable_control(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u8, arg7: address, arg8: address, arg9: u8, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (ArtifactControlRecord, ControllerNFT) {
        assert_valid_authority_mode(arg9);
        assert!(arg9 != 0, 5);
        let v0 = SeriesControlStateKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<SeriesControlStateKey>(arg0, v0), 3);
        let v1 = TreeControlStateKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<TreeControlStateKey>(arg1, v1), 3);
        let v2 = 0x2::clock::timestamp_ms(arg10);
        let v3 = 0x2::tx_context::sender(arg11);
        let v4 = 0x2::object::new(arg11);
        let v5 = *0x2::object::uid_as_inner(&v4);
        let v6 = 0x2::object::new(arg11);
        let v7 = *0x2::object::uid_as_inner(&v6);
        let v8 = ArtifactControlRecord{
            id                           : v4,
            version                      : 1,
            series_id                    : arg2,
            comments_tree_id             : arg3,
            artifact_type                : arg6,
            controller_nft_id            : v7,
            current_controller_mirror    : v3,
            legacy_series_owner_mirror   : arg7,
            legacy_comments_owner_mirror : arg8,
            authority_mode               : arg9,
            transfer_locked              : false,
            created_at_ms                : v2,
            updated_at_ms                : v2,
        };
        let v9 = ControllerNFT{
            id                  : v6,
            version             : 1,
            series_id           : arg2,
            artifact_code       : arg4,
            artifact_type_name  : arg5,
            control_right       : 0x1::string::utf8(b"artifact_controller"),
            authority_mode_name : authority_mode_name(arg9),
            image_url           : 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/46egR1yyhHVRNdNx72ICBQ99AiywUaMwfi00CDYznUI"),
            artifact_type       : arg6,
            control_record_id   : v5,
            issued_at_ms        : v2,
        };
        let v10 = SeriesControlStateKey{dummy_field: false};
        let v11 = SeriesControlState{
            control_record_id : v5,
            controller_nft_id : v7,
            artifact_type     : arg6,
            authority_mode    : arg9,
        };
        0x2::dynamic_field::add<SeriesControlStateKey, SeriesControlState>(arg0, v10, v11);
        let v12 = TreeControlStateKey{dummy_field: false};
        let v13 = TreeControlState{
            control_record_id : v5,
            controller_nft_id : v7,
            series_id         : arg2,
            artifact_type     : arg6,
            authority_mode    : arg9,
        };
        0x2::dynamic_field::add<TreeControlStateKey, TreeControlState>(arg1, v12, v13);
        let v14 = ArtifactControlRecordCreatedEvent{
            series_id                 : arg2,
            comments_tree_id          : arg3,
            artifact_type             : arg6,
            control_record_id         : v5,
            controller_nft_id         : v7,
            current_controller_mirror : v3,
            authority_mode            : arg9,
            created_at_ms             : v2,
        };
        0x2::event::emit<ArtifactControlRecordCreatedEvent>(v14);
        let v15 = ControllerNftMintedForSeriesEvent{
            series_id         : arg2,
            comments_tree_id  : arg3,
            artifact_type     : arg6,
            controller_nft_id : v7,
            control_record_id : v5,
            minted_to         : v3,
            authority_mode    : arg9,
            created_at_ms     : v2,
        };
        0x2::event::emit<ControllerNftMintedForSeriesEvent>(v15);
        (v8, v9)
    }

    public fun is_control_mirror_stale(arg0: &ArtifactControlRecord, arg1: address) : bool {
        if (arg0.current_controller_mirror != arg1) {
            true
        } else if (arg0.legacy_series_owner_mirror != arg1) {
            true
        } else {
            arg0.legacy_comments_owner_mirror != arg1
        }
    }

    public fun is_series_control_enabled(arg0: &0x2::object::UID) : bool {
        let v0 = SeriesControlStateKey{dummy_field: false};
        0x2::dynamic_field::exists<SeriesControlStateKey>(arg0, v0)
    }

    public fun is_series_in_controller_only_mode(arg0: &0x2::object::UID) : bool {
        series_authority_mode(arg0) == 3
    }

    public fun is_series_in_controller_primary_mode(arg0: &0x2::object::UID) : bool {
        series_authority_mode(arg0) == 2
    }

    public fun is_series_in_dual_mode(arg0: &0x2::object::UID) : bool {
        series_authority_mode(arg0) == 1
    }

    public fun is_tree_control_enabled(arg0: &0x2::object::UID) : bool {
        let v0 = TreeControlStateKey{dummy_field: false};
        0x2::dynamic_field::exists<TreeControlStateKey>(arg0, v0)
    }

    public fun is_tree_in_controller_only_mode(arg0: &0x2::object::UID) : bool {
        tree_authority_mode(arg0) == 3
    }

    public fun is_tree_in_controller_primary_mode(arg0: &0x2::object::UID) : bool {
        tree_authority_mode(arg0) == 2
    }

    public fun is_tree_in_dual_mode(arg0: &0x2::object::UID) : bool {
        tree_authority_mode(arg0) == 1
    }

    public fun repair_legacy_owner_mirrors(arg0: &mut ArtifactControlRecord, arg1: &ControllerNFT, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert_current_nft(arg1);
        assert!(arg0.controller_nft_id == 0x2::object::id<ControllerNFT>(arg1), 8);
        arg0.current_controller_mirror = 0x2::tx_context::sender(arg5);
        arg0.legacy_series_owner_mirror = arg2;
        arg0.legacy_comments_owner_mirror = arg3;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = ArtifactControllerMirrorRepairEvent{
            series_id                    : arg0.series_id,
            comments_tree_id             : arg0.comments_tree_id,
            artifact_type                : arg0.artifact_type,
            control_record_id            : 0x2::object::id<ArtifactControlRecord>(arg0),
            controller_nft_id            : 0x2::object::id<ControllerNFT>(arg1),
            repaired_by                  : 0x2::tx_context::sender(arg5),
            controller_mirror            : arg0.current_controller_mirror,
            legacy_series_owner_mirror   : arg0.legacy_series_owner_mirror,
            legacy_comments_owner_mirror : arg0.legacy_comments_owner_mirror,
            repaired_at_ms               : arg0.updated_at_ms,
        };
        0x2::event::emit<ArtifactControllerMirrorRepairEvent>(v0);
    }

    public fun series_authority_mode(arg0: &0x2::object::UID) : u8 {
        if (!is_series_control_enabled(arg0)) {
            0
        } else {
            let v1 = SeriesControlStateKey{dummy_field: false};
            0x2::dynamic_field::borrow<SeriesControlStateKey, SeriesControlState>(arg0, v1).authority_mode
        }
    }

    public fun series_control_record_id(arg0: &0x2::object::UID) : 0x1::option::Option<0x2::object::ID> {
        if (!is_series_control_enabled(arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            let v1 = SeriesControlStateKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<SeriesControlStateKey, SeriesControlState>(arg0, v1).control_record_id)
        }
    }

    public fun series_controller_nft_id(arg0: &0x2::object::UID) : 0x1::option::Option<0x2::object::ID> {
        if (!is_series_control_enabled(arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            let v1 = SeriesControlStateKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<SeriesControlStateKey, SeriesControlState>(arg0, v1).controller_nft_id)
        }
    }

    public fun set_authority_mode(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::object::UID, arg2: &mut ArtifactControlRecord, arg3: &mut ControllerNFT, arg4: u8, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_valid_authority_mode(arg4);
        assert_current_record(arg2);
        assert_current_nft(arg3);
        assert!(is_series_control_enabled(arg0), 4);
        assert!(is_tree_control_enabled(arg1), 4);
        assert!(arg2.controller_nft_id == 0x2::object::id<ControllerNFT>(arg3), 8);
        let v0 = 0x2::tx_context::sender(arg6);
        arg2.authority_mode = arg4;
        arg2.current_controller_mirror = v0;
        arg2.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        arg3.authority_mode_name = authority_mode_name(arg4);
        let v1 = SeriesControlStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<SeriesControlStateKey, SeriesControlState>(arg0, v1).authority_mode = arg4;
        let v2 = TreeControlStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<TreeControlStateKey, TreeControlState>(arg1, v2).authority_mode = arg4;
        let v3 = ArtifactControllerModeChangedEvent{
            series_id         : arg2.series_id,
            comments_tree_id  : arg2.comments_tree_id,
            artifact_type     : arg2.artifact_type,
            control_record_id : 0x2::object::id<ArtifactControlRecord>(arg2),
            controller_nft_id : 0x2::object::id<ControllerNFT>(arg3),
            changed_by        : v0,
            old_mode          : arg2.authority_mode,
            new_mode          : arg4,
            changed_at_ms     : arg2.updated_at_ms,
        };
        0x2::event::emit<ArtifactControllerModeChangedEvent>(v3);
    }

    public fun set_transfer_locked(arg0: &mut ArtifactControlRecord, arg1: &ControllerNFT, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert_current_nft(arg1);
        assert!(arg0.controller_nft_id == 0x2::object::id<ControllerNFT>(arg1), 8);
        arg0.transfer_locked = arg2;
        arg0.current_controller_mirror = 0x2::tx_context::sender(arg4);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
    }

    public fun share_record_and_transfer_nft(arg0: ArtifactControlRecord, arg1: ControllerNFT, arg2: address) {
        0x2::transfer::share_object<ArtifactControlRecord>(arg0);
        0x2::transfer::public_transfer<ControllerNFT>(arg1, arg2);
    }

    public fun sync_controller_mirror(arg0: &mut ArtifactControlRecord, arg1: &ControllerNFT, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert_current_nft(arg1);
        assert!(arg0.controller_nft_id == 0x2::object::id<ControllerNFT>(arg1), 8);
        let v0 = 0x2::tx_context::sender(arg3);
        arg0.current_controller_mirror = v0;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v1 = ArtifactControllerMirrorSyncedEvent{
            series_id                    : arg0.series_id,
            comments_tree_id             : arg0.comments_tree_id,
            artifact_type                : arg0.artifact_type,
            control_record_id            : 0x2::object::id<ArtifactControlRecord>(arg0),
            controller_nft_id            : 0x2::object::id<ControllerNFT>(arg1),
            synced_by                    : v0,
            controller_mirror            : arg0.current_controller_mirror,
            legacy_series_owner_mirror   : arg0.legacy_series_owner_mirror,
            legacy_comments_owner_mirror : arg0.legacy_comments_owner_mirror,
            synced_at_ms                 : arg0.updated_at_ms,
        };
        0x2::event::emit<ArtifactControllerMirrorSyncedEvent>(v1);
    }

    public fun sync_legacy_comments_owner_mirror(arg0: &mut ArtifactControlRecord, arg1: &ControllerNFT, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert_current_nft(arg1);
        assert!(arg0.controller_nft_id == 0x2::object::id<ControllerNFT>(arg1), 8);
        arg0.current_controller_mirror = 0x2::tx_context::sender(arg4);
        arg0.legacy_comments_owner_mirror = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
    }

    public fun sync_legacy_owner_mirrors(arg0: &mut ArtifactControlRecord, arg1: &ControllerNFT, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert_current_nft(arg1);
        assert!(arg0.controller_nft_id == 0x2::object::id<ControllerNFT>(arg1), 8);
        arg0.current_controller_mirror = 0x2::tx_context::sender(arg5);
        arg0.legacy_series_owner_mirror = arg2;
        arg0.legacy_comments_owner_mirror = arg3;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v0 = ArtifactControllerMirrorSyncedEvent{
            series_id                    : arg0.series_id,
            comments_tree_id             : arg0.comments_tree_id,
            artifact_type                : arg0.artifact_type,
            control_record_id            : 0x2::object::id<ArtifactControlRecord>(arg0),
            controller_nft_id            : 0x2::object::id<ControllerNFT>(arg1),
            synced_by                    : 0x2::tx_context::sender(arg5),
            controller_mirror            : arg0.current_controller_mirror,
            legacy_series_owner_mirror   : arg0.legacy_series_owner_mirror,
            legacy_comments_owner_mirror : arg0.legacy_comments_owner_mirror,
            synced_at_ms                 : arg0.updated_at_ms,
        };
        0x2::event::emit<ArtifactControllerMirrorSyncedEvent>(v0);
    }

    public fun sync_legacy_series_owner_mirror(arg0: &mut ArtifactControlRecord, arg1: &ControllerNFT, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert_current_nft(arg1);
        assert!(arg0.controller_nft_id == 0x2::object::id<ControllerNFT>(arg1), 8);
        arg0.current_controller_mirror = 0x2::tx_context::sender(arg4);
        arg0.legacy_series_owner_mirror = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
    }

    public fun tree_authority_mode(arg0: &0x2::object::UID) : u8 {
        if (!is_tree_control_enabled(arg0)) {
            0
        } else {
            let v1 = TreeControlStateKey{dummy_field: false};
            0x2::dynamic_field::borrow<TreeControlStateKey, TreeControlState>(arg0, v1).authority_mode
        }
    }

    public fun tree_control_record_id(arg0: &0x2::object::UID) : 0x1::option::Option<0x2::object::ID> {
        if (!is_tree_control_enabled(arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            let v1 = TreeControlStateKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<TreeControlStateKey, TreeControlState>(arg0, v1).control_record_id)
        }
    }

    public fun tree_controller_nft_id(arg0: &0x2::object::UID) : 0x1::option::Option<0x2::object::ID> {
        if (!is_tree_control_enabled(arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            let v1 = TreeControlStateKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<TreeControlStateKey, TreeControlState>(arg0, v1).controller_nft_id)
        }
    }

    // decompiled from Move bytecode v7
}

