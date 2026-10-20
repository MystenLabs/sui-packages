module 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow {
    struct EscrowRegistry<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct EscrowKey has copy, drop, store {
        pos0: address,
    }

    struct VestingTranche has copy, drop, store {
        amount: u64,
        released: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct LockPosition has copy, drop, store {
        lock_id: u64,
        amount: u64,
        start_ms: u64,
        end_ms: u64,
        boost_bps: u64,
        from_escrow: bool,
    }

    struct AutoLock has copy, drop, store {
        bps: u64,
        term_index: u64,
        term: 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm,
        relock: bool,
    }

    struct EscrowVault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        available: 0x2::balance::Balance<T0>,
        vesting: 0x2::balance::Balance<T0>,
        locked: 0x2::balance::Balance<T0>,
        tranches: vector<VestingTranche>,
        locks: vector<LockPosition>,
        next_lock_id: u64,
        auto_lock: 0x1::option::Option<AutoLock>,
        total_claimed: u64,
        total_exited: u64,
        total_penalized: u64,
    }

    struct EscrowOpened has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
    }

    struct VestStarted has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        end_ms: u64,
    }

    struct VestWithdrawn has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct ExitedEarly has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        received: u64,
        penalty_burned: u64,
        penalty_pooled: u64,
    }

    struct Locked has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        lock_id: u64,
        amount: u64,
        end_ms: u64,
        boost_bps: u64,
        from_escrow: bool,
    }

    struct Unlocked has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        lock_id: u64,
        amount: u64,
        received: u64,
        penalty_burned: u64,
        penalty_pooled: u64,
    }

    struct Relocked has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        lock_id: u64,
        end_ms: u64,
        boost_bps: u64,
    }

    struct AutoLockSet has copy, drop {
        escrow_id: 0x2::object::ID,
        owner: address,
        policy: 0x1::option::Option<AutoLock>,
    }

    public fun claim<T0>(arg0: &mut EscrowVault<T0>, arg1: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::EpochDistribution<T0>, arg2: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg3: u64, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock) {
        assert_known_version<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.available, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::take_claim<T0>(arg1, arg0.owner, 0x2::object::id<EscrowVault<T0>>(arg0), arg3, &arg4, arg5));
        arg0.total_claimed = arg0.total_claimed + arg3;
        let v0 = arg0.auto_lock;
        if (0x1::option::is_none<AutoLock>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<AutoLock>(v0);
        let v2 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg2);
        let v3 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::lock_terms(&v2);
        let v4 = 0x1::u64::mul_div(arg3, v1.bps, 10000);
        let v5 = if (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::is_paused<T0>(arg2)) {
            true
        } else if (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::version<T0>(arg2) != 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::package_version()) {
            true
        } else if (0x1::vector::length<LockPosition>(&arg0.locks) >= 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_locks(&v2)) {
            true
        } else if (!term_matches(&v1, &v3)) {
            true
        } else {
            v4 == 0
        };
        if (v5) {
            return
        };
        let v6 = 0x2::balance::split<T0>(&mut arg0.available, v4);
        add_lock<T0>(arg0, v6, v1.term, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_lock_bonus_bps(&v2), true, arg5);
    }

    fun assert_version<T0>(arg0: &EscrowVault<T0>) {
        assert!(arg0.version == 1, 13906836996136894465);
    }

    public fun boost_bps<T0>(arg0: &EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg1);
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_boosted_amount(&v0);
        let v2 = 0x1::vector::empty<LockPosition>();
        let v3 = arg0.locks;
        0x1::vector::reverse<LockPosition>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<LockPosition>(&v3)) {
            let v5 = 0x1::vector::pop_back<LockPosition>(&mut v3);
            if (v5.end_ms > 0x2::clock::timestamp_ms(arg2)) {
                0x1::vector::push_back<LockPosition>(&mut v2, v5);
            };
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<LockPosition>(v3);
        let v6 = &mut v2;
        let v7 = 0x1::vector::length<LockPosition>(v6);
        if (v7 < 2) {
        } else {
            let v8 = 1;
            while (v8 < v7) {
                while (v8 > 0 && !(0x1::vector::borrow<LockPosition>(v6, v8 - 1).boost_bps >= 0x1::vector::borrow<LockPosition>(v6, v8).boost_bps)) {
                    0x1::vector::swap<LockPosition>(v6, v8, v8 - 1);
                    v8 = v8 - 1;
                };
                v8 = v8 + 1;
            };
        };
        let v9 = 0;
        let v10 = &v2;
        let v11 = 0;
        while (v11 < 0x1::vector::length<LockPosition>(v10)) {
            let v12 = 0x1::vector::borrow<LockPosition>(v10, v11);
            let v13 = 0x1::u64::min(v12.amount, v1);
            v1 = v1 - v13;
            v9 = v9 + (v13 as u128) * ((v12.boost_bps - 10000) as u128);
            v11 = v11 + 1;
        };
        10000 + ((v9 / (v1 as u128)) as u64)
    }

    public fun version<T0>(arg0: &EscrowVault<T0>) : u64 {
        arg0.version
    }

    public fun active_locked_value<T0>(arg0: &EscrowVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = arg0.locks;
        0x1::vector::reverse<LockPosition>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<LockPosition>(&v1)) {
            let v3 = 0x1::vector::pop_back<LockPosition>(&mut v1);
            let v4 = if (v3.end_ms > 0x2::clock::timestamp_ms(arg1)) {
                v0 + v3.amount
            } else {
                v0
            };
            v0 = v4;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<LockPosition>(v1);
        v0
    }

    fun add_lock<T0>(arg0: &mut EscrowVault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = v1 + 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::duration_ms(&arg2);
        let v3 = 0x1::u64::mul_div(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::boost_bps(&arg2), arg3, 10000);
        let v4 = arg0.next_lock_id;
        arg0.next_lock_id = v4 + 1;
        let v5 = LockPosition{
            lock_id     : v4,
            amount      : v0,
            start_ms    : v1,
            end_ms      : v2,
            boost_bps   : v3,
            from_escrow : arg4,
        };
        0x1::vector::push_back<LockPosition>(&mut arg0.locks, v5);
        0x2::balance::join<T0>(&mut arg0.locked, arg1);
        let v6 = Locked{
            escrow_id   : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner       : arg0.owner,
            lock_id     : v4,
            amount      : v0,
            end_ms      : v2,
            boost_bps   : v3,
            from_escrow : arg4,
        };
        0x2::event::emit<Locked>(v6);
    }

    fun assert_known_version<T0>(arg0: &EscrowVault<T0>) {
        assert!(arg0.version <= 1, 13906837021906698241);
    }

    fun assert_owner<T0>(arg0: &EscrowVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13906837039086698499);
    }

    public fun auto_lock<T0>(arg0: &EscrowVault<T0>) : 0x1::option::Option<AutoLock> {
        arg0.auto_lock
    }

    public fun auto_lock_bps(arg0: &AutoLock) : u64 {
        arg0.bps
    }

    public fun auto_lock_relock(arg0: &AutoLock) : bool {
        arg0.relock
    }

    public fun auto_lock_term(arg0: &AutoLock) : 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm {
        arg0.term
    }

    public fun auto_lock_term_index(arg0: &AutoLock) : u64 {
        arg0.term_index
    }

    public fun auto_relock<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg1);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_not_paused<T0>(arg1);
        let v0 = arg0.auto_lock;
        let v1 = &v0;
        assert!(0x1::option::is_some<AutoLock>(v1) && 0x1::option::borrow<AutoLock>(v1).relock, 13906836257403961367);
        let v2 = 0x1::option::destroy_some<AutoLock>(v0);
        let v3 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg1);
        let v4 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::lock_terms(&v3);
        assert!(term_matches(&v2, &v4), 13906836265994420255);
        let v5 = lock_index<T0>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::vector::borrow<LockPosition>(&arg0.locks, v5).end_ms, 13906836274583437329);
        restart_lock<T0>(arg0, arg1, v5, v2.term_index, arg3);
    }

    public fun available_value<T0>(arg0: &EscrowVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.available)
    }

    fun checked_new_lock_term<T0>(arg0: &EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64) : (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm, u64) {
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg1);
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::lock_terms(&v0);
        assert!(arg2 < 0x1::vector::length<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(&v1), 13906837086331994125);
        assert!(0x1::vector::length<LockPosition>(&arg0.locks) < 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_locks(&v0), 13906837090626830347);
        (*0x1::vector::borrow<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(&v1, arg2), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_lock_bonus_bps(&v0))
    }

    public fun clear_auto_lock<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg1);
        arg0.auto_lock = 0x1::option::none<AutoLock>();
        emit_auto_lock_set<T0>(arg0);
    }

    public fun daily_point_cap<T0>(arg0: &EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::earning_caps<T0>(arg1);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::base_daily_points(&v0) + (0x1::u128::min(((active_locked_value<T0>(arg0, arg3) / 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::locked_unit(&v0)) as u128) * (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::points_per_locked_unit(&v0) as u128), (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_locked_points(&v0) as u128)) as u64) + 0x1::u64::min(arg2, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_counted_characters(&v0)) * 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::points_per_character(&v0)
    }

    fun early_unlock_penalty(arg0: &LockPosition, arg1: u64, arg2: u64) : u64 {
        (0x1::u128::mul_div_ceil((arg0.amount as u128) * (arg1 as u128), ((arg0.end_ms - arg2) as u128), (10000 as u128) * ((arg0.end_ms - arg0.start_ms) as u128)) as u64)
    }

    fun emit_auto_lock_set<T0>(arg0: &EscrowVault<T0>) {
        let v0 = AutoLockSet{
            escrow_id : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner     : arg0.owner,
            policy    : arg0.auto_lock,
        };
        0x2::event::emit<AutoLockSet>(v0);
    }

    public fun escrow_address(arg0: 0x2::object::ID, arg1: address) : address {
        let v0 = EscrowKey{pos0: arg1};
        0x2::derived_object::derive_address<EscrowKey>(arg0, v0)
    }

    public fun exit_now<T0>(arg0: &mut EscrowVault<T0>, arg1: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::RewardsPool<T0>, arg2: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>, arg3: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_known_version<T0>(arg0);
        assert_owner<T0>(arg0, arg5);
        assert!(arg4 > 0, 13906835553028145157);
        assert!(arg4 <= 0x2::balance::value<T0>(&arg0.available), 13906835557323243527);
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg3);
        let v1 = 0x1::u64::mul_div_ceil(arg4, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::exit_penalty_bps(&v0), 10000);
        let v2 = 0x2::balance::split<T0>(&mut arg0.available, arg4);
        let v3 = &mut v2;
        let (v4, v5) = pay_penalty<T0>(v3, v1, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::penalty_burn_bps(&v0), arg1, arg2);
        arg0.total_exited = arg0.total_exited + arg4;
        arg0.total_penalized = arg0.total_penalized + v1;
        let v6 = ExitedEarly{
            escrow_id      : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner          : arg0.owner,
            amount         : arg4,
            received       : 0x2::balance::value<T0>(&v2),
            penalty_burned : v4,
            penalty_pooled : v5,
        };
        0x2::event::emit<ExitedEarly>(v6);
        0x2::coin::from_balance<T0>(v2, arg5)
    }

    public fun lock_amount(arg0: &LockPosition) : u64 {
        arg0.amount
    }

    public fun lock_boost_bps(arg0: &LockPosition) : u64 {
        arg0.boost_bps
    }

    public fun lock_end_ms(arg0: &LockPosition) : u64 {
        arg0.end_ms
    }

    public fun lock_escrowed<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg5);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg1);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_not_paused<T0>(arg1);
        assert!(arg2 > 0, 13906835716236902405);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.available), 13906835720532000775);
        let (v0, v1) = checked_new_lock_term<T0>(arg0, arg1, arg3);
        let v2 = 0x2::balance::split<T0>(&mut arg0.available, arg2);
        add_lock<T0>(arg0, v2, v0, v1, true, arg4);
    }

    public fun lock_from_escrow(arg0: &LockPosition) : bool {
        arg0.from_escrow
    }

    public fun lock_id(arg0: &LockPosition) : u64 {
        arg0.lock_id
    }

    fun lock_index<T0>(arg0: &EscrowVault<T0>, arg1: u64) : u64 {
        let v0 = &arg0.locks;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<LockPosition>(v0)) {
            if (0x1::vector::borrow<LockPosition>(v0, v1).lock_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13906837404159705103);
                return 0x1::option::destroy_some<u64>(v2)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun lock_liquid<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg5);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg1);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_not_paused<T0>(arg1);
        assert!(0x2::coin::value<T0>(&arg2) > 0, 13906835810726182917);
        let (v0, _) = checked_new_lock_term<T0>(arg0, arg1, arg3);
        add_lock<T0>(arg0, 0x2::coin::into_balance<T0>(arg2), v0, 10000, false, arg4);
    }

    public fun lock_start_ms(arg0: &LockPosition) : u64 {
        arg0.start_ms
    }

    public fun locked_value<T0>(arg0: &EscrowVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun locks<T0>(arg0: &EscrowVault<T0>) : vector<LockPosition> {
        arg0.locks
    }

    public fun migrate<T0>(arg0: &mut EscrowVault<T0>) {
        assert!(arg0.version < 1, 13906836433498013725);
        arg0.version = 1;
    }

    public(friend) fun new_registry<T0>(arg0: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyRegistry) : EscrowRegistry<T0> {
        EscrowRegistry<T0>{id: 0x2::derived_object::claim<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::InstanceKey<T0>>(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::uid_mut(arg0), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::instance_key<T0>(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::kind_escrow_registry()))}
    }

    public fun open<T0>(arg0: &mut EscrowRegistry<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = EscrowKey{pos0: arg1};
        let v1 = EscrowVault<T0>{
            id              : 0x2::derived_object::claim<EscrowKey>(&mut arg0.id, v0),
            version         : 1,
            owner           : arg1,
            available       : 0x2::balance::zero<T0>(),
            vesting         : 0x2::balance::zero<T0>(),
            locked          : 0x2::balance::zero<T0>(),
            tranches        : 0x1::vector::empty<VestingTranche>(),
            locks           : 0x1::vector::empty<LockPosition>(),
            next_lock_id    : 0,
            auto_lock       : 0x1::option::none<AutoLock>(),
            total_claimed   : 0,
            total_exited    : 0,
            total_penalized : 0,
        };
        let v2 = 0x2::object::id<EscrowVault<T0>>(&v1);
        let v3 = EscrowOpened{
            escrow_id : v2,
            owner     : arg1,
        };
        0x2::event::emit<EscrowOpened>(v3);
        0x2::transfer::share_object<EscrowVault<T0>>(v1);
        v2
    }

    public fun owner<T0>(arg0: &EscrowVault<T0>) : address {
        arg0.owner
    }

    fun pay_penalty<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::RewardsPool<T0>, arg4: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>) : (u64, u64) {
        let v0 = 0x1::u64::mul_div(arg1, arg2, 10000);
        let v1 = arg1 - v0;
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::burn_balance<T0>(arg4, 0x2::balance::split<T0>(arg0, v0), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::source_penalty());
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::join<T0>(arg3, 0x2::balance::split<T0>(arg0, v1), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::source_penalty());
        (v0, v1)
    }

    public fun relock<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg5);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_version<T0>(arg1);
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::assert_not_paused<T0>(arg1);
        let v0 = lock_index<T0>(arg0, arg2);
        restart_lock<T0>(arg0, arg1, v0, arg3, arg4);
    }

    fun restart_lock<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg1);
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::lock_terms(&v0);
        assert!(arg3 < 0x1::vector::length<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(&v1), 13906837279605522445);
        let v2 = *0x1::vector::borrow<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(&v1, arg3);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = v3 + 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::duration_ms(&v2);
        let v5 = 0x1::vector::borrow_mut<LockPosition>(&mut arg0.locks, arg2);
        assert!(v4 >= v5.end_ms, 13906837301080883221);
        let v6 = if (v5.from_escrow) {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_lock_bonus_bps(&v0)
        } else {
            10000
        };
        v5.start_ms = v3;
        v5.end_ms = v4;
        v5.boost_bps = 0x1::u64::mul_div(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::boost_bps(&v2), v6, 10000);
        let v7 = Relocked{
            escrow_id : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner     : arg0.owner,
            lock_id   : v5.lock_id,
            end_ms    : v4,
            boost_bps : v5.boost_bps,
        };
        0x2::event::emit<Relocked>(v7);
    }

    public fun set_auto_lock<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg5);
        assert!(arg2 <= 10000, 13906836351893372953);
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg1);
        let v1 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::lock_terms(&v0);
        assert!(arg3 < 0x1::vector::length<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(&v1), 13906836360482521101);
        let v2 = AutoLock{
            bps        : arg2,
            term_index : arg3,
            term       : *0x1::vector::borrow<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(&v1, arg3),
            relock     : arg4,
        };
        arg0.auto_lock = 0x1::option::some<AutoLock>(v2);
        emit_auto_lock_set<T0>(arg0);
    }

    public(friend) fun share_registry<T0>(arg0: EscrowRegistry<T0>) {
        0x2::transfer::share_object<EscrowRegistry<T0>>(arg0);
    }

    public fun start_vest<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg4);
        assert!(arg2 > 0, 13906835351164682245);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.available), 13906835355459780615);
        let v0 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg1);
        assert!(0x1::vector::length<VestingTranche>(&arg0.tranches) < 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::max_vesting_tranches(&v0), 13906835364049846281);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::vest_duration_ms(&v0);
        let v3 = VestingTranche{
            amount   : arg2,
            released : 0,
            start_ms : v1,
            end_ms   : v2,
        };
        0x1::vector::push_back<VestingTranche>(&mut arg0.tranches, v3);
        0x2::balance::join<T0>(&mut arg0.vesting, 0x2::balance::split<T0>(&mut arg0.available, arg2));
        let v4 = VestStarted{
            escrow_id : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner     : arg0.owner,
            amount    : arg2,
            end_ms    : v2,
        };
        0x2::event::emit<VestStarted>(v4);
    }

    fun term_matches(arg0: &AutoLock, arg1: &vector<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>) : bool {
        arg0.term_index < 0x1::vector::length<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(arg1) && *0x1::vector::borrow<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::LockTerm>(arg1, arg0.term_index) == arg0.term
    }

    public fun total_claimed<T0>(arg0: &EscrowVault<T0>) : u64 {
        arg0.total_claimed
    }

    public fun total_exited<T0>(arg0: &EscrowVault<T0>) : u64 {
        arg0.total_exited
    }

    public fun total_penalized<T0>(arg0: &EscrowVault<T0>) : u64 {
        arg0.total_penalized
    }

    public fun tranche_amount(arg0: &VestingTranche) : u64 {
        arg0.amount
    }

    public fun tranche_end_ms(arg0: &VestingTranche) : u64 {
        arg0.end_ms
    }

    public fun tranche_released(arg0: &VestingTranche) : u64 {
        arg0.released
    }

    public fun tranche_start_ms(arg0: &VestingTranche) : u64 {
        arg0.start_ms
    }

    public fun tranches<T0>(arg0: &EscrowVault<T0>) : vector<VestingTranche> {
        arg0.tranches
    }

    public fun unlock<T0>(arg0: &mut EscrowVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_known_version<T0>(arg0);
        assert_owner<T0>(arg0, arg3);
        let v0 = lock_index<T0>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x1::vector::borrow<LockPosition>(&arg0.locks, v0).end_ms, 13906835883741413393);
        let v1 = 0x1::vector::remove<LockPosition>(&mut arg0.locks, v0);
        let v2 = Unlocked{
            escrow_id      : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner          : arg0.owner,
            lock_id        : arg1,
            amount         : v1.amount,
            received       : v1.amount,
            penalty_burned : 0,
            penalty_pooled : 0,
        };
        0x2::event::emit<Unlocked>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked, v1.amount), arg3)
    }

    public fun unlock_early<T0>(arg0: &mut EscrowVault<T0>, arg1: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::rewards::RewardsPool<T0>, arg2: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>, arg3: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        assert_owner<T0>(arg0, arg6);
        let v0 = lock_index<T0>(arg0, arg4);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 < 0x1::vector::borrow<LockPosition>(&arg0.locks, v0).end_ms, 13906836021180497939);
        let v2 = 0x1::vector::remove<LockPosition>(&mut arg0.locks, v0);
        let v3 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::escrow_params<T0>(arg3);
        let v4 = early_unlock_penalty(&v2, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::early_unlock_penalty_bps(&v3), v1);
        let v5 = 0x2::balance::split<T0>(&mut arg0.locked, v2.amount);
        let v6 = &mut v5;
        let (v7, v8) = pay_penalty<T0>(v6, v4, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::penalty_burn_bps(&v3), arg1, arg2);
        arg0.total_penalized = arg0.total_penalized + v4;
        let v9 = Unlocked{
            escrow_id      : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner          : arg0.owner,
            lock_id        : arg4,
            amount         : v2.amount,
            received       : 0x2::balance::value<T0>(&v5),
            penalty_burned : v7,
            penalty_pooled : v8,
        };
        0x2::event::emit<Unlocked>(v9);
        0x2::coin::from_balance<T0>(v5, arg6)
    }

    fun vested_at(arg0: &VestingTranche, arg1: u64) : u64 {
        if (arg1 >= arg0.end_ms) {
            arg0.amount
        } else if (arg1 <= arg0.start_ms) {
            0
        } else {
            0x1::u64::mul_div(arg0.amount, arg1 - arg0.start_ms, arg0.end_ms - arg0.start_ms)
        }
    }

    public fun vesting_value<T0>(arg0: &EscrowVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vesting)
    }

    public fun withdraw_vested<T0>(arg0: &mut EscrowVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_known_version<T0>(arg0);
        assert_owner<T0>(arg0, arg2);
        let v0 = withdrawable_now<T0>(arg0, arg1);
        assert!(v0 > 0, 13906835458540306459);
        let v1 = &mut arg0.tranches;
        let v2 = 0;
        while (v2 < 0x1::vector::length<VestingTranche>(v1)) {
            let v3 = 0x1::vector::borrow_mut<VestingTranche>(v1, v2);
            v3.released = vested_at(v3, 0x2::clock::timestamp_ms(arg1));
            v2 = v2 + 1;
        };
        let v4 = 0x1::vector::empty<VestingTranche>();
        let v5 = arg0.tranches;
        0x1::vector::reverse<VestingTranche>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<VestingTranche>(&v5)) {
            let v7 = 0x1::vector::pop_back<VestingTranche>(&mut v5);
            let v8 = &v7;
            if (v8.released < v8.amount) {
                0x1::vector::push_back<VestingTranche>(&mut v4, v7);
            };
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<VestingTranche>(v5);
        arg0.tranches = v4;
        let v9 = VestWithdrawn{
            escrow_id : 0x2::object::id<EscrowVault<T0>>(arg0),
            owner     : arg0.owner,
            amount    : v0,
        };
        0x2::event::emit<VestWithdrawn>(v9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vesting, v0), arg2)
    }

    public fun withdrawable_now<T0>(arg0: &EscrowVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = arg0.tranches;
        0x1::vector::reverse<VestingTranche>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<VestingTranche>(&v1)) {
            let v3 = 0x1::vector::pop_back<VestingTranche>(&mut v1);
            let v4 = v0 + vested_at(&v3, 0x2::clock::timestamp_ms(arg1));
            v0 = v4 - v3.released;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<VestingTranche>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

