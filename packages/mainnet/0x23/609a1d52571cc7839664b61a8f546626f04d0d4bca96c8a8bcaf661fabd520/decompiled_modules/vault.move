module 0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::vault {
    struct RewardState has key {
        id: 0x2::object::UID,
        counter: u64,
        stakedCoinsTreasury: 0x2::balance::Balance<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>,
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

    public entry fun mint(arg0: &mut RewardState, arg1: &mut 0x2::coin::TreasuryCap<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>>(0x2::coin::mint<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>(arg1, 1000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: &mut RewardState, arg1: 0x2::coin::Coin<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.counter = arg0.counter + 1;
        0x2::balance::join<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>(&mut arg0.stakedCoinsTreasury, 0x2::coin::into_balance<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>(arg1));
    }

    public entry fun add_counter(arg0: &mut RewardState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.counter = 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun console_log(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardState{
            id                  : 0x2::object::new(arg0),
            counter             : 0,
            stakedCoinsTreasury : 0x2::balance::zero<0x23609a1d52571cc7839664b61a8f546626f04d0d4bca96c8a8bcaf661fabd520::farm::FARM>(),
        };
        0x2::transfer::share_object<RewardState>(v0);
    }

    // decompiled from Move bytecode v6
}

