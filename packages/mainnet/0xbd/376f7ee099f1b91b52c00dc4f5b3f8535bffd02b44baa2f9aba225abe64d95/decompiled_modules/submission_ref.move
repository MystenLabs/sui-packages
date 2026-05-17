module 0xbd376f7ee099f1b91b52c00dc4f5b3f8535bffd02b44baa2f9aba225abe64d95::submission_ref {
    struct SubmissionRef has key {
        id: 0x2::object::UID,
        form_pointer_id: 0x2::object::ID,
        blob_id: vector<u8>,
        submitter: address,
        submitted_at_ms: u64,
    }

    struct SubmissionRecorded has copy, drop {
        submission_ref_id: 0x2::object::ID,
        form_pointer_id: 0x2::object::ID,
        blob_id: vector<u8>,
        submitter: address,
        submitted_at_ms: u64,
    }

    public fun blob_id(arg0: &SubmissionRef) : vector<u8> {
        arg0.blob_id
    }

    public fun form_pointer_id(arg0: &SubmissionRef) : 0x2::object::ID {
        arg0.form_pointer_id
    }

    entry fun record(arg0: &0xbd376f7ee099f1b91b52c00dc4f5b3f8535bffd02b44baa2f9aba225abe64d95::form_pointer::FormPointer, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::object::id<0xbd376f7ee099f1b91b52c00dc4f5b3f8535bffd02b44baa2f9aba225abe64d95::form_pointer::FormPointer>(arg0);
        0xbd376f7ee099f1b91b52c00dc4f5b3f8535bffd02b44baa2f9aba225abe64d95::form_pointer::owner(arg0);
        let v3 = SubmissionRef{
            id              : 0x2::object::new(arg3),
            form_pointer_id : v2,
            blob_id         : arg1,
            submitter       : v1,
            submitted_at_ms : v0,
        };
        let v4 = SubmissionRecorded{
            submission_ref_id : 0x2::object::id<SubmissionRef>(&v3),
            form_pointer_id   : v2,
            blob_id           : arg1,
            submitter         : v1,
            submitted_at_ms   : v0,
        };
        0x2::event::emit<SubmissionRecorded>(v4);
        0x2::transfer::freeze_object<SubmissionRef>(v3);
    }

    public fun submitted_at_ms(arg0: &SubmissionRef) : u64 {
        arg0.submitted_at_ms
    }

    public fun submitter(arg0: &SubmissionRef) : address {
        arg0.submitter
    }

    // decompiled from Move bytecode v7
}

