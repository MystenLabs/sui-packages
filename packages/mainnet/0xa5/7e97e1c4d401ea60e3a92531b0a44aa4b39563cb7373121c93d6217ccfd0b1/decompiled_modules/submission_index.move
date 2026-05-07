module 0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::submission_index {
    struct SubmissionRecord has copy, drop, store {
        blob_id: vector<u8>,
        encrypted: bool,
        respondent_mode: u8,
        submitted_at: u64,
    }

    struct SubmissionIndexed has copy, drop {
        form_id: address,
        blob_id: vector<u8>,
        encrypted: bool,
        respondent_mode: u8,
        submitted_at: u64,
    }

    public fun index_submission(arg0: &mut 0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::form_registry::Form, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: u8, arg5: &0x2::clock::Clock) {
        assert!(0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::form_registry::is_active(arg0), 1);
        let v0 = SubmissionRecord{
            blob_id         : arg2,
            encrypted       : arg3,
            respondent_mode : arg4,
            submitted_at    : 0x2::clock::timestamp_ms(arg5),
        };
        let v1 = SubmissionIndexed{
            form_id         : 0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::form_registry::form_id(arg0),
            blob_id         : v0.blob_id,
            encrypted       : v0.encrypted,
            respondent_mode : v0.respondent_mode,
            submitted_at    : v0.submitted_at,
        };
        0x2::event::emit<SubmissionIndexed>(v1);
        0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::form_registry::add_dynamic<SubmissionRecord>(arg0, arg1, v0);
        0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::form_registry::increment_submission_count(arg0);
    }

    public fun respondent_anonymous() : u8 {
        0
    }

    public fun respondent_wallet() : u8 {
        1
    }

    public fun respondent_zklogin() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

