module 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::pool {
    struct StakedEvent has copy, drop {
        staker: address,
        sui_amount: u64,
        cert_amount: u64,
    }

    struct CollectedEvent has copy, drop {
        to: address,
        amount: u64,
    }

    struct UnstakedEvent has copy, drop {
        staker: address,
        cert_amount: u64,
        sui_amount: u64,
    }

    struct RewardDistributedEvent has copy, drop {
        staker: address,
        amount: u64,
    }

    struct PausedEvent has copy, drop {
        paused: bool,
    }

    struct UnstakeRecord has copy, drop, store {
        staker: address,
        amount: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        pending: 0x2::balance::Balance<0x2::sui::SUI>,
        min_stake: u64,
        min_unstake: u64,
        unstake_queue: vector<UnstakeRecord>,
        total_unstake: u64,
        intermediary: address,
    }

    fun assert_version(arg0: &Pool) {
        assert!(arg0.version == 2 - 1 || arg0.version == 2, 1);
    }

    public entry fun change_intermediary(arg0: &mut Pool, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap, arg2: address) {
        assert_version(arg0);
        arg0.intermediary = arg2;
    }

    public entry fun change_min_stake(arg0: &mut Pool, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap, arg2: u64) {
        assert_version(arg0);
        arg0.min_stake = arg2;
    }

    public entry fun change_min_unstake(arg0: &mut Pool, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap, arg2: u64) {
        assert_version(arg0);
        arg0.min_unstake = arg2;
    }

    public entry fun collect(arg0: &mut Pool, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OperatorCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        when_not_paused(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pending);
        let v1 = CollectedEvent{
            to     : arg0.intermediary,
            amount : v0,
        };
        0x2::event::emit<CollectedEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pending, v0, arg2), arg0.intermediary);
    }

    public entry fun distribute_reward(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        when_not_paused(arg0);
        let v0 = &mut arg0.unstake_queue;
        while (0x1::vector::length<UnstakeRecord>(v0) > 0) {
            let v1 = *0x1::vector::borrow<UnstakeRecord>(v0, 0);
            if (0x2::coin::value<0x2::sui::SUI>(&mut arg1) >= v1.amount) {
                let v2 = RewardDistributedEvent{
                    staker : v1.staker,
                    amount : v1.amount,
                };
                0x2::event::emit<RewardDistributedEvent>(v2);
                arg0.total_unstake = arg0.total_unstake - v1.amount;
                0x1::vector::remove<UnstakeRecord>(v0, 0);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1.amount, arg2), v1.staker);
            };
        };
        if (0x2::coin::value<0x2::sui::SUI>(&mut arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
    }

    public fun get_min_stake(arg0: &Pool) : u64 {
        arg0.min_stake
    }

    public fun get_min_unstake(arg0: &Pool) : u64 {
        arg0.min_unstake
    }

    public fun get_pending(arg0: &Pool) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.pending
    }

    public fun get_total_unstake(arg0: &Pool) : u64 {
        arg0.total_unstake
    }

    public fun get_total_unstake_of(arg0: &Pool, arg1: address) : u64 {
        let v0 = &arg0.unstake_queue;
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<UnstakeRecord>(v0)) {
            let v3 = *0x1::vector::borrow<UnstakeRecord>(v0, v1);
            if (v3.staker == arg1) {
                v2 = v2 + v3.amount;
            };
            v1 = v1 + 1;
        };
        v2
    }

    public fun get_unstake_amounts_of(arg0: &Pool, arg1: address) : vector<u64> {
        let v0 = &arg0.unstake_queue;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        while (v1 < 0x1::vector::length<UnstakeRecord>(v0)) {
            let v3 = *0x1::vector::borrow<UnstakeRecord>(v0, v1);
            if (v3.staker == arg1) {
                0x1::vector::push_back<u64>(&mut v2, v3.amount);
            };
            v1 = v1 + 1;
        };
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id            : 0x2::object::new(arg0),
            version       : 2,
            paused        : false,
            pending       : 0x2::balance::zero<0x2::sui::SUI>(),
            min_stake     : 100000000,
            min_unstake   : 500000000,
            unstake_queue : 0x1::vector::empty<UnstakeRecord>(),
            total_unstake : 0,
            intermediary  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    entry fun migrate(arg0: &mut Pool, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap) {
        assert!(arg0.version < 2, 1);
        arg0.version = 2;
    }

    public entry fun set_pause(arg0: &mut Pool, arg1: &0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::ownership::OwnerCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = PausedEvent{paused: arg2};
        0x2::event::emit<PausedEvent>(v0);
    }

    public entry fun stake(arg0: &mut Pool, arg1: &mut 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::Metadata<0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::CERT>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        when_not_paused(arg0);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg0.min_stake, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending, v0);
        let v2 = 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::to_shares(arg1, v1);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = StakedEvent{
            staker      : v3,
            sui_amount  : v1,
            cert_amount : v2,
        };
        0x2::event::emit<StakedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::CERT>>(0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::mint(arg1, v2, arg3), v3);
    }

    public entry fun unstake(arg0: &mut Pool, arg1: &mut 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::Metadata<0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::CERT>, arg2: 0x2::coin::Coin<0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::CERT>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        when_not_paused(arg0);
        assert!(0x2::coin::value<0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::CERT>(&arg2) >= arg0.min_unstake, 0);
        let v0 = 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::burn(arg1, arg2);
        let v1 = 0xb22b983263e078df76442b23eba3b8249871be717c4da2420e69a35bbb550b9b::cert::from_shares(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        arg0.total_unstake = arg0.total_unstake + v1;
        let v3 = UnstakedEvent{
            staker      : v2,
            cert_amount : v0,
            sui_amount  : v1,
        };
        0x2::event::emit<UnstakedEvent>(v3);
        let v4 = UnstakeRecord{
            staker : v2,
            amount : v1,
        };
        0x1::vector::push_back<UnstakeRecord>(&mut arg0.unstake_queue, v4);
    }

    fun when_not_paused(arg0: &Pool) {
        assert!(!arg0.paused, 2);
    }

    // decompiled from Move bytecode v6
}

