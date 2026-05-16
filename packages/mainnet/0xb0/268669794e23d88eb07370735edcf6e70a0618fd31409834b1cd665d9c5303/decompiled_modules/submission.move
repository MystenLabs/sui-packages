module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission {
    struct Submission has key {
        id: 0x2::object::UID,
        form_id: address,
        submitter: address,
        encrypted_body: vector<u8>,
        file_blob_ids: vector<vector<u8>>,
        nonce: vector<u8>,
        submitted_at_ms: u64,
    }

    public fun form_id(arg0: &Submission) : address {
        arg0.form_id
    }

    fun build_submission(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Submission {
        assert!(0x1::vector::length<u8>(&arg1) <= 200000, 1);
        assert!(0x1::vector::length<u8>(&arg3) == 16, 2);
        assert!(!0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::closed(arg0), 3);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::closes_at_ms(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::settings(arg0));
        if (v1 != 0) {
            assert!(v0 < v1, 4);
        };
        let v2 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::max_submissions(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::settings(arg0));
        if (v2 != 0) {
            assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::submission_count(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::stats(arg0)) < v2, 5);
        };
        let v3 = 0x2::object::new(arg6);
        let v4 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg0);
        let v5 = 0x2::tx_context::sender(arg6);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::bump_stats(arg0, arg4, v0);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::emit_submission_created(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::events::new_submission_created(v4, 0x2::object::uid_to_address(&v3), v5, 0x1::vector::length<u8>(&arg1), v0));
        Submission{
            id              : v3,
            form_id         : v4,
            submitter       : v5,
            encrypted_body  : arg1,
            file_blob_ids   : arg2,
            nonce           : arg3,
            submitted_at_ms : v0,
        }
    }

    public fun encrypted_body(arg0: &Submission) : &vector<u8> {
        &arg0.encrypted_body
    }

    public fun file_blob_ids(arg0: &Submission) : &vector<vector<u8>> {
        &arg0.file_blob_ids
    }

    public fun max_encrypted_body_bytes() : u64 {
        200000
    }

    public fun nonce(arg0: &Submission) : &vector<u8> {
        &arg0.nonce
    }

    public fun nonce_bytes() : u64 {
        16
    }

    public fun share(arg0: Submission) {
        0x2::transfer::share_object<Submission>(arg0);
    }

    public fun submit(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::Allowlist, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Submission {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_mode(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::settings(arg0));
        if (v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_public()) {
        } else if (v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_allowlist()) {
            assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::form_id(arg1) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg0), 7);
            assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::contains(arg1, 0x2::tx_context::sender(arg6)), 6);
        } else if (v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_token()) {
        } else if (v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_paid()) {
            abort 8
        };
        build_submission(arg0, arg2, arg3, arg4, 0, arg5, arg6)
    }

    public fun submit_and_share(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::Allowlist, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Submission>(submit(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun submit_paid(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::payment::FormTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Submission {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_mode(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::settings(arg0)) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_paid(), 8);
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::payment::form_id(arg1) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg0), 7);
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::payment::deposit_fee(arg1, arg2, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::submission_fee_mist(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::settings(arg0)), 0x2::tx_context::sender(arg7));
        build_submission(arg0, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public fun submit_paid_and_share(arg0: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &mut 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::payment::FormTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Submission>(submit_paid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun submitted_at_ms(arg0: &Submission) : u64 {
        arg0.submitted_at_ms
    }

    public fun submitter(arg0: &Submission) : address {
        arg0.submitter
    }

    // decompiled from Move bytecode v6
}

