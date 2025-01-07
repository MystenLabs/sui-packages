module 0x44a73150aff57babc6cf334096fff6f727ce92833155a9f7566b842348ef7479::vault {
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

    public fun get_count(arg0: &mut RewardState) : u64 {
        arg0.counter
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

