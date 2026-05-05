module 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events {
    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        slug: 0x1::string::String,
        owner: address,
        schema_blob_id: 0x1::string::String,
        schema_version: u64,
        admin_allowlist_id: 0x2::object::ID,
        epoch: u64,
    }

    struct FormUpdated has copy, drop {
        form_id: 0x2::object::ID,
        schema_blob_id: 0x1::string::String,
        schema_version: u64,
        epoch: u64,
    }

    struct FormRetired has copy, drop {
        form_id: 0x2::object::ID,
        epoch: u64,
    }

    struct SubmissionCreated has copy, drop {
        submission_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        submitter: address,
        blob_id: 0x1::string::String,
        seal_envelope_id: 0x1::string::String,
        epoch: u64,
    }

    struct SubmissionRevoked has copy, drop {
        submission_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        submitter: address,
        epoch: u64,
    }

    struct SubmissionAnnotated has copy, drop {
        submission_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        note_blob_id: 0x1::string::String,
        priority: u8,
        status: u8,
        epoch: u64,
    }

    public(friend) fun emit_form_created(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: 0x2::object::ID, arg6: u64) {
        let v0 = FormCreated{
            form_id            : arg0,
            slug               : arg1,
            owner              : arg2,
            schema_blob_id     : arg3,
            schema_version     : arg4,
            admin_allowlist_id : arg5,
            epoch              : arg6,
        };
        0x2::event::emit<FormCreated>(v0);
    }

    public(friend) fun emit_form_retired(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = FormRetired{
            form_id : arg0,
            epoch   : arg1,
        };
        0x2::event::emit<FormRetired>(v0);
    }

    public(friend) fun emit_form_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64) {
        let v0 = FormUpdated{
            form_id        : arg0,
            schema_blob_id : arg1,
            schema_version : arg2,
            epoch          : arg3,
        };
        0x2::event::emit<FormUpdated>(v0);
    }

    public(friend) fun emit_submission_annotated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u8, arg4: u8, arg5: u64) {
        let v0 = SubmissionAnnotated{
            submission_id : arg0,
            form_id       : arg1,
            note_blob_id  : arg2,
            priority      : arg3,
            status        : arg4,
            epoch         : arg5,
        };
        0x2::event::emit<SubmissionAnnotated>(v0);
    }

    public(friend) fun emit_submission_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        let v0 = SubmissionCreated{
            submission_id    : arg0,
            form_id          : arg1,
            submitter        : arg2,
            blob_id          : arg3,
            seal_envelope_id : arg4,
            epoch            : arg5,
        };
        0x2::event::emit<SubmissionCreated>(v0);
    }

    public(friend) fun emit_submission_revoked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = SubmissionRevoked{
            submission_id : arg0,
            form_id       : arg1,
            submitter     : arg2,
            epoch         : arg3,
        };
        0x2::event::emit<SubmissionRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

