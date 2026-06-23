module 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::share_dedup {
    struct ShareDedupKey has copy, drop, store {
        miner: address,
        round_id: u64,
    }

    struct ShareDedupRegistry has key {
        id: 0x2::object::UID,
    }

    struct ShareDedup has key {
        id: 0x2::object::UID,
        round_id: u64,
        miner: address,
        count: u32,
    }

    public(friend) fun check_and_record(arg0: &mut ShareDedup, arg1: vector<u8>) {
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, arg1), 13906834771343835137);
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, arg1, true);
        arg0.count = arg0.count + 1;
    }

    public fun close_share_dedup(arg0: &mut ShareDedup, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.miner == 0x2::tx_context::sender(arg2), 13906834646790045701);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = *0x1::vector::borrow<vector<u8>>(&arg1, v0);
            if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, v1)) {
                0x2::dynamic_field::remove<vector<u8>, bool>(&mut arg0.id, v1);
                arg0.count = arg0.count - 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun count(arg0: &ShareDedup) : u32 {
        arg0.count
    }

    public fun create_share_dedup(arg0: &mut ShareDedupRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = ShareDedupKey{
            miner    : v0,
            round_id : arg1,
        };
        assert!(!0x2::dynamic_field::exists<ShareDedupKey>(&arg0.id, v1), 13906834565185536003);
        0x2::dynamic_field::add<ShareDedupKey, bool>(&mut arg0.id, v1, true);
        let v2 = ShareDedup{
            id       : 0x2::object::new(arg2),
            round_id : arg1,
            miner    : v0,
            count    : 0,
        };
        0x2::transfer::transfer<ShareDedup>(v2, v0);
    }

    public fun delete_share_dedup(arg0: ShareDedup, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.miner == 0x2::tx_context::sender(arg1), 13906834724099457029);
        assert!(arg0.count == 0, 13906834728394162177);
        let ShareDedup {
            id       : v0,
            round_id : _,
            miner    : _,
            count    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ShareDedupRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ShareDedupRegistry>(v0);
    }

    public fun miner(arg0: &ShareDedup) : address {
        arg0.miner
    }

    public fun round_id(arg0: &ShareDedup) : u64 {
        arg0.round_id
    }

    // decompiled from Move bytecode v6
}

