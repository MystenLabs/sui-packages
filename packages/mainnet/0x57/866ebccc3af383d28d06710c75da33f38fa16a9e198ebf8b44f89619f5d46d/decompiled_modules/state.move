module 0x57866ebccc3af383d28d06710c75da33f38fa16a9e198ebf8b44f89619f5d46d::state {
    struct RewardClaimState has store, key {
        id: 0x2::object::UID,
        reward_table: 0x2::bag::Bag,
        claim_table: 0x2::bag::Bag,
    }

    public fun increment_last_claim_id(arg0: &mut RewardClaimState, arg1: vector<u8>) : u64 {
        if (0x2::bag::contains<vector<u8>>(&arg0.claim_table, arg1)) {
            *0x2::bag::borrow_mut<vector<u8>, u64>(&mut arg0.claim_table, arg1) + 1
        } else {
            0x2::bag::add<vector<u8>, u64>(&mut arg0.claim_table, arg1, 1);
            *0x2::bag::borrow_mut<vector<u8>, u64>(&mut arg0.claim_table, arg1)
        }
    }

    public fun increment_last_reward_id(arg0: &mut RewardClaimState, arg1: vector<u8>) : u64 {
        if (0x2::bag::contains<vector<u8>>(&arg0.reward_table, arg1)) {
            *0x2::bag::borrow_mut<vector<u8>, u64>(&mut arg0.reward_table, arg1) + 1
        } else {
            0x2::bag::add<vector<u8>, u64>(&mut arg0.reward_table, arg1, 1);
            *0x2::bag::borrow_mut<vector<u8>, u64>(&mut arg0.reward_table, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardClaimState{
            id           : 0x2::object::new(arg0),
            reward_table : 0x2::bag::new(arg0),
            claim_table  : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<RewardClaimState>(v0);
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardClaimState{
            id           : 0x2::object::new(arg0),
            reward_table : 0x2::bag::new(arg0),
            claim_table  : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<RewardClaimState>(v0);
    }

    // decompiled from Move bytecode v6
}

