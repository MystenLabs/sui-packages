module 0x8f2534a77f1f0baf8c2bc44cf1cc5ada72ffd6be515f54f8f073dc434e1a3ca2::zk_verifier {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
        verifier_address: address,
    }

    struct ZKVerifierState has key {
        id: 0x2::object::UID,
        total_proofs_verified: u64,
        used_proofs: 0x2::table::Table<vector<u8>, bool>,
        paused: bool,
        proof_expiry_ms: u64,
    }

    struct ProofRecord has store, key {
        id: 0x2::object::UID,
        proof_hash: vector<u8>,
        commitment_hash: vector<u8>,
        verifier: address,
        verified_at: u64,
        portfolio_id: 0x1::option::Option<0x2::object::ID>,
        proof_type: 0x1::string::String,
        metadata: 0x1::string::String,
    }

    struct ZKCommitment has store, key {
        id: 0x2::object::UID,
        owner: address,
        commitment_hash: vector<u8>,
        strategy_type: 0x1::string::String,
        risk_level: u64,
        created_at: u64,
        executed: bool,
        executed_at: 0x1::option::Option<u64>,
    }

    struct ProofVerified has copy, drop {
        proof_hash: vector<u8>,
        commitment_hash: vector<u8>,
        verifier: address,
        proof_type: 0x1::string::String,
        timestamp: u64,
    }

    struct CommitmentCreated has copy, drop {
        commitment_id: 0x2::object::ID,
        owner: address,
        commitment_hash: vector<u8>,
        strategy_type: 0x1::string::String,
        risk_level: u64,
    }

    struct CommitmentExecuted has copy, drop {
        commitment_id: 0x2::object::ID,
        owner: address,
        executor: address,
        timestamp: u64,
    }

    struct ProofRejected has copy, drop {
        proof_hash: vector<u8>,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun create_commitment(arg0: &ZKVerifierState, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        assert!(arg3 <= 100, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::hash::keccak256(&arg1);
        let v2 = ZKCommitment{
            id              : 0x2::object::new(arg5),
            owner           : v0,
            commitment_hash : v1,
            strategy_type   : arg2,
            risk_level      : arg3,
            created_at      : 0x2::clock::timestamp_ms(arg4),
            executed        : false,
            executed_at     : 0x1::option::none<u64>(),
        };
        let v3 = CommitmentCreated{
            commitment_id   : 0x2::object::id<ZKCommitment>(&v2),
            owner           : v0,
            commitment_hash : v1,
            strategy_type   : v2.strategy_type,
            risk_level      : arg3,
        };
        0x2::event::emit<CommitmentCreated>(v3);
        0x2::transfer::transfer<ZKCommitment>(v2, v0);
    }

    public entry fun execute_commitment(arg0: &VerifierCap, arg1: &ZKVerifierState, arg2: &mut ZKCommitment, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 4);
        assert!(!arg2.executed, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::hash::keccak256(&arg3);
        assert!(0x1::vector::length<u8>(&v1) > 0, 1);
        arg2.executed = true;
        arg2.executed_at = 0x1::option::some<u64>(v0);
        let v2 = CommitmentExecuted{
            commitment_id : 0x2::object::id<ZKCommitment>(arg2),
            owner         : arg2.owner,
            executor      : 0x2::tx_context::sender(arg5),
            timestamp     : v0,
        };
        0x2::event::emit<CommitmentExecuted>(v2);
    }

    public fun get_commitment_info(arg0: &ZKCommitment) : (address, vector<u8>, bool) {
        (arg0.owner, arg0.commitment_hash, arg0.executed)
    }

    public fun get_proof_info(arg0: &ProofRecord) : (vector<u8>, address, u64) {
        (arg0.proof_hash, arg0.verifier, arg0.verified_at)
    }

    public fun get_total_proofs_verified(arg0: &ZKVerifierState) : u64 {
        arg0.total_proofs_verified
    }

    public entry fun grant_verifier_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = VerifierCap{
            id               : 0x2::object::new(arg2),
            verifier_address : arg1,
        };
        0x2::transfer::transfer<VerifierCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ZKVerifierState{
            id                    : 0x2::object::new(arg0),
            total_proofs_verified : 0,
            used_proofs           : 0x2::table::new<vector<u8>, bool>(arg0),
            paused                : false,
            proof_expiry_ms       : 86400000,
        };
        0x2::transfer::share_object<ZKVerifierState>(v1);
    }

    public fun is_paused(arg0: &ZKVerifierState) : bool {
        arg0.paused
    }

    public fun is_proof_used(arg0: &ZKVerifierState, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_proofs, arg1)
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut ZKVerifierState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_proof_expiry(arg0: &AdminCap, arg1: &mut ZKVerifierState, arg2: u64) {
        arg1.proof_expiry_ms = arg2;
    }

    public entry fun verify_proof(arg0: &mut ZKVerifierState, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x2::hash::keccak256(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_proofs, v2), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_proofs, v2, true);
        arg0.total_proofs_verified = arg0.total_proofs_verified + 1;
        let v3 = ProofRecord{
            id              : 0x2::object::new(arg6),
            proof_hash      : v2,
            commitment_hash : arg2,
            verifier        : v0,
            verified_at     : v1,
            portfolio_id    : 0x1::option::none<0x2::object::ID>(),
            proof_type      : arg3,
            metadata        : arg4,
        };
        let v4 = ProofVerified{
            proof_hash      : v2,
            commitment_hash : arg2,
            verifier        : v0,
            proof_type      : v3.proof_type,
            timestamp       : v1,
        };
        0x2::event::emit<ProofVerified>(v4);
        0x2::transfer::transfer<ProofRecord>(v3, v0);
    }

    public entry fun verify_proof_for_portfolio(arg0: &mut ZKVerifierState, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 4);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::hash::keccak256(&arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_proofs, v2), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_proofs, v2, true);
        arg0.total_proofs_verified = arg0.total_proofs_verified + 1;
        let v3 = ProofRecord{
            id              : 0x2::object::new(arg7),
            proof_hash      : v2,
            commitment_hash : arg2,
            verifier        : v0,
            verified_at     : v1,
            portfolio_id    : 0x1::option::some<0x2::object::ID>(arg3),
            proof_type      : arg4,
            metadata        : arg5,
        };
        let v4 = ProofVerified{
            proof_hash      : v2,
            commitment_hash : arg2,
            verifier        : v0,
            proof_type      : v3.proof_type,
            timestamp       : v1,
        };
        0x2::event::emit<ProofVerified>(v4);
        0x2::transfer::transfer<ProofRecord>(v3, v0);
    }

    // decompiled from Move bytecode v7
}

