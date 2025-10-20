module 0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::reclaim {
    struct ReclaimManager<phantom T0> has store, key {
        id: 0x2::object::UID,
        witnesses: vector<vector<u8>>,
        witnesses_num_threshold: u8,
        commitments: 0x2::object_table::ObjectTable<0x2::object::ID, ProofCommitment>,
        identifier_hash_to_commitment: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        max_reveal_window: u64,
    }

    struct ClaimInfo has copy, drop, store {
        provider: 0x1::ascii::String,
        parameters: 0x1::ascii::String,
        context: 0x1::ascii::String,
    }

    struct ClaimData has copy, drop, store {
        identifier: 0x1::ascii::String,
        owner: 0x1::ascii::String,
        epoch: 0x1::ascii::String,
        timestamp_s: 0x1::ascii::String,
    }

    struct SignedClaim has copy, drop, store {
        claim: ClaimData,
        signatures: vector<vector<u8>>,
    }

    struct Proof<phantom T0> has key {
        id: 0x2::object::UID,
        claimed_at: u64,
        claim_info: ClaimInfo,
        signed_claim: SignedClaim,
    }

    struct ProofCommitment has store, key {
        id: 0x2::object::UID,
        commitment_hash: vector<u8>,
        committer: address,
        commit_timestamp: u64,
        identifier_hash: vector<u8>,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::Config, arg1: &mut 0x2::tx_context::TxContext) : ReclaimManager<T0> {
        ReclaimManager<T0>{
            id                            : 0x2::derived_object::claim<0x1::ascii::String>(0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::config_uid_mut(arg0), 0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::derived_object_key<T0>(0x1::ascii::string(b"reclaim"))),
            witnesses                     : vector[],
            witnesses_num_threshold       : 1,
            commitments                   : 0x2::object_table::new<0x2::object::ID, ProofCommitment>(arg1),
            identifier_hash_to_commitment : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg1),
            max_reveal_window             : 60000 * 10,
        }
    }

    public(friend) fun burn_proof<T0>(arg0: Proof<T0>) {
        let Proof {
            id           : v0,
            claimed_at   : _,
            claim_info   : _,
            signed_claim : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun byte_to_hex_char(arg0: u8) : u8 {
        if (arg0 < 10) {
            arg0 + 48
        } else {
            arg0 + 87
        }
    }

    public fun bytes_to_hex(arg0: &vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            0x1::vector::push_back<u8>(&mut v0, byte_to_hex_char(v2 >> 4 & 15));
            0x1::vector::push_back<u8>(&mut v0, byte_to_hex_char(v2 & 15));
            v1 = v1 + 1;
        };
        0x1::ascii::string(v0)
    }

    public fun claim_data(arg0: &SignedClaim) : &ClaimData {
        &arg0.claim
    }

    public fun cleanup_expired_commitments<T0>(arg0: &mut ReclaimManager<T0>, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: vector<0x2::object::ID>, arg3: &0x2::clock::Clock) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let ProofCommitment {
                id               : v1,
                commitment_hash  : _,
                committer        : _,
                commit_timestamp : v4,
                identifier_hash  : v5,
            } = 0x2::object_table::remove<0x2::object::ID, ProofCommitment>(&mut arg0.commitments, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2));
            0x2::object::delete(v1);
            assert!(0x2::clock::timestamp_ms(arg3) - v4 > arg0.max_reveal_window, 106);
            0x2::table::remove<vector<u8>, 0x2::object::ID>(&mut arg0.identifier_hash_to_commitment, v5);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg2);
    }

    entry fun commit_proof<T0>(arg0: &mut ReclaimManager<T0>, arg1: &0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::Config, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::assert_version(arg1);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.identifier_hash_to_commitment, arg3), 101);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ProofCommitment{
            id               : v0,
            commitment_hash  : arg2,
            committer        : 0x2::tx_context::sender(arg5),
            commit_timestamp : 0x2::clock::timestamp_ms(arg4),
            identifier_hash  : arg3,
        };
        0x2::object_table::add<0x2::object::ID, ProofCommitment>(&mut arg0.commitments, v1, v2);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.identifier_hash_to_commitment, arg3, v1);
        v1
    }

    fun compute_commitment_hash(arg0: &ClaimInfo, arg1: &SignedClaim, arg2: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<ClaimInfo>(arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<SignedClaim>(arg1));
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x2::hash::keccak256(&v0)
    }

    fun contains_duplicates(arg0: &vector<vector<u8>>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::table::new<vector<u8>, bool>(arg1);
        let v1 = 0;
        let v2 = false;
        while (v1 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(arg0, v1);
            if (0x2::table::contains<vector<u8>, bool>(&v0, *v3)) {
                v2 = true;
                break
            };
            0x2::table::add<vector<u8>, bool>(&mut v0, *v3, true);
            v1 = v1 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(arg0)) {
            let v5 = 0x1::vector::borrow<vector<u8>>(arg0, v4);
            if (0x2::table::contains<vector<u8>, bool>(&v0, *v5)) {
                0x2::table::remove<vector<u8>, bool>(&mut v0, *v5);
            };
            v4 = v4 + 1;
        };
        0x2::table::destroy_empty<vector<u8>, bool>(v0);
        v2
    }

    public fun context(arg0: &ClaimInfo) : 0x1::ascii::String {
        arg0.context
    }

    public(friend) fun derive_id<T0>(arg0: &mut ReclaimManager<T0>, arg1: 0x1::ascii::String) : 0x2::object::UID {
        0x2::derived_object::claim<0x1::ascii::String>(&mut arg0.id, arg1)
    }

    public fun epoch(arg0: &ClaimData) : 0x1::ascii::String {
        arg0.epoch
    }

    fun fetch_witnesses_for_claim<T0>(arg0: &ReclaimManager<T0>, arg1: 0x1::ascii::String) : vector<vector<u8>> {
        let v0 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&arg1));
        let v1 = arg0.witnesses;
        let v2 = vector[];
        let v3 = 0x1::vector::length<vector<u8>>(&v1);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::length<u8>(&v0);
        while (v5 < arg0.witnesses_num_threshold) {
            let v7 = 0;
            let v8 = 0;
            while (v8 < 4) {
                v7 = (*0x1::vector::borrow<u8>(&v0, (v4 + v8) % v6) as u64) << ((8 * v8) as u8);
                v8 = v8 + 1;
            };
            let v9 = v7 % v3;
            let v10 = v3 - 1;
            if (v9 != v10) {
                0x1::vector::swap<vector<u8>>(&mut v1, v9, v10);
            };
            0x1::vector::pop_back<vector<u8>>(&mut v1);
            0x1::vector::push_back<vector<u8>>(&mut v2, *0x1::vector::borrow<vector<u8>>(&v1, v9));
            let v11 = v4 + 4;
            v4 = v11 % v6;
            v3 = v3 - 1;
            v5 = v5 + 1;
        };
        v2
    }

    fun hash_claim_info(arg0: &ClaimInfo) : 0x1::ascii::String {
        let v0 = arg0.provider;
        0x1::ascii::append(&mut v0, 0x1::ascii::string(x"0a"));
        0x1::ascii::append(&mut v0, arg0.parameters);
        0x1::ascii::append(&mut v0, 0x1::ascii::string(x"0a"));
        0x1::ascii::append(&mut v0, arg0.context);
        let v1 = 0x2::hash::keccak256(0x1::ascii::as_bytes(&v0));
        bytes_to_hex(&v1)
    }

    public fun identifier(arg0: &ClaimData) : 0x1::ascii::String {
        arg0.identifier
    }

    public fun new_claim_data(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) : ClaimData {
        ClaimData{
            identifier  : arg0,
            owner       : arg1,
            epoch       : arg2,
            timestamp_s : arg3,
        }
    }

    public fun new_claim_info(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : ClaimInfo {
        ClaimInfo{
            provider   : arg0,
            parameters : arg1,
            context    : arg2,
        }
    }

    public fun new_signed_claim(arg0: ClaimData, arg1: vector<vector<u8>>) : SignedClaim {
        SignedClaim{
            claim      : arg0,
            signatures : arg1,
        }
    }

    public fun owner(arg0: &ClaimData) : 0x1::ascii::String {
        arg0.owner
    }

    public fun parameters(arg0: &ClaimInfo) : 0x1::ascii::String {
        arg0.parameters
    }

    public fun proof_claim_info<T0>(arg0: &Proof<T0>) : &ClaimInfo {
        &arg0.claim_info
    }

    public fun proof_claimed_at<T0>(arg0: &Proof<T0>) : u64 {
        arg0.claimed_at
    }

    public fun proof_signed_claim<T0>(arg0: &Proof<T0>) : &SignedClaim {
        &arg0.signed_claim
    }

    public fun provider(arg0: &ClaimInfo) : 0x1::ascii::String {
        arg0.provider
    }

    fun recover_signers_of_signed_claim(arg0: SignedClaim) : vector<vector<u8>> {
        let v0 = vector[];
        let v1 = 0x1::ascii::string(x"0a");
        let v2 = 0x1::ascii::string(b"");
        let v3 = arg0.claim.timestamp_s;
        0x1::ascii::append(&mut v3, v1);
        0x1::ascii::append(&mut v3, arg0.claim.epoch);
        0x1::ascii::append(&mut v2, arg0.claim.identifier);
        0x1::ascii::append(&mut v2, v1);
        0x1::ascii::append(&mut v2, arg0.claim.owner);
        0x1::ascii::append(&mut v2, v1);
        0x1::ascii::append(&mut v2, v3);
        let v4 = 0x1::ascii::string(x"19457468657265756d205369676e6564204d6573736167653a0a");
        0x1::ascii::append(&mut v4, 0x1::ascii::string(b"122"));
        0x1::ascii::append(&mut v4, v2);
        let v5 = 0x1::ascii::as_bytes(&v4);
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg0.signatures)) {
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::ecdsa::ecrecover_to_eth_address(*0x1::vector::borrow<vector<u8>>(&arg0.signatures, v6), *v5));
            v6 = v6 + 1;
        };
        v0
    }

    public fun reveal_and_verify_proof<T0>(arg0: &mut ReclaimManager<T0>, arg1: &0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::Config, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: vector<vector<u8>>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (vector<vector<u8>>, Proof<T0>) {
        0x487468663117d16a643a19933933edac717776e78c72c74aa2b012f821444422::config::assert_version(arg1);
        let v0 = new_claim_info(arg3, arg4, arg5);
        let v1 = new_signed_claim(new_claim_data(arg6, arg7, arg8, arg9), arg10);
        let ProofCommitment {
            id               : v2,
            commitment_hash  : v3,
            committer        : v4,
            commit_timestamp : v5,
            identifier_hash  : v6,
        } = 0x2::object_table::remove<0x2::object::ID, ProofCommitment>(&mut arg0.commitments, arg2);
        0x2::object::delete(v2);
        assert!(v4 == 0x2::tx_context::sender(arg13), 102);
        assert!(0x2::clock::timestamp_ms(arg12) - v5 <= arg0.max_reveal_window, 103);
        assert!(compute_commitment_hash(&v0, &v1, &arg11) == v3, 104);
        assert!(0x2::hash::keccak256(0x1::ascii::as_bytes(&v1.claim.identifier)) == v6, 105);
        let v7 = verify_proof_internal<T0>(arg0, &v0, &v1, arg13);
        let v8 = Proof<T0>{
            id           : 0x2::object::new(arg13),
            claimed_at   : 0x2::clock::timestamp_ms(arg12),
            claim_info   : v0,
            signed_claim : v1,
        };
        0x2::table::remove<vector<u8>, 0x2::object::ID>(&mut arg0.identifier_hash_to_commitment, v6);
        (v7, v8)
    }

    public fun signatures(arg0: &SignedClaim) : vector<vector<u8>> {
        arg0.signatures
    }

    public fun timestamp_s(arg0: &ClaimData) : 0x1::ascii::String {
        arg0.timestamp_s
    }

    public fun update_max_reveal_window<T0>(arg0: &mut ReclaimManager<T0>, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u64) {
        arg0.max_reveal_window = arg2;
    }

    public fun update_witnesses<T0>(arg0: &mut ReclaimManager<T0>, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: vector<vector<u8>>) {
        arg0.witnesses = arg2;
    }

    public fun update_witnesses_num_threshold<T0>(arg0: &mut ReclaimManager<T0>, arg1: &0x8787e686e2fc7f1584106ed63aeec769f3f3216576fbcac500b8e507baa5079e::admin::AdminCap, arg2: u8) {
        arg0.witnesses_num_threshold = arg2;
    }

    fun verify_proof_internal<T0>(arg0: &ReclaimManager<T0>, arg1: &ClaimInfo, arg2: &SignedClaim, arg3: &mut 0x2::tx_context::TxContext) : vector<vector<u8>> {
        assert!(0x1::vector::length<vector<u8>>(&arg2.signatures) > 0, 0);
        assert!(hash_claim_info(arg1) == 0x1::ascii::substring(&arg2.claim.identifier, 2, 0x1::ascii::length(&arg2.claim.identifier)), 1);
        let v0 = fetch_witnesses_for_claim<T0>(arg0, arg2.claim.identifier);
        let v1 = recover_signers_of_signed_claim(*arg2);
        assert!(!contains_duplicates(&v1, arg3), 0);
        assert!(0x1::vector::length<vector<u8>>(&v1) == 0x1::vector::length<vector<u8>>(&v0), 0);
        let v2 = 0x2::vec_map::empty<vector<u8>, bool>();
        0x1::vector::reverse<vector<u8>>(&mut v0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&v0)) {
            0x2::vec_map::insert<vector<u8>, bool>(&mut v2, 0x1::vector::pop_back<vector<u8>>(&mut v0), true);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v0);
        0x1::vector::reverse<vector<u8>>(&mut v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(&v1)) {
            let v5 = 0x1::vector::pop_back<vector<u8>>(&mut v1);
            let (_, _) = 0x2::vec_map::remove<vector<u8>, bool>(&mut v2, &v5);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        0x2::vec_map::destroy_empty<vector<u8>, bool>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

