module 0x3645f1572d1cadc6ba277b0262c0f57c81820b347c28c7d15c59a4ba0840163c::meme_airdrop_tracker {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        default_threshold: u64,
        default_airdrop_ratio: u64,
        is_paused: bool,
    }

    struct MemeStats has copy, drop, store {
        meme_address: 0x1::string::String,
        chain_id: 0x1::string::String,
        meme_name: 0x1::string::String,
        total_purchases: u64,
        total_purchase_count: u64,
        total_airdrop_rounds: u64,
        executed_airdrop_rounds: u64,
        total_claims: u64,
        total_claimed_amount: u64,
        threshold: u64,
        airdrop_ratio: u64,
        last_airdrop_time: u64,
    }

    struct PurchaseRecordAdded has copy, drop {
        meme_address: 0x1::string::String,
        chain_id: 0x1::string::String,
        meme_name: 0x1::string::String,
        product_id: 0x1::string::String,
        design_id: 0x1::string::String,
        amount: u64,
        buyer_address: 0x1::string::String,
        timestamp: u64,
    }

    struct AirdropExecuted has copy, drop {
        meme_address: 0x1::string::String,
        chain_id: 0x1::string::String,
        rounds_executed: u64,
        total_amount: u64,
        timestamp: u64,
    }

    struct AirdropClaimed has copy, drop {
        meme_address: 0x1::string::String,
        chain_id: 0x1::string::String,
        claimer: 0x1::string::String,
        amount: u64,
        timestamp: u64,
    }

    struct MemeStatsTable has key {
        id: 0x2::object::UID,
        stats: 0x2::bag::Bag,
    }

    public fun add_purchase_record(arg0: &GlobalConfig, arg1: &mut MemeStatsTable, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : (bool, u64, u64) {
        assert!(!arg0.is_paused, 5);
        assert!(arg7 > 0, 3);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg9);
        let v1 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v1, arg2);
        0x1::string::append(&mut v1, arg3);
        let v2 = PurchaseRecordAdded{
            meme_address  : arg2,
            chain_id      : arg3,
            meme_name     : arg4,
            product_id    : arg5,
            design_id     : arg6,
            amount        : arg7,
            buyer_address : arg8,
            timestamp     : v0,
        };
        0x2::event::emit<PurchaseRecordAdded>(v2);
        if (!0x2::bag::contains<0x1::string::String>(&arg1.stats, v1)) {
            let v3 = MemeStats{
                meme_address            : arg2,
                chain_id                : arg3,
                meme_name               : arg4,
                total_purchases         : 0,
                total_purchase_count    : 0,
                total_airdrop_rounds    : 0,
                executed_airdrop_rounds : 0,
                total_claims            : 0,
                total_claimed_amount    : 0,
                threshold               : 100000,
                airdrop_ratio           : 10,
                last_airdrop_time       : 0,
            };
            0x2::bag::add<0x1::string::String, MemeStats>(&mut arg1.stats, v1, v3);
        };
        let v4 = 0x2::bag::borrow_mut<0x1::string::String, MemeStats>(&mut arg1.stats, v1);
        v4.total_purchases = safe_add(v4.total_purchases, arg7);
        v4.total_purchase_count = safe_add(v4.total_purchase_count, 1);
        let v5 = v4.threshold;
        assert!(v5 > 0, 0);
        let v6 = v4.total_purchases / v5;
        let v7 = v6 - v4.executed_airdrop_rounds;
        if (v7 > 0) {
            v4.last_airdrop_time = v0;
        };
        v4.total_airdrop_rounds = v6;
        (v7 > 0, v7, calculate_airdrop_amount(v5, v4.airdrop_ratio, v7))
    }

    fun calculate_airdrop_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        safe_mul(arg0 * arg1 / 100, arg2)
    }

    public fun claim_airdrop(arg0: &mut MemeStatsTable, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, arg2);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.stats, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, MemeStats>(&mut arg0.stats, v0);
        v1.total_claims = safe_add(v1.total_claims, 1);
        v1.total_claimed_amount = safe_add(v1.total_claimed_amount, arg4);
        let v2 = AirdropClaimed{
            meme_address : v1.meme_address,
            chain_id     : v1.chain_id,
            claimer      : arg3,
            amount       : arg4,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<AirdropClaimed>(v2);
    }

    public fun execute_airdrop(arg0: &AdminCap, arg1: &GlobalConfig, arg2: &mut MemeStatsTable, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(!arg1.is_paused, 5);
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg3);
        0x1::string::append(&mut v0, arg4);
        assert!(0x2::bag::contains<0x1::string::String>(&arg2.stats, v0), 2);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, MemeStats>(&mut arg2.stats, v0);
        let v2 = v1.threshold;
        assert!(v2 > 0, 0);
        let v3 = v1.total_purchases / v2;
        let v4 = v3 - v1.executed_airdrop_rounds;
        let v5 = calculate_airdrop_amount(v2, v1.airdrop_ratio, v4);
        v1.executed_airdrop_rounds = v3;
        let v6 = AirdropExecuted{
            meme_address    : v1.meme_address,
            chain_id        : v1.chain_id,
            rounds_executed : v4,
            total_amount    : v5,
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<AirdropExecuted>(v6);
        (v4, v5)
    }

    public fun get_meme_last_airdrop_time(arg0: &MemeStatsTable, arg1: 0x1::string::String, arg2: 0x1::string::String) : u64 {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, arg2);
        if (0x2::bag::contains<0x1::string::String>(&arg0.stats, v0)) {
            0x2::bag::borrow<0x1::string::String, MemeStats>(&arg0.stats, v0).last_airdrop_time
        } else {
            0
        }
    }

    public fun get_meme_stats(arg0: &MemeStatsTable, arg1: 0x1::string::String, arg2: 0x1::string::String) : (0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, arg2);
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.stats, v0), 2);
        let v1 = 0x2::bag::borrow<0x1::string::String, MemeStats>(&arg0.stats, v0);
        let v2 = v1.total_purchases;
        let v3 = v1.threshold;
        assert!(v3 > 0, 0);
        let v4 = v1.executed_airdrop_rounds;
        let v5 = v2 / v3 - v4;
        let v6 = if (v4 > 0) {
            let v7 = v4 * v3;
            if (v2 > v7) {
                v2 - v7
            } else {
                0
            }
        } else {
            v2
        };
        (v1.meme_name, v1.meme_address, v1.total_purchases, v1.total_airdrop_rounds, v1.threshold, v1.airdrop_ratio, v5, calculate_airdrop_amount(v3, v1.airdrop_ratio, v5), v1.last_airdrop_time, v4, v6, v1.total_purchase_count, v1.total_claimed_amount)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            admin                 : 0x2::tx_context::sender(arg0),
            default_threshold     : 100000,
            default_airdrop_ratio : 10,
            is_paused             : false,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
        let v2 = MemeStatsTable{
            id    : 0x2::object::new(arg0),
            stats : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<MemeStatsTable>(v2);
    }

    public fun pause_contract(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.is_paused = true;
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 4);
        v0
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        assert!(v0 / arg0 == arg1, 4);
        v0
    }

    public fun set_default_airdrop_ratio(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 100, 1);
        arg1.default_airdrop_ratio = arg2;
    }

    public fun set_default_threshold(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > 0, 0);
        arg1.default_threshold = arg2;
    }

    public fun set_meme_threshold(arg0: &AdminCap, arg1: &GlobalConfig, arg2: &mut MemeStatsTable, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        assert!(!arg1.is_paused, 5);
        assert!(arg5 > 0, 0);
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg3);
        0x1::string::append(&mut v0, arg4);
        assert!(0x2::bag::contains<0x1::string::String>(&arg2.stats, v0), 2);
        0x2::bag::borrow_mut<0x1::string::String, MemeStats>(&mut arg2.stats, v0).threshold = arg5;
    }

    public fun unpause_contract(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.is_paused = false;
    }

    // decompiled from Move bytecode v6
}

