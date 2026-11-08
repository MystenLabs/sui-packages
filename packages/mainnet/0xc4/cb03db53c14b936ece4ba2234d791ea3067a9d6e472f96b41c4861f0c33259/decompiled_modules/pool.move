module 0xc4cb03db53c14b936ece4ba2234d791ea3067a9d6e472f96b41c4861f0c33259::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResolverCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        fee_bps: u64,
        min_stake: u64,
        max_stake_per_user: u64,
        max_pool: u64,
        refund_after_ms: u64,
        registry: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct Position has store {
        side: bool,
        amount: u64,
        claimed: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        question_hash: vector<u8>,
        close_ms: u64,
        yes: 0x2::balance::Balance<0x2::sui::SUI>,
        no: 0x2::balance::Balance<0x2::sui::SUI>,
        positions: 0x2::table::Table<address, Position>,
        status: u8,
        outcome: bool,
        fee_taken: u64,
        yes_total: u64,
        no_total: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        question_hash: vector<u8>,
        close_ms: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        staker: address,
        side: bool,
        amount: u64,
        pick_hash: vector<u8>,
    }

    struct Resolved has copy, drop {
        pool: 0x2::object::ID,
        outcome_yes: bool,
        yes_total: u64,
        no_total: u64,
        fee: u64,
    }

    struct Voided has copy, drop {
        pool: 0x2::object::ID,
    }

    struct Claimed has copy, drop {
        pool: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    public fun claim(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 0, 12);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 13);
        let v1 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        assert!(!v1.claimed, 14);
        v1.claimed = true;
        let v2 = if (arg0.status == 2) {
            if (v1.side) {
                0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes, v1.amount)
            } else {
                0x2::balance::split<0x2::sui::SUI>(&mut arg0.no, v1.amount)
            }
        } else {
            assert!(v1.side == arg0.outcome, 15);
            let v3 = if (arg0.outcome) {
                arg0.yes_total
            } else {
                arg0.no_total
            };
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes, payout(v1.amount, arg0.yes_total + arg0.no_total - arg0.fee_taken, v3))
        };
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1), v0);
        let v5 = Claimed{
            pool    : 0x2::object::id<Pool>(arg0),
            claimer : v0,
            amount  : 0x2::balance::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<Claimed>(v5);
    }

    public fun create_pool(arg0: &ResolverCap, arg1: &mut Config, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 1);
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.registry, arg2), 2);
        let v0 = Pool{
            id            : 0x2::object::new(arg5),
            question_hash : arg2,
            close_ms      : arg3,
            yes           : 0x2::balance::zero<0x2::sui::SUI>(),
            no            : 0x2::balance::zero<0x2::sui::SUI>(),
            positions     : 0x2::table::new<address, Position>(arg5),
            status        : 0,
            outcome       : false,
            fee_taken     : 0,
            yes_total     : 0,
            no_total      : 0,
        };
        let v1 = 0x2::object::id<Pool>(&v0);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg1.registry, arg2, v1);
        let v2 = PoolCreated{
            pool          : v1,
            question_hash : arg2,
            close_ms      : arg3,
        };
        0x2::event::emit<PoolCreated>(v2);
        0x2::transfer::share_object<Pool>(v0);
    }

    fun fee_on(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                 : 0x2::object::new(arg0),
            treasury           : @0x8e0e9fecb8141cc2635effcb1a0d25c96331eecae8eb998329c47241259abb6a,
            fee_bps            : 100,
            min_stake          : 100000000,
            max_stake_per_user : 5000000000,
            max_pool           : 50000000000,
            refund_after_ms    : 604800000,
            registry           : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = ResolverCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ResolverCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun mark_void(arg0: &mut Pool) {
        arg0.status = 2;
        let v0 = Voided{pool: 0x2::object::id<Pool>(arg0)};
        0x2::event::emit<Voided>(v0);
    }

    fun payout(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun resolve(arg0: &ResolverCap, arg1: &Config, arg2: &mut Pool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 3);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.close_ms, 10);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2.yes);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg2.no);
        arg2.yes_total = v0;
        arg2.no_total = v1;
        let v2 = if (arg3) {
            v0
        } else {
            v1
        };
        if (v2 == 0) {
            mark_void(arg2);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.yes, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.no));
        let v3 = fee_on(v0 + v1, arg1.fee_bps);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.yes, v3), arg5), arg1.treasury);
        };
        arg2.status = 1;
        arg2.outcome = arg3;
        arg2.fee_taken = v3;
        let v4 = Resolved{
            pool        : 0x2::object::id<Pool>(arg2),
            outcome_yes : arg3,
            yes_total   : v0,
            no_total    : v1,
            fee         : v3,
        };
        0x2::event::emit<Resolved>(v4);
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 500, 16);
        arg1.fee_bps = arg2;
    }

    public fun set_limits(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg2 > 0) {
            if (arg2 <= arg3) {
                arg3 <= arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 17);
        arg1.min_stake = arg2;
        arg1.max_stake_per_user = arg3;
        arg1.max_pool = arg4;
        arg1.refund_after_ms = arg5;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun stake(arg0: &Config, arg1: &mut Pool, arg2: bool, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 3);
        assert!(0x2::clock::timestamp_ms(arg5) < arg1.close_ms, 4);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 9);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.min_stake, 5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.yes) + 0x2::balance::value<0x2::sui::SUI>(&arg1.no) + v0 <= arg0.max_pool, 8);
        let v1 = 0x2::tx_context::sender(arg6);
        if (0x2::table::contains<address, Position>(&arg1.positions, v1)) {
            let v2 = 0x2::table::borrow_mut<address, Position>(&mut arg1.positions, v1);
            assert!(v2.side == arg2, 6);
            assert!(v2.amount + v0 <= arg0.max_stake_per_user, 7);
            v2.amount = v2.amount + v0;
        } else {
            assert!(v0 <= arg0.max_stake_per_user, 7);
            let v3 = Position{
                side    : arg2,
                amount  : v0,
                claimed : false,
            };
            0x2::table::add<address, Position>(&mut arg1.positions, v1, v3);
        };
        if (arg2) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.yes, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.no, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        };
        let v4 = Staked{
            pool      : 0x2::object::id<Pool>(arg1),
            staker    : v1,
            side      : arg2,
            amount    : v0,
            pick_hash : arg4,
        };
        0x2::event::emit<Staked>(v4);
    }

    public fun void(arg0: &ResolverCap, arg1: &mut Pool) {
        assert!(arg1.status == 0, 3);
        mark_void(arg1);
    }

    public fun void_expired(arg0: &Config, arg1: &mut Pool, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 0, 3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.close_ms && v0 - arg1.close_ms > arg0.refund_after_ms, 11);
        mark_void(arg1);
    }

    // decompiled from Move bytecode v7
}

