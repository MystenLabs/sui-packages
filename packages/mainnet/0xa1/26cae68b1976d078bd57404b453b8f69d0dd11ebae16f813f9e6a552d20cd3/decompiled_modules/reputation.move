module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::reputation {
    struct SubmissionReceipt has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        submitter: address,
        severity: u8,
        resolved_at_ms: u64,
    }

    struct ReceiptMinted has copy, drop {
        receipt_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        submitter: address,
        severity: u8,
    }

    public fun form_id(arg0: &SubmissionReceipt) : 0x2::object::ID {
        arg0.form_id
    }

    public fun mint_receipt(arg0: &0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form, arg1: &0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::Submission, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::owner(arg0) == 0x2::tx_context::sender(arg4), 1);
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::form_id(arg1) == 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg0), 3);
        let v0 = 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::submitter(arg1);
        assert!(v0 != 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::owner(arg0), 2);
        let v1 = SubmissionReceipt{
            id             : 0x2::object::new(arg4),
            form_id        : 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg0),
            submission_id  : 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::Submission>(arg1),
            submitter      : v0,
            severity       : arg2,
            resolved_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        let v2 = ReceiptMinted{
            receipt_id    : 0x2::object::id<SubmissionReceipt>(&v1),
            form_id       : 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg0),
            submission_id : 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::Submission>(arg1),
            submitter     : v0,
            severity      : arg2,
        };
        0x2::event::emit<ReceiptMinted>(v2);
        0x2::transfer::transfer<SubmissionReceipt>(v1, v0);
    }

    public fun resolved_at_ms(arg0: &SubmissionReceipt) : u64 {
        arg0.resolved_at_ms
    }

    public fun severity(arg0: &SubmissionReceipt) : u8 {
        arg0.severity
    }

    public fun submission_id(arg0: &SubmissionReceipt) : 0x2::object::ID {
        arg0.submission_id
    }

    public fun submitter(arg0: &SubmissionReceipt) : address {
        arg0.submitter
    }

    // decompiled from Move bytecode v6
}

