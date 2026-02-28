module 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_staking {
    struct StakePool has key {
        id: 0x2::object::UID,
        total_staked: 0x2::balance::Balance<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>,
        staking_cap: u64,
        min_coeff: u256,
        max_coeff: u256,
        max_lock_ms: u64,
    }

    struct StakeAdminCap has key {
        id: 0x2::object::UID,
        pool_id: address,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        staked_at_ms: u64,
        unlock_at_ms: u64,
        lock_ms: u64,
        initial_v_shares: u256,
    }

    struct Staked has copy, drop {
        owner: address,
        amount: u64,
        lock_ms: u64,
        coeff: u256,
        initial_v_shares: u256,
        unlock_at_ms: u64,
    }

    struct Unstaked has copy, drop {
        owner: address,
        amount: u64,
    }

    struct StakingConfigUpdated has copy, drop {
        staking_cap: u64,
        min_coeff: u256,
        max_coeff: u256,
        max_lock_ms: u64,
    }

    fun assert_cap(arg0: &StakePool, arg1: &StakeAdminCap) {
        assert!(0x2::object::id_address<StakePool>(arg0) == arg1.pool_id, 11001);
    }

    public(friend) fun assert_position_owner(arg0: &StakePosition, arg1: address) {
        assert!(arg0.owner == arg1, 11004);
    }

    public fun create_pool(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_pool_internal(arg0, 200000000000000000, 1000000000000000000, 63072000000, arg1);
        0x2::transfer::transfer<StakeAdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StakePool>(v0);
    }

    fun create_pool_internal(arg0: u64, arg1: u256, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (StakePool, StakeAdminCap) {
        validate_config(arg0, arg1, arg2, arg3);
        let v0 = StakePool{
            id           : 0x2::object::new(arg4),
            total_staked : 0x2::balance::zero<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(),
            staking_cap  : arg0,
            min_coeff    : arg1,
            max_coeff    : arg2,
            max_lock_ms  : arg3,
        };
        let v1 = StakeAdminCap{
            id      : 0x2::object::new(arg4),
            pool_id : 0x2::object::id_address<StakePool>(&v0),
        };
        (v0, v1)
    }

    public fun current_vtaco_shares(arg0: &StakePosition, arg1: &0x2::clock::Clock) : u256 {
        current_vtaco_shares_at(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public(friend) fun current_vtaco_shares_at(arg0: &StakePosition, arg1: u64) : u256 {
        if (arg0.lock_ms == 0) {
            return arg0.initial_v_shares
        };
        if (arg1 >= arg0.unlock_at_ms) {
            return 0
        };
        arg0.initial_v_shares * ((arg0.unlock_at_ms - arg1) as u256) / (arg0.lock_ms as u256)
    }

    fun lock_coeff(arg0: &StakePool, arg1: u64) : u256 {
        if (arg1 == 0) {
            return arg0.min_coeff
        };
        arg0.min_coeff + (arg0.max_coeff - arg0.min_coeff) * (arg1 as u256) / (arg0.max_lock_ms as u256)
    }

    public(friend) fun position_id(arg0: &StakePosition) : address {
        0x2::object::id_address<StakePosition>(arg0)
    }

    public(friend) fun position_staked_at_ms(arg0: &StakePosition) : u64 {
        arg0.staked_at_ms
    }

    public fun set_staking_config(arg0: &mut StakePool, arg1: &StakeAdminCap, arg2: u64, arg3: u256, arg4: u256, arg5: u64) {
        assert_cap(arg0, arg1);
        validate_config(arg2, arg3, arg4, arg5);
        arg0.staking_cap = arg2;
        arg0.min_coeff = arg3;
        arg0.max_coeff = arg4;
        arg0.max_lock_ms = arg5;
        let v0 = StakingConfigUpdated{
            staking_cap : arg2,
            min_coeff   : arg3,
            max_coeff   : arg4,
            max_lock_ms : arg5,
        };
        0x2::event::emit<StakingConfigUpdated>(v0);
    }

    public fun stake(arg0: &mut StakePool, arg1: 0x2::coin::Coin<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<StakePosition>(stake_ptb(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun stake_ptb(arg0: &mut StakePool, arg1: 0x2::coin::Coin<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : StakePosition {
        assert!(arg2 <= arg0.max_lock_ms, 11002);
        let v0 = 0x2::coin::value<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(&arg1);
        assert!(v0 > 0, 11006);
        assert!(0x2::balance::value<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(&arg0.total_staked) + v0 <= arg0.staking_cap, 11003);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = lock_coeff(arg0, arg2);
        let v3 = (v0 as u256) * v2 / 1000000000000000000;
        let v4 = v1 + arg2;
        0x2::balance::join<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(&mut arg0.total_staked, 0x2::coin::into_balance<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(arg1));
        let v5 = StakePosition{
            id               : 0x2::object::new(arg4),
            owner            : 0x2::tx_context::sender(arg4),
            amount           : v0,
            staked_at_ms     : v1,
            unlock_at_ms     : v4,
            lock_ms          : arg2,
            initial_v_shares : v3,
        };
        let v6 = Staked{
            owner            : v5.owner,
            amount           : v0,
            lock_ms          : arg2,
            coeff            : v2,
            initial_v_shares : v3,
            unlock_at_ms     : v4,
        };
        0x2::event::emit<Staked>(v6);
        v5
    }

    public fun unstake(arg0: &mut StakePool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>>(unstake_ptb(arg0, arg1, arg2, arg3), v0);
    }

    public fun unstake_ptb(arg0: &mut StakePool, arg1: StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO> {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 11004);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_at_ms, 11005);
        let v0 = arg1.amount;
        let StakePosition {
            id               : v1,
            owner            : v2,
            amount           : _,
            staked_at_ms     : _,
            unlock_at_ms     : _,
            lock_ms          : _,
            initial_v_shares : _,
        } = arg1;
        0x2::object::delete(v1);
        let v8 = Unstaked{
            owner  : v2,
            amount : v0,
        };
        0x2::event::emit<Unstaked>(v8);
        0x2::coin::from_balance<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(0x2::balance::split<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco::TACO>(&mut arg0.total_staked, v0), arg3)
    }

    fun validate_config(arg0: u64, arg1: u256, arg2: u256, arg3: u64) {
        assert!(arg0 > 0, 11002);
        assert!(arg3 > 0, 11002);
        assert!(arg1 > 0, 11002);
        assert!(arg1 <= arg2, 11002);
        assert!(arg2 <= 1000000000000000000, 11002);
    }

    // decompiled from Move bytecode v6
}

