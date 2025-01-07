module 0x4b2645939ab720f7031b5b724802e44aac44e335f029414bee6a1d6dcbb42bc6::token_staking {
    struct StakingAdmin has key {
        id: 0x2::object::UID,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        lock_period: u64,
    }

    struct Stake<phantom T0> has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<T0>,
        owner: address,
        timestamp: u64,
    }

    public entry fun create_staking_pool<T0: store + key>(arg0: &StakingAdmin, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool<T0>{
            id           : 0x2::object::new(arg2),
            total_staked : 0,
            lock_period  : arg1,
        };
        0x2::transfer::share_object<StakingPool<T0>>(v0);
    }

    public fun get_stake_info<T0>(arg0: &Stake<T0>) : (address, u64, u64) {
        (arg0.owner, 0x2::balance::value<T0>(&arg0.amount), arg0.timestamp)
    }

    public fun get_total_staked<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.total_staked
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StakingAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = Stake<T0>{
            id        : 0x2::object::new(arg3),
            amount    : 0x2::coin::into_balance<T0>(arg1),
            owner     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        arg0.total_staked = arg0.total_staked + v0;
        0x2::transfer::transfer<Stake<T0>>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: Stake<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Stake {
            id        : v0,
            amount    : v1,
            owner     : v2,
            timestamp : v3,
        } = arg1;
        let v4 = v1;
        assert!(v2 == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v3 + arg0.lock_period * 1000, 2);
        arg0.total_staked = arg0.total_staked - 0x2::balance::value<T0>(&v4);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg3), v2);
    }

    // decompiled from Move bytecode v6
}

