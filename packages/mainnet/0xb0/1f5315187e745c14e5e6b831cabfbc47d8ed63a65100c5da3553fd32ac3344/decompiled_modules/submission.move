module 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::submission {
    struct Submission has key {
        id: 0x2::object::UID,
        form: 0x2::object::ID,
        respondent: address,
        encrypted_blob: 0x1::string::String,
        form_version: u32,
        submitted_at_ms: u64,
    }

    struct SubmissionCreated has copy, drop {
        form: 0x2::object::ID,
        submission: 0x2::object::ID,
        respondent: address,
        blob: 0x1::string::String,
        form_version: u32,
        submitted_at_ms: u64,
    }

    public fun encrypted_blob(arg0: &Submission) : 0x1::string::String {
        arg0.encrypted_blob
    }

    public fun form_id(arg0: &Submission) : 0x2::object::ID {
        arg0.form
    }

    public fun form_version(arg0: &Submission) : u32 {
        arg0.form_version
    }

    public fun respondent(arg0: &Submission) : address {
        arg0.respondent
    }

    public entry fun submit(arg0: &mut 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::Form, arg1: 0x1::string::String, arg2: u32, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::is_open(arg0), 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x2::object::id<0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::Form>(arg0);
        let v3 = Submission{
            id              : 0x2::object::new(arg4),
            form            : v2,
            respondent      : v0,
            encrypted_blob  : arg1,
            form_version    : arg2,
            submitted_at_ms : v1,
        };
        0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::inc_submission_count(arg0);
        let v4 = 0x2::object::id<Submission>(&v3);
        let v5 = SubmissionCreated{
            form            : v2,
            submission      : v4,
            respondent      : v0,
            blob            : v3.encrypted_blob,
            form_version    : arg2,
            submitted_at_ms : v1,
        };
        0x2::event::emit<SubmissionCreated>(v5);
        0x2::transfer::transfer<Submission>(v3, v0);
        0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::receipt::mint(v2, v4, 0xb01f5315187e745c14e5e6b831cabfbc47d8ed63a65100c5da3553fd32ac3344::form::title(arg0), 0x1::string::utf8(b"https://tusk.wal.app/og/receipt.png"), v0, arg4);
    }

    public fun submitted_at_ms(arg0: &Submission) : u64 {
        arg0.submitted_at_ms
    }

    // decompiled from Move bytecode v7
}

