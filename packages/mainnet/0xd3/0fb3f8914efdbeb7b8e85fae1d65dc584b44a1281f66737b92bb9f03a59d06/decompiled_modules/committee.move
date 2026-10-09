module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee {
    struct CommitteeMember has copy, drop, store {
        validator_address: address,
        public_key: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>,
        encryption_public_key: vector<u8>,
        weight: u64,
        extra_fields: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config,
    }

    struct Committee has copy, drop, store {
        epoch: u64,
        members: vector<CommitteeMember>,
        total_weight: u64,
        epoch_config: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config,
    }

    struct CommitteeSignature has copy, drop, store {
        epoch: u64,
        signature: vector<u8>,
        signers_bitmap: vector<u8>,
    }

    struct CertifiedMessage<T0> has copy, drop, store {
        message: T0,
        signature: CommitteeSignature,
        stake_support: u64,
    }

    public(friend) fun cert_epoch<T0>(arg0: &CertifiedMessage<T0>) : u64 {
        arg0.signature.epoch
    }

    public(friend) fun cert_signature<T0>(arg0: &CertifiedMessage<T0>) : &CommitteeSignature {
        &arg0.signature
    }

    public(friend) fun epoch(arg0: &Committee) : u64 {
        arg0.epoch
    }

    public(friend) fun find_index(arg0: &Committee, arg1: &address) : 0x1::option::Option<u64> {
        let v0 = &arg0.members;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<CommitteeMember>(v0)) {
            if (&0x1::vector::borrow<CommitteeMember>(v0, v1).validator_address == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        v2
    }

    public(friend) fun get_idx(arg0: &Committee, arg1: u64) : &CommitteeMember {
        0x1::vector::borrow<CommitteeMember>(&arg0.members, arg1)
    }

    public(friend) fun get_member_weight(arg0: &Committee, arg1: &address) : u64 {
        let v0 = find_index(arg0, arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<u64>(0x1::vector::borrow<CommitteeMember>(&arg0.members, 0x1::option::destroy_some<u64>(v0)).weight)
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<u64>()
        };
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::destroy_some<u64>(v2)
        } else {
            0x1::option::destroy_none<u64>(v2);
            0
        }
    }

    public(friend) fun has_member(arg0: &Committee, arg1: &address) : bool {
        let v0 = find_index(arg0, arg1);
        0x1::option::is_some<u64>(&v0)
    }

    public(friend) fun into_message<T0>(arg0: CertifiedMessage<T0>) : T0 {
        let CertifiedMessage {
            message       : v0,
            signature     : _,
            stake_support : _,
        } = arg0;
        v0
    }

    public(friend) fun message<T0>(arg0: &CertifiedMessage<T0>) : &T0 {
        &arg0.message
    }

    public(friend) fun n_members(arg0: &Committee) : u64 {
        0x1::vector::length<CommitteeMember>(&arg0.members)
    }

    public(friend) fun new_committee(arg0: u64, arg1: vector<CommitteeMember>, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : Committee {
        assert!(!0x1::vector::is_empty<CommitteeMember>(&arg1), 13906834603840110591);
        let v0 = 0;
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<CommitteeMember>(v1)) {
            let v3 = 0x1::vector::borrow<CommitteeMember>(v1, v2).weight;
            assert!(v3 > 0, 13906834625315340295);
            v0 = v0 + v3;
            v2 = v2 + 1;
        };
        Committee{
            epoch        : arg0,
            members      : arg1,
            total_weight : v0,
            epoch_config : arg2,
        }
    }

    public(friend) fun new_committee_member(arg0: address, arg1: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>, arg2: vector<u8>, arg3: u64) : CommitteeMember {
        assert!(arg3 > 0, 13906834706919718919);
        CommitteeMember{
            validator_address     : arg0,
            public_key            : arg1,
            encryption_public_key : arg2,
            weight                : arg3,
            extra_fields          : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::empty(),
        }
    }

    entry fun new_committee_signature(arg0: u64, arg1: vector<u8>, arg2: vector<u8>) : CommitteeSignature {
        CommitteeSignature{
            epoch          : arg0,
            signature      : arg1,
            signers_bitmap : arg2,
        }
    }

    public(friend) fun signature_epoch(arg0: &CommitteeSignature) : u64 {
        arg0.epoch
    }

    public(friend) fun stake_support<T0>(arg0: &CertifiedMessage<T0>) : u64 {
        arg0.stake_support
    }

    public(friend) fun to_vec_map(arg0: &Committee) : 0x2::vec_map::VecMap<address, u64> {
        let v0 = 0x2::vec_map::empty<address, u64>();
        let v1 = &arg0.members;
        let v2 = 0;
        while (v2 < 0x1::vector::length<CommitteeMember>(v1)) {
            let v3 = 0x1::vector::borrow<CommitteeMember>(v1, v2);
            0x2::vec_map::insert<address, u64>(&mut v0, v3.validator_address, v3.weight);
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun total_weight(arg0: &Committee) : u64 {
        arg0.total_weight
    }

    public(friend) fun validator_address(arg0: &CommitteeMember) : address {
        arg0.validator_address
    }

    public(friend) fun verify_certificate<T0>(arg0: &Committee, arg1: address, arg2: u16, arg3: T0, arg4: CommitteeSignature, arg5: u64) : CertifiedMessage<T0> {
        assert!(arg4.epoch == epoch(arg0), 13906835033336840191);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>();
        let v2 = 0;
        let v3 = n_members(arg0);
        assert!(0x1::vector::length<u8>(&arg4.signers_bitmap) <= 0x1::u64::divide_and_round_up(v3, 8), 13906835076286513153);
        let v4 = arg4.signers_bitmap;
        0x1::vector::reverse<u8>(&mut v4);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&v4)) {
            let v6 = 0;
            while (v6 < 8) {
                let v7 = v2 + (v6 as u64);
                if (v7 >= v3) {
                    assert!(!(0x1::vector::pop_back<u8>(&mut v4) & 1 << 7 - v6 != 0), 13906835127826120705);
                } else if (0x1::vector::pop_back<u8>(&mut v4) & 1 << 7 - v6 != 0) {
                    let v8 = *0x1::vector::borrow<CommitteeMember>(&arg0.members, v7);
                    v0 = v0 + v8.weight;
                    0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&mut v1, v8.public_key);
                };
                v6 = v6 + 1;
            };
            v2 = v2 + 8;
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<u8>(v4);
        assert!(v0 >= arg5, 13906835187955924997);
        let v9 = 0x2::bls12381::uncompressed_g1_sum(&v1);
        let v10 = 0x2::bls12381::uncompressed_g1_to_g1(&v9);
        let v11 = 0x2::bcs::to_bytes<u16>(&arg2);
        0x1::vector::append<u8>(&mut v11, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v11, 0x2::bcs::to_bytes<u64>(&arg4.epoch));
        0x1::vector::append<u8>(&mut v11, 0x2::bcs::to_bytes<T0>(&arg3));
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg4.signature, 0x2::group_ops::bytes<0x2::bls12381::G1>(&v10), &v11), 13906835312509845507);
        CertifiedMessage<T0>{
            message       : arg3,
            signature     : arg4,
            stake_support : v0,
        }
    }

    // decompiled from Move bytecode v7
}

