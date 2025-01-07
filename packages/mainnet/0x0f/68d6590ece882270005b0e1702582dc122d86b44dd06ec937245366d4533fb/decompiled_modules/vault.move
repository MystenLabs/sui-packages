module 0xf68d6590ece882270005b0e1702582dc122d86b44dd06ec937245366d4533fb::vault {
    struct RewardState has key {
        id: 0x2::object::UID,
        counter: u64,
    }

    struct UserState has key {
        id: 0x2::object::UID,
        rewardPerTokenStored: u64,
        userRewardPerTokenPaid: 0x2::vec_map::VecMap<address, u64>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
        rewards: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        rewardsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        stakedCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RewardAdded has copy, drop {
        reward: u64,
    }

    struct RewardDurationUpdated has copy, drop {
        newDuration: u64,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
    }

    struct Withdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct RewardPaid has copy, drop {
        user: address,
        reward: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardState{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::share_object<RewardState>(v0);
    }

    public entry fun stake(arg0: &mut RewardState, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.counter = arg0.counter + 1;
    }

    // decompiled from Move bytecode v6
}

