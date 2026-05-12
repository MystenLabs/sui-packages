module 0x96b327898e00fb886c1ccf9b7e460634b1fe249e2762f7d11f0d508715ce3f6e::events {
    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        schema_blob_id: vector<u8>,
    }

    struct FormUpdated has copy, drop {
        form_id: 0x2::object::ID,
        new_schema_blob_id: vector<u8>,
        version: u64,
    }

    struct FormStatusChanged has copy, drop {
        form_id: 0x2::object::ID,
        status: u8,
    }

    struct AdminAdded has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    struct SubmissionReceived has copy, drop {
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        blob_id: vector<u8>,
        submitter: address,
        submitted_at_ms: u64,
    }

    struct SubmissionStatusChanged has copy, drop {
        submission_id: 0x2::object::ID,
        status: u8,
    }

    struct SubmissionPriorityChanged has copy, drop {
        submission_id: 0x2::object::ID,
        priority: u8,
    }

    struct SubmissionTagged has copy, drop {
        submission_id: 0x2::object::ID,
        tag: 0x1::string::String,
    }

    struct NotesAttached has copy, drop {
        submission_id: 0x2::object::ID,
        notes_blob_id: vector<u8>,
    }

    public(friend) fun emit_admin_added(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AdminAdded{
            form_id : arg0,
            admin   : arg1,
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public(friend) fun emit_admin_removed(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AdminRemoved{
            form_id : arg0,
            admin   : arg1,
        };
        0x2::event::emit<AdminRemoved>(v0);
    }

    public(friend) fun emit_form_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>) {
        let v0 = FormCreated{
            form_id        : arg0,
            owner          : arg1,
            schema_blob_id : arg2,
        };
        0x2::event::emit<FormCreated>(v0);
    }

    public(friend) fun emit_form_status_changed(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = FormStatusChanged{
            form_id : arg0,
            status  : arg1,
        };
        0x2::event::emit<FormStatusChanged>(v0);
    }

    public(friend) fun emit_form_updated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = FormUpdated{
            form_id            : arg0,
            new_schema_blob_id : arg1,
            version            : arg2,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    public(friend) fun emit_notes_attached(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = NotesAttached{
            submission_id : arg0,
            notes_blob_id : arg1,
        };
        0x2::event::emit<NotesAttached>(v0);
    }

    public(friend) fun emit_submission_priority_changed(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = SubmissionPriorityChanged{
            submission_id : arg0,
            priority      : arg1,
        };
        0x2::event::emit<SubmissionPriorityChanged>(v0);
    }

    public(friend) fun emit_submission_received(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: u64) {
        let v0 = SubmissionReceived{
            form_id         : arg0,
            submission_id   : arg1,
            blob_id         : arg2,
            submitter       : arg3,
            submitted_at_ms : arg4,
        };
        0x2::event::emit<SubmissionReceived>(v0);
    }

    public(friend) fun emit_submission_status_changed(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = SubmissionStatusChanged{
            submission_id : arg0,
            status        : arg1,
        };
        0x2::event::emit<SubmissionStatusChanged>(v0);
    }

    public(friend) fun emit_submission_tagged(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = SubmissionTagged{
            submission_id : arg0,
            tag           : arg1,
        };
        0x2::event::emit<SubmissionTagged>(v0);
    }

    // decompiled from Move bytecode v7
}

