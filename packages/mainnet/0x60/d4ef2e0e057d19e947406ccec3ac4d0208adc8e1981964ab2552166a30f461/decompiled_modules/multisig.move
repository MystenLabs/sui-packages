module 0x60d4ef2e0e057d19e947406ccec3ac4d0208adc8e1981964ab2552166a30f461::multisig {
    struct UpdateSignerEvent has copy, drop {
        dvn: address,
        signer: vector<u8>,
        active: bool,
    }

    struct UpdateQuorumEvent has copy, drop {
        dvn: address,
        quorum: u64,
    }

    struct MultiSig has store {
        signers: 0x2::vec_set::VecSet<vector<u8>>,
        quorum: u64,
    }

    fun decompress_pubkey(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::decompress_pubkey(&arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2 + 1));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun assert_signatures_verified(arg0: &MultiSig, arg1: vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg2) % 65 == 0, 2);
        assert!(0x1::vector::length<u8>(arg2) / 65 >= arg0.quorum, 5);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < arg0.quorum) {
            let v2 = b"";
            let v3 = 0;
            while (v3 < 65) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg2, v1 * 65 + v3));
                v3 = v3 + 1;
            };
            let v4 = decompress_pubkey(0x2::ecdsa_k1::secp256k1_ecrecover(&v2, &arg1, 0));
            assert!(!0x1::vector::contains<vector<u8>>(&v0, &v4), 1);
            assert!(0x2::vec_set::contains<vector<u8>>(&arg0.signers, &v4), 8);
            0x1::vector::push_back<vector<u8>>(&mut v0, v4);
            v1 = v1 + 1;
        };
    }

    public(friend) fun get_signers(arg0: &MultiSig) : vector<vector<u8>> {
        0x2::vec_set::into_keys<vector<u8>>(arg0.signers)
    }

    public(friend) fun is_signer(arg0: &MultiSig, arg1: vector<u8>) : bool {
        0x2::vec_set::contains<vector<u8>>(&arg0.signers, &arg1)
    }

    public(friend) fun new(arg0: vector<vector<u8>>, arg1: u64) : MultiSig {
        assert!(arg1 > 0, 4);
        assert!(arg1 <= 0x1::vector::length<vector<u8>>(&arg0), 9);
        let v0 = 0x2::vec_set::empty<vector<u8>>();
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v2 = 0x1::vector::pop_back<vector<u8>>(&mut arg0);
            assert!(0x1::vector::length<u8>(&v2) == 64, 3);
            0x2::vec_set::insert<vector<u8>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg0);
        MultiSig{
            signers : v0,
            quorum  : arg1,
        }
    }

    public(friend) fun quorum(arg0: &MultiSig) : u64 {
        arg0.quorum
    }

    public(friend) fun set_quorum(arg0: &mut MultiSig, arg1: address, arg2: u64) {
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 0x2::vec_set::size<vector<u8>>(&arg0.signers), 9);
        arg0.quorum = arg2;
        let v0 = UpdateQuorumEvent{
            dvn    : arg1,
            quorum : arg2,
        };
        0x2::event::emit<UpdateQuorumEvent>(v0);
    }

    public(friend) fun set_signer(arg0: &mut MultiSig, arg1: address, arg2: vector<u8>, arg3: bool) {
        assert!(0x1::vector::length<u8>(&arg2) == 64, 3);
        if (arg3) {
            assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.signers, &arg2), 6);
            0x2::vec_set::insert<vector<u8>>(&mut arg0.signers, arg2);
        } else {
            assert!(0x2::vec_set::contains<vector<u8>>(&arg0.signers, &arg2), 7);
            0x2::vec_set::remove<vector<u8>>(&mut arg0.signers, &arg2);
        };
        assert!(0x2::vec_set::size<vector<u8>>(&arg0.signers) >= arg0.quorum, 9);
        let v0 = UpdateSignerEvent{
            dvn    : arg1,
            signer : arg2,
            active : arg3,
        };
        0x2::event::emit<UpdateSignerEvent>(v0);
    }

    public(friend) fun signer_count(arg0: &MultiSig) : u64 {
        0x2::vec_set::size<vector<u8>>(&arg0.signers)
    }

    // decompiled from Move bytecode v6
}

