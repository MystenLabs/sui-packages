module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::miner {
    struct MinerRoundRegistry has key {
        id: 0x2::object::UID,
    }

    struct MinerRoundKey has copy, drop, store {
        miner: address,
        round_id: u64,
    }

    struct MinerStats has key {
        id: 0x2::object::UID,
        miner: address,
        total_shares: u64,
        blocks_found: u64,
        registered_at_ms: u64,
        btc_payout_address: vector<u8>,
    }

    struct MinerRoundStats has store, key {
        id: 0x2::object::UID,
        round_id: u64,
        miner: address,
        work: u128,
        shares: u64,
        sold_work: u128,
        sold_shares: u64,
        min_height: u64,
    }

    struct MinerRegistered has copy, drop {
        miner: address,
        timestamp_ms: u64,
    }

    public fun blocks_found(arg0: &MinerStats) : u64 {
        arg0.blocks_found
    }

    public fun btc_payout_address(arg0: &MinerStats) : vector<u8> {
        arg0.btc_payout_address
    }

    public fun close_miner_round_stats(arg0: MinerRoundStats, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.miner == 0x2::tx_context::sender(arg1), 13906834887307952129);
        let MinerRoundStats {
            id          : v0,
            round_id    : _,
            miner       : _,
            work        : _,
            shares      : _,
            sold_work   : _,
            sold_shares : _,
            min_height  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_round_stats(arg0: &mut MinerRoundRegistry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = MinerRoundKey{
            miner    : v0,
            round_id : arg1,
        };
        assert!(!0x2::dynamic_field::exists<MinerRoundKey>(&arg0.id, v1), 13906834809999065097);
        0x2::dynamic_field::add<MinerRoundKey, bool>(&mut arg0.id, v1, true);
        let v2 = MinerRoundStats{
            id          : 0x2::object::new(arg3),
            round_id    : arg1,
            miner       : v0,
            work        : 0,
            shares      : 0,
            sold_work   : 0,
            sold_shares : 0,
            min_height  : arg2,
        };
        0x2::transfer::transfer<MinerRoundStats>(v2, v0);
    }

    public(friend) fun delete_round_stats(arg0: MinerRoundStats) {
        let MinerRoundStats {
            id          : v0,
            round_id    : _,
            miner       : _,
            work        : _,
            shares      : _,
            sold_work   : _,
            sold_shares : _,
            min_height  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MinerRoundRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MinerRoundRegistry>(v0);
    }

    public fun miner_address(arg0: &MinerStats) : address {
        arg0.miner
    }

    public fun mrs_min_height(arg0: &MinerRoundStats) : u64 {
        arg0.min_height
    }

    public fun mrs_miner(arg0: &MinerRoundStats) : address {
        arg0.miner
    }

    public fun mrs_round_id(arg0: &MinerRoundStats) : u64 {
        arg0.round_id
    }

    public fun mrs_shares(arg0: &MinerRoundStats) : u64 {
        arg0.shares
    }

    public fun mrs_sold_shares(arg0: &MinerRoundStats) : u64 {
        arg0.sold_shares
    }

    public fun mrs_sold_work(arg0: &MinerRoundStats) : u128 {
        arg0.sold_work
    }

    public fun mrs_work(arg0: &MinerRoundStats) : u128 {
        arg0.work
    }

    public(friend) fun record_share(arg0: &mut MinerStats, arg1: &mut MinerRoundStats, arg2: u64, arg3: bool, arg4: u64, arg5: u64) {
        assert!(arg1.round_id == arg4, 13906834981797363715);
        assert!(arg1.miner == arg0.miner, 13906834986092199937);
        assert!(arg5 >= arg1.min_height, 13906834990387560455);
        arg0.total_shares = arg0.total_shares + 1;
        if (arg3) {
            arg0.blocks_found = arg0.blocks_found + 1;
        };
        arg1.work = arg1.work + (arg2 as u128);
        arg1.shares = arg1.shares + 1;
        arg1.min_height = arg5;
    }

    public(friend) fun record_sold_share(arg0: &mut MinerRoundStats, arg1: address, arg2: u64, arg3: u64) {
        assert!(arg0.round_id == arg3, 13906835076286644227);
        assert!(arg0.miner == arg1, 13906835080581742597);
        arg0.sold_work = arg0.sold_work + (arg2 as u128);
        arg0.sold_shares = arg0.sold_shares + 1;
    }

    public fun register_miner(arg0: vector<u8>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = MinerStats{
            id                 : 0x2::object::new(arg2),
            miner              : v0,
            total_shares       : 0,
            blocks_found       : 0,
            registered_at_ms   : v1,
            btc_payout_address : arg0,
        };
        let v3 = MinerRegistered{
            miner        : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<MinerRegistered>(v3);
        0x2::transfer::transfer<MinerStats>(v2, v0);
    }

    public fun set_btc_payout_address(arg0: &mut MinerStats, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.miner == 0x2::tx_context::sender(arg2), 13906834706919325697);
        arg0.btc_payout_address = arg1;
    }

    public fun total_shares(arg0: &MinerStats) : u64 {
        arg0.total_shares
    }

    // decompiled from Move bytecode v6
}

