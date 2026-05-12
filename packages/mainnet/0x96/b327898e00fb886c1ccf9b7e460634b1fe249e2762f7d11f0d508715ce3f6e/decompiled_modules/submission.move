module 0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::submission {
    struct Submission has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        blob_id: vector<u8>,
        submitter: address,
        submitted_at_ms: u64,
        status: u8,
        priority: u8,
        tags: vector<0x1::string::String>,
        notes_blob_id: vector<u8>,
        has_notes: bool,
    }

    struct SubmitterRegistry has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        submitters: 0x2::table::Table<address, bool>,
    }

    public fun id(arg0: &Submission) : 0x2::object::ID {
        0x2::object::id<Submission>(arg0)
    }

    public fun add_tag(arg0: &0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut Submission, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        0x1::vector::push_back<0x1::string::String>(&mut arg1.tags, arg2);
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::events::emit_submission_tagged(0x2::object::id<Submission>(arg1), arg2);
    }

    public fun attach_notes(arg0: &0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut Submission, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        arg1.notes_blob_id = arg2;
        arg1.has_notes = true;
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::events::emit_notes_attached(0x2::object::id<Submission>(arg1), arg2);
    }

    public fun blob_id(arg0: &Submission) : &vector<u8> {
        &arg0.blob_id
    }

    public fun clear_tags(arg0: &0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut Submission, arg2: &0x2::tx_context::TxContext) {
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::assert_admin(arg0, 0x2::tx_context::sender(arg2));
        arg1.tags = 0x1::vector::empty<0x1::string::String>();
    }

    public fun create_registry(arg0: &0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SubmitterRegistry{
            id         : 0x2::object::new(arg1),
            form_id    : 0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::id(arg0),
            submitters : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<SubmitterRegistry>(v0);
    }

    public fun form_id(arg0: &Submission) : 0x2::object::ID {
        arg0.form_id
    }

    public fun has_notes(arg0: &Submission) : bool {
        arg0.has_notes
    }

    public fun notes_blob_id(arg0: &Submission) : &vector<u8> {
        &arg0.notes_blob_id
    }

    public fun priority(arg0: &Submission) : u8 {
        arg0.priority
    }

    public fun priority_high() : u8 {
        2
    }

    public fun priority_low() : u8 {
        0
    }

    public fun priority_med() : u8 {
        1
    }

    public fun priority_urgent() : u8 {
        3
    }

    public fun set_priority(arg0: &0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut Submission, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 3, 5);
        arg1.priority = arg2;
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::events::emit_submission_priority_changed(0x2::object::id<Submission>(arg1), arg2);
    }

    public fun set_status(arg0: &0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut Submission, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 3, 4);
        arg1.status = arg2;
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::events::emit_submission_status_changed(0x2::object::id<Submission>(arg1), arg2);
    }

    public fun status(arg0: &Submission) : u8 {
        arg0.status
    }

    public fun status_in_progress() : u8 {
        1
    }

    public fun status_new() : u8 {
        0
    }

    public fun status_resolved() : u8 {
        2
    }

    public fun status_spam() : u8 {
        3
    }

    public fun submit(arg0: &mut 0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::assert_open(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::require_wallet(arg0)) {
            assert!(v0 != @0x0, 2);
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Submission{
            id              : 0x2::object::new(arg3),
            form_id         : 0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::id(arg0),
            blob_id         : arg1,
            submitter       : v0,
            submitted_at_ms : v1,
            status          : 0,
            priority        : 1,
            tags            : 0x1::vector::empty<0x1::string::String>(),
            notes_blob_id   : b"",
            has_notes       : false,
        };
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::bump_submission_count(arg0);
        0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::events::emit_submission_received(0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::id(arg0), 0x2::object::id<Submission>(&v2), arg1, v0, v1);
        0x2::transfer::share_object<Submission>(v2);
    }

    public fun submit_unique(arg0: &mut 0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::form::Form, arg1: &mut SubmitterRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, bool>(&arg1.submitters, v0), 3);
        0x2::table::add<address, bool>(&mut arg1.submitters, v0, true);
        submit(arg0, arg2, arg3, arg4);
    }

    public fun submitted_at_ms(arg0: &Submission) : u64 {
        arg0.submitted_at_ms
    }

    public fun submitter(arg0: &Submission) : address {
        arg0.submitter
    }

    public fun tags(arg0: &Submission) : &vector<0x1::string::String> {
        &arg0.tags
    }

    // decompiled from Move bytecode v6
}

