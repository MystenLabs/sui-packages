module 0x6e49ba9a0146a82bbd3ef23508cb1730e73497909eab40f44caa83011e988a38::one_stake {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        staked: 0x2::balance::Balance<T0>,
        rewards: 0x2::balance::Balance<T0>,
        rate_bps: u64,
        min_stake: u64,
        max_stake: u64,
        total_staked: u64,
        receipts: u64,
        paused: bool,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        amount: u64,
        rate_bps: u64,
        staked_at_ms: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        rate_bps: u64,
        min: u64,
        max: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        who: address,
        amount: u64,
        rate_bps: u64,
    }

    struct Redeemed has copy, drop {
        pool: 0x2::object::ID,
        who: address,
        principal: u64,
        reward: u64,
        held_ms: u64,
        shortfall: u64,
    }

    struct RewardsFunded has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
        pot: u64,
    }

    struct RateChanged has copy, drop {
        pool: 0x2::object::ID,
        old_bps: u64,
        new_bps: u64,
    }

    public fun accrued<T0>(arg0: &Pool<T0>, arg1: &Receipt, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 5);
        (((arg1.amount as u128) * (arg1.rate_bps as u128) * ((0x2::clock::timestamp_ms(arg2) - arg1.staked_at_ms) as u128) / 10000 * 31536000000) as u64)
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg3 >= arg2, 6);
        let v0 = Pool<T0>{
            id           : 0x2::object::new(arg4),
            version      : 1,
            staked       : 0x2::balance::zero<T0>(),
            rewards      : 0x2::balance::zero<T0>(),
            rate_bps     : arg1,
            min_stake    : arg2,
            max_stake    : arg3,
            total_staked : 0,
            receipts     : 0,
            paused       : false,
        };
        let v1 = PoolCreated{
            pool     : 0x2::object::id<Pool<T0>>(&v0),
            rate_bps : arg1,
            min      : arg2,
            max      : arg3,
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public fun fund_rewards<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(arg0.version == 1, 1);
        0x2::balance::join<T0>(&mut arg0.rewards, 0x2::coin::into_balance<T0>(arg1));
        let v0 = RewardsFunded{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            amount : 0x2::coin::value<T0>(&arg1),
            pot    : 0x2::balance::value<T0>(&arg0.rewards),
        };
        0x2::event::emit<RewardsFunded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.paused
    }

    public fun limits<T0>(arg0: &Pool<T0>) : (u64, u64) {
        (arg0.min_stake, arg0.max_stake)
    }

    public fun rate_bps<T0>(arg0: &Pool<T0>) : u64 {
        arg0.rate_bps
    }

    public fun receipt_amount(arg0: &Receipt) : u64 {
        arg0.amount
    }

    public fun receipt_rate(arg0: &Receipt) : u64 {
        arg0.rate_bps
    }

    public fun receipts<T0>(arg0: &Pool<T0>) : u64 {
        arg0.receipts
    }

    public fun redeem<T0>(arg0: &mut Pool<T0>, arg1: Receipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 1);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 5);
        let v0 = accrued<T0>(arg0, &arg1, arg2);
        let v1 = 0x2::balance::value<T0>(&arg0.rewards);
        let v2 = if (v0 > v1) {
            v1
        } else {
            v0
        };
        let Receipt {
            id           : v3,
            pool         : _,
            amount       : v5,
            rate_bps     : _,
            staked_at_ms : v7,
        } = arg1;
        0x2::object::delete(v3);
        let v8 = 0x2::balance::split<T0>(&mut arg0.staked, v5);
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut arg0.rewards, v2));
        };
        arg0.total_staked = arg0.total_staked - v5;
        arg0.receipts = arg0.receipts - 1;
        let v9 = Redeemed{
            pool      : 0x2::object::id<Pool<T0>>(arg0),
            who       : 0x2::tx_context::sender(arg3),
            principal : v5,
            reward    : v2,
            held_ms   : 0x2::clock::timestamp_ms(arg2) - v7,
            shortfall : v0 - v2,
        };
        0x2::event::emit<Redeemed>(v9);
        0x2::coin::from_balance<T0>(v8, arg3)
    }

    public fun reward_pot<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards)
    }

    public fun set_limits<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: u64) {
        assert!(arg1.version == 1, 1);
        assert!(arg2 > 0 && arg3 >= arg2, 6);
        arg1.min_stake = arg2;
        arg1.max_stake = arg3;
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: bool) {
        assert!(arg1.version == 1, 1);
        arg1.paused = arg2;
    }

    public fun set_rate<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64) {
        assert!(arg1.version == 1, 1);
        assert!(arg1.rate_bps != arg2, 9);
        arg1.rate_bps = arg2;
        let v0 = RateChanged{
            pool    : 0x2::object::id<Pool<T0>>(arg1),
            old_bps : arg1.rate_bps,
            new_bps : arg2,
        };
        0x2::event::emit<RateChanged>(v0);
    }

    public fun stake<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(!arg0.paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 7);
        assert!(v0 >= arg0.min_stake, 3);
        assert!(v0 <= arg0.max_stake, 4);
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_staked = arg0.total_staked + v0;
        arg0.receipts = arg0.receipts + 1;
        let v1 = Receipt{
            id           : 0x2::object::new(arg3),
            pool         : 0x2::object::id<Pool<T0>>(arg0),
            amount       : v0,
            rate_bps     : arg0.rate_bps,
            staked_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        let v2 = Staked{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            who      : 0x2::tx_context::sender(arg3),
            amount   : v0,
            rate_bps : arg0.rate_bps,
        };
        0x2::event::emit<Staked>(v2);
        0x2::transfer::transfer<Receipt>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun total_staked<T0>(arg0: &Pool<T0>) : u64 {
        arg0.total_staked
    }

    public fun withdraw_rewards<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.version == 1, 1);
        assert!(0x2::balance::value<T0>(&arg1.rewards) >= arg2, 8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.rewards, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

