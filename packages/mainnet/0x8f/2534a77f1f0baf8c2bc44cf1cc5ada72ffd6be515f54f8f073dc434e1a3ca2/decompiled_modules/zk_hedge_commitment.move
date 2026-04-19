module 0x8f2534a77f1f0baf8c2bc44cf1cc5ada72ffd6be515f54f8f073dc434e1a3ca2::zk_hedge_commitment {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RelayerCap has store, key {
        id: 0x2::object::UID,
        relayer_address: address,
    }

    struct HedgeCommitment has store, key {
        id: 0x2::object::UID,
        commitment_hash: vector<u8>,
        nullifier: vector<u8>,
        stealth_address: address,
        timestamp: u64,
        settled: bool,
        merkle_root: vector<u8>,
        batch_id: 0x1::option::Option<u64>,
    }

    struct BatchCommitment has store, key {
        id: 0x2::object::UID,
        batch_id: u64,
        commitment_ids: vector<0x2::object::ID>,
        batch_root: vector<u8>,
        timestamp: u64,
        aggregated: bool,
    }

    struct ZKHedgeCommitmentState has key {
        id: 0x2::object::UID,
        total_commitments: u64,
        total_settled: u64,
        total_value_locked: u64,
        last_batch_time: u64,
        current_batch_id: u64,
        paused: bool,
        nullifier_used: 0x2::table::Table<vector<u8>, bool>,
        commitments: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        pending_commitments: vector<0x2::object::ID>,
        batches: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct CommitmentStored has copy, drop {
        commitment_id: 0x2::object::ID,
        commitment_hash: vector<u8>,
        stealth_address: address,
        nullifier: vector<u8>,
        timestamp: u64,
    }

    struct CommitmentBatched has copy, drop {
        batch_id: u64,
        batch_root: vector<u8>,
        commitment_count: u64,
        timestamp: u64,
    }

    struct HedgeSettled has copy, drop {
        commitment_hash: vector<u8>,
        nullifier: vector<u8>,
        success: bool,
        timestamp: u64,
    }

    struct BatchAggregated has copy, drop {
        batch_id: u64,
        commitments_aggregated: u64,
        timestamp: u64,
    }

    public entry fun aggregate_batch(arg0: &RelayerCap, arg1: &mut ZKHedgeCommitmentState, arg2: &mut BatchCommitment, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 6);
        assert!(!arg2.aggregated, 3);
        arg2.aggregated = true;
        let v0 = BatchAggregated{
            batch_id               : arg2.batch_id,
            commitments_aggregated : 0x1::vector::length<0x2::object::ID>(&arg2.commitment_ids),
            timestamp              : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BatchAggregated>(v0);
    }

    fun compute_batch_root(arg0: &vector<0x2::object::ID>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(0x1::vector::borrow<0x2::object::ID>(arg0, v1)));
            v1 = v1 + 1;
        };
        0x2::hash::keccak256(&v0)
    }

    public entry fun create_batch(arg0: &mut ZKHedgeCommitmentState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_batch_time + 3600000, 5);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg0.pending_commitments);
        if (v1 == 0) {
            return
        };
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        let v3 = if (v1 > 100) {
            100
        } else {
            v1
        };
        let v4 = 0;
        while (v4 < v3) {
            0x1::vector::push_back<0x2::object::ID>(&mut v2, 0x1::vector::remove<0x2::object::ID>(&mut arg0.pending_commitments, 0));
            v4 = v4 + 1;
        };
        let v5 = compute_batch_root(&v2);
        arg0.current_batch_id = arg0.current_batch_id + 1;
        let v6 = arg0.current_batch_id;
        let v7 = BatchCommitment{
            id             : 0x2::object::new(arg2),
            batch_id       : v6,
            commitment_ids : v2,
            batch_root     : v5,
            timestamp      : v0,
            aggregated     : false,
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.batches, v6, 0x2::object::id<BatchCommitment>(&v7));
        arg0.last_batch_time = v0;
        let v8 = CommitmentBatched{
            batch_id         : v6,
            batch_root       : v5,
            commitment_count : v3,
            timestamp        : v0,
        };
        0x2::event::emit<CommitmentBatched>(v8);
        0x2::transfer::share_object<BatchCommitment>(v7);
    }

    public fun get_batch_info(arg0: &BatchCommitment) : (u64, vector<u8>, u64, bool) {
        (arg0.batch_id, arg0.batch_root, arg0.timestamp, arg0.aggregated)
    }

    public fun get_commitment_info(arg0: &HedgeCommitment) : (vector<u8>, address, bool, u64) {
        (arg0.commitment_hash, arg0.stealth_address, arg0.settled, arg0.timestamp)
    }

    public fun get_pending_count(arg0: &ZKHedgeCommitmentState) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.pending_commitments)
    }

    public fun get_state_stats(arg0: &ZKHedgeCommitmentState) : (u64, u64, u64, u64) {
        (arg0.total_commitments, arg0.total_settled, arg0.total_value_locked, arg0.current_batch_id)
    }

    public entry fun grant_relayer_role(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RelayerCap{
            id              : 0x2::object::new(arg2),
            relayer_address : arg1,
        };
        0x2::transfer::transfer<RelayerCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = RelayerCap{
            id              : 0x2::object::new(arg0),
            relayer_address : v0,
        };
        0x2::transfer::transfer<RelayerCap>(v2, v0);
        let v3 = ZKHedgeCommitmentState{
            id                  : 0x2::object::new(arg0),
            total_commitments   : 0,
            total_settled       : 0,
            total_value_locked  : 0,
            last_batch_time     : 0,
            current_batch_id    : 0,
            paused              : false,
            nullifier_used      : 0x2::table::new<vector<u8>, bool>(arg0),
            commitments         : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
            pending_commitments : 0x1::vector::empty<0x2::object::ID>(),
            batches             : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<ZKHedgeCommitmentState>(v3);
    }

    public fun is_nullifier_used(arg0: &ZKHedgeCommitmentState, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.nullifier_used, arg1)
    }

    public fun is_paused(arg0: &ZKHedgeCommitmentState) : bool {
        arg0.paused
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut ZKHedgeCommitmentState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun settle_commitment(arg0: &RelayerCap, arg1: &mut ZKHedgeCommitmentState, arg2: &mut HedgeCommitment, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 6);
        assert!(!arg2.settled, 3);
        assert!(verify_settlement_proof(&arg3, &arg2.commitment_hash), 4);
        arg2.settled = true;
        arg1.total_settled = arg1.total_settled + 1;
        let v0 = HedgeSettled{
            commitment_hash : arg2.commitment_hash,
            nullifier       : arg2.nullifier,
            success         : true,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<HedgeSettled>(v0);
    }

    public entry fun store_commitment(arg0: &mut ZKHedgeCommitmentState, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.nullifier_used, arg2), 1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = HedgeCommitment{
            id              : 0x2::object::new(arg5),
            commitment_hash : arg1,
            nullifier       : arg2,
            stealth_address : v0,
            timestamp       : v1,
            settled         : false,
            merkle_root     : arg3,
            batch_id        : 0x1::option::none<u64>(),
        };
        let v3 = 0x2::object::id<HedgeCommitment>(&v2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.nullifier_used, arg2, true);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.commitments, arg1, v3);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pending_commitments, v3);
        arg0.total_commitments = arg0.total_commitments + 1;
        let v4 = CommitmentStored{
            commitment_id   : v3,
            commitment_hash : arg1,
            stealth_address : v0,
            nullifier       : arg2,
            timestamp       : v1,
        };
        0x2::event::emit<CommitmentStored>(v4);
        0x2::transfer::share_object<HedgeCommitment>(v2);
    }

    public entry fun update_tvl(arg0: &AdminCap, arg1: &mut ZKHedgeCommitmentState, arg2: u64) {
        arg1.total_value_locked = arg2;
    }

    fun verify_settlement_proof(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) < 64) {
            return false
        };
        0x1::vector::length<u8>(arg1) > 0
    }

    // decompiled from Move bytecode v7
}

