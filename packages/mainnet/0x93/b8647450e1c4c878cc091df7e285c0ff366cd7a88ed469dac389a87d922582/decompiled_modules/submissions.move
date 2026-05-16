module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::submissions {
    struct Submission has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        session_id: 0x1::option::Option<0x2::object::ID>,
        submitter: address,
        payload_blob_id: u256,
        media_blob_ids: vector<u256>,
        triage_blob_id: u256,
        has_triage: bool,
        priority: u8,
        archived: bool,
        submitted_at: u64,
    }

    struct SubmissionCreated has copy, drop {
        submission_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        session_id: 0x1::option::Option<0x2::object::ID>,
        submitter: address,
        encrypted: bool,
    }

    struct SubmissionPriorityChanged has copy, drop {
        submission_id: 0x2::object::ID,
        priority: u8,
    }

    struct SubmissionArchived has copy, drop {
        submission_id: 0x2::object::ID,
        archived: bool,
    }

    struct SubmissionTriageAttached has copy, drop {
        submission_id: 0x2::object::ID,
        triage_blob_id: u256,
    }

    public fun session_id(arg0: &Submission) : &0x1::option::Option<0x2::object::ID> {
        &arg0.session_id
    }

    fun assert_form_in_session(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session) {
        let v0 = 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::session_id(arg0);
        assert!(0x1::option::is_some<0x2::object::ID>(v0), 9);
        let v1 = 0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(v0, &v1), 6);
    }

    fun assert_nft_match<T0: key>(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &T0, arg2: &0x1::string::String) {
        let v0 = 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_nft_type(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(v0), 2);
        assert!(0x1::option::borrow<0x1::string::String>(v0) == arg2, 3);
    }

    fun assert_token_match<T0>(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &0x2::coin::Coin<T0>, arg2: &0x1::string::String) {
        let v0 = 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_token_type(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(v0), 7);
        assert!(0x1::option::borrow<0x1::string::String>(v0) == arg2, 5);
        assert!(0x2::coin::value<T0>(arg1) >= 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_token_amount(arg0), 4);
    }

    public fun attach_triage(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &mut Submission, arg2: u256, arg3: &0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg1.form_id == 0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form>(arg0), 0);
        arg1.triage_blob_id = arg2;
        arg1.has_triage = true;
        let v0 = SubmissionTriageAttached{
            submission_id  : 0x2::object::id<Submission>(arg1),
            triage_blob_id : arg2,
        };
        0x2::event::emit<SubmissionTriageAttached>(v0);
    }

    fun finish(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: Submission, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::issues_attendance_nft(arg0)) {
            0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::soulbound::transfer_to_sender(0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::soulbound::mint(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form>(arg0), 0x2::object::id<Submission>(&arg1), 0x2::clock::timestamp_ms(arg2), arg3), arg3);
        };
        0x2::transfer::share_object<Submission>(arg1);
    }

    public fun form_id(arg0: &Submission) : 0x2::object::ID {
        arg0.form_id
    }

    public fun has_triage(arg0: &Submission) : bool {
        arg0.has_triage
    }

    public fun is_archived(arg0: &Submission) : bool {
        arg0.archived
    }

    public fun media_blob_ids(arg0: &Submission) : &vector<u256> {
        &arg0.media_blob_ids
    }

    fun mint_submission_inner(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: u256, arg2: vector<u256>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Submission {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::assert_open(arg0);
        let v0 = Submission{
            id              : 0x2::object::new(arg4),
            form_id         : 0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form>(arg0),
            session_id      : *0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::session_id(arg0),
            submitter       : 0x2::tx_context::sender(arg4),
            payload_blob_id : arg1,
            media_blob_ids  : arg2,
            triage_blob_id  : 0,
            has_triage      : false,
            priority        : 1,
            archived        : false,
            submitted_at    : 0x2::clock::timestamp_ms(arg3),
        };
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::record_submission(arg0);
        let v1 = SubmissionCreated{
            submission_id : 0x2::object::id<Submission>(&v0),
            form_id       : 0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form>(arg0),
            session_id    : *0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::session_id(arg0),
            submitter     : 0x2::tx_context::sender(arg4),
            encrypted     : 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::encrypted(arg0),
        };
        0x2::event::emit<SubmissionCreated>(v1);
        v0
    }

    public fun payload_blob_id(arg0: &Submission) : u256 {
        arg0.payload_blob_id
    }

    public fun priority(arg0: &Submission) : u8 {
        arg0.priority
    }

    public fun set_archived(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &mut Submission, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        arg1.archived = arg2;
        let v0 = SubmissionArchived{
            submission_id : 0x2::object::id<Submission>(arg1),
            archived      : arg2,
        };
        0x2::event::emit<SubmissionArchived>(v0);
    }

    public fun set_priority(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &mut Submission, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        arg1.priority = arg2;
        let v0 = SubmissionPriorityChanged{
            submission_id : 0x2::object::id<Submission>(arg1),
            priority      : arg2,
        };
        0x2::event::emit<SubmissionPriorityChanged>(v0);
    }

    public fun set_priority_with_session(arg0: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg2: &mut Submission, arg3: u8, arg4: &0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0);
        assert!(0x1::option::contains<0x2::object::ID>(0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::session_id(arg1), &v0), 6);
        arg2.priority = arg3;
        let v1 = SubmissionPriorityChanged{
            submission_id : 0x2::object::id<Submission>(arg2),
            priority      : arg3,
        };
        0x2::event::emit<SubmissionPriorityChanged>(v1);
    }

    public fun submit(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: u256, arg2: vector<u256>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x1::string::String>(0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_nft_type(arg0)), 8);
        assert!(0x1::option::is_none<0x1::string::String>(0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_token_type(arg0)), 8);
        let v0 = mint_submission_inner(arg0, arg1, arg2, arg3, arg4);
        finish(arg0, v0, arg3, arg4);
    }

    public fun submit_in_session(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg2: u256, arg3: vector<u256>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x1::string::String>(0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_nft_type(arg0)), 8);
        assert!(0x1::option::is_none<0x1::string::String>(0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::require_token_type(arg0)), 8);
        assert_form_in_session(arg0, arg1);
        let v0 = mint_submission_inner(arg0, arg2, arg3, arg4, arg5);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::bump_attendance(arg1);
        finish(arg0, v0, arg4, arg5);
    }

    public fun submit_with_nft<T0: key>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &T0, arg2: 0x1::string::String, arg3: u256, arg4: vector<u256>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_nft_match<T0>(arg0, arg1, &arg2);
        let v0 = mint_submission_inner(arg0, arg3, arg4, arg5, arg6);
        finish(arg0, v0, arg5, arg6);
    }

    public fun submit_with_nft_in_session<T0: key>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg2: &T0, arg3: 0x1::string::String, arg4: u256, arg5: vector<u256>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_nft_match<T0>(arg0, arg2, &arg3);
        assert_form_in_session(arg0, arg1);
        let v0 = mint_submission_inner(arg0, arg4, arg5, arg6, arg7);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::bump_attendance(arg1);
        finish(arg0, v0, arg6, arg7);
    }

    public fun submit_with_token<T0>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u256, arg4: vector<u256>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_token_match<T0>(arg0, arg1, &arg2);
        let v0 = mint_submission_inner(arg0, arg3, arg4, arg5, arg6);
        finish(arg0, v0, arg5, arg6);
    }

    public fun submit_with_token_in_session<T0>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::forms::Form, arg1: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg2: &0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: u256, arg5: vector<u256>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_token_match<T0>(arg0, arg2, &arg3);
        assert_form_in_session(arg0, arg1);
        let v0 = mint_submission_inner(arg0, arg4, arg5, arg6, arg7);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::bump_attendance(arg1);
        finish(arg0, v0, arg6, arg7);
    }

    public fun submitted_at(arg0: &Submission) : u64 {
        arg0.submitted_at
    }

    public fun submitter(arg0: &Submission) : address {
        arg0.submitter
    }

    public fun triage_blob_id(arg0: &Submission) : u256 {
        arg0.triage_blob_id
    }

    // decompiled from Move bytecode v6
}

