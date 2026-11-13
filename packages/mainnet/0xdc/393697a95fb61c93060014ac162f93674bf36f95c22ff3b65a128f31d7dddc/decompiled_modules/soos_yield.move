module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::soos_yield {
    struct YieldPool has key {
        id: 0x2::object::UID,
        stake_coin: 0x1::ascii::String,
        reward_coin: 0x1::ascii::String,
        staked: u64,
        rewards: u64,
        apr_bps: u64,
        price_e12: u128,
        paused: bool,
        stakers: u64,
        funded_total: u64,
        paid_total: u64,
    }

    struct Stake<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        amount: u64,
        last_day: u64,
        unpaid: u64,
    }

    struct Staked has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Unstaked has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct EarningsCollected has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        days: u64,
        unpaid: u64,
    }

    struct YieldFunded has copy, drop {
        amount: u64,
        from: address,
    }

    struct StakedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun apr_bps(arg0: &YieldPool) : u64 {
        arg0.apr_bps
    }

    fun check<T0, T1>(arg0: &YieldPool) {
        assert!(arg0.stake_coin == name<T0>() && arg0.reward_coin == name<T1>(), 5);
    }

    public fun collect<T0, T1>(arg0: &mut YieldPool, arg1: &mut Stake<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1.pool_id == 0x2::object::id<YieldPool>(arg0), 3);
        check<T0, T1>(arg0);
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(0x2::clock::timestamp_ms(arg2));
        let v1 = if (v0 > arg1.last_day) {
            v0 - arg1.last_day
        } else {
            0
        };
        let v2 = daily_for(arg0, arg1.amount) * v1 + arg1.unpaid;
        let v3 = arg0.rewards;
        let v4 = if (v2 < v3) {
            v2
        } else {
            v3
        };
        arg1.unpaid = v2 - v4;
        arg1.last_day = v0;
        arg0.paid_total = arg0.paid_total + v4;
        let v5 = EarningsCollected{
            stake_id : 0x2::object::id<Stake<T0, T1>>(arg1),
            owner    : 0x2::tx_context::sender(arg3),
            amount   : v4,
            days     : v1,
            unpaid   : arg1.unpaid,
        };
        0x2::event::emit<EarningsCollected>(v5);
        take_rewards<T1>(arg0, v4, arg3)
    }

    public(friend) fun create<T0, T1>(arg0: u64, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : YieldPool {
        create_named(name<T0>(), name<T1>(), arg0, arg1, arg2)
    }

    public(friend) fun create_named(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : YieldPool {
        assert!(arg2 <= 2000, 4);
        YieldPool{
            id           : 0x2::object::new(arg4),
            stake_coin   : arg0,
            reward_coin  : arg1,
            staked       : 0,
            rewards      : 0,
            apr_bps      : arg2,
            price_e12    : arg3,
            paused       : false,
            stakers      : 0,
            funded_total : 0,
            paid_total   : 0,
        }
    }

    public fun daily_for(arg0: &YieldPool, arg1: u64) : u64 {
        (((arg1 as u128) * arg0.price_e12 * (arg0.apr_bps as u128) / 1000000000000 * 10000 * 365) as u64)
    }

    public fun fund<T0, T1>(arg0: &mut YieldPool, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        check<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        arg0.funded_total = arg0.funded_total + v0;
        let v1 = rewards_mut<T1>(arg0);
        0x2::balance::join<T1>(v1, 0x2::coin::into_balance<T1>(arg1));
        arg0.rewards = arg0.rewards + v0;
        let v2 = YieldFunded{
            amount : v0,
            from   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<YieldFunded>(v2);
    }

    fun name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())
    }

    public fun owed<T0, T1>(arg0: &YieldPool, arg1: &Stake<T0, T1>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(0x2::clock::timestamp_ms(arg2));
        let v1 = if (v0 > arg1.last_day) {
            v0 - arg1.last_day
        } else {
            0
        };
        daily_for(arg0, arg1.amount) * v1 + arg1.unpaid
    }

    public fun price_e12(arg0: &YieldPool) : u128 {
        arg0.price_e12
    }

    public fun reward_coin(arg0: &YieldPool) : 0x1::ascii::String {
        arg0.reward_coin
    }

    public fun rewards_left(arg0: &YieldPool) : u64 {
        arg0.rewards
    }

    fun rewards_mut<T0>(arg0: &mut YieldPool) : &mut 0x2::balance::Balance<T0> {
        let v0 = RewardsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RewardsKey>(&arg0.id, v0)) {
            let v1 = RewardsKey{dummy_field: false};
            0x2::dynamic_field::add<RewardsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = RewardsKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RewardsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2)
    }

    public(friend) fun set_params(arg0: &mut YieldPool, arg1: u64, arg2: u128, arg3: bool) {
        assert!(arg1 <= 2000, 4);
        arg0.apr_bps = arg1;
        arg0.price_e12 = arg2;
        arg0.paused = arg3;
    }

    public(friend) fun share(arg0: YieldPool) {
        0x2::transfer::share_object<YieldPool>(arg0);
    }

    public fun stake<T0, T1>(arg0: &mut YieldPool, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0);
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = staked_mut<T0>(arg0);
        0x2::balance::join<T0>(v1, 0x2::coin::into_balance<T0>(arg1));
        arg0.staked = arg0.staked + v0;
        arg0.stakers = arg0.stakers + 1;
        let v2 = Stake<T0, T1>{
            id       : 0x2::object::new(arg3),
            pool_id  : 0x2::object::id<YieldPool>(arg0),
            amount   : v0,
            last_day : 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::revenue::day_of(0x2::clock::timestamp_ms(arg2)),
            unpaid   : 0,
        };
        let v3 = Staked{
            stake_id : 0x2::object::id<Stake<T0, T1>>(&v2),
            owner    : 0x2::tx_context::sender(arg3),
            amount   : v0,
        };
        0x2::event::emit<Staked>(v3);
        0x2::transfer::transfer<Stake<T0, T1>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun stake_amount<T0, T1>(arg0: &Stake<T0, T1>) : u64 {
        arg0.amount
    }

    public fun stake_coin(arg0: &YieldPool) : 0x1::ascii::String {
        arg0.stake_coin
    }

    public fun stake_unpaid<T0, T1>(arg0: &Stake<T0, T1>) : u64 {
        arg0.unpaid
    }

    fun staked_mut<T0>(arg0: &mut YieldPool) : &mut 0x2::balance::Balance<T0> {
        let v0 = StakedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StakedKey>(&arg0.id, v0)) {
            let v1 = StakedKey{dummy_field: false};
            0x2::dynamic_field::add<StakedKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        let v2 = StakedKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StakedKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v2)
    }

    fun take_rewards<T0>(arg0: &mut YieldPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = rewards_mut<T0>(arg0);
        arg0.rewards = arg0.rewards - arg1;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg1), arg2)
    }

    public fun total_staked(arg0: &YieldPool) : u64 {
        arg0.staked
    }

    public fun unstake<T0, T1>(arg0: &mut YieldPool, arg1: Stake<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = &mut arg1;
        let v1 = collect<T0, T1>(arg0, v0, arg2, arg3);
        let Stake {
            id       : v2,
            pool_id  : _,
            amount   : v4,
            last_day : _,
            unpaid   : _,
        } = arg1;
        let v7 = v2;
        let v8 = Unstaked{
            stake_id : 0x2::object::uid_to_inner(&v7),
            owner    : 0x2::tx_context::sender(arg3),
            amount   : v4,
        };
        0x2::event::emit<Unstaked>(v8);
        0x2::object::delete(v7);
        arg0.stakers = arg0.stakers - 1;
        let v9 = staked_mut<T0>(arg0);
        arg0.staked = arg0.staked - v4;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v9, v4), arg3), v1)
    }

    public(friend) fun withdraw_rewards<T0, T1>(arg0: &mut YieldPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0);
        take_rewards<T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

