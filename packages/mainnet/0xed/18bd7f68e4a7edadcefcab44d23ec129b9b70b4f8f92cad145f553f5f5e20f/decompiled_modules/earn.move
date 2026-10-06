module 0xed18bd7f68e4a7edadcefcab44d23ec129b9b70b4f8f92cad145f553f5f5e20f::earn {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct PoolKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct End has copy, drop, store {
        at_ms: u64,
        rate: u256,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        staked: 0x2::balance::Balance<T0>,
        rewards: 0x2::balance::Balance<T0>,
        acc: u256,
        rate: u256,
        ends: vector<End>,
        idle: u256,
        last_ms: u64,
        stakers: u64,
        funded: u128,
        paid: u128,
    }

    struct Stake<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        amount: u64,
        debt: u256,
        owed: u64,
    }

    struct State has copy, drop, store {
        acc: u256,
        rate: u256,
        staked: u64,
        rewards: u64,
        idle: u256,
        at_ms: u64,
    }

    struct PoolOpened has copy, drop {
        pool: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        at_ms: u64,
    }

    struct Funded has copy, drop {
        pool: 0x2::object::ID,
        funder: address,
        amount: u64,
        end_ms: u64,
        rate_add: u256,
        state: State,
    }

    struct Restreamed has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
        end_ms: u64,
        rate_add: u256,
        at_ms: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        stake_amount: u64,
        stake_owed: u64,
        state: State,
    }

    struct Unstaked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        reward: u64,
        stake_amount: u64,
        stake_owed: u64,
        closed: bool,
        state: State,
    }

    struct Claimed has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        stake_owed: u64,
        state: State,
    }

    struct Restaked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        stake_amount: u64,
        stake_owed: u64,
        state: State,
    }

    public fun claim<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        current<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        accrue<T0>(arg0, v0);
        settle<T0>(arg0, arg1);
        let v1 = payable<T0>(arg0, arg1);
        arg0.paid = arg0.paid + (v1 as u128);
        let v2 = Claimed{
            pool       : 0x2::object::id<Pool<T0>>(arg0),
            stake      : 0x2::object::id<Stake<T0>>(arg1),
            owner      : 0x2::tx_context::sender(arg3),
            amount     : v1,
            stake_owed : arg1.owed,
            state      : state<T0>(arg0, v0),
        };
        0x2::event::emit<Claimed>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, v1), arg3)
    }

    public fun acc<T0>(arg0: &Pool<T0>) : u256 {
        arg0.acc
    }

    fun acc_at<T0>(arg0: &Pool<T0>, arg1: u64) : u256 {
        let v0 = 0x2::balance::value<T0>(&arg0.staked);
        if (arg1 <= arg0.last_ms || v0 == 0) {
            return arg0.acc
        };
        let v1 = (v0 as u256);
        let v2 = arg0.acc;
        let v3 = arg0.rate;
        let v4 = arg0.last_ms;
        let v5 = 0;
        while (v5 < 0x1::vector::length<End>(&arg0.ends) && 0x1::vector::borrow<End>(&arg0.ends, v5).at_ms <= arg1) {
            let v6 = *0x1::vector::borrow<End>(&arg0.ends, v5);
            if (v3 > 0) {
                v2 = v2 + v3 * ((v6.at_ms - v4) as u256) / v1;
            };
            v3 = v3 - v6.rate;
            v4 = v6.at_ms;
            v5 = v5 + 1;
        };
        if (v3 > 0 && arg1 > v4) {
            v2 = v2 + v3 * ((arg1 - v4) as u256) / v1;
        };
        v2
    }

    fun accrue<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        if (arg1 <= arg0.last_ms) {
            return
        };
        let v0 = arg0.last_ms;
        while (!0x1::vector::is_empty<End>(&arg0.ends) && 0x1::vector::borrow<End>(&arg0.ends, 0).at_ms <= arg1) {
            let v1 = 0x1::vector::remove<End>(&mut arg0.ends, 0);
            flow<T0>(arg0, v0, v1.at_ms);
            arg0.rate = arg0.rate - v1.rate;
            v0 = v1.at_ms;
        };
        flow<T0>(arg0, v0, arg1);
        arg0.last_ms = arg1;
    }

    public fun add<T0>(arg0: &mut Pool<T0>, arg1: &Registry, arg2: &mut Stake<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        open_for_more<T0>(arg0, arg1);
        assert!(arg2.pool == 0x2::object::id<Pool<T0>>(arg0), 3);
        put<T0>(arg0, arg2, arg3, 0x2::clock::timestamp_ms(arg4), 0x2::tx_context::sender(arg5));
    }

    public fun close<T0>(arg0: &mut Pool<T0>, arg1: Stake<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        current<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        accrue<T0>(arg0, v0);
        let v1 = &mut arg1;
        settle<T0>(arg0, v1);
        let v2 = &mut arg1;
        let v3 = payable<T0>(arg0, v2);
        let Stake {
            id     : v4,
            pool   : _,
            amount : v6,
            debt   : _,
            owed   : v8,
        } = arg1;
        let v9 = v4;
        if (v6 > 0) {
            arg0.stakers = arg0.stakers - 1;
        };
        arg0.paid = arg0.paid + (v3 as u128);
        let v10 = Unstaked{
            pool         : 0x2::object::id<Pool<T0>>(arg0),
            stake        : 0x2::object::uid_to_inner(&v9),
            owner        : 0x2::tx_context::sender(arg3),
            amount       : v6,
            reward       : v3,
            stake_amount : 0,
            stake_owed   : v8,
            closed       : true,
            state        : state<T0>(arg0, v0),
        };
        0x2::event::emit<Unstaked>(v10);
        0x2::object::delete(v9);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, v6), arg3), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, v3), arg3))
    }

    fun current<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 0);
    }

    public fun end_at(arg0: &End) : u64 {
        arg0.at_ms
    }

    public fun end_rate(arg0: &End) : u256 {
        arg0.rate
    }

    public fun ends<T0>(arg0: &Pool<T0>) : vector<End> {
        arg0.ends
    }

    fun flow<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) {
        if (arg2 <= arg1 || arg0.rate == 0) {
            return
        };
        let v0 = 0x2::balance::value<T0>(&arg0.staked);
        if (v0 == 0) {
            arg0.idle = arg0.idle + arg0.rate * ((arg2 - arg1) as u256);
        } else {
            arg0.acc = arg0.acc + arg0.rate * ((arg2 - arg1) as u256) / (v0 as u256);
        };
    }

    public fun fund<T0>(arg0: &mut Pool<T0>, arg1: &Registry, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        open_for_more<T0>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        accrue<T0>(arg0, v1);
        0x2::balance::join<T0>(&mut arg0.rewards, 0x2::coin::into_balance<T0>(arg2));
        let (v2, v3) = stream<T0>(arg0, (v0 as u256) * 1000000000000000000, v1);
        arg0.funded = arg0.funded + (v0 as u128);
        let v4 = Funded{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            funder   : 0x2::tx_context::sender(arg4),
            amount   : v0,
            end_ms   : v2,
            rate_add : v3,
            state    : state<T0>(arg0, v1),
        };
        0x2::event::emit<Funded>(v4);
    }

    public fun funded<T0>(arg0: &Pool<T0>) : u128 {
        arg0.funded
    }

    public fun idle<T0>(arg0: &Pool<T0>) : u256 {
        arg0.idle
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Registry{
            id      : 0x2::object::new(arg0),
            version : 1,
            paused  : false,
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    fun joining<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        if (0x2::balance::value<T0>(&arg0.staked) > 0 || arg0.idle < 1000000000000000000) {
            return
        };
        let v0 = arg0.idle;
        arg0.idle = 0;
        let (v1, v2) = stream<T0>(arg0, v0, arg1);
        let v3 = Restreamed{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            amount   : ((v0 / 1000000000000000000) as u64),
            end_ms   : v1,
            rate_add : v2,
            at_ms    : arg1,
        };
        0x2::event::emit<Restreamed>(v3);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 5);
        arg1.version = 1;
    }

    public fun migrate_pool<T0>(arg0: &mut Pool<T0>) {
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun open<T0>(arg0: &mut Registry, arg1: &0x2::clock::Clock) : Pool<T0> {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = PoolKey{coin: v0};
        let v3 = Pool<T0>{
            id      : 0x2::derived_object::claim<PoolKey>(&mut arg0.id, v2),
            version : 1,
            staked  : 0x2::balance::zero<T0>(),
            rewards : 0x2::balance::zero<T0>(),
            acc     : 0,
            rate    : 0,
            ends    : 0x1::vector::empty<End>(),
            idle    : 0,
            last_ms : v1,
            stakers : 0,
            funded  : 0,
            paid    : 0,
        };
        let v4 = PoolOpened{
            pool  : 0x2::object::id<Pool<T0>>(&v3),
            coin  : v0,
            at_ms : v1,
        };
        0x2::event::emit<PoolOpened>(v4);
        v3
    }

    fun open_for_more<T0>(arg0: &Pool<T0>, arg1: &Registry) {
        assert!(arg0.version == 1 && arg1.version == 1, 0);
        assert!(!arg1.paused, 1);
    }

    public fun paid<T0>(arg0: &Pool<T0>) : u128 {
        arg0.paid
    }

    fun payable<T0>(arg0: &Pool<T0>, arg1: &mut Stake<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.rewards);
        let v1 = if (arg1.owed <= v0) {
            arg1.owed
        } else {
            v0
        };
        arg1.owed = arg1.owed - v1;
        v1
    }

    public fun pending<T0>(arg0: &Pool<T0>, arg1: &Stake<T0>, arg2: &0x2::clock::Clock) : u64 {
        arg1.owed + (((arg1.amount as u256) * (acc_at<T0>(arg0, 0x2::clock::timestamp_ms(arg2)) - arg1.debt) / 1000000000000000000) as u64)
    }

    fun put<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        accrue<T0>(arg0, arg3);
        joining<T0>(arg0, arg3);
        settle<T0>(arg0, arg1);
        if (arg1.amount == 0) {
            arg0.stakers = arg0.stakers + 1;
        };
        arg1.amount = arg1.amount + v0;
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::coin::into_balance<T0>(arg2));
        let v1 = Staked{
            pool         : 0x2::object::id<Pool<T0>>(arg0),
            stake        : 0x2::object::id<Stake<T0>>(arg1),
            owner        : arg4,
            amount       : v0,
            stake_amount : arg1.amount,
            stake_owed   : arg1.owed,
            state        : state<T0>(arg0, arg3),
        };
        0x2::event::emit<Staked>(v1);
    }

    public fun rate<T0>(arg0: &Pool<T0>) : u256 {
        arg0.rate
    }

    public fun restake<T0>(arg0: &mut Pool<T0>, arg1: &Registry, arg2: &mut Stake<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        open_for_more<T0>(arg0, arg1);
        assert!(arg2.pool == 0x2::object::id<Pool<T0>>(arg0), 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        accrue<T0>(arg0, v0);
        settle<T0>(arg0, arg2);
        let v1 = payable<T0>(arg0, arg2);
        if (v1 == 0) {
            return
        };
        joining<T0>(arg0, v0);
        arg0.paid = arg0.paid + (v1 as u128);
        if (arg2.amount == 0) {
            arg0.stakers = arg0.stakers + 1;
        };
        arg2.amount = arg2.amount + v1;
        0x2::balance::join<T0>(&mut arg0.staked, 0x2::balance::split<T0>(&mut arg0.rewards, v1));
        let v2 = Restaked{
            pool         : 0x2::object::id<Pool<T0>>(arg0),
            stake        : 0x2::object::id<Stake<T0>>(arg2),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : v1,
            stake_amount : arg2.amount,
            stake_owed   : arg2.owed,
            state        : state<T0>(arg0, v0),
        };
        0x2::event::emit<Restaked>(v2);
    }

    public fun rewards<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.rewards)
    }

    public fun scale() : u256 {
        1000000000000000000
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool) {
        arg1.paused = arg2;
    }

    fun settle<T0>(arg0: &Pool<T0>, arg1: &mut Stake<T0>) {
        arg1.owed = arg1.owed + (((arg1.amount as u256) * (arg0.acc - arg1.debt) / 1000000000000000000) as u64);
        arg1.debt = arg0.acc;
    }

    public fun share<T0>(arg0: Pool<T0>) {
        0x2::transfer::share_object<Pool<T0>>(arg0);
    }

    public fun stake<T0>(arg0: &mut Pool<T0>, arg1: &Registry, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        open_for_more<T0>(arg0, arg1);
        let v0 = Stake<T0>{
            id     : 0x2::object::new(arg4),
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            amount : 0,
            debt   : 0,
            owed   : 0,
        };
        let v1 = &mut v0;
        put<T0>(arg0, v1, arg2, 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::sender(arg4));
        0x2::transfer::transfer<Stake<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun stake_amount<T0>(arg0: &Stake<T0>) : u64 {
        arg0.amount
    }

    public fun stake_owed<T0>(arg0: &Stake<T0>) : u64 {
        arg0.owed
    }

    public fun stake_pool<T0>(arg0: &Stake<T0>) : 0x2::object::ID {
        arg0.pool
    }

    public fun staked<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.staked)
    }

    public fun stakers<T0>(arg0: &Pool<T0>) : u64 {
        arg0.stakers
    }

    fun state<T0>(arg0: &Pool<T0>, arg1: u64) : State {
        State{
            acc     : arg0.acc,
            rate    : arg0.rate,
            staked  : 0x2::balance::value<T0>(&arg0.staked),
            rewards : 0x2::balance::value<T0>(&arg0.rewards),
            idle    : arg0.idle,
            at_ms   : arg1,
        }
    }

    fun stream<T0>(arg0: &mut Pool<T0>, arg1: u256, arg2: u64) : (u64, u256) {
        let v0 = (arg2 + 2592000000 + 86400000 - 1) / 86400000 * 86400000;
        let v1 = arg1 / ((v0 - arg2) as u256);
        arg0.rate = arg0.rate + v1;
        let v2 = 0x1::vector::length<End>(&arg0.ends);
        while (v2 > 0 && 0x1::vector::borrow<End>(&arg0.ends, v2 - 1).at_ms > v0) {
            v2 = v2 - 1;
        };
        if (v2 > 0 && 0x1::vector::borrow<End>(&arg0.ends, v2 - 1).at_ms == v0) {
            let v3 = 0x1::vector::borrow_mut<End>(&mut arg0.ends, v2 - 1);
            v3.rate = v3.rate + v1;
        } else {
            let v4 = End{
                at_ms : v0,
                rate  : v1,
            };
            0x1::vector::insert<End>(&mut arg0.ends, v4, v2);
        };
        (v0, v1)
    }

    public fun unstake<T0>(arg0: &mut Pool<T0>, arg1: &mut Stake<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        current<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 3);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= arg1.amount, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        accrue<T0>(arg0, v0);
        settle<T0>(arg0, arg1);
        arg1.amount = arg1.amount - arg2;
        if (arg1.amount == 0) {
            arg0.stakers = arg0.stakers - 1;
        };
        let v1 = payable<T0>(arg0, arg1);
        arg0.paid = arg0.paid + (v1 as u128);
        let v2 = Unstaked{
            pool         : 0x2::object::id<Pool<T0>>(arg0),
            stake        : 0x2::object::id<Stake<T0>>(arg1),
            owner        : 0x2::tx_context::sender(arg4),
            amount       : arg2,
            reward       : v1,
            stake_amount : arg1.amount,
            stake_owed   : arg1.owed,
            closed       : false,
            state        : state<T0>(arg0, v0),
        };
        0x2::event::emit<Unstaked>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.staked, arg2), arg4), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, v1), arg4))
    }

    // decompiled from Move bytecode v7
}

