module 0x7ebe339eba278fbff10103f65770e4c6293ce0a55b4c9bc70e6f6959f2775346::vault {
    struct RewardState has key {
        id: 0x2::object::UID,
        counter: u64,
        stakedCoinsTreasury: 0x2::balance::Balance<0x7ebe339eba278fbff10103f65770e4c6293ce0a55b4c9bc70e6f6959f2775346::farm::FARM>,
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

    public entry fun transfer(arg0: &mut RewardState, arg1: 0x2::coin::Coin<0x7ebe339eba278fbff10103f65770e4c6293ce0a55b4c9bc70e6f6959f2775346::farm::FARM>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.counter = arg0.counter + 1;
        0x2::balance::join<0x7ebe339eba278fbff10103f65770e4c6293ce0a55b4c9bc70e6f6959f2775346::farm::FARM>(&mut arg0.stakedCoinsTreasury, 0x2::coin::into_balance<0x7ebe339eba278fbff10103f65770e4c6293ce0a55b4c9bc70e6f6959f2775346::farm::FARM>(arg1));
    }

    public entry fun add_counter(arg0: &mut RewardState, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.counter = arg0.counter + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardState{
            id                  : 0x2::object::new(arg0),
            counter             : 0,
            stakedCoinsTreasury : 0x2::balance::zero<0x7ebe339eba278fbff10103f65770e4c6293ce0a55b4c9bc70e6f6959f2775346::farm::FARM>(),
        };
        0x2::transfer::share_object<RewardState>(v0);
    }

    public fun magic(arg0: &RewardState) : u64 {
        arg0.counter
    }

    // decompiled from Move bytecode v6
}

