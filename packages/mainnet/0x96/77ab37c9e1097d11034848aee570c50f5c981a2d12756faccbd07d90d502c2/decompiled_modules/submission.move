module 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::submission {
    struct SubmissionRef has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        payload_blob_id: 0x1::string::String,
        schema_version: u64,
        submitter: address,
        commitment: vector<u8>,
        submitted_ms: u64,
    }

    struct SubmissionMade has copy, drop {
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        submitter: address,
        schema_version: u64,
        anonymous: bool,
    }

    public fun schema_version(arg0: &SubmissionRef) : u64 {
        arg0.schema_version
    }

    public fun commitment(arg0: &SubmissionRef) : vector<u8> {
        arg0.commitment
    }

    public fun form_id(arg0: &SubmissionRef) : 0x2::object::ID {
        arg0.form_id
    }

    public fun payload_blob_id(arg0: &SubmissionRef) : 0x1::string::String {
        arg0.payload_blob_id
    }

    public fun submit(arg0: &mut 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::Form, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::assert_open(arg0);
        let v0 = SubmissionRef{
            id              : 0x2::object::new(arg3),
            form_id         : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::id(arg0),
            payload_blob_id : arg1,
            schema_version  : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::schema_version(arg0),
            submitter       : 0x2::tx_context::sender(arg3),
            commitment      : 0x1::vector::empty<u8>(),
            submitted_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        let v1 = 0x2::object::id<SubmissionRef>(&v0);
        0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::bump_submission_count(arg0);
        let v2 = SubmissionMade{
            form_id        : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::id(arg0),
            submission_id  : v1,
            submitter      : 0x2::tx_context::sender(arg3),
            schema_version : v0.schema_version,
            anonymous      : false,
        };
        0x2::event::emit<SubmissionMade>(v2);
        0x2::transfer::share_object<SubmissionRef>(v0);
        v1
    }

    public fun submit_anonymous(arg0: &mut 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::Form, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::assert_open(arg0);
        0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::record_commitment(arg0, arg2);
        let v0 = SubmissionRef{
            id              : 0x2::object::new(arg4),
            form_id         : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::id(arg0),
            payload_blob_id : arg1,
            schema_version  : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::schema_version(arg0),
            submitter       : @0x0,
            commitment      : arg2,
            submitted_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = 0x2::object::id<SubmissionRef>(&v0);
        0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::bump_submission_count(arg0);
        let v2 = SubmissionMade{
            form_id        : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::id(arg0),
            submission_id  : v1,
            submitter      : @0x0,
            schema_version : v0.schema_version,
            anonymous      : true,
        };
        0x2::event::emit<SubmissionMade>(v2);
        0x2::transfer::share_object<SubmissionRef>(v0);
        v1
    }

    public fun submitted_ms(arg0: &SubmissionRef) : u64 {
        arg0.submitted_ms
    }

    public fun submitter(arg0: &SubmissionRef) : address {
        arg0.submitter
    }

    // decompiled from Move bytecode v6
}

