module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::submission {
    struct SubmissionReceived has copy, drop {
        form_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        blob_id: vector<u8>,
        submitter: 0x1::option::Option<address>,
        schema_version: u64,
        is_encrypted: bool,
        identity_mode: u8,
        is_sponsored: bool,
    }

    struct DeletionRequested has copy, drop {
        receipt_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        requester: address,
        form_owner: address,
    }

    struct SubmissionReceipt has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        blob_id: vector<u8>,
        is_encrypted: bool,
        submitter: 0x1::option::Option<address>,
        identity_mode: u8,
        is_sponsored: bool,
        form_owner_at_submission: address,
        schema_version_at_submission: u64,
        created_at: u64,
    }

    struct DeletionRequest has key {
        id: 0x2::object::UID,
        receipt_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        requested_by: address,
        requested_at: u64,
    }

    public fun blob_id(arg0: &SubmissionReceipt) : vector<u8> {
        arg0.blob_id
    }

    public fun created_at(arg0: &SubmissionReceipt) : u64 {
        arg0.created_at
    }

    public fun deletion_request_form_id(arg0: &DeletionRequest) : 0x2::object::ID {
        arg0.form_id
    }

    public fun deletion_request_receipt_id(arg0: &DeletionRequest) : 0x2::object::ID {
        arg0.receipt_id
    }

    public fun form_id(arg0: &SubmissionReceipt) : 0x2::object::ID {
        arg0.form_id
    }

    public fun form_owner_at_submission(arg0: &SubmissionReceipt) : address {
        arg0.form_owner_at_submission
    }

    public fun identity_mode(arg0: &SubmissionReceipt) : u8 {
        arg0.identity_mode
    }

    public fun is_encrypted(arg0: &SubmissionReceipt) : bool {
        arg0.is_encrypted
    }

    public fun is_sponsored(arg0: &SubmissionReceipt) : bool {
        arg0.is_sponsored
    }

    entry fun request_deletion(arg0: &SubmissionReceipt, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::option::is_some<address>(&arg0.submitter), 21);
        assert!(*0x1::option::borrow<address>(&arg0.submitter) == v0, 21);
        let v1 = DeletionRequest{
            id           : 0x2::object::new(arg1),
            receipt_id   : 0x2::object::uid_to_inner(&arg0.id),
            form_id      : arg0.form_id,
            requested_by : v0,
            requested_at : 0x2::tx_context::epoch(arg1),
        };
        let v2 = DeletionRequested{
            receipt_id : 0x2::object::uid_to_inner(&arg0.id),
            form_id    : arg0.form_id,
            requester  : v0,
            form_owner : arg0.form_owner_at_submission,
        };
        0x2::event::emit<DeletionRequested>(v2);
        0x2::transfer::transfer<DeletionRequest>(v1, arg0.form_owner_at_submission);
    }

    public fun requested_by(arg0: &DeletionRequest) : address {
        arg0.requested_by
    }

    public fun schema_version_at_submission(arg0: &SubmissionReceipt) : u64 {
        arg0.schema_version_at_submission
    }

    entry fun submit(arg0: &mut 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg1: vector<u8>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::is_closed(arg0), 3);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg0);
        let v2 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::schema_version(arg0);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::increment_submission_count(arg0);
        let v3 = SubmissionReceipt{
            id                           : 0x2::object::new(arg3),
            form_id                      : v1,
            blob_id                      : arg1,
            is_encrypted                 : arg2,
            submitter                    : 0x1::option::some<address>(v0),
            identity_mode                : 2,
            is_sponsored                 : false,
            form_owner_at_submission     : 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::owner(arg0),
            schema_version_at_submission : v2,
            created_at                   : 0x2::tx_context::epoch(arg3),
        };
        let v4 = SubmissionReceived{
            form_id        : v1,
            receipt_id     : 0x2::object::uid_to_inner(&v3.id),
            blob_id        : v3.blob_id,
            submitter      : 0x1::option::some<address>(v0),
            schema_version : v2,
            is_encrypted   : arg2,
            identity_mode  : 2,
            is_sponsored   : false,
        };
        0x2::event::emit<SubmissionReceived>(v4);
        0x2::transfer::transfer<SubmissionReceipt>(v3, v0);
    }

    entry fun submit_anonymous(arg0: &mut 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg1: vector<u8>, arg2: bool, arg3: 0x1::option::Option<address>, arg4: address, arg5: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::sponsorship::SponsorshipPool, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::is_closed(arg0), 3);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::submission_identity_mode(arg0);
        assert!(v0 == 0 || v0 == 1, 12);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::sponsorship::verify_sponsorship(arg5, arg4);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = v1 != arg4;
        let v3 = if (v0 == 0) {
            0x1::option::none<address>()
        } else {
            arg3
        };
        let v4 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg0);
        let v5 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::schema_version(arg0);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::increment_submission_count(arg0);
        let v6 = SubmissionReceipt{
            id                           : 0x2::object::new(arg6),
            form_id                      : v4,
            blob_id                      : arg1,
            is_encrypted                 : arg2,
            submitter                    : v3,
            identity_mode                : v0,
            is_sponsored                 : v2,
            form_owner_at_submission     : 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::owner(arg0),
            schema_version_at_submission : v5,
            created_at                   : 0x2::tx_context::epoch(arg6),
        };
        let v7 = SubmissionReceived{
            form_id        : v4,
            receipt_id     : 0x2::object::uid_to_inner(&v6.id),
            blob_id        : v6.blob_id,
            submitter      : v3,
            schema_version : v5,
            is_encrypted   : arg2,
            identity_mode  : v0,
            is_sponsored   : v2,
        };
        0x2::event::emit<SubmissionReceived>(v7);
        0x2::transfer::transfer<SubmissionReceipt>(v6, v1);
    }

    entry fun submit_anonymous_with_policy(arg0: &mut 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::FormAccessPolicy, arg2: vector<u8>, arg3: bool, arg4: 0x1::option::Option<address>, arg5: address, arg6: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::sponsorship::SponsorshipPool, arg7: 0x1::option::Option<vector<u8>>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::is_closed(arg0), 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        assert!(0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::policy_form_id(arg1) == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg0), 2);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::submission_identity_mode(arg0);
        assert!(v0 == 0 || v0 == 1, 12);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::verify_submission_window(arg1, 0x2::tx_context::epoch(arg8));
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::verify_password(arg1, arg7);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::sponsorship::verify_sponsorship(arg6, arg5);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = v1 != arg5;
        let v3 = if (v0 == 0) {
            0x1::option::none<address>()
        } else {
            arg4
        };
        let v4 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg0);
        let v5 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::schema_version(arg0);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::increment_submission_count(arg0);
        let v6 = SubmissionReceipt{
            id                           : 0x2::object::new(arg8),
            form_id                      : v4,
            blob_id                      : arg2,
            is_encrypted                 : arg3,
            submitter                    : v3,
            identity_mode                : v0,
            is_sponsored                 : v2,
            form_owner_at_submission     : 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::owner(arg0),
            schema_version_at_submission : v5,
            created_at                   : 0x2::tx_context::epoch(arg8),
        };
        let v7 = SubmissionReceived{
            form_id        : v4,
            receipt_id     : 0x2::object::uid_to_inner(&v6.id),
            blob_id        : v6.blob_id,
            submitter      : v3,
            schema_version : v5,
            is_encrypted   : arg3,
            identity_mode  : v0,
            is_sponsored   : v2,
        };
        0x2::event::emit<SubmissionReceived>(v7);
        0x2::transfer::transfer<SubmissionReceipt>(v6, v1);
    }

    entry fun submit_with_policy(arg0: &mut 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::FormAccessPolicy, arg2: vector<u8>, arg3: bool, arg4: 0x1::option::Option<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::is_closed(arg0), 3);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        assert!(0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::policy_form_id(arg1) == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg0), 2);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::verify_submission_window(arg1, 0x2::tx_context::epoch(arg5));
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::access::verify_password(arg1, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg0);
        let v2 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::schema_version(arg0);
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::increment_submission_count(arg0);
        let v3 = SubmissionReceipt{
            id                           : 0x2::object::new(arg5),
            form_id                      : v1,
            blob_id                      : arg2,
            is_encrypted                 : arg3,
            submitter                    : 0x1::option::some<address>(v0),
            identity_mode                : 2,
            is_sponsored                 : false,
            form_owner_at_submission     : 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::owner(arg0),
            schema_version_at_submission : v2,
            created_at                   : 0x2::tx_context::epoch(arg5),
        };
        let v4 = SubmissionReceived{
            form_id        : v1,
            receipt_id     : 0x2::object::uid_to_inner(&v3.id),
            blob_id        : v3.blob_id,
            submitter      : 0x1::option::some<address>(v0),
            schema_version : v2,
            is_encrypted   : arg3,
            identity_mode  : 2,
            is_sponsored   : false,
        };
        0x2::event::emit<SubmissionReceived>(v4);
        0x2::transfer::transfer<SubmissionReceipt>(v3, v0);
    }

    public fun submitter(arg0: &SubmissionReceipt) : 0x1::option::Option<address> {
        arg0.submitter
    }

    // decompiled from Move bytecode v6
}

