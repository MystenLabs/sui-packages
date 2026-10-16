module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::referral {
    struct ReferralRecorded has copy, drop {
        form_id: address,
        submission_id: address,
        submitter: address,
        referrer: address,
        referrer_submission_id: address,
        submitted_at_ms: u64,
    }

    fun record(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission) {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::form_id(arg1) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::form_id(arg0), 1);
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitter(arg1) != 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitter(arg0), 2);
        let v0 = ReferralRecorded{
            form_id                : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::form_id(arg0),
            submission_id          : 0x2::object::id_address<0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission>(arg0),
            submitter              : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitter(arg0),
            referrer               : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitter(arg1),
            referrer_submission_id : 0x2::object::id_address<0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission>(arg1),
            submitted_at_ms        : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitted_at_ms(arg0),
        };
        0x2::event::emit<ReferralRecorded>(v0);
    }

    public fun submit_and_share(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::Allowlist, arg2: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submit(arg0, arg1, arg3, arg4, arg5, arg6, arg7);
        record(&v0, arg2);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::share(v0);
    }

    public fun submit_paid_and_share(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::payment::FormTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submit_paid(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8);
        record(&v0, arg3);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::share(v0);
    }

    // decompiled from Move bytecode v7
}

