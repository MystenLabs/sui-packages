module 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::submissions {
    struct SubmissionKey has copy, drop, store {
        pos0: u64,
    }

    struct Submission has store {
        submitter: 0x1::option::Option<address>,
        response_blob_id: 0x1::string::String,
        encrypted_field_ids: vector<0x1::string::String>,
        priority: u8,
        tag: 0x1::string::String,
        note_blob_id: 0x1::option::Option<0x1::string::String>,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct SubmissionAdded has copy, drop {
        form_id: 0x2::object::ID,
        index: u64,
        submitter: 0x1::option::Option<address>,
        response_blob_id: 0x1::string::String,
        encrypted_field_ids: vector<0x1::string::String>,
        created_at_ms: u64,
    }

    struct SubmissionUpdated has copy, drop {
        form_id: 0x2::object::ID,
        index: u64,
        priority: u8,
        tag: 0x1::string::String,
        note_blob_id: 0x1::option::Option<0x1::string::String>,
        updated_at_ms: u64,
    }

    public fun attach_note(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = SubmissionKey{pos0: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v1);
        v2.note_blob_id = 0x1::option::some<0x1::string::String>(arg2);
        v2.updated_at_ms = v0;
        let v3 = SubmissionUpdated{
            form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
            index         : arg1,
            priority      : v2.priority,
            tag           : v2.tag,
            note_blob_id  : v2.note_blob_id,
            updated_at_ms : v0,
        };
        0x2::event::emit<SubmissionUpdated>(v3);
    }

    public fun batch_clear_notes(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: vector<u64>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 13906835806431346695);
        assert!(v0 <= 256, 13906835810726445065);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            let v4 = SubmissionKey{pos0: v3};
            let v5 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v4);
            v5.note_blob_id = 0x1::option::none<0x1::string::String>();
            v5.updated_at_ms = v1;
            let v6 = SubmissionUpdated{
                form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
                index         : v3,
                priority      : v5.priority,
                tag           : v5.tag,
                note_blob_id  : v5.note_blob_id,
                updated_at_ms : v1,
            };
            0x2::event::emit<SubmissionUpdated>(v6);
            v2 = v2 + 1;
        };
    }

    public fun batch_set_priority(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: vector<u64>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 <= 3, 13906835510078210049);
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 13906835518668537863);
        assert!(v0 <= 256, 13906835522963636233);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            let v4 = SubmissionKey{pos0: v3};
            let v5 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v4);
            v5.priority = arg2;
            v5.updated_at_ms = v1;
            let v6 = SubmissionUpdated{
                form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
                index         : v3,
                priority      : v5.priority,
                tag           : v5.tag,
                note_blob_id  : v5.note_blob_id,
                updated_at_ms : v1,
            };
            0x2::event::emit<SubmissionUpdated>(v6);
            v2 = v2 + 1;
        };
    }

    public fun batch_set_tag(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: vector<u64>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 > 0, 13906835660402458631);
        assert!(v0 <= 256, 13906835664697557001);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            let v4 = SubmissionKey{pos0: v3};
            let v5 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v4);
            v5.tag = arg2;
            v5.updated_at_ms = v1;
            let v6 = SubmissionUpdated{
                form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
                index         : v3,
                priority      : v5.priority,
                tag           : v5.tag,
                note_blob_id  : v5.note_blob_id,
                updated_at_ms : v1,
            };
            0x2::event::emit<SubmissionUpdated>(v6);
            v2 = v2 + 1;
        };
    }

    public fun clear_note(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = SubmissionKey{pos0: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v1);
        v2.note_blob_id = 0x1::option::none<0x1::string::String>();
        v2.updated_at_ms = v0;
        let v3 = SubmissionUpdated{
            form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
            index         : arg1,
            priority      : v2.priority,
            tag           : v2.tag,
            note_blob_id  : v2.note_blob_id,
            updated_at_ms : v0,
        };
        0x2::event::emit<SubmissionUpdated>(v3);
    }

    public fun created_at_ms(arg0: &Submission) : u64 {
        arg0.created_at_ms
    }

    public fun encrypted_field_ids(arg0: &Submission) : &vector<0x1::string::String> {
        &arg0.encrypted_field_ids
    }

    public fun has_submission(arg0: &0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: u64) : bool {
        let v0 = SubmissionKey{pos0: arg1};
        0x2::dynamic_field::exists_with_type<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid(arg0), v0)
    }

    public fun note_blob_id(arg0: &Submission) : &0x1::option::Option<0x1::string::String> {
        &arg0.note_blob_id
    }

    public fun priority(arg0: &Submission) : u8 {
        arg0.priority
    }

    public fun response_blob_id(arg0: &Submission) : &0x1::string::String {
        &arg0.response_blob_id
    }

    public fun set_priority(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 <= 3, 13906834917372723201);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = SubmissionKey{pos0: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v1);
        v2.priority = arg2;
        v2.updated_at_ms = v0;
        let v3 = SubmissionUpdated{
            form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
            index         : arg1,
            priority      : v2.priority,
            tag           : v2.tag,
            note_blob_id  : v2.note_blob_id,
            updated_at_ms : v0,
        };
        0x2::event::emit<SubmissionUpdated>(v3);
    }

    public fun set_tag(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = SubmissionKey{pos0: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v1);
        v2.tag = arg2;
        v2.updated_at_ms = v0;
        let v3 = SubmissionUpdated{
            form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
            index         : arg1,
            priority      : v2.priority,
            tag           : v2.tag,
            note_blob_id  : v2.note_blob_id,
            updated_at_ms : v0,
        };
        0x2::event::emit<SubmissionUpdated>(v3);
    }

    public fun submission_at(arg0: &0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: u64) : &Submission {
        assert!(has_submission(arg0, arg1), 13906835935280234501);
        let v0 = SubmissionKey{pos0: arg1};
        0x2::dynamic_field::borrow<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid(arg0), v0)
    }

    public fun submit(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::archived(arg0), 13906834560890568707);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::require_wallet(arg0);
        if (v1 && 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::allowlist_size(arg0) > 0) {
            assert!(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::is_allowlisted(arg0, v0), 13906834595250831371);
        };
        if (v1 && !0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::allow_duplicate(arg0)) {
            assert!(!0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::has_submitted(arg0, v0), 13906834625315733517);
        };
        let v2 = if (v1) {
            0x1::option::some<address>(v0)
        } else {
            0x1::option::none<address>()
        };
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = Submission{
            submitter           : v2,
            response_blob_id    : arg1,
            encrypted_field_ids : arg2,
            priority            : 0,
            tag                 : 0x1::string::utf8(b""),
            note_blob_id        : 0x1::option::none<0x1::string::String>(),
            created_at_ms       : v3,
            updated_at_ms       : v3,
        };
        let v5 = 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::increment_submissions(arg0);
        let v6 = SubmissionKey{pos0: v5};
        0x2::dynamic_field::add<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v6, v4);
        if (v1) {
            0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::record_submitter(arg0, v0);
        };
        let v7 = SubmissionAdded{
            form_id             : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
            index               : v5,
            submitter           : v4.submitter,
            response_blob_id    : v4.response_blob_id,
            encrypted_field_ids : v4.encrypted_field_ids,
            created_at_ms       : v3,
        };
        0x2::event::emit<SubmissionAdded>(v7);
        v5
    }

    entry fun submit_entry(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        submit(arg0, arg1, arg2, arg3, arg4);
    }

    public fun submitter(arg0: &Submission) : &0x1::option::Option<address> {
        &arg0.submitter
    }

    public fun tag(arg0: &Submission) : &0x1::string::String {
        &arg0.tag
    }

    entry fun update_submission(arg0: &mut 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg1: &0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::AdminCap, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: bool, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorizes(arg1, arg0);
        0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::assert_authorized_sender(arg0, 0x2::tx_context::sender(arg8));
        assert!(arg3 <= 3, 13906835316804681729);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = SubmissionKey{pos0: arg2};
        let v2 = 0x2::dynamic_field::borrow_mut<SubmissionKey, Submission>(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::uid_mut(arg0), v1);
        v2.priority = arg3;
        v2.tag = arg4;
        if (arg5) {
            v2.note_blob_id = 0x1::option::some<0x1::string::String>(arg6);
        } else {
            v2.note_blob_id = 0x1::option::none<0x1::string::String>();
        };
        v2.updated_at_ms = v0;
        let v3 = SubmissionUpdated{
            form_id       : 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg0),
            index         : arg2,
            priority      : v2.priority,
            tag           : v2.tag,
            note_blob_id  : v2.note_blob_id,
            updated_at_ms : v0,
        };
        0x2::event::emit<SubmissionUpdated>(v3);
    }

    public fun updated_at_ms(arg0: &Submission) : u64 {
        arg0.updated_at_ms
    }

    // decompiled from Move bytecode v6
}

