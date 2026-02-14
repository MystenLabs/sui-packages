module 0xff9c62f5af93b27146bbd2c11883190748ba8eee570946a6d6241b6de932a9c0::city_staking {
    struct StakingPool has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
    }

    struct UserStake<phantom T0> has key {
        id: 0x2::object::UID,
        principal: 0x2::balance::Balance<T0>,
        staked_amount: u64,
        lock_days: u64,
        multiplier_bps: u64,
        lock_start_ms: u64,
        lock_end_ms: u64,
        last_accrual_ms: u64,
        unclaimed_credits: u128,
        claimed_credits: u128,
    }

    struct PoolCreated has copy, drop {
        pool_id: address,
        admin: address,
    }

    struct StakeCreated has copy, drop {
        staker: address,
        stake_id: address,
        amount: u64,
        lock_days: u64,
        lock_end_ms: u64,
    }

    struct StakeIncreased has copy, drop {
        staker: address,
        stake_id: address,
        added_amount: u64,
        total_staked: u64,
    }

    struct CreditsClaimed has copy, drop {
        staker: address,
        stake_id: address,
        claimed: u128,
        lifetime_claimed: u128,
    }

    struct Unstaked has copy, drop {
        staker: address,
        stake_id: address,
        amount: u64,
    }

    struct PoolPauseToggled has copy, drop {
        admin: address,
        paused: bool,
    }

    fun accrue<T0>(arg0: &mut UserStake<T0>, arg1: u64) {
        let v0 = pending_delta<T0>(arg0, arg1);
        if (v0 > 0) {
            arg0.unclaimed_credits = arg0.unclaimed_credits + v0;
        };
        if (arg0.staked_amount > 0) {
            let v1 = if (arg1 > arg0.lock_end_ms) {
                arg0.lock_end_ms
            } else {
                arg1
            };
            if (v1 > arg0.last_accrual_ms) {
                arg0.last_accrual_ms = v1;
            };
        } else {
            arg0.last_accrual_ms = arg1;
        };
    }

    fun assert_city<T0>() {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = b"308fa16c7aead43e3a49a4ff2e76205ba2a12697234f4fe80a2da66515284060::city::CITY";
        assert!(0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0)) == &v1, 5);
    }

    public fun claim_credits<T0>(arg0: &StakingPool, arg1: &mut UserStake<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_city<T0>();
        assert!(!arg0.paused, 3);
        accrue<T0>(arg1, 0x2::clock::timestamp_ms(arg2));
        let v0 = arg1.unclaimed_credits;
        if (v0 > 0) {
            arg1.unclaimed_credits = 0;
            arg1.claimed_credits = arg1.claimed_credits + v0;
            let v1 = CreditsClaimed{
                staker           : 0x2::tx_context::sender(arg3),
                stake_id         : 0x2::object::uid_to_address(&arg1.id),
                claimed          : v0,
                lifetime_claimed : arg1.claimed_credits,
            };
            0x2::event::emit<CreditsClaimed>(v1);
        };
    }

    public fun get_lock_config(arg0: u64) : u64 {
        lock_multiplier_bps(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = StakingPool{
            id     : 0x2::object::new(arg0),
            admin  : v0,
            paused : false,
        };
        let v2 = PoolCreated{
            pool_id : 0x2::object::uid_to_address(&v1.id),
            admin   : v0,
        };
        0x2::event::emit<PoolCreated>(v2);
        0x2::transfer::share_object<StakingPool>(v1);
    }

    fun lock_multiplier_bps(arg0: u64) : u64 {
        if (arg0 == 7) {
            10000
        } else if (arg0 == 30) {
            15000
        } else {
            assert!(arg0 == 90, 1);
            20000
        }
    }

    fun pending_delta<T0>(arg0: &UserStake<T0>, arg1: u64) : u128 {
        if (arg0.staked_amount == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0.lock_end_ms) {
            arg0.lock_end_ms
        } else {
            arg1
        };
        if (v0 <= arg0.last_accrual_ms) {
            return 0
        };
        (((arg0.staked_amount as u256) * ((v0 - arg0.last_accrual_ms) as u256) * (arg0.multiplier_bps as u256) * (10 as u256) * (1000000000 as u256) / (3600000 as u256) * (1000000000000000 as u256) * (10000 as u256)) as u128)
    }

    public fun preview_unclaimed<T0>(arg0: &UserStake<T0>, arg1: u64) : u128 {
        arg0.unclaimed_credits + pending_delta<T0>(arg0, arg1)
    }

    public fun set_paused(arg0: &mut StakingPool, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4);
        arg0.paused = arg1;
        let v0 = PoolPauseToggled{
            admin  : arg0.admin,
            paused : arg1,
        };
        0x2::event::emit<PoolPauseToggled>(v0);
    }

    public fun stake_more<T0>(arg0: &StakingPool, arg1: &mut UserStake<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_city<T0>();
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < arg1.lock_end_ms, 2);
        accrue<T0>(arg1, v1);
        0x2::coin::put<T0>(&mut arg1.principal, arg2);
        arg1.staked_amount = arg1.staked_amount + v0;
        let v2 = StakeIncreased{
            staker       : 0x2::tx_context::sender(arg4),
            stake_id     : 0x2::object::uid_to_address(&arg1.id),
            added_amount : v0,
            total_staked : arg1.staked_amount,
        };
        0x2::event::emit<StakeIncreased>(v2);
    }

    public fun stake_new<T0>(arg0: &StakingPool, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_city<T0>();
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + arg2 * 86400000;
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = UserStake<T0>{
            id                : 0x2::object::new(arg4),
            principal         : 0x2::coin::into_balance<T0>(arg1),
            staked_amount     : v0,
            lock_days         : arg2,
            multiplier_bps    : lock_multiplier_bps(arg2),
            lock_start_ms     : v1,
            lock_end_ms       : v2,
            last_accrual_ms   : v1,
            unclaimed_credits : 0,
            claimed_credits   : 0,
        };
        let v5 = StakeCreated{
            staker      : v3,
            stake_id    : 0x2::object::uid_to_address(&v4.id),
            amount      : v0,
            lock_days   : arg2,
            lock_end_ms : v2,
        };
        0x2::event::emit<StakeCreated>(v5);
        0x2::transfer::transfer<UserStake<T0>>(v4, v3);
    }

    public fun unstake<T0>(arg0: &StakingPool, arg1: &mut UserStake<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_city<T0>();
        assert!(!arg0.paused, 3);
        assert!(arg1.staked_amount > 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.lock_end_ms, 2);
        accrue<T0>(arg1, v0);
        let v1 = 0x2::balance::value<T0>(&arg1.principal);
        arg1.staked_amount = 0;
        arg1.lock_days = 0;
        arg1.multiplier_bps = 0;
        arg1.lock_start_ms = 0;
        arg1.lock_end_ms = 0;
        arg1.last_accrual_ms = v0;
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.principal, v1, arg3), v2);
        let v3 = Unstaked{
            staker   : v2,
            stake_id : 0x2::object::uid_to_address(&arg1.id),
            amount   : v1,
        };
        0x2::event::emit<Unstaked>(v3);
    }

    // decompiled from Move bytecode v6
}

