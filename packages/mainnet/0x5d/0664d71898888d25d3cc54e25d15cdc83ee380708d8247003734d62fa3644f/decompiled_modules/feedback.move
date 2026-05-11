module 0x5d0664d71898888d25d3cc54e25d15cdc83ee380708d8247003734d62fa3644f::feedback {
    struct Form has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        creator: address,
        submission_count: u64,
    }

    struct SubmissionCreated has copy, drop {
        form_id: address,
        submitter: address,
        blob_id: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun create_form(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Form{
            id               : 0x2::object::new(arg1),
            title            : arg0,
            creator          : 0x2::tx_context::sender(arg1),
            submission_count : 0,
        };
        0x2::transfer::share_object<Form>(v0);
    }

    public fun get_submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public entry fun submit(arg0: &mut Form, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.submission_count = arg0.submission_count + 1;
        let v0 = SubmissionCreated{
            form_id   : 0x2::object::uid_to_address(&arg0.id),
            submitter : 0x2::tx_context::sender(arg2),
            blob_id   : arg1,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SubmissionCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

