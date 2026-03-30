module 0xdb66219fb1ecebb424ddd4ad31796438eb3848abff712f0bad66273c4fa2d329::type_reward {
    struct AllRewardsData has drop, store {
        fee_x: u64,
        fee_y: u64,
        rewards: vector<RewardAmount>,
    }

    struct RewardAmount has copy, drop, store {
        index: u64,
        amount: u64,
    }

    public(friend) fun new_all_rewards_data(arg0: u64, arg1: u64, arg2: vector<RewardAmount>) : AllRewardsData {
        AllRewardsData{
            fee_x   : arg0,
            fee_y   : arg1,
            rewards : arg2,
        }
    }

    public(friend) fun new_reward_amount(arg0: u64, arg1: u64) : RewardAmount {
        RewardAmount{
            index  : arg0,
            amount : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

