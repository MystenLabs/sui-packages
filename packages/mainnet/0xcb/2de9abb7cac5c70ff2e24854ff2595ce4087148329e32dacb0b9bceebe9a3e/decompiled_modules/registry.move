module 0xcb2de9abb7cac5c70ff2e24854ff2595ce4087148329e32dacb0b9bceebe9a3e::registry {
    struct Grant has store, key {
        id: 0x2::object::UID,
        sponsor: address,
        builder: address,
        metadata_hash: vector<u8>,
        creator: address,
        created_at_ms: u64,
    }

    struct MilestoneProof has store, key {
        id: 0x2::object::UID,
        grant_ref: vector<u8>,
        milestone_ref: vector<u8>,
        sponsor: address,
        submitter: address,
        proof_packet_blob_id: vector<u8>,
        proof_packet_hash: vector<u8>,
        status: u8,
        created_at_ms: u64,
    }

    struct Review has store, key {
        id: 0x2::object::UID,
        proof_ref: vector<u8>,
        reviewer: address,
        decision: u8,
        review_packet_blob_id: vector<u8>,
        review_packet_hash: vector<u8>,
        created_at_ms: u64,
    }

    struct GrantCreated has copy, drop {
        grant_id: 0x2::object::ID,
        sponsor: address,
        builder: address,
        creator: address,
        metadata_hash: vector<u8>,
        created_at_ms: u64,
    }

    struct ProofSubmitted has copy, drop {
        proof_id: 0x2::object::ID,
        grant_ref: vector<u8>,
        milestone_ref: vector<u8>,
        sponsor: address,
        submitter: address,
        proof_packet_blob_id: vector<u8>,
        proof_packet_hash: vector<u8>,
        status: u8,
        created_at_ms: u64,
    }

    struct ProofReviewed has copy, drop {
        review_id: 0x2::object::ID,
        proof_ref: vector<u8>,
        reviewer: address,
        decision: u8,
        review_packet_blob_id: vector<u8>,
        review_packet_hash: vector<u8>,
        created_at_ms: u64,
    }

    fun assert_not_empty(arg0: &vector<u8>, arg1: u64) {
        assert!(0x1::vector::length<u8>(arg0) > 0, arg1);
    }

    public entry fun create_grant(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_not_empty(&arg2, 2);
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = GrantCreated{
            grant_id      : 0x2::object::uid_to_inner(&v0),
            sponsor       : arg0,
            builder       : arg1,
            creator       : v1,
            metadata_hash : arg2,
            created_at_ms : arg3,
        };
        0x2::event::emit<GrantCreated>(v2);
        let v3 = Grant{
            id            : v0,
            sponsor       : arg0,
            builder       : arg1,
            metadata_hash : arg2,
            creator       : v1,
            created_at_ms : arg3,
        };
        0x2::transfer::public_transfer<Grant>(v3, v1);
    }

    fun is_valid_decision(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    public entry fun review_proof(arg0: vector<u8>, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_not_empty(&arg0, 7);
        assert_not_empty(&arg2, 8);
        assert_not_empty(&arg3, 9);
        assert!(is_valid_decision(arg1), 1);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = ProofReviewed{
            review_id             : 0x2::object::uid_to_inner(&v0),
            proof_ref             : arg0,
            reviewer              : v1,
            decision              : arg1,
            review_packet_blob_id : arg2,
            review_packet_hash    : arg3,
            created_at_ms         : arg4,
        };
        0x2::event::emit<ProofReviewed>(v2);
        let v3 = Review{
            id                    : v0,
            proof_ref             : arg0,
            reviewer              : v1,
            decision              : arg1,
            review_packet_blob_id : arg2,
            review_packet_hash    : arg3,
            created_at_ms         : arg4,
        };
        0x2::transfer::public_transfer<Review>(v3, v1);
    }

    public entry fun submit_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_not_empty(&arg0, 3);
        assert_not_empty(&arg1, 4);
        assert_not_empty(&arg3, 5);
        assert_not_empty(&arg4, 6);
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = ProofSubmitted{
            proof_id             : 0x2::object::uid_to_inner(&v0),
            grant_ref            : arg0,
            milestone_ref        : arg1,
            sponsor              : arg2,
            submitter            : v1,
            proof_packet_blob_id : arg3,
            proof_packet_hash    : arg4,
            status               : 1,
            created_at_ms        : arg5,
        };
        0x2::event::emit<ProofSubmitted>(v2);
        let v3 = MilestoneProof{
            id                   : v0,
            grant_ref            : arg0,
            milestone_ref        : arg1,
            sponsor              : arg2,
            submitter            : v1,
            proof_packet_blob_id : arg3,
            proof_packet_hash    : arg4,
            status               : 1,
            created_at_ms        : arg5,
        };
        0x2::transfer::public_transfer<MilestoneProof>(v3, v1);
    }

    // decompiled from Move bytecode v7
}

