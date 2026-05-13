module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::seal_policies {
    fun check_read_identity(arg0: &vector<u8>, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission) : bool {
        if (0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::form_id(arg2) != 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1)) {
            return false
        };
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        let v2 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::nonce(arg2);
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(&v1) + 0x1::vector::length<u8>(v2)) {
            return false
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v1)) {
            if (*0x1::vector::borrow<u8>(arg0, v3) != *0x1::vector::borrow<u8>(&v1, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v2)) {
            if (*0x1::vector::borrow<u8>(arg0, 0x1::vector::length<u8>(&v1) + v4) != *0x1::vector::borrow<u8>(v2, v4)) {
                return false
            };
            v4 = v4 + 1;
        };
        true
    }

    public fun e_bad_identity() : u64 {
        1
    }

    public fun e_unauthorized() : u64 {
        2
    }

    public fun e_wrong_form() : u64 {
        3
    }

    entry fun seal_approve_read_form_schema(arg0: vector<u8>, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::Allowlist, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        assert!(0x1::vector::length<u8>(&arg0) >= 0x1::vector::length<u8>(&v1), 1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v2) == *0x1::vector::borrow<u8>(&v1, v2), 1);
            v2 = v2 + 1;
        };
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::form_id(arg2) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1), 3);
        let v3 = 0x2::tx_context::sender(arg3);
        assert!(v3 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::owner(arg1) || 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::contains(arg2, v3), 2);
    }

    entry fun seal_approve_read_submission(arg0: vector<u8>, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission, arg3: &0x2::tx_context::TxContext) {
        assert!(check_read_identity(&arg0, arg1, arg2), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::owner(arg1) || v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitter(arg2), 2);
    }

    entry fun seal_approve_read_submission_with_reviewers(arg0: vector<u8>, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::Submission, arg3: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::reviewers::FormReviewers, arg4: &0x2::tx_context::TxContext) {
        assert!(check_read_identity(&arg0, arg1, arg2), 1);
        0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::reviewers::assert_for_form(arg3, 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1));
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::owner(arg1)) {
            true
        } else if (v0 == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::submission::submitter(arg2)) {
            true
        } else {
            0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::reviewers::is_reviewer(arg3, v0)
        };
        assert!(v1, 2);
    }

    entry fun seal_approve_read_template_schema(arg0: vector<u8>, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::FormTemplate, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::id_address(arg1);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        assert!(0x1::vector::length<u8>(&arg0) >= 0x1::vector::length<u8>(&v1), 1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v2) == *0x1::vector::borrow<u8>(&v1, v2), 1);
            v2 = v2 + 1;
        };
        assert!(0x2::tx_context::sender(arg2) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::creator(arg1), 2);
    }

    entry fun seal_approve_submit(arg0: vector<u8>, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg1);
        let v1 = 0x2::bcs::to_bytes<address>(&v0);
        assert!(0x1::vector::length<u8>(&arg0) >= 0x1::vector::length<u8>(&v1), 1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v1)) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v2) == *0x1::vector::borrow<u8>(&v1, v2), 1);
            v2 = v2 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

