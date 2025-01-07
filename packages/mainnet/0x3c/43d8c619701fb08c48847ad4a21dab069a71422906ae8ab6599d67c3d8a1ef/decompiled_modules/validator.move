module 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct UpdatePublicKeyEvent has copy, drop {
        public_key: vector<u8>,
    }

    struct DkgState has store, key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        is_set: bool,
    }

    struct ClusterInfo has drop {
        cc: CoherentCluster,
        round: u64,
        cluster_hashes: vector<vector<u8>>,
        cluster_idx: u64,
    }

    struct SignedCoherentCluster has drop {
        cc: CoherentCluster,
        qc: vector<u8>,
        round: u64,
        origin: Origin,
    }

    struct Origin has drop {
        id: vector<u8>,
        member_index: u64,
        committee_index: u64,
    }

    struct CoherentCluster has drop {
        data_hash: vector<u8>,
        pair: vector<u32>,
        prices: vector<u128>,
        timestamp: vector<u128>,
        decimals: vector<u16>,
    }

    struct MinTxn has drop {
        cluster_hashes: vector<vector<u8>>,
        sender: vector<u8>,
        protocol: vector<u8>,
        tx_sub_type: u8,
    }

    struct MinBatch has drop {
        protocol: vector<u8>,
        txn_hashes: vector<vector<u8>>,
    }

    struct Vote has drop {
        smr_block: MinBlock,
        round: u64,
    }

    struct MinBlock has drop {
        round: vector<u8>,
        timestamp: vector<u8>,
        author: vector<u8>,
        qc_hash: vector<u8>,
        batch_hashes: vector<vector<u8>>,
    }

    fun batch_verification(arg0: &MinBatch, arg1: &vector<vector<u8>>, arg2: u64) : bool {
        let v0 = hash_min_batch(arg0);
        0x1::vector::borrow<vector<u8>>(arg1, arg2) == &v0
    }

    public fun cluster_info_split(arg0: &ClusterInfo) : (&CoherentCluster, u64) {
        (&arg0.cc, arg0.round)
    }

    public fun coherent_cluster_split(arg0: &CoherentCluster) : (vector<u32>, vector<u128>, vector<u16>, vector<u128>) {
        (arg0.pair, arg0.prices, arg0.decimals, arg0.timestamp)
    }

    entry fun disable_public_key(arg0: &mut OwnerCap, arg1: &mut DkgState, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.public_key = b"";
        arg1.is_set = false;
        let v0 = UpdatePublicKeyEvent{public_key: b""};
        0x2::event::emit<UpdatePublicKeyEvent>(v0);
    }

    public fun get_public_key(arg0: &DkgState) : vector<u8> {
        assert!(arg0.is_set, 16);
        arg0.public_key
    }

    fun hash_min_batch(arg0: &MinBatch) : vector<u8> {
        let v0 = b"";
        0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::vector_flatten_concat<u8>(&mut v0, arg0.txn_hashes);
        let v1 = arg0.protocol;
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        0x2::hash::keccak256(&v1)
    }

    fun hash_min_txn(arg0: &MinTxn) : vector<u8> {
        let v0 = b"";
        0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::vector_flatten_concat<u8>(&mut v0, arg0.cluster_hashes);
        0x1::vector::append<u8>(&mut v0, arg0.sender);
        0x1::vector::append<u8>(&mut v0, arg0.protocol);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, arg0.tx_sub_type);
        0x1::vector::append<u8>(&mut v0, v1);
        0x2::hash::keccak256(&v0)
    }

    fun hash_scc(arg0: &SignedCoherentCluster) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<SignedCoherentCluster>(arg0);
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DkgState{
            id         : 0x2::object::new(arg0),
            public_key : b"",
            is_set     : false,
        };
        0x2::transfer::share_object<DkgState>(v1);
    }

    public fun oracle_ssc_processed_event(arg0: &ClusterInfo) : &vector<u8> {
        0x1::vector::borrow<vector<u8>>(&arg0.cluster_hashes, arg0.cluster_idx)
    }

    fun scc_verification(arg0: &SignedCoherentCluster, arg1: &vector<vector<u8>>, arg2: u64) : bool {
        let v0 = hash_scc(arg0);
        0x1::vector::borrow<vector<u8>>(arg1, arg2) == &v0
    }

    fun smr_hash_vote(arg0: &Vote) : vector<u8> {
        let v0 = b"";
        0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::vector_flatten_concat<u8>(&mut v0, arg0.smr_block.batch_hashes);
        let v1 = arg0.smr_block.round;
        0x1::vector::append<u8>(&mut v1, arg0.smr_block.timestamp);
        0x1::vector::append<u8>(&mut v1, arg0.smr_block.author);
        0x1::vector::append<u8>(&mut v1, arg0.smr_block.qc_hash);
        0x1::vector::append<u8>(&mut v1, 0x2::hash::keccak256(&v0));
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = &mut v2;
        0x1::vector::append<u8>(v3, 0x1::bcs::to_bytes<u64>(&arg0.round));
        0x2::hash::keccak256(v3)
    }

    fun transaction_verification(arg0: &MinTxn, arg1: &vector<vector<u8>>, arg2: u64) : bool {
        let v0 = hash_min_txn(arg0);
        0x1::vector::borrow<vector<u8>>(arg1, arg2) == &v0
    }

    entry fun transfer_authority(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    entry fun update_public_key(arg0: &mut OwnerCap, arg1: &mut DkgState, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 96, 17);
        arg1.public_key = arg2;
        arg1.is_set = true;
        let v0 = UpdatePublicKeyEvent{public_key: arg2};
        0x2::event::emit<UpdatePublicKeyEvent>(v0);
    }

    public fun validate_then_get_cluster_info_list(arg0: &DkgState, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<vector<u8>>>, arg6: vector<u64>, arg7: vector<vector<u8>>, arg8: vector<vector<vector<u8>>>, arg9: vector<vector<vector<u8>>>, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: vector<u8>, arg13: vector<vector<u8>>, arg14: vector<vector<u32>>, arg15: vector<vector<u128>>, arg16: vector<vector<u128>>, arg17: vector<vector<u16>>, arg18: vector<vector<u8>>, arg19: vector<u64>, arg20: vector<vector<u8>>, arg21: vector<u64>, arg22: vector<u64>, arg23: vector<u64>, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<vector<u8>>) : vector<ClusterInfo> {
        assert!(arg0.is_set, 16);
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg2), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg3), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg4), 11);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg5), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg6), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg7), 11);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg8), 11);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg9), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg10), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg11), 11);
        assert!(v0 == 0x1::vector::length<u8>(&arg12), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg13), 11);
        assert!(v0 == 0x1::vector::length<vector<u32>>(&arg14), 11);
        assert!(v0 == 0x1::vector::length<vector<u128>>(&arg15), 11);
        assert!(v0 == 0x1::vector::length<vector<u128>>(&arg16), 11);
        assert!(v0 == 0x1::vector::length<vector<u16>>(&arg17), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg18), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg19), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg20), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg21), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg22), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg23), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg24), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg25), 11);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg26), 11);
        let v1 = 0x1::vector::empty<ClusterInfo>();
        while (!0x1::vector::is_empty<vector<u8>>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg6);
            let v3 = MinBlock{
                round        : 0x1::vector::pop_back<vector<u8>>(&mut arg1),
                timestamp    : 0x1::vector::pop_back<vector<u8>>(&mut arg2),
                author       : 0x1::vector::pop_back<vector<u8>>(&mut arg3),
                qc_hash      : 0x1::vector::pop_back<vector<u8>>(&mut arg4),
                batch_hashes : 0x1::vector::pop_back<vector<vector<u8>>>(&mut arg5),
            };
            let v4 = Vote{
                smr_block : v3,
                round     : v2,
            };
            assert!(vote_verification(arg0.public_key, &v4, 0x1::vector::pop_back<vector<u8>>(&mut arg26)), 12);
            let v5 = MinBatch{
                protocol   : 0x1::vector::pop_back<vector<u8>>(&mut arg7),
                txn_hashes : 0x1::vector::pop_back<vector<vector<u8>>>(&mut arg8),
            };
            assert!(batch_verification(&v5, &v4.smr_block.batch_hashes, 0x1::vector::pop_back<u64>(&mut arg23)), 13);
            let v6 = MinTxn{
                cluster_hashes : 0x1::vector::pop_back<vector<vector<u8>>>(&mut arg9),
                sender         : 0x1::vector::pop_back<vector<u8>>(&mut arg10),
                protocol       : 0x1::vector::pop_back<vector<u8>>(&mut arg11),
                tx_sub_type    : 0x1::vector::pop_back<u8>(&mut arg12),
            };
            assert!(transaction_verification(&v6, &v5.txn_hashes, 0x1::vector::pop_back<u64>(&mut arg24)), 14);
            let v7 = 0x1::vector::pop_back<vector<u8>>(&mut arg13);
            let v8 = 0x1::vector::pop_back<vector<u32>>(&mut arg14);
            let v9 = 0x1::vector::pop_back<vector<u128>>(&mut arg15);
            let v10 = 0x1::vector::pop_back<vector<u128>>(&mut arg16);
            let v11 = 0x1::vector::pop_back<vector<u16>>(&mut arg17);
            let v12 = 0x1::vector::pop_back<u64>(&mut arg25);
            let v13 = CoherentCluster{
                data_hash : v7,
                pair      : v8,
                prices    : v9,
                timestamp : v10,
                decimals  : v11,
            };
            let v14 = Origin{
                id              : 0x1::vector::pop_back<vector<u8>>(&mut arg20),
                member_index    : 0x1::vector::pop_back<u64>(&mut arg21),
                committee_index : 0x1::vector::pop_back<u64>(&mut arg22),
            };
            let v15 = SignedCoherentCluster{
                cc     : v13,
                qc     : 0x1::vector::pop_back<vector<u8>>(&mut arg18),
                round  : 0x1::vector::pop_back<u64>(&mut arg19),
                origin : v14,
            };
            assert!(scc_verification(&v15, &v6.cluster_hashes, v12), 15);
            let v16 = CoherentCluster{
                data_hash : v7,
                pair      : v8,
                prices    : v9,
                timestamp : v10,
                decimals  : v11,
            };
            let v17 = ClusterInfo{
                cc             : v16,
                round          : v2,
                cluster_hashes : v6.cluster_hashes,
                cluster_idx    : v12,
            };
            0x1::vector::push_back<ClusterInfo>(&mut v1, v17);
        };
        v1
    }

    fun verify_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        0x2::bls12381::bls12381_min_sig_verify(&arg2, &arg0, &arg1)
    }

    fun vote_verification(arg0: vector<u8>, arg1: &Vote, arg2: vector<u8>) : bool {
        verify_signature(arg0, smr_hash_vote(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

