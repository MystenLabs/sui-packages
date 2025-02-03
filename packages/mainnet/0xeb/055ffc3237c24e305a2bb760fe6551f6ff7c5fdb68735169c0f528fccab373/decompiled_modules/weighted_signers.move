module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers {
    struct WeightedSigners has copy, drop, store {
        signers: vector<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>,
        threshold: u128,
        nonce: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32,
    }

    public(friend) fun hash(arg0: &WeightedSigners) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32 {
        let v0 = 0x2::bcs::to_bytes<WeightedSigners>(arg0);
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun peel(arg0: &mut 0x2::bcs::BCS) : WeightedSigners {
        let v0 = 0x2::bcs::peel_vec_length(arg0);
        assert!(v0 > 0, 9223372191473598465);
        let v1 = 0x1::vector::empty<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>();
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(&mut v1, 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::peel(arg0));
            v2 = v2 + 1;
        };
        WeightedSigners{
            signers   : v1,
            threshold : 0x2::bcs::peel_u128(arg0),
            nonce     : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::peel(arg0),
        }
    }

    public(friend) fun validate(arg0: &WeightedSigners) {
        validate_signers(arg0);
        validate_threshold(arg0);
    }

    public(friend) fun nonce(arg0: &WeightedSigners) : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32 {
        arg0.nonce
    }

    public(friend) fun signers(arg0: &WeightedSigners) : &vector<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner> {
        &arg0.signers
    }

    public(friend) fun threshold(arg0: &WeightedSigners) : u128 {
        arg0.threshold
    }

    fun total_weight(arg0: &WeightedSigners) : u128 {
        let v0 = 0;
        let v1 = arg0.signers;
        0x1::vector::reverse<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(&mut v1);
        while (0x1::vector::length<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(&v1) != 0) {
            let v2 = 0x1::vector::pop_back<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(&mut v1);
            v0 = v0 + 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::weight(&v2);
        };
        0x1::vector::destroy_empty<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(v1);
        v0
    }

    fun validate_signers(arg0: &WeightedSigners) {
        assert!(!0x1::vector::is_empty<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(&arg0.signers), 9223372371862224897);
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::default();
        let v1 = &v0;
        let v2 = &arg0.signers;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(v2)) {
            v1 = 0x1::vector::borrow<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(v2, v3);
            0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::validate(v1);
            assert!(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::lt(v1, v1), 9223372389042356229);
            v3 = v3 + 1;
        };
    }

    fun validate_threshold(arg0: &WeightedSigners) {
        assert!(arg0.threshold != 0 && total_weight(arg0) >= arg0.threshold, 9223372470646603779);
    }

    // decompiled from Move bytecode v6
}

