module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission {
    struct Submission has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        submitter: address,
        blob_id: 0x1::string::String,
        status: u8,
        submitted_at_ms: u64,
        file_blob_ids: vector<0x1::string::String>,
    }

    struct SubmissionCreated has copy, drop {
        submission_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        submitter: address,
        blob_id: 0x1::string::String,
        submitted_at_ms: u64,
    }

    struct SubmissionStatusChanged has copy, drop {
        submission_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
    }

    public fun blob_id(arg0: &Submission) : 0x1::string::String {
        arg0.blob_id
    }

    public fun form_id(arg0: &Submission) : 0x2::object::ID {
        arg0.form_id
    }

    public(friend) fun set_status(arg0: &mut Submission, arg1: u8) {
        arg0.status = arg1;
        let v0 = SubmissionStatusChanged{
            submission_id : 0x2::object::id<Submission>(arg0),
            old_status    : arg0.status,
            new_status    : arg1,
        };
        0x2::event::emit<SubmissionStatusChanged>(v0);
    }

    public fun status(arg0: &Submission) : u8 {
        arg0.status
    }

    public fun status_in_progress() : u8 {
        2
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_resolved() : u8 {
        3
    }

    public fun status_triaged() : u8 {
        1
    }

    public fun submit(arg0: &mut 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::is_open(arg0), 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = Submission{
            id              : 0x2::object::new(arg4),
            form_id         : 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg0),
            submitter       : 0x2::tx_context::sender(arg4),
            blob_id         : arg1,
            status          : 0,
            submitted_at_ms : v0,
            file_blob_ids   : arg2,
        };
        0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::increment_submission_count(arg0);
        let v2 = SubmissionCreated{
            submission_id   : 0x2::object::id<Submission>(&v1),
            form_id         : 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg0),
            submitter       : v1.submitter,
            blob_id         : v1.blob_id,
            submitted_at_ms : v0,
        };
        0x2::event::emit<SubmissionCreated>(v2);
        0x2::transfer::share_object<Submission>(v1);
    }

    public fun submitter(arg0: &Submission) : address {
        arg0.submitter
    }

    // decompiled from Move bytecode v6
}

