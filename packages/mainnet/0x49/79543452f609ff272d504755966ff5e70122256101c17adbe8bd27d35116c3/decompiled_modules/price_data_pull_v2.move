module 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::price_data_pull_v2 {
    struct PriceData has copy, drop {
        pair_index: u32,
        value: u128,
        timestamp: u64,
        decimal: u16,
        round: u64,
    }

    struct CommitteeFeedWithProof has drop {
        committee_feed: PriceData,
        proof: vector<vector<u8>>,
    }

    struct PriceDetailsWithCommittee has drop {
        committee_id: u64,
        root: vector<u8>,
        sig: vector<u8>,
        committee_data: vector<CommitteeFeedWithProof>,
    }

    struct OracleProofV2 has drop {
        data: vector<PriceDetailsWithCommittee>,
    }

    struct MerkleRootHash has store, key {
        id: 0x2::object::UID,
        version: u64,
        root_hashes: 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::enumerable_set_ring::EnnumerableSetRing<vector<u8>>,
    }

    struct CommitteeFeedWithMultileafProof has drop {
        committee_feeds: vector<PriceData>,
        proofs: vector<vector<u8>>,
        flags: vector<bool>,
    }

    struct PriceDetailsWithCommitteeData has drop {
        committee_id: u64,
        root: vector<u8>,
        sig: vector<u8>,
        committee_data: CommitteeFeedWithMultileafProof,
    }

    struct OracleProof has drop {
        data: vector<PriceDetailsWithCommitteeData>,
    }

    fun create_merkle_root_hash(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MerkleRootHash{
            id          : 0x2::object::new(arg0),
            version     : 1,
            root_hashes : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::enumerable_set_ring::new<vector<u8>>(500, arg0),
        };
        0x2::transfer::share_object<MerkleRootHash>(v0);
    }

    fun decode_bytes_to_oracle_proof(arg0: vector<u8>) : OracleProof {
        let v0 = 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::new(arg0);
        let v1 = 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_vec_length(&mut v0);
        let v2 = 0x1::vector::empty<PriceDetailsWithCommitteeData>();
        while (v1 > 0) {
            let v3 = 0x1::vector::empty<PriceData>();
            let v4 = 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_vec_length(&mut v0);
            while (v4 > 0) {
                let v5 = PriceData{
                    pair_index : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_u32(&mut v0),
                    value      : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_u128(&mut v0),
                    timestamp  : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_u64(&mut v0),
                    decimal    : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_u16(&mut v0),
                    round      : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_u64(&mut v0),
                };
                0x1::vector::push_back<PriceData>(&mut v3, v5);
                v4 = v4 - 1;
            };
            let v6 = 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_vec_vec_u8(&mut v0);
            let v7 = vector[];
            let v8 = 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_vec_length(&mut v0);
            while (v8 > 0) {
                0x1::vector::push_back<bool>(&mut v7, 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_bool(&mut v0));
                v8 = v8 - 1;
            };
            0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::ensure_multileaf_merkle_proof_lengths<PriceData>(v6, v7, v3);
            let v9 = CommitteeFeedWithMultileafProof{
                committee_feeds : v3,
                proofs          : v6,
                flags           : v7,
            };
            let v10 = PriceDetailsWithCommitteeData{
                committee_id   : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_u64(&mut v0),
                root           : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_vec_u8(&mut v0),
                sig            : 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::peel_vec_u8(&mut v0),
                committee_data : v9,
            };
            0x1::vector::push_back<PriceDetailsWithCommitteeData>(&mut v2, v10);
            v1 = v1 - 1;
        };
        OracleProof{data: v2}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_merkle_root_hash(arg0);
    }

    public fun merkle_root_hashes_length(arg0: &MerkleRootHash) : u64 {
        0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::enumerable_set_ring::length<vector<u8>>(&arg0.root_hashes)
    }

    entry fun migrate(arg0: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        create_merkle_root_hash(arg1);
    }

    public fun price_data_split(arg0: &PriceData) : (u32, u128, u64, u16, u64) {
        (arg0.pair_index, arg0.value, arg0.timestamp, arg0.decimal, arg0.round)
    }

    public fun verify_oracle_proof(arg0: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator_v2::DkgState, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &mut MerkleRootHash, arg3: &0x2::clock::Clock, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : vector<PriceData> {
        0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::oracle_holder_version_check(arg1);
        verify_oracle_proof_and_update_data(arg0, arg1, arg2, arg3, decode_bytes_to_oracle_proof(arg4))
    }

    fun verify_oracle_proof_and_update_data(arg0: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator_v2::DkgState, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &mut MerkleRootHash, arg3: &0x2::clock::Clock, arg4: OracleProof) : vector<PriceData> {
        let v0 = 0;
        while (0x1::vector::length<PriceDetailsWithCommitteeData>(&arg4.data) > v0) {
            let v1 = 0x1::vector::borrow<PriceDetailsWithCommitteeData>(&arg4.data, v0);
            if (!0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::enumerable_set_ring::contains<vector<u8>>(&arg2.root_hashes, v1.root)) {
                assert!(0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator_v2::committee_sign_verification(arg0, v1.committee_id, v1.root, v1.sig), 11);
                0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::enumerable_set_ring::add<vector<u8>>(&mut arg2.root_hashes, v1.root);
            };
            v0 = v0 + 1;
        };
        let v2 = 0x1::vector::empty<PriceData>();
        while (!0x1::vector::is_empty<PriceDetailsWithCommitteeData>(&arg4.data)) {
            let v3 = 0x1::vector::pop_back<PriceDetailsWithCommitteeData>(&mut arg4.data);
            let v4 = 0;
            let v5 = vector[];
            while (v4 < 0x1::vector::length<PriceData>(&v3.committee_data.committee_feeds)) {
                let v6 = 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::bcs::to_bytes<PriceData>(0x1::vector::borrow<PriceData>(&v3.committee_data.committee_feeds, v4));
                0x1::vector::push_back<vector<u8>>(&mut v5, 0x2::hash::keccak256(&v6));
                v4 = v4 + 1;
            };
            assert!(0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::is_valid_multileaf_merkle_proof(v3.committee_data.proofs, v3.committee_data.flags, v5, v3.root), 12);
            while (!0x1::vector::is_empty<PriceData>(&v3.committee_data.committee_feeds)) {
                let v7 = 0x1::vector::pop_back<PriceData>(&mut v3.committee_data.committee_feeds);
                0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_oracle_holder_and_upsert_pair_data_v2(arg1, arg3, v7.pair_index, v7.value, v7.decimal, (v7.timestamp as u128), v7.round);
                let v8 = v7.pair_index;
                let (v9, v10, v11, v12) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg1, v8);
                let v13 = PriceData{
                    pair_index : v8,
                    value      : v9,
                    timestamp  : (v11 as u64),
                    decimal    : v10,
                    round      : v12,
                };
                0x1::vector::push_back<PriceData>(&mut v2, v13);
            };
        };
        v2
    }

    entry fun verify_oracle_proof_push(arg0: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator_v2::DkgState, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &mut MerkleRootHash, arg3: &0x2::clock::Clock, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<vector<u32>>, arg8: vector<vector<u128>>, arg9: vector<vector<u64>>, arg10: vector<vector<u16>>, arg11: vector<vector<u64>>, arg12: vector<vector<vector<u8>>>, arg13: vector<vector<bool>>, arg14: &mut 0x2::tx_context::TxContext) {
        0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::oracle_holder_version_check(arg1);
        let v0 = 0x1::vector::length<u64>(&arg4);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg5), 13);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg6), 13);
        assert!(v0 == 0x1::vector::length<vector<u32>>(&arg7), 13);
        assert!(v0 == 0x1::vector::length<vector<u128>>(&arg8), 13);
        assert!(v0 == 0x1::vector::length<vector<u64>>(&arg9), 13);
        assert!(v0 == 0x1::vector::length<vector<u16>>(&arg10), 13);
        assert!(v0 == 0x1::vector::length<vector<u64>>(&arg11), 13);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg12), 13);
        assert!(v0 == 0x1::vector::length<vector<bool>>(&arg13), 13);
        let v1 = 0x1::vector::empty<PriceDetailsWithCommitteeData>();
        while (!0x1::vector::is_empty<u64>(&arg4)) {
            let v2 = 0x1::vector::pop_back<vector<u32>>(&mut arg7);
            let v3 = 0x1::vector::pop_back<vector<u128>>(&mut arg8);
            let v4 = 0x1::vector::pop_back<vector<u64>>(&mut arg9);
            let v5 = 0x1::vector::pop_back<vector<u16>>(&mut arg10);
            let v6 = 0x1::vector::pop_back<vector<u64>>(&mut arg11);
            let v7 = 0x1::vector::pop_back<vector<vector<u8>>>(&mut arg12);
            let v8 = 0x1::vector::pop_back<vector<bool>>(&mut arg13);
            let v9 = 0x1::vector::length<u32>(&v2);
            assert!(v9 == 0x1::vector::length<u128>(&v3), 13);
            assert!(v9 == 0x1::vector::length<u64>(&v4), 13);
            assert!(v9 == 0x1::vector::length<u16>(&v5), 13);
            assert!(v9 == 0x1::vector::length<u64>(&v6), 13);
            let v10 = 0x1::vector::empty<PriceData>();
            while (!0x1::vector::is_empty<u32>(&v2)) {
                let v11 = PriceData{
                    pair_index : 0x1::vector::pop_back<u32>(&mut v2),
                    value      : 0x1::vector::pop_back<u128>(&mut v3),
                    timestamp  : 0x1::vector::pop_back<u64>(&mut v4),
                    decimal    : 0x1::vector::pop_back<u16>(&mut v5),
                    round      : 0x1::vector::pop_back<u64>(&mut v6),
                };
                0x1::vector::push_back<PriceData>(&mut v10, v11);
            };
            0x1::vector::reverse<PriceData>(&mut v10);
            0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::ensure_multileaf_merkle_proof_lengths<PriceData>(v7, v8, v10);
            let v12 = CommitteeFeedWithMultileafProof{
                committee_feeds : v10,
                proofs          : v7,
                flags           : v8,
            };
            let v13 = PriceDetailsWithCommitteeData{
                committee_id   : 0x1::vector::pop_back<u64>(&mut arg4),
                root           : 0x1::vector::pop_back<vector<u8>>(&mut arg5),
                sig            : 0x1::vector::pop_back<vector<u8>>(&mut arg6),
                committee_data : v12,
            };
            0x1::vector::push_back<PriceDetailsWithCommitteeData>(&mut v1, v13);
        };
        let v14 = OracleProof{data: v1};
        verify_oracle_proof_and_update_data(arg0, arg1, arg2, arg3, v14);
    }

    // decompiled from Move bytecode v6
}

