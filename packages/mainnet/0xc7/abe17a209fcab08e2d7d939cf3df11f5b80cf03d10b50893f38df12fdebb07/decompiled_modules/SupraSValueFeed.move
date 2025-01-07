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

    struct MigrateVersionEvent has copy, drop {
        from_v: u64,
        to_v: u64,
    }

    public fun extract_price(arg0: &Price) : (u32, u128, u16, u128, u64) {
        (arg0.pair, arg0.value, arg0.decimal, arg0.timestamp, arg0.round)
    }

    public fun get_derived_price(arg0: &OracleHolder, arg1: u32, arg2: u32, arg3: u8) : (u128, u16, u64, u8) {
        assert!(arg0.version == 1, 2);
        assert!(arg1 != arg2, 5);
        assert!(arg3 <= 1, 6);
        let (v0, v1, _, v3) = get_price(arg0, arg1);
        let (v4, v5, _, v7) = get_price(arg0, arg2);
        let v8 = if (arg3 == 0) {
            let v9 = v1 + v5;
            if (v9 > 18) {
                (v0 as u256) * (v4 as u256) / 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, v9 - 18)
            } else {
                (v0 as u256) * (v4 as u256) * 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, 18 - v9)
            }
        } else {
            scale_price((v0 as u256), v1) * 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, 18) / scale_price((v4 as u256), v5)
        };
        let v10 = 0;
        let v11 = if (v3 > v7) {
            v10 = 2;
            v3 - v7
        } else if (v3 < v7) {
            v10 = 1;
            v7 - v3
        } else {
            0
        };
        ((v8 as u128), 18, v11, v10)
    }

    public(friend) fun get_oracle_holder_and_upsert_pair_data(arg0: &mut OracleHolder, arg1: u32, arg2: u128, arg3: u16, arg4: u128, arg5: u64) {
        let v0 = Entry{
            value     : arg2,
            decimal   : arg3,
            timestamp : arg4,
            round     : arg5,
        };
        upsert_pair_data(arg0, arg1, v0);
    }

    public fun get_price(arg0: &OracleHolder, arg1: u32) : (u128, u16, u128, u64) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::table::contains<u32, Entry>(&arg0.feeds, arg1), 1);
        let v0 = 0x2::table::borrow<u32, Entry>(&arg0.feeds, arg1);
        (v0.value, v0.decimal, v0.timestamp, v0.round)
    }

    public fun get_prices(arg0: &OracleHolder, arg1: vector<u32>) : vector<Price> {
        assert!(arg0.version == 1, 2);
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        let v1 = OracleHolder{
            id      : 0x2::object::new(arg0),
            version : 1,
            owner   : 0x2::object::id<OwnerCap>(&v0),
            feeds   : 0x2::table::new<u32, Entry>(arg0),
        };
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<OracleHolder>(v1);
    }

    public fun is_pair_exist(arg0: &OracleHolder, arg1: u32) : bool {
        0x2::table::contains<u32, Entry>(&arg0.feeds, arg1)
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut OracleHolder) {
        assert!(arg1.owner == 0x2::object::id<OwnerCap>(arg0), 4);
        assert!(arg1.version < 1, 3);
        let v0 = MigrateVersionEvent{
            from_v : arg1.version,
            to_v   : 1,
        };
        0x2::event::emit<MigrateVersionEvent>(v0);
        arg1.version = 1;
    }

    entry fun process_cluster(arg0: &0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::DkgState, arg1: &mut OracleHolder, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<vector<vector<u8>>>, arg7: vector<u64>, arg8: vector<vector<u8>>, arg9: vector<vector<vector<u8>>>, arg10: vector<vector<vector<u8>>>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<u8>, arg14: vector<vector<u8>>, arg15: vector<vector<u32>>, arg16: vector<vector<u128>>, arg17: vector<vector<u128>>, arg18: vector<vector<u16>>, arg19: vector<vector<u8>>, arg20: vector<u64>, arg21: vector<vector<u8>>, arg22: vector<u64>, arg23: vector<u64>, arg24: vector<u64>, arg25: vector<u64>, arg26: vector<u64>, arg27: vector<vector<u8>>, arg28: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        let v0 = 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::validate_then_get_cluster_info_list(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27);
        while (!0x1::vector::is_empty<0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::ClusterInfo>(&v0)) {
            update_price(arg1, 0x1::vector::pop_back<0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::ClusterInfo>(&mut v0));
        };
    }

    fun scale_price(arg0: u256, arg1: u16) : u256 {
        assert!(arg1 <= 18, 7);
        if (arg1 == 18) {
            arg0
        } else {
            arg0 * 0x1ee7b04f04ef049a6d711d0c0446d7b67b63c27c1397efa9536145085a4d1b7c::utils::calculate_power(10, 18 - arg1)
        }
    }

    fun update_price(arg0: &mut OracleHolder, arg1: 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::ClusterInfo) {
        let (v0, v1) = 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::cluster_info_split(&arg1);
        let (v2, v3, v4, v5) = 0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::coherent_cluster_split(v0);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        while (!0x1::vector::is_empty<u32>(&v9)) {
            let v10 = Entry{
                value     : 0x1::vector::pop_back<u128>(&mut v8),
                decimal   : 0x1::vector::pop_back<u16>(&mut v7),
                timestamp : 0x1::vector::pop_back<u128>(&mut v6),
                round     : v1,
            };
            upsert_pair_data(arg0, 0x1::vector::pop_back<u32>(&mut v9), v10);
        };
        let v11 = SCCProcessedEvent{hash: *0x3a75968d0951fc99e7b336b26088d0f6888efd691b9cf2ac61c3958cfaa6d41b::validator::oracle_ssc_processed_event(&arg1)};
        0x2::event::emit<SCCProcessedEvent>(v11);
    }

    fun upsert_pair_data(arg0: &mut OracleHolder, arg1: u32, arg2: Entry) {
        if (is_pair_exist(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<u32, Entry>(&mut arg0.feeds, arg1);
            if (v0.timestamp < arg2.timestamp) {
                *v0 = arg2;
            };
        } else {
            0x2::table::add<u32, Entry>(&mut arg0.feeds, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

