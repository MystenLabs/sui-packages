module 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee {
    struct BlsCommitteeMember has copy, drop, store {
        validator_id: 0x2::object::ID,
        protocol_pubkey: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>,
    }

    struct BlsCommittee has copy, drop, store {
        members: vector<BlsCommitteeMember>,
        aggregated_protocol_pubkey: 0x2::group_ops::Element<0x2::bls12381::G1>,
        quorum_threshold: u64,
        validity_threshold: u64,
    }

    struct CommitteeQuorumVerifiedEvent has copy, drop {
        epoch: u64,
        signer_count: u64,
    }

    public fun empty() : BlsCommittee {
        BlsCommittee{
            members                    : 0x1::vector::empty<BlsCommitteeMember>(),
            aggregated_protocol_pubkey : 0x2::bls12381::g1_identity(),
            quorum_threshold           : 0,
            validity_threshold         : 0,
        }
    }

    public fun contains(arg0: &BlsCommittee, arg1: &0x2::object::ID) : bool {
        let v0 = members(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<BlsCommitteeMember>(v0)) {
            let v3 = validator_id(0x1::vector::borrow<BlsCommitteeMember>(v0, v1));
            if (&v3 == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun is_quorum_threshold(arg0: &BlsCommittee, arg1: u64) : bool {
        arg1 >= arg0.quorum_threshold
    }

    public fun is_validity_threshold(arg0: &BlsCommittee, arg1: u64) : bool {
        arg1 >= arg0.validity_threshold
    }

    public fun members(arg0: &BlsCommittee) : &vector<BlsCommitteeMember> {
        &arg0.members
    }

    public fun new_bls_committee(arg0: vector<BlsCommitteeMember>) : BlsCommittee {
        let v0 = 0x1::vector::empty<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>();
        0x1::vector::reverse<BlsCommitteeMember>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<BlsCommitteeMember>(&arg0)) {
            let v2 = 0x1::vector::pop_back<BlsCommitteeMember>(&mut arg0);
            0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&mut v0, v2.protocol_pubkey);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<BlsCommitteeMember>(arg0);
        let v3 = 0x2::bls12381::uncompressed_g1_sum(&v0);
        BlsCommittee{
            members                    : arg0,
            aggregated_protocol_pubkey : 0x2::bls12381::uncompressed_g1_to_g1(&v3),
            quorum_threshold           : 2 * 0x1::vector::length<BlsCommitteeMember>(&arg0) / 3 + 1,
            validity_threshold         : 0x1::vector::length<BlsCommitteeMember>(&arg0) / 3 + 1,
        }
    }

    public fun new_bls_committee_member(arg0: 0x2::object::ID, arg1: 0x2::group_ops::Element<0x2::bls12381::UncompressedG1>) : BlsCommitteeMember {
        BlsCommitteeMember{
            validator_id    : arg0,
            protocol_pubkey : arg1,
        }
    }

    public fun quorum_threshold(arg0: &BlsCommittee) : u64 {
        arg0.quorum_threshold
    }

    public fun total_voting_power(arg0: &BlsCommittee) : u64 {
        0x1::vector::length<BlsCommitteeMember>(&arg0.members)
    }

    public fun validator_id(arg0: &BlsCommitteeMember) : 0x2::object::ID {
        arg0.validator_id
    }

    public fun validator_ids(arg0: &BlsCommittee) : vector<0x2::object::ID> {
        let v0 = members(arg0);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<BlsCommitteeMember>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, validator_id(0x1::vector::borrow<BlsCommitteeMember>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun validity_threshold(arg0: &BlsCommittee) : u64 {
        arg0.validity_threshold
    }

    public fun verify_certificate(arg0: &BlsCommittee, arg1: u64, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg2) == 96, 1);
        let v0 = &arg0.members;
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>();
        let v3 = 0;
        let v4 = 0x1::vector::length<BlsCommitteeMember>(v0);
        let v5 = 0x1::u64::divide_and_round_up(v4, 8);
        assert!(0x1::vector::length<u8>(arg3) == v5, 0);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = if (v6 < 0x1::vector::length<u8>(arg3)) {
                *0x1::vector::borrow<u8>(arg3, v6)
            } else {
                0
            };
            let v8 = 0;
            while (v8 < 8) {
                let v9 = v3 + (v8 as u64);
                if (v9 >= v4) {
                    assert!(!(v7 >> v8 & 1 == 1), 0);
                } else if (!(v7 >> v8 & 1 == 1)) {
                    v1 = v1 + 1;
                    0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::UncompressedG1>>(&mut v2, 0x1::vector::borrow<BlsCommitteeMember>(v0, v9).protocol_pubkey);
                };
                v8 = v8 + 1;
            };
            v3 = v3 + 8;
            v6 = v6 + 1;
        };
        let v10 = v4 - v1;
        assert!(is_quorum_threshold(arg0, v10), 3);
        let v11 = 0x2::bls12381::uncompressed_g1_sum(&v2);
        let v12 = 0x2::bls12381::uncompressed_g1_to_g1(&v11);
        let v13 = 0x2::bls12381::g1_sub(&arg0.aggregated_protocol_pubkey, &v12);
        assert!(0x2::bls12381::bls12381_min_pk_verify(arg2, 0x2::group_ops::bytes<0x2::bls12381::G1>(&v13), arg4), 2);
        let v14 = CommitteeQuorumVerifiedEvent{
            epoch        : arg1,
            signer_count : v10,
        };
        0x2::event::emit<CommitteeQuorumVerifiedEvent>(v14);
    }

    // decompiled from Move bytecode v6
}

