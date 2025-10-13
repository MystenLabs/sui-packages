module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_proof_checker {
    struct ProofChecker has store {
        active_signer: 0x1::option::Option<vector<u8>>,
        used_proofs: 0x2::table::Table<vector<u8>, vector<u8>>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ProofChecker {
        ProofChecker{
            active_signer : 0x1::option::none<vector<u8>>(),
            used_proofs   : 0x2::table::new<vector<u8>, vector<u8>>(arg0),
        }
    }

    public(friend) fun assert_proof_not_used(arg0: &ProofChecker, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, vector<u8>>(&arg0.used_proofs, arg1), 1);
    }

    fun assert_valid_proof(arg0: &ProofChecker, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x2::ed25519::ed25519_verify(arg1, borrow_active_signer(arg0), arg2), 2);
    }

    public(friend) fun borrow_active_signer(arg0: &ProofChecker) : &vector<u8> {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.active_signer), 0);
        0x1::option::borrow<vector<u8>>(&arg0.active_signer)
    }

    public(friend) fun consume_proof(arg0: &mut ProofChecker, arg1: vector<u8>, arg2: vector<u8>) {
        assert_proof_not_used(arg0, arg1);
        assert_valid_proof(arg0, &arg1, &arg2);
        mark_proof_as_used(arg0, arg1);
    }

    fun mark_proof_as_used(arg0: &mut ProofChecker, arg1: vector<u8>) {
        assert!(0x1::option::is_some<vector<u8>>(&arg0.active_signer), 0);
        0x2::table::add<vector<u8>, vector<u8>>(&mut arg0.used_proofs, arg1, *0x1::option::borrow<vector<u8>>(&arg0.active_signer));
    }

    public(friend) fun set_active_signer(arg0: &mut ProofChecker, arg1: 0x1::option::Option<vector<u8>>) {
        arg0.active_signer = arg1;
    }

    // decompiled from Move bytecode v6
}

