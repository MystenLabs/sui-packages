module 0x6e0191d5c9f87e4339f9067b687242d05ab6d0ae5e7197d7c0fae1b299d61f83::state {
    struct RewardClaimState has store, key {
        id: 0x2::object::UID,
        reward_table: 0x2::table::Table<vector<u8>, u64>,
        claim_table: 0x2::table::Table<vector<u8>, u64>,
    }

    public fun increment_last_claim_id(arg0: &mut RewardClaimState, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.claim_table, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.claim_table, arg1) + 1
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.claim_table, arg1, 1);
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.claim_table, arg1)
        }
    }

    public fun increment_last_reward_id(arg0: &mut RewardClaimState, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.reward_table, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.reward_table, arg1) + 1
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.reward_table, arg1, 1);
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.reward_table, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardClaimState{
            id           : 0x2::object::new(arg0),
            reward_table : 0x2::table::new<vector<u8>, u64>(arg0),
            claim_table  : 0x2::table::new<vector<u8>, u64>(arg0),
        };
        0x2::transfer::share_object<RewardClaimState>(v0);
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardClaimState{
            id           : 0x2::object::new(arg0),
            reward_table : 0x2::table::new<vector<u8>, u64>(arg0),
            claim_table  : 0x2::table::new<vector<u8>, u64>(arg0),
        };
        0x2::transfer::share_object<RewardClaimState>(v0);
    }

    // decompiled from Move bytecode v6
}

