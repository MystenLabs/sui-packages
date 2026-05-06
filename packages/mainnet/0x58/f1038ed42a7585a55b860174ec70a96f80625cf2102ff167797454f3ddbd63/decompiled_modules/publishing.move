module 0x58f1038ed42a7585a55b860174ec70a96f80625cf2102ff167797454f3ddbd63::publishing {
    struct PaperRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        current_epoch: u64,
        epoch_counter: u64,
        next_record_number: u64,
        code_prefix: 0x1::string::String,
        max_file_size: u64,
        min_page_count: u64,
        max_page_count: u64,
        max_keywords: u64,
        max_authors: u64,
        paused: bool,
        code_to_record: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct PaperRecord has key {
        id: 0x2::object::UID,
        version: u64,
        paper_code: 0x1::string::String,
        paper_epoch: u64,
        epoch_seq: u64,
        record_number: u64,
        reserver: address,
        owner: address,
        status: u8,
        ui_status: u8,
        title: 0x1::string::String,
        abstract_text: 0x1::string::String,
        keywords: vector<0x1::string::String>,
        authors: vector<0x1::string::String>,
        field: 0x1::string::String,
        license: 0x1::string::String,
        current_version: u64,
        version_ids: vector<0x2::object::ID>,
        comments_tree_id: 0x1::option::Option<0x2::object::ID>,
        reserved_at_ms: u64,
        published_at_ms: u64,
        updated_at_ms: u64,
    }

    struct PaperVersion has key {
        id: 0x2::object::UID,
        paper_record_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        version_number: u64,
        walrus_blob_id: 0x1::string::String,
        walrus_blob_object_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        file_size: u64,
        page_count: u64,
        storage_end_epoch: u64,
        is_shared_blob: bool,
        title_snapshot: 0x1::string::String,
        abstract_snapshot: 0x1::string::String,
        keywords_snapshot: vector<0x1::string::String>,
        authors_snapshot: vector<0x1::string::String>,
        field_snapshot: 0x1::string::String,
        license_snapshot: 0x1::string::String,
        tx_sender: address,
        created_at_ms: u64,
    }

    struct CodeReserved has copy, drop {
        paper_record_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        paper_epoch: u64,
        epoch_seq: u64,
        record_number: u64,
        reserver: address,
        reserved_at_ms: u64,
    }

    struct PaperFinalized has copy, drop {
        paper_record_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        paper_epoch: u64,
        epoch_seq: u64,
        record_number: u64,
        owner: address,
        title: 0x1::string::String,
        authors: vector<0x1::string::String>,
        field: 0x1::string::String,
        keywords: vector<0x1::string::String>,
        walrus_blob_id: 0x1::string::String,
        walrus_blob_object_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        comments_tree_id: 0x2::object::ID,
        published_at_ms: u64,
    }

    struct PaperVersionAdded has copy, drop {
        paper_record_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        version_number: u64,
        submitter: address,
        title: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        walrus_blob_object_id: 0x1::string::String,
        file_hash: 0x1::string::String,
        created_at_ms: u64,
    }

    struct StorageExtended has copy, drop {
        paper_record_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        old_storage_end_epoch: u64,
        new_storage_end_epoch: u64,
        extender: address,
        updated_at_ms: u64,
    }

    struct PaperOwnerTransferred has copy, drop {
        paper_record_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        old_owner: address,
        new_owner: address,
        timestamp_ms: u64,
    }

    struct CommentsTreeBound has copy, drop {
        paper_record_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        comments_tree_id: 0x2::object::ID,
        bound_at_ms: u64,
    }

    struct PaperUiStatusChanged has copy, drop {
        paper_record_id: 0x2::object::ID,
        paper_code: 0x1::string::String,
        changed_by: address,
        ui_status: u8,
        timestamp_ms: u64,
    }

    struct ConfigUpdated has copy, drop {
        admin: address,
        timestamp_ms: u64,
    }

    public fun add_version(arg0: &PaperRegistry, arg1: &mut PaperRecord, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        assert_current_record(arg1);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg2);
        assert!(!arg0.paused, 2);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg2) == 0x2::object::id<PaperRegistry>(arg0), 23);
        assert_record_in_registry(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg18);
        assert!(arg1.status == 1, 17);
        assert!(v0 == arg1.owner, 15);
        validate_metadata(arg0, &arg3, &arg4, &arg5, &arg6);
        validate_file(arg0, &arg9, &arg10, &arg11, arg12, arg13);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::collect_publishing_fee(arg2, arg16, arg18);
        let v1 = 0x2::clock::timestamp_ms(arg17);
        let v2 = arg1.current_version + 1;
        arg1.title = arg3;
        arg1.abstract_text = arg4;
        arg1.keywords = arg5;
        arg1.authors = arg6;
        arg1.field = arg7;
        arg1.license = arg8;
        arg1.current_version = v2;
        arg1.updated_at_ms = v1;
        let v3 = 0x2::object::id<PaperRecord>(arg1);
        let v4 = PaperVersion{
            id                    : 0x2::object::new(arg18),
            paper_record_id       : v3,
            paper_code            : arg1.paper_code,
            version_number        : v2,
            walrus_blob_id        : arg9,
            walrus_blob_object_id : arg10,
            file_hash             : arg11,
            file_size             : arg12,
            page_count            : arg13,
            storage_end_epoch     : arg14,
            is_shared_blob        : arg15,
            title_snapshot        : arg1.title,
            abstract_snapshot     : arg1.abstract_text,
            keywords_snapshot     : arg1.keywords,
            authors_snapshot      : arg1.authors,
            field_snapshot        : arg1.field,
            license_snapshot      : arg1.license,
            tx_sender             : v0,
            created_at_ms         : v1,
        };
        let v5 = 0x2::object::id<PaperVersion>(&v4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.version_ids, v5);
        let v6 = PaperVersionAdded{
            paper_record_id       : v3,
            version_id            : v5,
            paper_code            : arg1.paper_code,
            version_number        : v2,
            submitter             : v0,
            title                 : arg1.title,
            walrus_blob_id        : v4.walrus_blob_id,
            walrus_blob_object_id : v4.walrus_blob_object_id,
            file_hash             : v4.file_hash,
            created_at_ms         : v1,
        };
        0x2::event::emit<PaperVersionAdded>(v6);
        0x2::transfer::share_object<PaperVersion>(v4);
    }

    fun assert_admin(arg0: &PaperRegistry, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::OperatorPermit, arg3: address) {
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_active_operator(arg1, arg2, 0x2::object::id<PaperRegistry>(arg0), arg3);
    }

    fun assert_current_record(arg0: &PaperRecord) {
        assert!(arg0.version == 1, 26);
    }

    fun assert_current_registry(arg0: &PaperRegistry) {
        assert!(arg0.version == 1, 25);
    }

    fun assert_record_in_registry(arg0: &PaperRegistry, arg1: &PaperRecord) {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.code_to_record, arg1.paper_code), 27);
        assert!(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.code_to_record, arg1.paper_code) == 0x2::object::id<PaperRecord>(arg1), 27);
    }

    public fun comments_tree_id(arg0: &PaperRecord) : &0x1::option::Option<0x2::object::ID> {
        &arg0.comments_tree_id
    }

    public fun current_paper_record_version() : u64 {
        1
    }

    public fun current_registry_version() : u64 {
        1
    }

    public fun current_version(arg0: &PaperRecord) : u64 {
        arg0.current_version
    }

    public fun epoch_seq(arg0: &PaperRecord) : u64 {
        arg0.epoch_seq
    }

    public fun extend_walrus_storage_and_record(arg0: &PaperRegistry, arg1: &PaperRecord, arg2: &mut PaperVersion, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        assert_current_record(arg1);
        abort 22
    }

    public fun finalize_paper(arg0: &PaperRegistry, arg1: &mut PaperRecord, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        assert_current_record(arg1);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg2);
        assert!(!arg0.paused, 2);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg2) == 0x2::object::id<PaperRegistry>(arg0), 23);
        assert_record_in_registry(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg18);
        assert!(v0 == arg1.reserver, 14);
        assert!(arg1.status == 0, 16);
        validate_metadata(arg0, &arg3, &arg4, &arg5, &arg6);
        validate_file(arg0, &arg9, &arg10, &arg11, arg12, arg13);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::collect_publishing_fee(arg2, arg16, arg18);
        let v1 = 0x2::clock::timestamp_ms(arg17);
        arg1.title = arg3;
        arg1.abstract_text = arg4;
        arg1.keywords = arg5;
        arg1.authors = arg6;
        arg1.field = arg7;
        arg1.license = arg8;
        arg1.status = 1;
        arg1.current_version = 1;
        arg1.published_at_ms = v1;
        arg1.updated_at_ms = v1;
        let v2 = 0x2::object::id<PaperRecord>(arg1);
        let v3 = 0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::new_tree(0x2::object::id<PaperRegistry>(arg0), arg1.owner, arg1.paper_code, v2, arg17, arg18);
        let v4 = 0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::tree_id(&v3);
        arg1.comments_tree_id = 0x1::option::some<0x2::object::ID>(v4);
        let v5 = PaperVersion{
            id                    : 0x2::object::new(arg18),
            paper_record_id       : v2,
            paper_code            : arg1.paper_code,
            version_number        : 1,
            walrus_blob_id        : arg9,
            walrus_blob_object_id : arg10,
            file_hash             : arg11,
            file_size             : arg12,
            page_count            : arg13,
            storage_end_epoch     : arg14,
            is_shared_blob        : arg15,
            title_snapshot        : arg1.title,
            abstract_snapshot     : arg1.abstract_text,
            keywords_snapshot     : arg1.keywords,
            authors_snapshot      : arg1.authors,
            field_snapshot        : arg1.field,
            license_snapshot      : arg1.license,
            tx_sender             : v0,
            created_at_ms         : v1,
        };
        let v6 = 0x2::object::id<PaperVersion>(&v5);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.version_ids, v6);
        let v7 = PaperFinalized{
            paper_record_id       : v2,
            version_id            : v6,
            paper_code            : arg1.paper_code,
            paper_epoch           : arg1.paper_epoch,
            epoch_seq             : arg1.epoch_seq,
            record_number         : arg1.record_number,
            owner                 : arg1.owner,
            title                 : arg1.title,
            authors               : arg1.authors,
            field                 : arg1.field,
            keywords              : arg1.keywords,
            walrus_blob_id        : v5.walrus_blob_id,
            walrus_blob_object_id : v5.walrus_blob_object_id,
            file_hash             : v5.file_hash,
            comments_tree_id      : v4,
            published_at_ms       : v1,
        };
        0x2::event::emit<PaperFinalized>(v7);
        let v8 = CommentsTreeBound{
            paper_record_id  : v2,
            paper_code       : arg1.paper_code,
            comments_tree_id : v4,
            bound_at_ms      : v1,
        };
        0x2::event::emit<CommentsTreeBound>(v8);
        0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::share_tree(v3);
        0x2::transfer::share_object<PaperVersion>(v5);
    }

    public fun get_record_id_by_code(arg0: &PaperRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.code_to_record, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PaperRegistry{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            current_epoch      : 0,
            epoch_counter      : 0,
            next_record_number : 1,
            code_prefix        : 0x1::string::utf8(b"OriginPaper"),
            max_file_size      : 50000000,
            min_page_count     : 2,
            max_page_count     : 200,
            max_keywords       : 10,
            max_authors        : 20,
            paused             : false,
            code_to_record     : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        let v1 = 0x2::tx_context::sender(arg0);
        let (v2, v3) = 0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::new_vault(0x2::object::id<PaperRegistry>(&v0), v1, v1, arg0);
        0x2::transfer::share_object<PaperRegistry>(v0);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::share_vault(v2);
        0x2::transfer::public_transfer<0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::OperatorPermit>(v3, v1);
    }

    fun make_paper_code(arg0: &0x1::string::String, arg1: u64, arg2: u64) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, u64_to_string(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, u64_to_string(arg2));
        v0
    }

    public fun migrate_record(arg0: &PaperRegistry, arg1: &mut PaperRecord, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg3: &0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg2);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg2) == 0x2::object::id<PaperRegistry>(arg0), 23);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_upgrade_authority(arg2, 0x2::tx_context::sender(arg3));
        assert_record_in_registry(arg0, arg1);
        migrate_record_version(arg1);
    }

    fun migrate_record_version(arg0: &mut PaperRecord) {
        assert!(arg0.version <= 1, 26);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun migrate_registry(arg0: &mut PaperRegistry, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: &0x2::tx_context::TxContext) {
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert!(0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::registry_id(arg1) == 0x2::object::id<PaperRegistry>(arg0), 23);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_upgrade_authority(arg1, 0x2::tx_context::sender(arg2));
        migrate_registry_version(arg0);
    }

    fun migrate_registry_version(arg0: &mut PaperRegistry) {
        assert!(arg0.version <= 1, 25);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun paper_code(arg0: &PaperRecord) : 0x1::string::String {
        arg0.paper_code
    }

    public fun paper_epoch(arg0: &PaperRecord) : u64 {
        arg0.paper_epoch
    }

    public fun paper_owner(arg0: &PaperRecord) : address {
        arg0.owner
    }

    public fun paper_record_version(arg0: &PaperRecord) : u64 {
        arg0.version
    }

    public fun record_status(arg0: &PaperRecord) : u8 {
        arg0.status
    }

    public fun record_storage_extension(arg0: &PaperRecord, arg1: &mut PaperVersion, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert!(arg0.status == 1, 17);
        assert!(arg1.paper_record_id == 0x2::object::id<PaperRecord>(arg0), 20);
        assert!(arg2 > arg1.storage_end_epoch, 18);
        arg1.storage_end_epoch = arg2;
        let v0 = StorageExtended{
            paper_record_id       : 0x2::object::id<PaperRecord>(arg0),
            version_id            : 0x2::object::id<PaperVersion>(arg1),
            paper_code            : arg0.paper_code,
            old_storage_end_epoch : arg1.storage_end_epoch,
            new_storage_end_epoch : arg2,
            extender              : 0x2::tx_context::sender(arg4),
            updated_at_ms         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<StorageExtended>(v0);
    }

    public fun record_timestamps(arg0: &PaperRecord) : (u64, u64, u64) {
        (arg0.reserved_at_ms, arg0.published_at_ms, arg0.updated_at_ms)
    }

    public fun registry_limits(arg0: &PaperRegistry) : (u64, u64, u64, u64, u64) {
        (arg0.max_file_size, arg0.min_page_count, arg0.max_page_count, arg0.max_keywords, arg0.max_authors)
    }

    public fun registry_paused(arg0: &PaperRegistry) : bool {
        arg0.paused
    }

    public fun registry_version(arg0: &PaperRegistry) : u64 {
        arg0.version
    }

    public fun reserve_code(arg0: &mut PaperRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(v2 >= arg0.current_epoch, 21);
        if (v2 != arg0.current_epoch) {
            arg0.current_epoch = v2;
            arg0.epoch_counter = 0;
        };
        arg0.epoch_counter = arg0.epoch_counter + 1;
        let v3 = arg0.epoch_counter;
        let v4 = arg0.next_record_number;
        arg0.next_record_number = v4 + 1;
        let v5 = PaperRecord{
            id               : 0x2::object::new(arg2),
            version          : 1,
            paper_code       : make_paper_code(&arg0.code_prefix, v2, v3),
            paper_epoch      : v2,
            epoch_seq        : v3,
            record_number    : v4,
            reserver         : v0,
            owner            : v0,
            status           : 0,
            ui_status        : 0,
            title            : 0x1::string::utf8(b""),
            abstract_text    : 0x1::string::utf8(b""),
            keywords         : 0x1::vector::empty<0x1::string::String>(),
            authors          : 0x1::vector::empty<0x1::string::String>(),
            field            : 0x1::string::utf8(b""),
            license          : 0x1::string::utf8(b""),
            current_version  : 0,
            version_ids      : 0x1::vector::empty<0x2::object::ID>(),
            comments_tree_id : 0x1::option::none<0x2::object::ID>(),
            reserved_at_ms   : v1,
            published_at_ms  : 0,
            updated_at_ms    : v1,
        };
        let v6 = 0x2::object::id<PaperRecord>(&v5);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.code_to_record, v5.paper_code, v6);
        let v7 = CodeReserved{
            paper_record_id : v6,
            paper_code      : v5.paper_code,
            paper_epoch     : v2,
            epoch_seq       : v3,
            record_number   : v4,
            reserver        : v0,
            reserved_at_ms  : v1,
        };
        0x2::event::emit<CodeReserved>(v7);
        0x2::transfer::share_object<PaperRecord>(v5);
    }

    public fun set_paused(arg0: &mut PaperRegistry, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::OperatorPermit, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert_admin(arg0, arg1, arg2, 0x2::tx_context::sender(arg5));
        arg0.paused = arg3;
        let v0 = ConfigUpdated{
            admin        : 0x2::tx_context::sender(arg5),
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_ui_status(arg0: &PaperRegistry, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::OperatorPermit, arg3: &mut PaperRecord, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        assert_current_record(arg3);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert_admin(arg0, arg1, arg2, 0x2::tx_context::sender(arg6));
        let v0 = if (arg4 == 0) {
            true
        } else if (arg4 == 1) {
            true
        } else {
            arg4 == 2
        };
        assert!(v0, 20);
        arg3.ui_status = arg4;
        arg3.updated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v1 = PaperUiStatusChanged{
            paper_record_id : 0x2::object::id<PaperRecord>(arg3),
            paper_code      : arg3.paper_code,
            changed_by      : 0x2::tx_context::sender(arg6),
            ui_status       : arg4,
            timestamp_ms    : arg3.updated_at_ms,
        };
        0x2::event::emit<PaperUiStatusChanged>(v1);
    }

    public fun transfer_paper_owner(arg0: &mut PaperRecord, arg1: &mut 0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::CommentsTree, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_record(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 15);
        assert!(arg2 != @0x0, 19);
        assert!(arg0.status == 1, 17);
        assert!(0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::paper_object_id(arg1) == 0x2::object::id<PaperRecord>(arg0), 24);
        assert!(0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::owner(arg1) == arg0.owner, 24);
        0x4957dc41c3f5ada9fec450681d6447334d59d21983183cbe1b876287be722097::comments::transfer_tree_owner(arg1, arg2, arg4);
        arg0.owner = arg2;
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = PaperOwnerTransferred{
            paper_record_id : 0x2::object::id<PaperRecord>(arg0),
            paper_code      : arg0.paper_code,
            old_owner       : arg0.owner,
            new_owner       : arg2,
            timestamp_ms    : arg0.updated_at_ms,
        };
        0x2::event::emit<PaperOwnerTransferred>(v0);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 48 + ((arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0x1::vector::empty<u8>();
        while (v1 > 0) {
            v1 = v1 - 1;
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&v0, v1));
        };
        0x1::string::utf8(v2)
    }

    public fun ui_status(arg0: &PaperRecord) : u8 {
        arg0.ui_status
    }

    public fun update_limits(arg0: &mut PaperRegistry, arg1: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::GovernanceVault, arg2: &0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::OperatorPermit, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_current_registry(arg0);
        0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance::assert_current_vault(arg1);
        assert_admin(arg0, arg1, arg2, 0x2::tx_context::sender(arg9));
        arg0.max_file_size = arg3;
        arg0.min_page_count = arg4;
        arg0.max_page_count = arg5;
        arg0.max_keywords = arg6;
        arg0.max_authors = arg7;
        let v0 = ConfigUpdated{
            admin        : 0x2::tx_context::sender(arg9),
            timestamp_ms : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    fun validate_file(arg0: &PaperRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &0x1::string::String, arg4: u64, arg5: u64) {
        assert!(0x1::string::length(arg1) > 0, 11);
        assert!(0x1::string::length(arg2) > 0, 12);
        assert!(0x1::string::length(arg3) > 0, 13);
        assert!(arg4 <= arg0.max_file_size, 8);
        assert!(arg5 >= arg0.min_page_count, 9);
        assert!(arg5 <= arg0.max_page_count, 10);
    }

    fun validate_metadata(arg0: &PaperRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: &vector<0x1::string::String>, arg4: &vector<0x1::string::String>) {
        assert!(0x1::string::length(arg1) > 0, 3);
        assert!(0x1::string::length(arg2) > 0, 4);
        assert!(0x1::vector::length<0x1::string::String>(arg3) <= arg0.max_keywords, 5);
        assert!(0x1::vector::length<0x1::string::String>(arg4) > 0, 7);
        assert!(0x1::vector::length<0x1::string::String>(arg4) <= arg0.max_authors, 6);
    }

    public fun version_count(arg0: &PaperRecord) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.version_ids)
    }

    public fun version_id_at(arg0: &PaperRecord, arg1: u64) : 0x2::object::ID {
        *0x1::vector::borrow<0x2::object::ID>(&arg0.version_ids, arg1)
    }

    // decompiled from Move bytecode v7
}

