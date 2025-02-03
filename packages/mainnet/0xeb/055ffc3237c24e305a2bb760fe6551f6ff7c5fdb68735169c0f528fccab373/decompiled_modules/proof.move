module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::proof {
    struct Signature has copy, drop, store {
        bytes: vector<u8>,
    }

    struct Proof has copy, drop, store {
        signers: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners,
        signatures: vector<Signature>,
    }

    fun find_weight_by_pub_key_from(arg0: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners, arg1: u64, arg2: &vector<u8>) : (u128, u64) {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::signers(arg0);
        let v1 = 0x1::vector::length<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(v0);
        let v2 = arg1;
        loop {
            let v3 = if (v2 < v1) {
                let v4 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::pub_key(0x1::vector::borrow<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(v0, v2));
                &v4 != arg2
            } else {
                false
            };
            if (v3) {
                v2 = v2 + 1;
            } else {
                break
            };
        };
        assert!(v2 < v1, 9223372599495819270);
        (0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::weight(0x1::vector::borrow<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signer::WeightedSigner>(v0, v2)), v2)
    }

    public(friend) fun new_signature(arg0: vector<u8>) : Signature {
        assert!(0x1::vector::length<u8>(&arg0) == 65, 9223372285962944514);
        Signature{bytes: arg0}
    }

    public(friend) fun peel(arg0: &mut 0x2::bcs::BCS) : Proof {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::peel(arg0);
        let v1 = 0x1::vector::empty<Signature>();
        let v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(arg0)) {
            0x1::vector::push_back<Signature>(&mut v1, peel_signature(arg0));
            v2 = v2 + 1;
        };
        Proof{
            signers    : v0,
            signatures : v1,
        }
    }

    public(friend) fun peel_signature(arg0: &mut 0x2::bcs::BCS) : Signature {
        new_signature(0x2::bcs::peel_vec_u8(arg0))
    }

    public(friend) fun recover_pub_key(arg0: &Signature, arg1: &vector<u8>) : vector<u8> {
        0x2::ecdsa_k1::secp256k1_ecrecover(&arg0.bytes, arg1, 0)
    }

    public(friend) fun signatures(arg0: &Proof) : &vector<Signature> {
        &arg0.signatures
    }

    public(friend) fun signers(arg0: &Proof) : &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::WeightedSigners {
        &arg0.signers
    }

    public(friend) fun validate(arg0: &Proof, arg1: vector<u8>) {
        let v0 = &arg0.signers;
        let v1 = &arg0.signatures;
        assert!(0x1::vector::length<Signature>(v1) != 0, 9223372384747323396);
        let v2 = 0x1::vector::length<Signature>(v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            let v6 = recover_pub_key(0x1::vector::borrow<Signature>(v1, v5), &arg1);
            let (v7, v8) = find_weight_by_pub_key_from(v0, v4, &v6);
            let v9 = v3 + v7;
            v3 = v9;
            if (v9 >= 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::weighted_signers::threshold(v0)) {
                assert!(v5 + 1 == v2, 9223372487826800648);
                return
            };
            v5 = v5 + 1;
            v4 = v8 + 1;
        };
        abort 9223372517891309572
    }

    // decompiled from Move bytecode v6
}

