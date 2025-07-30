module 0xca2c790042a6b6a6b0ab160945f2950d2438b3562b86cd68ee172719abab0f70::meme_airdrop_tracker {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        default_threshold: u64,
        default_airdrop_ratio: u64,
    }

    struct MemeStats has store, key {
        id: 0x2::object::UID,
        meme_address: 0x1::string::String,
        chain_id: 0x1::string::String,
        meme_name: 0x1::string::String,
        total_purchases: u64,
        total_airdrop_rounds: u64,
        threshold: u64,
        airdrop_ratio: u64,
    }

    struct PurchaseRecord has store {
        product_id: 0x1::string::String,
        design_id: 0x1::string::String,
        amount: u64,
        buyer_address: 0x1::string::String,
        timestamp: u64,
    }

    struct MemeStatsTable has key {
        id: 0x2::object::UID,
        stats: 0x2::table::Table<0x1::string::String, MemeStats>,
    }

    struct PurchaseRecordsTable has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<0x1::string::String, vector<PurchaseRecord>>,
    }

    public fun add_purchase_record(arg0: &mut MemeStatsTable, arg1: &mut PurchaseRecordsTable, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (bool, u64, u64) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg2);
        0x1::string::append(&mut v0, arg3);
        let v1 = PurchaseRecord{
            product_id    : arg5,
            design_id     : arg6,
            amount        : arg7,
            buyer_address : arg8,
            timestamp     : arg9,
        };
        if (0x2::table::contains<0x1::string::String, vector<PurchaseRecord>>(&arg1.records, v0)) {
            0x1::vector::push_back<PurchaseRecord>(0x2::table::borrow_mut<0x1::string::String, vector<PurchaseRecord>>(&mut arg1.records, v0), v1);
        } else {
            let v2 = 0x1::vector::empty<PurchaseRecord>();
            0x1::vector::push_back<PurchaseRecord>(&mut v2, v1);
            0x2::table::add<0x1::string::String, vector<PurchaseRecord>>(&mut arg1.records, v0, v2);
        };
        if (!0x2::table::contains<0x1::string::String, MemeStats>(&arg0.stats, v0)) {
            let v3 = MemeStats{
                id                   : 0x2::object::new(arg10),
                meme_address         : arg2,
                chain_id             : arg3,
                meme_name            : arg4,
                total_purchases      : 0,
                total_airdrop_rounds : 0,
                threshold            : 10000000000,
                airdrop_ratio        : 20,
            };
            0x2::table::add<0x1::string::String, MemeStats>(&mut arg0.stats, v0, v3);
        };
        if (0x2::table::contains<0x1::string::String, MemeStats>(&arg0.stats, v0)) {
            let v7 = 0x2::table::borrow_mut<0x1::string::String, MemeStats>(&mut arg0.stats, v0);
            v7.total_purchases = v7.total_purchases + arg7;
            let v8 = v7.threshold;
            let v9 = v7.total_purchases / v8;
            let v10 = v9 - v7.total_airdrop_rounds;
            v7.total_airdrop_rounds = v9;
            let v11 = if (v10 > 0) {
                v8 * v7.airdrop_ratio / 100 * v10
            } else {
                0
            };
            (v10 > 0, v10, v11)
        } else {
            (false, 0, 0)
        }
    }

    public fun get_meme_stats(arg0: &MemeStatsTable, arg1: 0x1::string::String, arg2: 0x1::string::String) : (0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, arg2);
        assert!(0x2::table::contains<0x1::string::String, MemeStats>(&arg0.stats, v0), 2);
        let v1 = 0x2::table::borrow<0x1::string::String, MemeStats>(&arg0.stats, v0);
        let v2 = v1.threshold;
        let v3 = v1.total_purchases / v2 - v1.total_airdrop_rounds;
        let v4 = if (v3 > 0) {
            v2 * v1.airdrop_ratio / 100 * v3
        } else {
            0
        };
        (v1.meme_name, v1.meme_address, v1.total_purchases, v1.total_airdrop_rounds, v1.threshold, v1.airdrop_ratio, v3, v4)
    }

    public fun get_purchase_records_count(arg0: &PurchaseRecordsTable, arg1: 0x1::string::String, arg2: 0x1::string::String) : u64 {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, arg2);
        if (0x2::table::contains<0x1::string::String, vector<PurchaseRecord>>(&arg0.records, v0)) {
            0x1::vector::length<PurchaseRecord>(0x2::table::borrow<0x1::string::String, vector<PurchaseRecord>>(&arg0.records, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            default_threshold     : 10000000000,
            default_airdrop_ratio : 20,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
        let v2 = MemeStatsTable{
            id    : 0x2::object::new(arg0),
            stats : 0x2::table::new<0x1::string::String, MemeStats>(arg0),
        };
        0x2::transfer::share_object<MemeStatsTable>(v2);
        let v3 = PurchaseRecordsTable{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<0x1::string::String, vector<PurchaseRecord>>(arg0),
        };
        0x2::transfer::share_object<PurchaseRecordsTable>(v3);
    }

    public fun set_default_airdrop_ratio(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 100, 1);
        arg1.default_airdrop_ratio = arg2;
    }

    public fun set_default_threshold(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0, 0);
        arg1.default_threshold = arg2;
    }

    // decompiled from Move bytecode v6
}

