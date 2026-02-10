module 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier {
    struct MerkleRoot has drop, store {
        content_id: vector<u8>,
        root_hash: vector<u8>,
        leaf_count: u64,
        threshold: u64,
    }

    struct VoteProofRoot has drop, store {
        proposal_id: vector<u8>,
        root_hash: vector<u8>,
        voter_count: u64,
        quorum: u64,
    }

    public fun create_merkle_root(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64) : MerkleRoot {
        assert!(arg3 <= arg2, 1);
        MerkleRoot{
            content_id : arg0,
            root_hash  : arg1,
            leaf_count : arg2,
            threshold  : arg3,
        }
    }

    public fun create_vote_proof_root(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64) : VoteProofRoot {
        assert!(arg3 <= arg2, 1);
        VoteProofRoot{
            proposal_id : arg0,
            root_hash   : arg1,
            voter_count : arg2,
            quorum      : arg3,
        }
    }

    public fun get_content_id(arg0: &MerkleRoot) : &vector<u8> {
        &arg0.content_id
    }

    public fun get_leaf_count(arg0: &MerkleRoot) : u64 {
        arg0.leaf_count
    }

    public fun get_quorum(arg0: &VoteProofRoot) : u64 {
        arg0.quorum
    }

    public fun get_root_hash(arg0: &MerkleRoot) : &vector<u8> {
        &arg0.root_hash
    }

    public fun get_threshold(arg0: &MerkleRoot) : u64 {
        arg0.threshold
    }

    public fun get_vote_proposal_id(arg0: &VoteProofRoot) : &vector<u8> {
        &arg0.proposal_id
    }

    public fun get_vote_root_hash(arg0: &VoteProofRoot) : &vector<u8> {
        &arg0.root_hash
    }

    public fun get_voter_count(arg0: &VoteProofRoot) : u64 {
        arg0.voter_count
    }

    public fun verify_batch_ad_views(arg0: &MerkleRoot, arg1: vector<vector<u8>>, arg2: vector<vector<vector<u8>>>, arg3: vector<vector<u8>>) : bool {
        if (arg0.leaf_count < arg0.threshold) {
            return false
        };
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        if (v0 > 100) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<vector<vector<u8>>>(&arg2, v1);
            if (0x1::vector::length<vector<u8>>(&v2) > 40) {
                return false
            };
            if (!verify_merkle_inclusion(*0x1::vector::borrow<vector<u8>>(&arg1, v1), v2, *0x1::vector::borrow<vector<u8>>(&arg3, v1), arg0.root_hash)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun verify_batch_votes(arg0: &VoteProofRoot, arg1: vector<vector<u8>>, arg2: vector<vector<vector<u8>>>, arg3: vector<vector<u8>>) : bool {
        if (arg0.voter_count < arg0.quorum) {
            return false
        };
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        if (v0 > 100) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<vector<vector<u8>>>(&arg2, v1);
            if (0x1::vector::length<vector<u8>>(&v2) > 40) {
                return false
            };
            if (!verify_merkle_inclusion(*0x1::vector::borrow<vector<u8>>(&arg1, v1), v2, *0x1::vector::borrow<vector<u8>>(&arg3, v1), arg0.root_hash)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun verify_merkle_inclusion(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        let v1 = 0x1::vector::length<u8>(&arg2);
        let v2 = if (v0 == 0) {
            true
        } else if (v1 == 0) {
            true
        } else {
            v0 != v1
        };
        if (v2) {
            return false
        };
        let v3 = 0x2::hash::keccak256(&arg0);
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::empty<u8>();
            if (*0x1::vector::borrow<u8>(&arg2, v4) == 0) {
                0x1::vector::append<u8>(&mut v5, v3);
                0x1::vector::append<u8>(&mut v5, *0x1::vector::borrow<vector<u8>>(&arg1, v4));
            } else {
                0x1::vector::append<u8>(&mut v5, *0x1::vector::borrow<vector<u8>>(&arg1, v4));
                0x1::vector::append<u8>(&mut v5, v3);
            };
            v3 = 0x2::hash::keccak256(&v5);
            v4 = v4 + 1;
        };
        if (0x1::vector::length<u8>(&v3) != 0x1::vector::length<u8>(&arg3)) {
            return false
        };
        let v6 = 0;
        while (v6 < 0x1::vector::length<u8>(&v3)) {
            if (*0x1::vector::borrow<u8>(&v3, v6) != *0x1::vector::borrow<u8>(&arg3, v6)) {
                return false
            };
            v6 = v6 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

