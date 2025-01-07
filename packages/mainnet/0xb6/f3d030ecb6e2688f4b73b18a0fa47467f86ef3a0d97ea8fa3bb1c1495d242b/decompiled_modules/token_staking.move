module 0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::token_staking {
    struct StakingAdmin has key {
        id: 0x2::object::UID,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        total_staked: u64,
        lock_period: u64,
    }

    struct Stake has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>,
        owner: address,
        timestamp: u64,
    }

    public entry fun create_staking_pool(arg0: &StakingAdmin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id           : 0x2::object::new(arg2),
            total_staked : 0,
            lock_period  : arg1,
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public fun get_stake_info(arg0: &Stake) : (address, u64, u64) {
        (arg0.owner, 0x2::balance::value<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>(&arg0.amount), arg0.timestamp)
    }

    public fun get_total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StakingAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = Stake{
            id        : 0x2::object::new(arg3),
            amount    : 0x2::coin::into_balance<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>(arg1),
            owner     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        arg0.total_staked = arg0.total_staked + v0;
        0x2::transfer::transfer<Stake>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: Stake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Stake {
            id        : v0,
            amount    : v1,
            owner     : v2,
            timestamp : v3,
        } = arg1;
        let v4 = v1;
        assert!(v2 == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v3 + arg0.lock_period * 1000, 2);
        arg0.total_staked = arg0.total_staked - 0x2::balance::value<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>(&v4);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>>(0x2::coin::from_balance<0xb6f3d030ecb6e2688f4b73b18a0fa47467f86ef3a0d97ea8fa3bb1c1495d242b::farm::FARM>(v4, arg3), v2);
    }

    // decompiled from Move bytecode v6
}

