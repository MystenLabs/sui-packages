module 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::publishing {
    struct PaperProofRoot has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        governance_vault_id: 0x2::object::ID,
        fee_manager_id: 0x2::object::ID,
        type_registry_id: 0x2::object::ID,
        comments_tree_factory_cap: 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::TreeFactoryCap,
        governance_action_executor_cap: 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceActionExecutorCap,
    }

    struct TypeInfo has store {
        artifact_type: u8,
        index_object_id: 0x2::object::ID,
        enabled: bool,
        schema_version: u64,
        min_protocol_version: u64,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct TypeRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        types: 0x2::table::Table<u8, TypeInfo>,
    }

    struct TypeIndex has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        artifact_type: u8,
    }

    struct MetadataAttribute has copy, drop, store {
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct ArtifactSeries has key {
        id: 0x2::object::UID,
        version: u64,
        artifact_type: u8,
        artifact_code: 0x1::string::String,
        owner: address,
        current_version: u64,
        current_version_id: 0x2::object::ID,
        version_ids: vector<0x2::object::ID>,
        metadata_extensions: vector<MetadataAttribute>,
        comments_tree_id: 0x2::object::ID,
        likes_book_id: 0x2::object::ID,
        status: u8,
        ui_status: u8,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct PreprintReservation has store, key {
        id: 0x2::object::UID,
        reserver: address,
        series_address: address,
        artifact_code: 0x1::string::String,
        created_at_ms: u64,
    }

    struct PreprintSeriesKey has copy, drop, store {
        reservation_id: 0x2::object::ID,
    }

    struct CommonArtifactHeader has store {
        series_id: 0x2::object::ID,
        artifact_type: u8,
        version: u64,
        previous_version_id: 0x1::option::Option<0x2::object::ID>,
        author: address,
        content_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        walrus_blob_object_id: 0x1::string::String,
        content_type: 0x1::string::String,
        metadata_extensions: vector<MetadataAttribute>,
        status: u8,
        created_at_ms: u64,
    }

    struct PreprintVersionRecord has key {
        id: 0x2::object::UID,
        header: CommonArtifactHeader,
        title: 0x1::string::String,
        abstract_text: 0x1::string::String,
        authors: vector<0x1::string::String>,
        keywords: vector<0x1::string::String>,
        field: 0x1::string::String,
        license: 0x1::string::String,
        page_count: u64,
    }

    struct BlogPostVersionRecord has key {
        id: 0x2::object::UID,
        header: CommonArtifactHeader,
        title: 0x1::string::String,
        summary: 0x1::string::String,
        tags: vector<0x1::string::String>,
        language: 0x1::string::String,
    }

    struct TechnicalReportVersionRecord has key {
        id: 0x2::object::UID,
        header: CommonArtifactHeader,
        title: 0x1::string::String,
        abstract_text: 0x1::string::String,
        authors: vector<0x1::string::String>,
        organization: 0x1::string::String,
        report_number: 0x1::string::String,
        keywords: vector<0x1::string::String>,
        license: 0x1::string::String,
    }

    struct DatasetVersionRecord has key {
        id: 0x2::object::UID,
        header: CommonArtifactHeader,
        title: 0x1::string::String,
        description: 0x1::string::String,
        format: 0x1::string::String,
        file_count: u64,
        size_bytes: u64,
        license: 0x1::string::String,
        keywords: vector<0x1::string::String>,
    }

    struct SoftwareReleaseVersionRecord has key {
        id: 0x2::object::UID,
        header: CommonArtifactHeader,
        project_name: 0x1::string::String,
        version_name: 0x1::string::String,
        source_hash: 0x1::string::String,
        package_hash: 0x1::string::String,
        changelog: 0x1::string::String,
        license: 0x1::string::String,
        repository_url: 0x1::string::String,
    }

    struct GenericFileVersionRecord has key {
        id: 0x2::object::UID,
        header: CommonArtifactHeader,
        title: 0x1::string::String,
        description: 0x1::string::String,
        filename: 0x1::string::String,
        file_size: u64,
        license: 0x1::string::String,
    }

    struct ArtifactPublishedEvent has copy, drop {
        series_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        artifact_type: u8,
        artifact_code: 0x1::string::String,
        author: address,
        content_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        content_type: 0x1::string::String,
        version: u64,
        comments_tree_id: 0x2::object::ID,
        likes_book_id: 0x2::object::ID,
        created_at_ms: u64,
    }

    struct PreprintCodeReservedEvent has copy, drop {
        reservation_id: 0x2::object::ID,
        series_id: 0x2::object::ID,
        reserver: address,
        artifact_code: 0x1::string::String,
        created_at_ms: u64,
    }

    struct ArtifactVersionAddedEvent has copy, drop {
        series_id: 0x2::object::ID,
        old_version_id: 0x2::object::ID,
        new_version_id: 0x2::object::ID,
        artifact_type: u8,
        artifact_code: 0x1::string::String,
        author: address,
        content_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        content_type: 0x1::string::String,
        version: u64,
        created_at_ms: u64,
    }

    struct ArtifactStatusChangedEvent has copy, drop {
        series_id: 0x2::object::ID,
        artifact_type: u8,
        changed_by: address,
        old_status: u8,
        new_status: u8,
        changed_at_ms: u64,
    }

    struct ArtifactSeriesMetadataUpdatedEvent has copy, drop {
        series_id: 0x2::object::ID,
        artifact_type: u8,
        updated_by: address,
        metadata_count: u64,
        updated_at_ms: u64,
    }

    struct ArtifactTypeStatusChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        artifact_type: u8,
        changed_by: address,
        old_enabled: bool,
        enabled: bool,
        changed_at_ms: u64,
    }

    struct ProtocolPausedChangedEvent has copy, drop {
        root_id: 0x2::object::ID,
        changed_by: address,
        old_paused: bool,
        new_paused: bool,
        changed_at_ms: u64,
    }

    struct PaperProofRootCreatedEvent has copy, drop {
        root_id: 0x2::object::ID,
        created_by: address,
        governance_vault_id: 0x2::object::ID,
        fee_manager_id: 0x2::object::ID,
        type_registry_id: 0x2::object::ID,
        comments_tree_factory_cap_registry_id: 0x2::object::ID,
        governance_action_executor_cap_registry_id: 0x2::object::ID,
    }

    struct TypeRegistryCreatedEvent has copy, drop {
        root_id: 0x2::object::ID,
        type_registry_id: 0x2::object::ID,
        created_by: address,
    }

    struct TypeIndexCreatedEvent has copy, drop {
        root_id: 0x2::object::ID,
        artifact_type: u8,
        type_index_id: 0x2::object::ID,
        created_by: address,
    }

    public fun execute_comments_fee_level_proposal(arg0: &PaperProofRoot, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg3: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::GovernanceConfig, arg4: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::Proposal, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_root(arg0);
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1), 8);
        assert!(arg0.fee_manager_id == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg2), 9);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::execute_comments_fee_level_proposal(arg3, arg4, arg1, &arg0.governance_action_executor_cap, arg2, arg5);
    }

    public fun add_blog_post_version(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: vector<MetadataAttribute>, arg14: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_medium_text(&arg6);
        validate_tags(&arg7);
        validate_short_text(&arg8);
        let v0 = 0x2::object::new(arg16);
        let v1 = BlogPostVersionRecord{
            id       : v0,
            header   : add_version_common(arg0, arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::blog_post(), *0x2::object::uid_as_inner(&v0), arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16),
            title    : arg5,
            summary  : arg6,
            tags     : arg7,
            language : arg8,
        };
        0x2::transfer::share_object<BlogPostVersionRecord>(v1);
    }

    public fun add_dataset_version(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: vector<0x1::string::String>, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_long_text(&arg6);
        validate_keywords(&arg11);
        validate_short_text(&arg7);
        validate_short_text(&arg10);
        let v0 = 0x2::object::new(arg19);
        let v1 = DatasetVersionRecord{
            id          : v0,
            header      : add_version_common(arg0, arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::dataset(), *0x2::object::uid_as_inner(&v0), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19),
            title       : arg5,
            description : arg6,
            format      : arg7,
            file_count  : arg8,
            size_bytes  : arg9,
            license     : arg10,
            keywords    : arg11,
        };
        0x2::transfer::share_object<DatasetVersionRecord>(v1);
    }

    public fun add_generic_file_version(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: vector<MetadataAttribute>, arg15: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_long_text(&arg6);
        validate_short_text(&arg7);
        validate_short_text(&arg9);
        let v0 = 0x2::object::new(arg17);
        let v1 = GenericFileVersionRecord{
            id          : v0,
            header      : add_version_common(arg0, arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::generic_file(), *0x2::object::uid_as_inner(&v0), arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17),
            title       : arg5,
            description : arg6,
            filename    : arg7,
            file_size   : arg8,
            license     : arg9,
        };
        0x2::transfer::share_object<GenericFileVersionRecord>(v1);
    }

    public fun add_preprint_version(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_long_text(&arg6);
        validate_authors(&arg7);
        validate_keywords(&arg8);
        validate_short_text(&arg9);
        validate_short_text(&arg10);
        let v0 = 0x2::object::new(arg19);
        let v1 = PreprintVersionRecord{
            id            : v0,
            header        : add_version_common(arg0, arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(), *0x2::object::uid_as_inner(&v0), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19),
            title         : arg5,
            abstract_text : arg6,
            authors       : arg7,
            keywords      : arg8,
            field         : arg9,
            license       : arg10,
            page_count    : arg11,
        };
        0x2::transfer::share_object<PreprintVersionRecord>(v1);
    }

    public fun add_software_release_version(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_short_text(&arg6);
        validate_short_text(&arg7);
        validate_short_text(&arg8);
        validate_medium_text(&arg9);
        validate_short_text(&arg10);
        validate_medium_text(&arg11);
        let v0 = 0x2::object::new(arg19);
        let v1 = SoftwareReleaseVersionRecord{
            id             : v0,
            header         : add_version_common(arg0, arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::software_release(), *0x2::object::uid_as_inner(&v0), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19),
            project_name   : arg5,
            version_name   : arg6,
            source_hash    : arg7,
            package_hash   : arg8,
            changelog      : arg9,
            license        : arg10,
            repository_url : arg11,
        };
        0x2::transfer::share_object<SoftwareReleaseVersionRecord>(v1);
    }

    public fun add_technical_report_version(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_long_text(&arg6);
        validate_authors(&arg7);
        validate_keywords(&arg10);
        validate_short_text(&arg8);
        validate_short_text(&arg9);
        validate_short_text(&arg11);
        let v0 = 0x2::object::new(arg19);
        let v1 = TechnicalReportVersionRecord{
            id            : v0,
            header        : add_version_common(arg0, arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::technical_report(), *0x2::object::uid_as_inner(&v0), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19),
            title         : arg5,
            abstract_text : arg6,
            authors       : arg7,
            organization  : arg8,
            report_number : arg9,
            keywords      : arg10,
            license       : arg11,
        };
        0x2::transfer::share_object<TechnicalReportVersionRecord>(v1);
    }

    fun add_type_info(arg0: &mut TypeRegistry, arg1: u8, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = TypeInfo{
            artifact_type        : arg1,
            index_object_id      : arg2,
            enabled              : true,
            schema_version       : 1,
            min_protocol_version : 1,
            created_at_ms        : arg3,
            updated_at_ms        : arg3,
        };
        0x2::table::add<u8, TypeInfo>(&mut arg0.types, arg1, v0);
    }

    fun add_version_common(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &mut ArtifactSeries, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: u8, arg6: 0x2::object::ID, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: vector<MetadataAttribute>, arg12: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : CommonArtifactHeader {
        assert_current_root(arg0);
        assert_current_registry(arg1);
        assert_current_series(arg2);
        assert!(!arg0.paused, 1);
        assert!(0x2::object::id<TypeRegistry>(arg1) == arg0.type_registry_id, 7);
        assert!(arg1.registry_id == 0x2::object::id<PaperProofRoot>(arg0), 7);
        assert!(0x2::table::borrow<u8, TypeInfo>(&arg1.types, arg5).enabled, 6);
        assert!(arg2.artifact_type == arg5, 5);
        assert!(arg2.status == 0, 22);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2.version_ids) < 168, 25);
        assert!(0x2::tx_context::sender(arg14) == arg2.owner, 21);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg3) == 0x2::object::id<PaperProofRoot>(arg0), 8);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_registry_id(arg4) == 0x2::object::id<PaperProofRoot>(arg0), 9);
        assert!(0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg3) == arg0.governance_vault_id, 8);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg4) == arg0.fee_manager_id, 9);
        validate_content_fields(&arg7, &arg8, &arg9, &arg10);
        validate_metadata_extensions(&arg11);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::collect_artifact_fee(arg3, arg4, arg5, arg12, arg14);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = arg2.current_version_id;
        let v3 = arg2.current_version + 1;
        arg2.current_version = v3;
        arg2.current_version_id = arg6;
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.version_ids, arg6);
        arg2.updated_at_ms = v0;
        let v4 = CommonArtifactHeader{
            series_id             : 0x2::object::id<ArtifactSeries>(arg2),
            artifact_type         : arg5,
            version               : v3,
            previous_version_id   : 0x1::option::some<0x2::object::ID>(v2),
            author                : v1,
            content_hash          : arg7,
            walrus_blob_id        : arg8,
            walrus_blob_object_id : arg9,
            content_type          : arg10,
            metadata_extensions   : arg11,
            status                : 0,
            created_at_ms         : v0,
        };
        let v5 = ArtifactVersionAddedEvent{
            series_id      : 0x2::object::id<ArtifactSeries>(arg2),
            old_version_id : v2,
            new_version_id : arg6,
            artifact_type  : arg5,
            artifact_code  : arg2.artifact_code,
            author         : v1,
            content_hash   : v4.content_hash,
            walrus_blob_id : v4.walrus_blob_id,
            content_type   : v4.content_type,
            version        : v3,
            created_at_ms  : v0,
        };
        0x2::event::emit<ArtifactVersionAddedEvent>(v5);
        v4
    }

    fun apply_artifact_type_enabled(arg0: &mut TypeRegistry, arg1: u8, arg2: bool, arg3: address, arg4: &0x2::clock::Clock) {
        assert_valid_artifact_type(arg1);
        let v0 = 0x2::table::borrow_mut<u8, TypeInfo>(&mut arg0.types, arg1);
        v0.enabled = arg2;
        v0.updated_at_ms = 0x2::clock::timestamp_ms(arg4);
        let v1 = ArtifactTypeStatusChangedEvent{
            registry_id   : arg0.registry_id,
            artifact_type : arg1,
            changed_by    : arg3,
            old_enabled   : v0.enabled,
            enabled       : arg2,
            changed_at_ms : v0.updated_at_ms,
        };
        0x2::event::emit<ArtifactTypeStatusChangedEvent>(v1);
    }

    public fun artifact_type_blog_post() : u8 {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::blog_post()
    }

    public fun artifact_type_dataset() : u8 {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::dataset()
    }

    public fun artifact_type_generic_file() : u8 {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::generic_file()
    }

    public fun artifact_type_name(arg0: u8) : 0x1::string::String {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::name(arg0)
    }

    public fun artifact_type_preprint() : u8 {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint()
    }

    public fun artifact_type_software_release() : u8 {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::software_release()
    }

    public fun artifact_type_technical_report() : u8 {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::technical_report()
    }

    fun assert_admin(arg0: &PaperProofRoot, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::OperatorPermit, arg3: address) {
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1), 8);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_active_operator(arg1, arg2, 0x2::object::id<PaperProofRoot>(arg0), arg3);
    }

    fun assert_current_registry(arg0: &TypeRegistry) {
        assert!(arg0.version == 1, 3);
    }

    fun assert_current_root(arg0: &PaperProofRoot) {
        assert!(arg0.version == 1, 2);
    }

    fun assert_current_series(arg0: &ArtifactSeries) {
        assert!(arg0.version == 1, 4);
    }

    fun assert_publish_context(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: u8) {
        assert_current_root(arg0);
        assert_current_registry(arg1);
        assert!(!arg0.paused, 1);
        assert_valid_artifact_type(arg4);
        assert!(0x2::object::id<TypeRegistry>(arg1) == arg0.type_registry_id, 7);
        assert!(arg1.registry_id == 0x2::object::id<PaperProofRoot>(arg0), 7);
        assert!(0x2::table::borrow<u8, TypeInfo>(&arg1.types, arg4).enabled, 6);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg2) == 0x2::object::id<PaperProofRoot>(arg0), 8);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_registry_id(arg3) == 0x2::object::id<PaperProofRoot>(arg0), 9);
        assert!(0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg2) == arg0.governance_vault_id, 8);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg3) == arg0.fee_manager_id, 9);
        assert!(0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::tree_factory_cap_registry_id(&arg0.comments_tree_factory_cap) == 0x2::object::id<PaperProofRoot>(arg0), 23);
    }

    fun assert_valid_artifact_type(arg0: u8) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::assert_supported(arg0);
    }

    fun assert_valid_series_status(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 22);
    }

    public fun blog_post_header(arg0: &BlogPostVersionRecord) : &CommonArtifactHeader {
        &arg0.header
    }

    public fun dataset_header(arg0: &DatasetVersionRecord) : &CommonArtifactHeader {
        &arg0.header
    }

    public fun execute_artifact_fee_level_proposal(arg0: &PaperProofRoot, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg3: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::GovernanceConfig, arg4: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::Proposal, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_root(arg0);
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1), 8);
        assert!(arg0.fee_manager_id == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg2), 9);
        let v0 = 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::consume_executable_proposal_action(arg3, arg4, arg1, &arg0.governance_action_executor_cap, 0x2::object::id<PaperProofRoot>(arg0), 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::action_set_artifact_fee_level(), arg5);
        assert_valid_artifact_type((0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::action_ticket_payload_u64_1(&v0) as u8));
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_artifact_fee_level_from_ticket(arg1, arg2, v0);
    }

    public fun execute_artifact_type_activation_proposal(arg0: &PaperProofRoot, arg1: &mut TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::GovernanceConfig, arg5: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::Proposal, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_current_root(arg0);
        assert_current_registry(arg1);
        assert!(0x2::object::id<TypeRegistry>(arg1) == arg0.type_registry_id, 7);
        assert!(arg1.registry_id == 0x2::object::id<PaperProofRoot>(arg0), 7);
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg2), 8);
        assert!(arg0.fee_manager_id == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(arg3), 9);
        let v0 = 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::consume_executable_proposal_action(arg4, arg5, arg2, &arg0.governance_action_executor_cap, 0x2::object::id<PaperProofRoot>(arg0), 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::action_activate_artifact_type(), arg7);
        apply_artifact_type_enabled(arg1, (0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::action_ticket_payload_u64_1(&v0) as u8), true, 0x2::tx_context::sender(arg7), arg6);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_artifact_fee_level_from_ticket(arg2, arg3, v0);
    }

    public fun execute_artifact_type_enabled_proposal(arg0: &PaperProofRoot, arg1: &mut TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::GovernanceConfig, arg4: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::Proposal, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_root(arg0);
        assert_current_registry(arg1);
        assert!(0x2::object::id<TypeRegistry>(arg1) == arg0.type_registry_id, 7);
        assert!(arg1.registry_id == 0x2::object::id<PaperProofRoot>(arg0), 7);
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg2), 8);
        let (v0, v1, v2, _) = 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::unpack_artifact_type_enabled_ticket(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::consume_executable_proposal_action(arg3, arg4, arg2, &arg0.governance_action_executor_cap, 0x2::object::id<PaperProofRoot>(arg0), 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting::action_set_artifact_type_enabled(), arg6));
        assert!(v0 == 0x2::object::id<PaperProofRoot>(arg0), 24);
        assert!(v2 == 0 || v2 == 1, 24);
        apply_artifact_type_enabled(arg1, (v1 as u8), v2 == 1, 0x2::tx_context::sender(arg6), arg5);
    }

    public fun finalize_reserved_preprint(arg0: PreprintReservation, arg1: &PaperProofRoot, arg2: &TypeRegistry, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<MetadataAttribute>, arg17: vector<MetadataAttribute>, arg18: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg5);
        validate_long_text(&arg6);
        validate_authors(&arg7);
        validate_keywords(&arg8);
        validate_short_text(&arg9);
        validate_short_text(&arg10);
        let v0 = 0x2::object::new(arg20);
        let (v1, v2, v3, v4) = publish_reserved_preprint_common(arg0, arg1, arg2, arg3, arg4, *0x2::object::uid_as_inner(&v0), arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20);
        let v5 = PreprintVersionRecord{
            id            : v0,
            header        : v2,
            title         : arg5,
            abstract_text : arg6,
            authors       : arg7,
            keywords      : arg8,
            field         : arg9,
            license       : arg10,
            page_count    : arg11,
        };
        0x2::transfer::share_object<ArtifactSeries>(v1);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_tree(v3);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_likes_book(v4);
        0x2::transfer::share_object<PreprintVersionRecord>(v5);
    }

    public fun generic_file_header(arg0: &GenericFileVersionRecord) : &CommonArtifactHeader {
        &arg0.header
    }

    public fun header_artifact_type(arg0: &CommonArtifactHeader) : u8 {
        arg0.artifact_type
    }

    public fun header_content_hash(arg0: &CommonArtifactHeader) : 0x1::string::String {
        arg0.content_hash
    }

    public fun header_metadata_count(arg0: &CommonArtifactHeader) : u64 {
        0x1::vector::length<MetadataAttribute>(&arg0.metadata_extensions)
    }

    public fun header_metadata_key_at(arg0: &CommonArtifactHeader, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<MetadataAttribute>(&arg0.metadata_extensions, arg1).key
    }

    public fun header_metadata_value_at(arg0: &CommonArtifactHeader, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<MetadataAttribute>(&arg0.metadata_extensions, arg1).value
    }

    public fun header_series_id(arg0: &CommonArtifactHeader) : 0x2::object::ID {
        arg0.series_id
    }

    public fun header_version(arg0: &CommonArtifactHeader) : u64 {
        arg0.version
    }

    public fun index_artifact_type(arg0: &TypeIndex) : u8 {
        arg0.artifact_type
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = *0x2::object::uid_as_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = 0;
        let v4 = new_index(v1, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(), arg0);
        let v5 = new_index(v1, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::blog_post(), arg0);
        let v6 = new_index(v1, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::technical_report(), arg0);
        let v7 = new_index(v1, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::dataset(), arg0);
        let v8 = new_index(v1, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::software_release(), arg0);
        let v9 = new_index(v1, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::generic_file(), arg0);
        let v10 = 0x2::object::id<TypeIndex>(&v4);
        let v11 = 0x2::object::id<TypeIndex>(&v5);
        let v12 = 0x2::object::id<TypeIndex>(&v6);
        let v13 = 0x2::object::id<TypeIndex>(&v7);
        let v14 = 0x2::object::id<TypeIndex>(&v8);
        let v15 = 0x2::object::id<TypeIndex>(&v9);
        let v16 = TypeRegistry{
            id          : 0x2::object::new(arg0),
            version     : 1,
            registry_id : v1,
            types       : 0x2::table::new<u8, TypeInfo>(arg0),
        };
        let v17 = &mut v16;
        add_type_info(v17, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(), v10, v3);
        let v18 = &mut v16;
        add_type_info(v18, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::blog_post(), v11, v3);
        let v19 = &mut v16;
        add_type_info(v19, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::technical_report(), v12, v3);
        let v20 = &mut v16;
        add_type_info(v20, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::dataset(), v13, v3);
        let v21 = &mut v16;
        add_type_info(v21, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::software_release(), v14, v3);
        let v22 = &mut v16;
        add_type_info(v22, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::generic_file(), v15, v3);
        let v23 = 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::new_fee_manager(v1, arg0);
        let (v24, v25, v26) = 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::new_vault_with_action_executor_cap(v1, v2, v2, arg0);
        let v27 = v24;
        let v28 = PaperProofRoot{
            id                             : v0,
            version                        : 1,
            paused                         : false,
            governance_vault_id            : 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(&v27),
            fee_manager_id                 : 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::fee_manager_id(&v23),
            type_registry_id               : 0x2::object::id<TypeRegistry>(&v16),
            comments_tree_factory_cap      : 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::new_tree_factory_cap(&v27, &v23, arg0),
            governance_action_executor_cap : v26,
        };
        let v29 = v28.type_registry_id;
        let v30 = PaperProofRootCreatedEvent{
            root_id                                    : v1,
            created_by                                 : v2,
            governance_vault_id                        : v28.governance_vault_id,
            fee_manager_id                             : v28.fee_manager_id,
            type_registry_id                           : v29,
            comments_tree_factory_cap_registry_id      : 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::tree_factory_cap_registry_id(&v28.comments_tree_factory_cap),
            governance_action_executor_cap_registry_id : v1,
        };
        0x2::event::emit<PaperProofRootCreatedEvent>(v30);
        let v31 = TypeRegistryCreatedEvent{
            root_id          : v1,
            type_registry_id : v29,
            created_by       : v2,
        };
        0x2::event::emit<TypeRegistryCreatedEvent>(v31);
        let v32 = TypeIndexCreatedEvent{
            root_id       : v1,
            artifact_type : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(),
            type_index_id : v10,
            created_by    : v2,
        };
        0x2::event::emit<TypeIndexCreatedEvent>(v32);
        let v33 = TypeIndexCreatedEvent{
            root_id       : v1,
            artifact_type : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::blog_post(),
            type_index_id : v11,
            created_by    : v2,
        };
        0x2::event::emit<TypeIndexCreatedEvent>(v33);
        let v34 = TypeIndexCreatedEvent{
            root_id       : v1,
            artifact_type : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::technical_report(),
            type_index_id : v12,
            created_by    : v2,
        };
        0x2::event::emit<TypeIndexCreatedEvent>(v34);
        let v35 = TypeIndexCreatedEvent{
            root_id       : v1,
            artifact_type : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::dataset(),
            type_index_id : v13,
            created_by    : v2,
        };
        0x2::event::emit<TypeIndexCreatedEvent>(v35);
        let v36 = TypeIndexCreatedEvent{
            root_id       : v1,
            artifact_type : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::software_release(),
            type_index_id : v14,
            created_by    : v2,
        };
        0x2::event::emit<TypeIndexCreatedEvent>(v36);
        let v37 = TypeIndexCreatedEvent{
            root_id       : v1,
            artifact_type : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::generic_file(),
            type_index_id : v15,
            created_by    : v2,
        };
        0x2::event::emit<TypeIndexCreatedEvent>(v37);
        0x2::transfer::share_object<PaperProofRoot>(v28);
        0x2::transfer::share_object<TypeIndex>(v4);
        0x2::transfer::share_object<TypeIndex>(v5);
        0x2::transfer::share_object<TypeIndex>(v6);
        0x2::transfer::share_object<TypeIndex>(v7);
        0x2::transfer::share_object<TypeIndex>(v8);
        0x2::transfer::share_object<TypeIndex>(v9);
        0x2::transfer::share_object<TypeRegistry>(v16);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::share_fee_manager(v23);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::share_vault(v27);
        0x2::transfer::public_transfer<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::OperatorPermit>(v25, v2);
    }

    fun make_artifact_code(arg0: u8, arg1: u64, arg2: &0x2::object::ID) : 0x1::string::String {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::code(arg0, arg1, arg2)
    }

    public fun metadata_attribute(arg0: 0x1::string::String, arg1: 0x1::string::String) : MetadataAttribute {
        let v0 = MetadataAttribute{
            key   : arg0,
            value : arg1,
        };
        validate_metadata_attribute(&v0);
        v0
    }

    fun new_index(arg0: 0x2::object::ID, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : TypeIndex {
        TypeIndex{
            id            : 0x2::object::new(arg2),
            version       : 1,
            registry_id   : arg0,
            artifact_type : arg1,
        }
    }

    public fun preprint_header(arg0: &PreprintVersionRecord) : &CommonArtifactHeader {
        &arg0.header
    }

    public fun preprint_reservation_artifact_code(arg0: &PreprintReservation) : 0x1::string::String {
        arg0.artifact_code
    }

    public fun preprint_reservation_created_at_ms(arg0: &PreprintReservation) : u64 {
        arg0.created_at_ms
    }

    public fun preprint_reservation_reserver(arg0: &PreprintReservation) : address {
        arg0.reserver
    }

    public fun preprint_reservation_series_id(arg0: &PreprintReservation) : 0x2::object::ID {
        0x2::object::id_from_address(arg0.series_address)
    }

    public fun publish_blog_post(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: vector<MetadataAttribute>, arg13: vector<MetadataAttribute>, arg14: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg4);
        validate_medium_text(&arg5);
        validate_tags(&arg6);
        validate_short_text(&arg7);
        let v0 = 0x2::object::new(arg16);
        let (v1, v2, v3, v4) = publish_common(arg0, arg1, arg2, arg3, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::blog_post(), *0x2::object::uid_as_inner(&v0), arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        let v5 = BlogPostVersionRecord{
            id       : v0,
            header   : v2,
            title    : arg4,
            summary  : arg5,
            tags     : arg6,
            language : arg7,
        };
        0x2::transfer::share_object<ArtifactSeries>(v1);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_tree(v3);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_likes_book(v4);
        0x2::transfer::share_object<BlogPostVersionRecord>(v5);
    }

    fun publish_common(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: u8, arg5: 0x2::object::ID, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<MetadataAttribute>, arg11: vector<MetadataAttribute>, arg12: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (ArtifactSeries, CommonArtifactHeader, 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::CommentsTree, 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::LikesBook) {
        assert_publish_context(arg0, arg1, arg2, arg3, arg4);
        validate_content_fields(&arg6, &arg7, &arg8, &arg9);
        validate_metadata_extensions(&arg10);
        validate_metadata_extensions(&arg11);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::collect_artifact_fee(arg2, arg3, arg4, arg12, arg14);
        let v0 = 0x2::clock::timestamp_ms(arg13);
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = 0x2::object::new(arg14);
        let v3 = *0x2::object::uid_as_inner(&v2);
        let v4 = make_artifact_code(arg4, 0x2::tx_context::epoch(arg14), &v3);
        let (v5, v6) = 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::new_tree(&arg0.comments_tree_factory_cap, 0x2::object::id<PaperProofRoot>(arg0), arg0.governance_vault_id, arg0.fee_manager_id, v1, v4, v3, arg4, arg13, arg14);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::tree_id(&v8);
        let v10 = 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::likes_book_id(&v7);
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v11, arg5);
        let v12 = ArtifactSeries{
            id                  : v2,
            version             : 1,
            artifact_type       : arg4,
            artifact_code       : v4,
            owner               : v1,
            current_version     : 1,
            current_version_id  : arg5,
            version_ids         : v11,
            metadata_extensions : arg10,
            comments_tree_id    : v9,
            likes_book_id       : v10,
            status              : 0,
            ui_status           : 0,
            created_at_ms       : v0,
            updated_at_ms       : v0,
        };
        let v13 = CommonArtifactHeader{
            series_id             : v3,
            artifact_type         : arg4,
            version               : 1,
            previous_version_id   : 0x1::option::none<0x2::object::ID>(),
            author                : v1,
            content_hash          : arg6,
            walrus_blob_id        : arg7,
            walrus_blob_object_id : arg8,
            content_type          : arg9,
            metadata_extensions   : arg11,
            status                : 0,
            created_at_ms         : v0,
        };
        let v14 = ArtifactPublishedEvent{
            series_id        : v3,
            version_id       : arg5,
            artifact_type    : arg4,
            artifact_code    : v4,
            author           : v1,
            content_hash     : v13.content_hash,
            walrus_blob_id   : v13.walrus_blob_id,
            content_type     : v13.content_type,
            version          : 1,
            comments_tree_id : v9,
            likes_book_id    : v10,
            created_at_ms    : v0,
        };
        0x2::event::emit<ArtifactPublishedEvent>(v14);
        (v12, v13, v8, v7)
    }

    public fun publish_dataset(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<MetadataAttribute>, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg4);
        validate_long_text(&arg5);
        validate_keywords(&arg10);
        validate_short_text(&arg6);
        validate_short_text(&arg9);
        let v0 = 0x2::object::new(arg19);
        let (v1, v2, v3, v4) = publish_common(arg0, arg1, arg2, arg3, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::dataset(), *0x2::object::uid_as_inner(&v0), arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v5 = DatasetVersionRecord{
            id          : v0,
            header      : v2,
            title       : arg4,
            description : arg5,
            format      : arg6,
            file_count  : arg7,
            size_bytes  : arg8,
            license     : arg9,
            keywords    : arg10,
        };
        0x2::transfer::share_object<ArtifactSeries>(v1);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_tree(v3);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_likes_book(v4);
        0x2::transfer::share_object<DatasetVersionRecord>(v5);
    }

    public fun publish_generic_file(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: vector<MetadataAttribute>, arg14: vector<MetadataAttribute>, arg15: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg4);
        validate_long_text(&arg5);
        validate_short_text(&arg6);
        validate_short_text(&arg8);
        let v0 = 0x2::object::new(arg17);
        let (v1, v2, v3, v4) = publish_common(arg0, arg1, arg2, arg3, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::generic_file(), *0x2::object::uid_as_inner(&v0), arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v5 = GenericFileVersionRecord{
            id          : v0,
            header      : v2,
            title       : arg4,
            description : arg5,
            filename    : arg6,
            file_size   : arg7,
            license     : arg8,
        };
        0x2::transfer::share_object<ArtifactSeries>(v1);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_tree(v3);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_likes_book(v4);
        0x2::transfer::share_object<GenericFileVersionRecord>(v5);
    }

    public fun publish_preprint(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<MetadataAttribute>, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        abort 30
    }

    fun publish_reserved_preprint_common(arg0: PreprintReservation, arg1: &PaperProofRoot, arg2: &TypeRegistry, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg4: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: 0x2::object::ID, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<MetadataAttribute>, arg11: vector<MetadataAttribute>, arg12: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (ArtifactSeries, CommonArtifactHeader, 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::CommentsTree, 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::LikesBook) {
        assert_publish_context(arg1, arg2, arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint());
        validate_content_fields(&arg6, &arg7, &arg8, &arg9);
        validate_metadata_extensions(&arg10);
        validate_metadata_extensions(&arg11);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::collect_artifact_fee(arg3, arg4, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(), arg12, arg14);
        let PreprintReservation {
            id             : v0,
            reserver       : v1,
            series_address : v2,
            artifact_code  : v3,
            created_at_ms  : _,
        } = arg0;
        let v5 = v0;
        let v6 = 0x2::tx_context::sender(arg14);
        assert!(v6 == v1, 21);
        let v7 = 0x2::clock::timestamp_ms(arg13);
        let v8 = PreprintSeriesKey{reservation_id: *0x2::object::uid_as_inner(&v5)};
        let v9 = 0x2::derived_object::claim<PreprintSeriesKey>(&mut v5, v8);
        0x2::object::delete(v5);
        let v10 = *0x2::object::uid_as_inner(&v9);
        assert!(v10 == 0x2::object::id_from_address(v2), 7);
        let (v11, v12) = 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::new_tree(&arg1.comments_tree_factory_cap, 0x2::object::id<PaperProofRoot>(arg1), arg1.governance_vault_id, arg1.fee_manager_id, v6, v3, v10, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(), arg13, arg14);
        let v13 = v12;
        let v14 = v11;
        let v15 = 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::tree_id(&v14);
        let v16 = 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::likes_book_id(&v13);
        let v17 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v17, arg5);
        let v18 = ArtifactSeries{
            id                  : v9,
            version             : 1,
            artifact_type       : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(),
            artifact_code       : v3,
            owner               : v6,
            current_version     : 1,
            current_version_id  : arg5,
            version_ids         : v17,
            metadata_extensions : arg10,
            comments_tree_id    : v15,
            likes_book_id       : v16,
            status              : 0,
            ui_status           : 0,
            created_at_ms       : v7,
            updated_at_ms       : v7,
        };
        let v19 = CommonArtifactHeader{
            series_id             : v10,
            artifact_type         : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(),
            version               : 1,
            previous_version_id   : 0x1::option::none<0x2::object::ID>(),
            author                : v6,
            content_hash          : arg6,
            walrus_blob_id        : arg7,
            walrus_blob_object_id : arg8,
            content_type          : arg9,
            metadata_extensions   : arg11,
            status                : 0,
            created_at_ms         : v7,
        };
        let v20 = ArtifactPublishedEvent{
            series_id        : v10,
            version_id       : arg5,
            artifact_type    : 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(),
            artifact_code    : v3,
            author           : v6,
            content_hash     : v19.content_hash,
            walrus_blob_id   : v19.walrus_blob_id,
            content_type     : v19.content_type,
            version          : 1,
            comments_tree_id : v15,
            likes_book_id    : v16,
            created_at_ms    : v7,
        };
        0x2::event::emit<ArtifactPublishedEvent>(v20);
        (v18, v19, v14, v13)
    }

    public fun publish_software_release(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<MetadataAttribute>, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg4);
        validate_short_text(&arg5);
        validate_short_text(&arg6);
        validate_short_text(&arg7);
        validate_medium_text(&arg8);
        validate_short_text(&arg9);
        validate_medium_text(&arg10);
        let v0 = 0x2::object::new(arg19);
        let (v1, v2, v3, v4) = publish_common(arg0, arg1, arg2, arg3, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::software_release(), *0x2::object::uid_as_inner(&v0), arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v5 = SoftwareReleaseVersionRecord{
            id             : v0,
            header         : v2,
            project_name   : arg4,
            version_name   : arg5,
            source_hash    : arg6,
            package_hash   : arg7,
            changelog      : arg8,
            license        : arg9,
            repository_url : arg10,
        };
        0x2::transfer::share_object<ArtifactSeries>(v1);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_tree(v3);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_likes_book(v4);
        0x2::transfer::share_object<SoftwareReleaseVersionRecord>(v5);
    }

    public fun publish_technical_report(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<0x1::string::String>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: vector<MetadataAttribute>, arg16: vector<MetadataAttribute>, arg17: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        validate_title(&arg4);
        validate_long_text(&arg5);
        validate_authors(&arg6);
        validate_keywords(&arg9);
        validate_short_text(&arg7);
        validate_short_text(&arg8);
        validate_short_text(&arg10);
        let v0 = 0x2::object::new(arg19);
        let (v1, v2, v3, v4) = publish_common(arg0, arg1, arg2, arg3, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::technical_report(), *0x2::object::uid_as_inner(&v0), arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v5 = TechnicalReportVersionRecord{
            id            : v0,
            header        : v2,
            title         : arg4,
            abstract_text : arg5,
            authors       : arg6,
            organization  : arg7,
            report_number : arg8,
            keywords      : arg9,
            license       : arg10,
        };
        0x2::transfer::share_object<ArtifactSeries>(v1);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_tree(v3);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::share_likes_book(v4);
        0x2::transfer::share_object<TechnicalReportVersionRecord>(v5);
    }

    public fun reserve_preprint_code(arg0: &PaperProofRoot, arg1: &TypeRegistry, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PreprintReservation {
        assert_publish_context(arg0, arg1, arg2, arg3, 0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::new(arg5);
        let v3 = *0x2::object::uid_as_inner(&v2);
        let v4 = PreprintSeriesKey{reservation_id: v3};
        let v5 = 0x2::derived_object::derive_address<PreprintSeriesKey>(v3, v4);
        let v6 = 0x2::object::id_from_address(v5);
        let v7 = make_artifact_code(0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::artifact_types::preprint(), 0x2::tx_context::epoch(arg5), &v6);
        let v8 = PreprintCodeReservedEvent{
            reservation_id : v3,
            series_id      : v6,
            reserver       : v1,
            artifact_code  : v7,
            created_at_ms  : v0,
        };
        0x2::event::emit<PreprintCodeReservedEvent>(v8);
        PreprintReservation{
            id             : v2,
            reserver       : v1,
            series_address : v5,
            artifact_code  : v7,
            created_at_ms  : v0,
        }
    }

    public fun root_comments_tree_factory_cap_registry_id(arg0: &PaperProofRoot) : 0x2::object::ID {
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::tree_factory_cap_registry_id(&arg0.comments_tree_factory_cap)
    }

    public fun root_fee_manager_id(arg0: &PaperProofRoot) : 0x2::object::ID {
        arg0.fee_manager_id
    }

    public fun root_governance_vault_id(arg0: &PaperProofRoot) : 0x2::object::ID {
        arg0.governance_vault_id
    }

    public fun root_paused(arg0: &PaperProofRoot) : bool {
        arg0.paused
    }

    public fun root_type_registry_id(arg0: &PaperProofRoot) : 0x2::object::ID {
        arg0.type_registry_id
    }

    public fun root_version(arg0: &PaperProofRoot) : u64 {
        arg0.version
    }

    public fun series_artifact_code(arg0: &ArtifactSeries) : 0x1::string::String {
        arg0.artifact_code
    }

    public fun series_artifact_type(arg0: &ArtifactSeries) : u8 {
        arg0.artifact_type
    }

    public fun series_comments_tree_id(arg0: &ArtifactSeries) : 0x2::object::ID {
        arg0.comments_tree_id
    }

    public fun series_current_version(arg0: &ArtifactSeries) : u64 {
        arg0.current_version
    }

    public fun series_current_version_id(arg0: &ArtifactSeries) : 0x2::object::ID {
        arg0.current_version_id
    }

    public fun series_likes_book_id(arg0: &ArtifactSeries) : 0x2::object::ID {
        arg0.likes_book_id
    }

    public fun series_metadata_count(arg0: &ArtifactSeries) : u64 {
        0x1::vector::length<MetadataAttribute>(&arg0.metadata_extensions)
    }

    public fun series_metadata_key_at(arg0: &ArtifactSeries, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<MetadataAttribute>(&arg0.metadata_extensions, arg1).key
    }

    public fun series_metadata_value_at(arg0: &ArtifactSeries, arg1: u64) : 0x1::string::String {
        0x1::vector::borrow<MetadataAttribute>(&arg0.metadata_extensions, arg1).value
    }

    public fun series_owner(arg0: &ArtifactSeries) : address {
        arg0.owner
    }

    public fun series_status(arg0: &ArtifactSeries) : u8 {
        arg0.status
    }

    public fun series_status_active() : u8 {
        0
    }

    public fun series_status_hidden() : u8 {
        2
    }

    public fun series_status_locked() : u8 {
        1
    }

    public fun series_ui_status(arg0: &ArtifactSeries) : u8 {
        arg0.ui_status
    }

    public fun set_paused(arg0: &mut PaperProofRoot, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::OperatorPermit, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_root(arg0);
        assert_admin(arg0, arg1, arg2, 0x2::tx_context::sender(arg5));
        arg0.paused = arg3;
        let v0 = ProtocolPausedChangedEvent{
            root_id       : 0x2::object::id<PaperProofRoot>(arg0),
            changed_by    : 0x2::tx_context::sender(arg5),
            old_paused    : arg0.paused,
            new_paused    : arg3,
            changed_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ProtocolPausedChangedEvent>(v0);
    }

    public fun set_series_status(arg0: &PaperProofRoot, arg1: &mut ArtifactSeries, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::OperatorPermit, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_root(arg0);
        assert_current_series(arg1);
        assert_admin(arg0, arg2, arg3, 0x2::tx_context::sender(arg6));
        assert_valid_series_status(arg4);
        arg1.status = arg4;
        arg1.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v0 = ArtifactStatusChangedEvent{
            series_id     : 0x2::object::id<ArtifactSeries>(arg1),
            artifact_type : arg1.artifact_type,
            changed_by    : 0x2::tx_context::sender(arg6),
            old_status    : arg1.status,
            new_status    : arg4,
            changed_at_ms : arg1.updated_at_ms,
        };
        0x2::event::emit<ArtifactStatusChangedEvent>(v0);
    }

    public fun software_release_header(arg0: &SoftwareReleaseVersionRecord) : &CommonArtifactHeader {
        &arg0.header
    }

    public fun technical_report_header(arg0: &TechnicalReportVersionRecord) : &CommonArtifactHeader {
        &arg0.header
    }

    public fun transfer_artifact_owner(arg0: &mut ArtifactSeries, arg1: &mut 0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::CommentsTree, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_series(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 21);
        assert!(0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::tree_id(arg1) == arg0.comments_tree_id, 23);
        assert!(0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::target_series_id(arg1) == 0x2::object::id<ArtifactSeries>(arg0), 23);
        assert!(0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::target_artifact_type(arg1) == arg0.artifact_type, 23);
        assert!(0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::owner(arg1) == arg0.owner, 23);
        0xaef346fc40bf20af62f4bbbc1608ba2272e80e4ba3d716634026baa589e9aeba::comments::transfer_tree_owner(arg1, arg2, arg4);
        arg0.owner = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
    }

    public fun type_enabled(arg0: &TypeRegistry, arg1: u8) : bool {
        0x2::table::borrow<u8, TypeInfo>(&arg0.types, arg1).enabled
    }

    public fun type_index_object_id(arg0: &TypeRegistry, arg1: u8) : 0x2::object::ID {
        0x2::table::borrow<u8, TypeInfo>(&arg0.types, arg1).index_object_id
    }

    public fun ui_status_flagged() : u8 {
        1
    }

    public fun ui_status_hidden_in_official_ui() : u8 {
        2
    }

    public fun ui_status_normal() : u8 {
        0
    }

    public fun update_series_metadata_extensions(arg0: &mut ArtifactSeries, arg1: vector<MetadataAttribute>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_series(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 21);
        assert!(arg0.status == 0, 22);
        validate_metadata_extensions(&arg1);
        arg0.metadata_extensions = arg1;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg2);
        let v0 = ArtifactSeriesMetadataUpdatedEvent{
            series_id      : 0x2::object::id<ArtifactSeries>(arg0),
            artifact_type  : arg0.artifact_type,
            updated_by     : 0x2::tx_context::sender(arg3),
            metadata_count : 0x1::vector::length<MetadataAttribute>(&arg0.metadata_extensions),
            updated_at_ms  : arg0.updated_at_ms,
        };
        0x2::event::emit<ArtifactSeriesMetadataUpdatedEvent>(v0);
    }

    fun validate_authors(arg0: &vector<0x1::string::String>) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::authors(arg0);
    }

    fun validate_content_fields(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::content_fields(arg0, arg1, arg2, arg3);
    }

    fun validate_keywords(arg0: &vector<0x1::string::String>) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::keywords(arg0);
    }

    fun validate_long_text(arg0: &0x1::string::String) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::long_text(arg0);
    }

    fun validate_medium_text(arg0: &0x1::string::String) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::medium_text(arg0);
    }

    fun validate_metadata_attribute(arg0: &MetadataAttribute) {
        assert!(0x1::string::length(&arg0.key) > 0, 27);
        assert!(0x1::string::length(&arg0.key) <= 64, 28);
        assert!(0x1::string::length(&arg0.value) < 511 + 1, 28);
    }

    fun validate_metadata_extensions(arg0: &vector<MetadataAttribute>) {
        let v0 = 0x1::vector::length<MetadataAttribute>(arg0);
        assert!(v0 <= 4, 26);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<MetadataAttribute>(arg0, v1);
            validate_metadata_attribute(v2);
            let v3 = v1 + 1;
            while (v3 < v0) {
                assert!(v2.key != 0x1::vector::borrow<MetadataAttribute>(arg0, v3).key, 29);
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun validate_short_text(arg0: &0x1::string::String) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::short_text(arg0);
    }

    fun validate_tags(arg0: &vector<0x1::string::String>) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::tags(arg0);
    }

    fun validate_title(arg0: &0x1::string::String) {
        0xe67a6956f37c3182354189d9b77ca14058694aad82522da0c6cb91cfddee4782::validation::title(arg0);
    }

    public fun version_count(arg0: &ArtifactSeries) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.version_ids)
    }

    public fun version_id_at(arg0: &ArtifactSeries, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.version_ids, arg1)
    }

    // decompiled from Move bytecode v7
}

