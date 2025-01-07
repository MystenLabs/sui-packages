module 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct DkgState has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
    }

    struct OracleHolder has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: 0x2::object::ID,
        feeds: 0x2::table::Table<u32, Entry>,
    }

    struct Entry has copy, drop, store {
        value: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    struct MinBlock has drop {
        round: vector<u8>,
        timestamp: vector<u8>,
        author: vector<u8>,
        qc_hash: vector<u8>,
        batch_hashes: vector<vector<u8>>,
    }

    struct Vote has drop {
        smr_block: MinBlock,
        round: u64,
    }

    struct MinBatch has drop {
        protocol: vector<u8>,
        txn_hashes: vector<vector<u8>>,
    }

    struct MinTxn has drop {
        cluster_hashes: vector<vector<u8>>,
        sender: vector<u8>,
        protocol: vector<u8>,
        tx_sub_type: u8,
    }

    struct SignedCoherentCluster has drop {
        cc: CoherentCluster,
        qc: vector<u8>,
        round: u64,
        origin: Origin,
    }

    struct CoherentCluster has copy, drop {
        data_hash: vector<u8>,
        pair: vector<u32>,
        prices: vector<u128>,
        timestamp: vector<u128>,
        decimals: vector<u16>,
    }

    struct Origin has drop {
        id: vector<u8>,
        member_index: u64,
        committee_index: u64,
    }

    struct Price has drop {
        pair: u32,
        value: u128,
        decimal: u16,
        timestamp: u128,
        round: u64,
    }

    struct SCCProcessedEvent has copy, drop {
        hash: vector<u8>,
    }

    entry fun add_public_key(arg0: &mut OwnerCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        create_dkg_state(arg1, arg2);
    }

    fun batch_verification(arg0: &MinBatch, arg1: &vector<vector<u8>>, arg2: u64) : bool {
        let v0 = hash_min_batch(arg0);
        0x1::vector::borrow<vector<u8>>(arg1, arg2) == &v0
    }

    fun create_dkg_state(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DkgState{
            id         : 0x2::object::new(arg1),
            public_key : arg0,
        };
        0x2::transfer::freeze_object<DkgState>(v0);
    }

    fun create_oracle_holder(arg0: &mut 0x2::tx_context::TxContext, arg1: &OwnerCap) {
        let v0 = OracleHolder{
            id      : 0x2::object::new(arg0),
            version : 1,
            owner   : 0x2::object::id<OwnerCap>(arg1),
            feeds   : 0x2::table::new<u32, Entry>(arg0),
        };
        0x2::transfer::share_object<OracleHolder>(v0);
    }

    fun create_owner(arg0: OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OwnerCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun extract_price(arg0: &Price) : (u32, u128, u16, u128, u64) {
        (arg0.pair, arg0.value, arg0.decimal, arg0.timestamp, arg0.round)
    }

    public fun get_price(arg0: &OracleHolder, arg1: u32) : (u128, u16, u128, u64) {
        assert!(arg0.version == 1, 21);
        if (!0x2::table::contains<u32, Entry>(&arg0.feeds, arg1)) {
            abort 11
        };
        let v0 = 0x2::table::borrow<u32, Entry>(&arg0.feeds, arg1);
        (v0.value, v0.decimal, v0.timestamp, v0.round)
    }

    public fun get_prices(arg0: &OracleHolder, arg1: vector<u32>) : vector<Price> {
        assert!(arg0.version == 1, 21);
        let v0 = 0;
        let v1 = 0x1::vector::empty<Price>();
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            let v2 = 0x1::vector::borrow<u32>(&arg1, v0);
            v0 = v0 + 1;
            if (!0x2::table::contains<u32, Entry>(&arg0.feeds, *v2)) {
                continue
            };
            let v3 = 0x2::table::borrow<u32, Entry>(&arg0.feeds, *v2);
            let v4 = Price{
                pair      : *v2,
                value     : v3.value,
                decimal   : v3.decimal,
                timestamp : v3.timestamp,
                round     : v3.round,
            };
            0x1::vector::push_back<Price>(&mut v1, v4);
        };
        v1
    }

    fun hash_min_batch(arg0: &MinBatch) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        vector_flatten_concate<u8>(v1, arg0.txn_hashes);
        let v2 = arg0.protocol;
        0x1::vector::append<u8>(&mut v2, 0x2::hash::keccak256(&v0));
        0x2::hash::keccak256(&v2)
    }

    fun hash_min_txn(arg0: &MinTxn) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        vector_flatten_concate<u8>(v1, arg0.cluster_hashes);
        0x1::vector::append<u8>(&mut v0, arg0.sender);
        0x1::vector::append<u8>(&mut v0, arg0.protocol);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, arg0.tx_sub_type);
        0x1::vector::append<u8>(&mut v0, v2);
        0x2::hash::keccak256(&v0)
    }

    fun hash_scc(arg0: &SignedCoherentCluster) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<SignedCoherentCluster>(arg0);
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        create_oracle_holder(arg0, &v0);
        create_owner(v0, arg0);
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut OracleHolder) {
        assert!(arg1.owner == 0x2::object::id<OwnerCap>(arg0), 41);
        assert!(arg1.version < 1, 31);
        arg1.version = 1;
    }

    fun new_min_batch(arg0: vector<u8>, arg1: vector<vector<u8>>) : MinBatch {
        MinBatch{
            protocol   : arg0,
            txn_hashes : arg1,
        }
    }

    fun new_min_txn(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) : MinTxn {
        MinTxn{
            cluster_hashes : arg0,
            sender         : arg1,
            protocol       : arg2,
            tx_sub_type    : arg3,
        }
    }

    fun new_scc(arg0: vector<u8>, arg1: vector<u32>, arg2: vector<u128>, arg3: vector<u128>, arg4: vector<u16>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: u64) : SignedCoherentCluster {
        let v0 = CoherentCluster{
            data_hash : arg0,
            pair      : arg1,
            prices    : arg2,
            timestamp : arg3,
            decimals  : arg4,
        };
        let v1 = Origin{
            id              : arg7,
            member_index    : arg8,
            committee_index : arg9,
        };
        SignedCoherentCluster{
            cc     : v0,
            qc     : arg5,
            round  : arg6,
            origin : v1,
        }
    }

    fun new_vote(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: u64) : Vote {
        let v0 = MinBlock{
            round        : arg0,
            timestamp    : arg1,
            author       : arg2,
            qc_hash      : arg3,
            batch_hashes : arg4,
        };
        Vote{
            smr_block : v0,
            round     : arg5,
        }
    }

    entry fun process_cluster(arg0: &DkgState, arg1: &mut OracleHolder, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<vector<u8>>>, arg7: vector<u64>, arg8: vector<vector<u8>>, arg9: vector<vector<vector<u8>>>, arg10: vector<vector<vector<u8>>>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<u8>, arg14: vector<vector<u8>>, arg15: vector<vector<u32>>, arg16: vector<vector<u128>>, arg17: vector<vector<u128>>, arg18: vector<vector<u16>>, arg19: vector<vector<u8>>, arg20: vector<u64>, arg21: vector<vector<u8>>, arg22: vector<u64>, arg23: vector<u64>, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<vector<u8>>, arg28: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 21);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v1 = new_vote(*0x1::vector::borrow<vector<u8>>(&arg2, v0), *0x1::vector::borrow<vector<u8>>(&arg3, v0), *0x1::vector::borrow<vector<u8>>(&arg4, v0), *0x1::vector::borrow<vector<u8>>(&arg5, v0), *0x1::vector::borrow<vector<vector<u8>>>(&arg6, v0), *0x1::vector::borrow<u64>(&arg7, v0));
            let v2 = new_min_batch(*0x1::vector::borrow<vector<u8>>(&arg8, v0), *0x1::vector::borrow<vector<vector<u8>>>(&arg9, v0));
            let v3 = new_min_txn(*0x1::vector::borrow<vector<vector<u8>>>(&arg10, v0), *0x1::vector::borrow<vector<u8>>(&arg11, v0), *0x1::vector::borrow<vector<u8>>(&arg12, v0), *0x1::vector::borrow<u8>(&arg13, v0));
            let v4 = new_scc(*0x1::vector::borrow<vector<u8>>(&arg14, v0), *0x1::vector::borrow<vector<u32>>(&arg15, v0), *0x1::vector::borrow<vector<u128>>(&arg16, v0), *0x1::vector::borrow<vector<u128>>(&arg17, v0), *0x1::vector::borrow<vector<u16>>(&arg18, v0), *0x1::vector::borrow<vector<u8>>(&arg19, v0), *0x1::vector::borrow<u64>(&arg20, v0), *0x1::vector::borrow<vector<u8>>(&arg21, v0), *0x1::vector::borrow<u64>(&arg22, v0), *0x1::vector::borrow<u64>(&arg23, v0));
            let v5 = 0x1::vector::borrow<u64>(&arg24, v0);
            let v6 = 0x1::vector::borrow<u64>(&arg25, v0);
            let v7 = 0x1::vector::borrow<u64>(&arg26, v0);
            if (vote_verification(arg0.public_key, &v1, *0x1::vector::borrow<vector<u8>>(&arg27, v0)) == false) {
                continue
            };
            if (batch_verification(&v2, &v1.smr_block.batch_hashes, *v5) == false) {
                continue
            };
            if (transaction_verification(&v3, &v2.txn_hashes, *v6) == false) {
                continue
            };
            if (!scc_verification(&v4, &v3.cluster_hashes, *v7)) {
                continue
            };
            let v8 = SCCProcessedEvent{hash: *0x1::vector::borrow<vector<u8>>(&v3.cluster_hashes, *v7)};
            0x2::event::emit<SCCProcessedEvent>(v8);
            update_price(arg1, v4);
            v0 = v0 + 1;
        };
    }

    fun scc_verification(arg0: &SignedCoherentCluster, arg1: &vector<vector<u8>>, arg2: u64) : bool {
        let v0 = hash_scc(arg0);
        0x1::vector::borrow<vector<u8>>(arg1, arg2) == &v0
    }

    fun smr_hash_vote(arg0: &Vote) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        vector_flatten_concate<u8>(v1, arg0.smr_block.batch_hashes);
        let v2 = arg0.smr_block.round;
        0x1::vector::append<u8>(&mut v2, arg0.smr_block.timestamp);
        0x1::vector::append<u8>(&mut v2, arg0.smr_block.author);
        0x1::vector::append<u8>(&mut v2, arg0.smr_block.qc_hash);
        0x1::vector::append<u8>(&mut v2, 0x2::hash::keccak256(&mut v0));
        let v3 = 0x2::hash::keccak256(&v2);
        let v4 = &mut v3;
        0x1::vector::append<u8>(v4, 0x2::bcs::to_bytes<u64>(&arg0.round));
        0x2::hash::keccak256(v4)
    }

    fun transaction_verification(arg0: &MinTxn, arg1: &vector<vector<u8>>, arg2: u64) : bool {
        let v0 = hash_min_txn(arg0);
        0x1::vector::borrow<vector<u8>>(arg1, arg2) == &v0
    }

    fun update_price(arg0: &mut OracleHolder, arg1: SignedCoherentCluster) {
        let v0 = arg1.cc;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&v0.pair)) {
            let v2 = 0x1::vector::borrow<u32>(&v0.pair, v1);
            let v3 = *0x1::vector::borrow<u128>(&v0.timestamp, v1);
            let v4 = Entry{
                value     : *0x1::vector::borrow<u128>(&v0.prices, v1),
                decimal   : *0x1::vector::borrow<u16>(&v0.decimals, v1),
                timestamp : v3,
                round     : arg1.round,
            };
            if (0x2::table::contains<u32, Entry>(&arg0.feeds, *v2)) {
                let v5 = 0x2::table::borrow_mut<u32, Entry>(&mut arg0.feeds, *v2);
                if (v5.timestamp < v3) {
                    *v5 = v4;
                };
            } else {
                0x2::table::add<u32, Entry>(&mut arg0.feeds, *v2, v4);
            };
            v1 = v1 + 1;
        };
    }

    fun vector_flatten_concate<T0: copy + drop>(arg0: &mut vector<T0>, arg1: vector<vector<T0>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<T0>>(&arg1)) {
            0x1::vector::append<T0>(arg0, *0x1::vector::borrow<vector<T0>>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::bls12381::bls12381_min_sig_verify(&arg2, &arg0, &arg1)
    }

    fun vote_verification(arg0: vector<u8>, arg1: &Vote, arg2: vector<u8>) : bool {
        verify_signature(arg0, smr_hash_vote(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

