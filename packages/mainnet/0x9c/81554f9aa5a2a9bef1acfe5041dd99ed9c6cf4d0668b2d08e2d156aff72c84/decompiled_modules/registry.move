module 0x9c81554f9aa5a2a9bef1acfe5041dd99ed9c6cf4d0668b2d08e2d156aff72c84::registry {
    struct AdminCap has key {
        id: 0x2::object::UID,
        admins: vector<address>,
    }

    struct WalForm has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        creator: address,
        definition_blob_id: vector<u8>,
        definition_hash: vector<u8>,
        created_at_ms: u64,
        submission_count: u64,
        final_manifest_root: 0x1::option::Option<vector<u8>>,
        sealed_at_ms: 0x1::option::Option<u64>,
    }

    struct FormCreated has copy, drop {
        form_id: address,
        creator: address,
        definition_blob_id: vector<u8>,
        title: 0x1::string::String,
    }

    struct SubmissionRecorded has copy, drop {
        form_id: address,
        submission_blob_id: vector<u8>,
        submission_hash: vector<u8>,
        submitter: address,
        submitted_at_ms: u64,
        sequence: u64,
    }

    struct FormSealed has copy, drop {
        form_id: address,
        manifest_root: vector<u8>,
        submission_count: u64,
        sealed_at_ms: u64,
    }

    struct ApplicationReviewed has copy, drop {
        form_id: address,
        reviewer: address,
        approved: bool,
        reviewed_at_ms: u64,
    }

    struct AdminAdded has copy, drop {
        new_admin: address,
        added_by: address,
    }

    public entry fun add_admin(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_admin(arg0, v0), 3);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v1 = AdminAdded{
            new_admin : arg1,
            added_by  : v0,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    public entry fun create_form(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = WalForm{
            id                  : 0x2::object::new(arg4),
            title               : 0x1::string::utf8(arg0),
            creator             : 0x2::tx_context::sender(arg4),
            definition_blob_id  : arg1,
            definition_hash     : arg2,
            created_at_ms       : 0x2::clock::timestamp_ms(arg3),
            submission_count    : 0,
            final_manifest_root : 0x1::option::none<vector<u8>>(),
            sealed_at_ms        : 0x1::option::none<u64>(),
        };
        let v1 = FormCreated{
            form_id            : 0x2::object::uid_to_address(&v0.id),
            creator            : v0.creator,
            definition_blob_id : v0.definition_blob_id,
            title              : v0.title,
        };
        0x2::event::emit<FormCreated>(v1);
        0x2::transfer::share_object<WalForm>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, @0xc4d6ee019649edba41d5a5ed1081fe3c86afc41fea413195dd6ecdd0f6090e54);
        let v1 = AdminCap{
            id     : 0x2::object::new(arg0),
            admins : v0,
        };
        0x2::transfer::share_object<AdminCap>(v1);
    }

    fun is_admin(arg0: &AdminCap, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun record_submission(arg0: &mut WalForm, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<vector<u8>>(&arg0.final_manifest_root), 0);
        let v0 = arg0.submission_count;
        arg0.submission_count = v0 + 1;
        let v1 = SubmissionRecorded{
            form_id            : 0x2::object::uid_to_address(&arg0.id),
            submission_blob_id : arg1,
            submission_hash    : arg2,
            submitter          : 0x2::tx_context::sender(arg4),
            submitted_at_ms    : 0x2::clock::timestamp_ms(arg3),
            sequence           : v0,
        };
        0x2::event::emit<SubmissionRecorded>(v1);
    }

    public entry fun review_application(arg0: &AdminCap, arg1: &WalForm, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_admin(arg0, v0), 3);
        let v1 = ApplicationReviewed{
            form_id        : 0x2::object::uid_to_address(&arg1.id),
            reviewer       : v0,
            approved       : arg2,
            reviewed_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ApplicationReviewed>(v1);
    }

    public entry fun seal_form(arg0: &mut WalForm, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg3), 1);
        assert!(0x1::option::is_none<vector<u8>>(&arg0.final_manifest_root), 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.final_manifest_root = 0x1::option::some<vector<u8>>(arg1);
        arg0.sealed_at_ms = 0x1::option::some<u64>(v0);
        let v1 = FormSealed{
            form_id          : 0x2::object::uid_to_address(&arg0.id),
            manifest_root    : arg1,
            submission_count : arg0.submission_count,
            sealed_at_ms     : v0,
        };
        0x2::event::emit<FormSealed>(v1);
    }

    // decompiled from Move bytecode v7
}

