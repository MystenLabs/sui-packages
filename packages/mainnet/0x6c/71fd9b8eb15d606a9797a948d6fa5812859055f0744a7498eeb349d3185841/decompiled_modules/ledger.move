module 0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::ledger {
    struct LEDGER has drop {
        dummy_field: bool,
    }

    struct Setup has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct ImportCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        source: 0x2::object::ID,
    }

    struct PoolAdmin has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct CooldownChanged has copy, drop {
        pool: 0x2::object::ID,
        old_ms: u64,
        new_ms: u64,
        admin: address,
    }

    struct Position<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct PositionState<phantom T0> has store {
        owner: address,
        active: u64,
        short: u64,
        orders: 0x2::table::Table<u64, Cooling<T0>>,
        next_order: u64,
    }

    struct Cooling<phantom T0> has store {
        principal: 0x2::balance::Balance<T0>,
        ready_at: u64,
    }

    struct BehaviorMetrics has copy, drop, store {
        vault_usd_e6: u128,
        hatoken_usd_e6: u128,
        average_active: u64,
        active_days: u8,
    }

    struct PositionChanged has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        owner: address,
        active: u64,
        short: u64,
    }

    struct PositionTransferred has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct PositionOrder has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        order: u64,
        amount: u64,
        ready_at: u64,
        owner: address,
    }

    struct PositionOrderClosed has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        order: u64,
        owner: address,
        amount: u64,
        cancelled: bool,
    }

    struct Account has store {
        active: u64,
        short: u64,
        member: 0x1::option::Option<0x2::object::ID>,
        positions: vector<0x2::object::ID>,
        long_import: 0x1::option::Option<0x2::object::ID>,
        short_import: 0x1::option::Option<0x2::object::ID>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        accounts: 0x2::table::Table<address, Account>,
        positions: 0x2::table::Table<0x2::object::ID, PositionState<T0>>,
        vault: 0x2::balance::Balance<T0>,
        active: u64,
        short: u64,
        reserve: 0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::Reserve,
        cooldown_ms: u64,
        live: bool,
        paused: bool,
        reward_claims_paused: bool,
        operators: vector<address>,
        pausers: vector<address>,
        distributor_registered: bool,
        scheduled_start_ms: 0x1::option::Option<u64>,
        reward_duration_ms: u64,
        start: u64,
        started: bool,
        migration_root: vector<u8>,
        context_hash: vector<u8>,
    }

    struct Changed has copy, drop {
        pool: 0x2::object::ID,
        user: address,
        active: u64,
        short: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct InstantExited has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        amount: u64,
        fee: u64,
    }

    struct ShortClaimed has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Ordered has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        order: 0x2::object::ID,
        amount: u64,
        ready_at: u64,
    }

    struct Claimed has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        order: 0x2::object::ID,
        amount: u64,
    }

    struct ExitCancelled has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        order: 0x2::object::ID,
        amount: u64,
    }

    struct RewardDeposited<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        operator: address,
        amount: u64,
    }

    struct ActionPauseChanged has copy, drop {
        pool: 0x2::object::ID,
        action: u8,
        paused: bool,
        actor: address,
    }

    struct PauseChanged has copy, drop {
        pool: 0x2::object::ID,
        paused: bool,
    }

    struct PauserChanged has copy, drop {
        pool: 0x2::object::ID,
        pauser: address,
        enabled: bool,
    }

    struct RewardClaimsPauseChanged has copy, drop {
        pool: 0x2::object::ID,
        paused: bool,
    }

    struct OperatorChanged has copy, drop {
        pool: 0x2::object::ID,
        operator: address,
        enabled: bool,
        admin: address,
    }

    struct InstantFeeChanged has copy, drop {
        pool: 0x2::object::ID,
        old_bps: u64,
        new_bps: u64,
        admin: address,
    }

    fun account<T0>(arg0: &mut Pool<T0>, arg1: address) : &mut Account {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            let v0 = Account{
                active       : 0,
                short        : 0,
                member       : 0x1::option::none<0x2::object::ID>(),
                positions    : 0x1::vector::empty<0x2::object::ID>(),
                long_import  : 0x1::option::none<0x2::object::ID>(),
                short_import : 0x1::option::none<0x2::object::ID>(),
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1, v0);
        };
        0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1)
    }

    public fun add_operator<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624222167531543);
        assert!(arg2 != @0x0, 13835624226462498839);
        assert!(!is_operator<T0>(arg0, arg2), 13837031605641674785);
        0x1::vector::push_back<address>(&mut arg0.operators, arg2);
        let v0 = OperatorChanged{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            operator : arg2,
            enabled  : true,
            admin    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OperatorChanged>(v0);
    }

    public fun add_stake<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 1 == 0, 13836185235090964507);
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= 10000000000, 13835340823045341205);
        credit<T0>(arg0, v0, 0x2::coin::into_balance<T0>(arg2), v1);
        let v2 = Staked{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            owner  : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<Staked>(v2);
    }

    public(friend) fun assert_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 3, 13837593705191833637);
    }

    fun available<T0>(arg0: &Pool<T0>) {
        assert_version<T0>(arg0);
        assert!(arg0.live, 13835061224969207827);
        assert!(!arg0.paused, 13836187129171542043);
    }

    public fun balance_of<T0>(arg0: &Pool<T0>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        (v0.active, v0.short)
    }

    public fun base_weight_bps() : u64 {
        10000
    }

    public fun begin_epochs<T0>(arg0: &ImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        check_empty_import<T0>(arg0, arg1, arg2);
        assert!(!arg1.started, 13835060228536795155);
        arg1.start = 0x2::clock::timestamp_ms(arg3);
        arg1.started = true;
    }

    public fun cancel_epochs<T0>(arg0: &ImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID) {
        check_empty_import<T0>(arg0, arg1, arg2);
        arg1.started = false;
        arg1.start = 0;
    }

    public fun cancel_order<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let Cooling {
            principal : v1,
            ready_at  : _,
        } = 0x2::table::remove<u64, Cooling<T0>>(&mut 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0).orders, arg2);
        let v3 = v1;
        let v4 = 0x2::balance::value<T0>(&v3);
        credit<T0>(arg0, v0, v3, v4);
        let v5 = PositionOrderClosed{
            pool      : 0x2::object::id<Pool<T0>>(arg0),
            position  : v0,
            order     : arg2,
            owner     : 0x2::tx_context::sender(arg3),
            amount    : v4,
            cancelled : true,
        };
        0x2::event::emit<PositionOrderClosed>(v5);
    }

    fun change_pause<T0>(arg0: &mut Pool<T0>, arg1: u8, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        if (arg1 == 4) {
            arg0.reward_claims_paused = arg2;
            let v0 = RewardClaimsPauseChanged{
                pool   : 0x2::object::id<Pool<T0>>(arg0),
                paused : arg2,
            };
            0x2::event::emit<RewardClaimsPauseChanged>(v0);
        } else {
            let v1 = if (arg1 == 16) {
                1 | 2 | 8
            } else {
                arg1
            };
            let v2 = if (arg1 == 16) {
                true
            } else if (arg1 == 1) {
                true
            } else if (arg1 == 2) {
                true
            } else {
                arg1 == 8
            };
            assert!(v2, 13835623942994657303);
            let v3 = if (arg2) {
                pause_flags<T0>(arg0) | v1
            } else {
                pause_flags<T0>(arg0) & (255 ^ v1)
            };
            if (arg1 == 16) {
                if (!arg2) {
                    arg0.paused = false;
                };
                let v4 = PauseChanged{
                    pool   : 0x2::object::id<Pool<T0>>(arg0),
                    paused : arg2,
                };
                0x2::event::emit<PauseChanged>(v4);
            };
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"vehaedal_pause_flags")) {
                *0x2::dynamic_field::borrow_mut<vector<u8>, u8>(&mut arg0.id, b"vehaedal_pause_flags") = v3;
            } else {
                0x2::dynamic_field::add<vector<u8>, u8>(&mut arg0.id, b"vehaedal_pause_flags", v3);
            };
        };
        let v5 = ActionPauseChanged{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            action : arg1,
            paused : arg2,
            actor  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ActionPauseChanged>(v5);
    }

    fun changed<T0>(arg0: &Pool<T0>, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, arg1);
        let v1 = PositionChanged{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            position : arg1,
            owner    : v0.owner,
            active   : v0.active,
            short    : v0.short,
        };
        0x2::event::emit<PositionChanged>(v1);
        emit_balance<T0>(arg0, v0.owner);
    }

    public fun check_empty_import<T0>(arg0: &ImportCap, arg1: &Pool<T0>, arg2: 0x2::object::ID) {
        check_import<T0>(arg0, arg1, arg2);
        let v0 = if (0x2::table::is_empty<address, Account>(&arg1.accounts)) {
            if (0x2::balance::value<T0>(&arg1.vault) == 0) {
                if (arg1.active == 0) {
                    arg1.short == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835624432620929047);
    }

    public fun check_import<T0>(arg0: &ImportCap, arg1: &Pool<T0>, arg2: 0x2::object::ID) {
        assert_version<T0>(arg1);
        let v0 = if (!arg1.live) {
            if (arg0.source == arg2) {
                arg0.pool == 0x2::object::id<Pool<T0>>(arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835624454095765527);
    }

    public fun close_position<T0>(arg0: &mut Pool<T0>, arg1: Position<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, &arg1, arg2);
        let v1 = 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, v0);
        let v2 = if (v1.active == 0) {
            if (v1.short == 0) {
                0x2::table::is_empty<u64, Cooling<T0>>(&v1.orders)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 13835340986254098453);
        let v3 = &mut 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, 0x2::tx_context::sender(arg2)).positions;
        remove_id(v3, v0);
        let Position {
            id   : v4,
            pool : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public fun cooldown_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.cooldown_ms
    }

    public fun create_position<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 1 == 0, 13836185192141291547);
        available<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000000, 13835340780095668245);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = mint_position<T0>(arg0, v1, arg2);
        credit<T0>(arg0, v2, 0x2::coin::into_balance<T0>(arg1), v0);
        let v3 = Staked{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            owner  : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<Staked>(v3);
    }

    fun credit<T0>(arg0: &mut Pool<T0>, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        let v0 = 0x2::balance::value<T0>(&arg2) - arg3;
        0x2::balance::join<T0>(&mut arg0.vault, arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, arg1);
        v1.active = v1.active + arg3;
        v1.short = v1.short + v0;
        let v2 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v1.owner);
        v2.active = v2.active + arg3;
        v2.short = v2.short + v0;
        arg0.active = arg0.active + arg3;
        arg0.short = arg0.short + v0;
        changed<T0>(arg0, arg1);
    }

    public fun current_epoch<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = reward_start_ms<T0>(arg0);
        assert!(arg0.started && v0 >= v1, 13835060683803328531);
        (v0 - v1) / arg0.reward_duration_ms
    }

    fun debit_short_position<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        assert!(arg2 > 0 && v1.short >= arg2, 13835341321261547541);
        v1.short = v1.short - arg2;
        let v2 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, 0x2::tx_context::sender(arg3));
        v2.short = v2.short - arg2;
        arg0.short = arg0.short - arg2;
        v0
    }

    public(friend) fun draw_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T1> {
        assert_version<T0>(arg0);
        0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::draw<T1>(&mut arg0.reserve, arg1, arg2)
    }

    fun emit_balance<T0>(arg0: &Pool<T0>, arg1: address) {
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        let v1 = Changed{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            user   : arg1,
            active : v0.active,
            short  : v0.short,
        };
        0x2::event::emit<Changed>(v1);
    }

    public fun epoch_duration_ms() : u64 {
        604800000
    }

    public(friend) fun epoch_start<T0>(arg0: &Pool<T0>, arg1: &0x2::tx_context::TxContext) : u64 {
        assert_version<T0>(arg0);
        assert!(arg0.live, 13835060709573132307);
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg1)), 13836749563729149983);
        reward_start_ms<T0>(arg0)
    }

    public fun fund_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_operator<T0>(arg0, v0), 13836749379045556255);
        let v1 = 0x2::object::id<Pool<T0>>(arg0);
        let v2 = 0x2::coin::value<T1>(&arg1);
        assert!(v2 > 0, 13835342017046249493);
        let v3 = RewardDeposited<T1>{
            pool     : v1,
            operator : v0,
            amount   : v2,
        };
        0x2::event::emit<RewardDeposited<T1>>(v3);
        0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::deposit<T1>(&mut arg0.reserve, v1, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun import_position<T0>(arg0: &ImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_import<T0>(arg0, arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg4) > 0 && (arg5 == 0 || arg5 == 0x2::balance::value<T0>(&arg4)), 13835341029203771413);
        let v0 = account<T0>(arg1, arg3);
        let v1 = if (arg5 > 0) {
            v0.long_import
        } else {
            v0.short_import
        };
        let v2 = v1;
        let v3 = if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            *0x1::option::borrow<0x2::object::ID>(&v2)
        } else {
            let v4 = mint_position<T0>(arg1, arg3, arg6);
            if (arg5 > 0) {
                0x2::table::borrow_mut<address, Account>(&mut arg1.accounts, arg3).long_import = 0x1::option::some<0x2::object::ID>(v4);
            } else {
                0x2::table::borrow_mut<address, Account>(&mut arg1.accounts, arg3).short_import = 0x1::option::some<0x2::object::ID>(v4);
            };
            v4
        };
        credit<T0>(arg1, v3, arg4, arg5);
        v3
    }

    fun init(arg0: LEDGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Setup{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<LEDGER>(arg0, arg1),
        };
        0x2::transfer::transfer<Setup>(v0, 0x2::tx_context::sender(arg1));
    }

    fun instant_fee<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        ((((arg1 as u128) * (instant_fee_bps<T0>(arg0) as u128) + 10000 - 1) / 10000) as u64)
    }

    public fun instant_fee_bps<T0>(arg0: &Pool<T0>) : u64 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"instant_exit_fee_bps")) {
            *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"instant_exit_fee_bps")
        } else {
            500
        }
    }

    public fun is_operator<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public(friend) fun mark_distributor<T0>(arg0: &mut Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        epoch_start<T0>(arg0, arg1);
        assert!(!arg0.distributor_registered, 13835624368196419607);
        arg0.distributor_registered = true;
    }

    public fun migrate_version<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623401828778007);
        assert!(arg0.version < 3, 13837593730961637413);
        arg0.version = 3;
        if (arg0.paused) {
            arg0.paused = false;
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"vehaedal_pause_flags")) {
                *0x2::dynamic_field::borrow_mut<vector<u8>, u8>(&mut arg0.id, b"vehaedal_pause_flags") = pause_flags<T0>(arg0) | 1 | 2 | 8;
            } else {
                0x2::dynamic_field::add<vector<u8>, u8>(&mut arg0.id, b"vehaedal_pause_flags", pause_flags<T0>(arg0) | 1 | 2 | 8);
            };
        };
    }

    public fun migration_context<T0>(arg0: &Pool<T0>) : vector<u8> {
        arg0.context_hash
    }

    fun mint_position<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Position<T0>{
            id   : 0x2::object::new(arg2),
            pool : 0x2::object::id<Pool<T0>>(arg0),
        };
        let v1 = 0x2::object::id<Position<T0>>(&v0);
        let v2 = account<T0>(arg0, arg1);
        assert!(0x1::vector::length<0x2::object::ID>(&v2.positions) < 10, 13835340595412074517);
        0x1::vector::push_back<0x2::object::ID>(&mut v2.positions, v1);
        let v3 = PositionState<T0>{
            owner      : arg1,
            active     : 0,
            short      : 0,
            orders     : 0x2::table::new<u64, Cooling<T0>>(arg2),
            next_order : 0,
        };
        0x2::table::add<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v1, v3);
        0x2::transfer::transfer<Position<T0>>(v0, arg1);
        v1
    }

    public fun open<T0>(arg0: ImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) {
        assert_version<T0>(arg1);
        let ImportCap {
            id     : v0,
            pool   : v1,
            source : v2,
        } = arg0;
        let v3 = if (!arg1.live) {
            if (v1 == 0x2::object::id<Pool<T0>>(arg1)) {
                if (arg2 == v2) {
                    0x2::balance::value<T0>(&arg1.vault) == arg3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 13835623285864661015);
        let v4 = if (0x1::vector::length<u8>(&arg5) == 32) {
            if (0x1::vector::length<u8>(&arg6) == 32) {
                arg1.active + arg1.short == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 13835623303044530199);
        0x2::object::delete(v0);
        arg1.migration_root = arg5;
        arg1.context_hash = arg6;
        arg1.live = true;
        assert!(!arg1.started || arg1.start == arg4, 13835904803791175705);
        arg1.started = true;
        arg1.start = arg4;
    }

    public fun pause_action<T0>(arg0: &mut Pool<T0>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.pausers, &v0), 13836749907326533663);
        change_pause<T0>(arg0, arg1, true, arg2);
    }

    public fun pause_flags<T0>(arg0: &Pool<T0>) : u8 {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"vehaedal_pause_flags")) {
            *0x2::dynamic_field::borrow<vector<u8>, u8>(&arg0.id, b"vehaedal_pause_flags")
        } else {
            0
        }
    }

    public fun position_balance<T0>(arg0: &Pool<T0>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, arg1);
        (v0.active, v0.short)
    }

    public fun position_metadata() : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (0x1::string::utf8(b"veHAEDAL Position #{id}"), 0x1::string::utf8(b"A veHAEDAL NFT representing staked HAEDAL in the Haedal Protocol on Sui."), 0x1::string::utf8(b"veHAEDAL NFT"), 0x1::string::utf8(b"https://assets.haedal.xyz/images/veHAEDALV2.svg"))
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(arg0, &arg1);
        assert!(v0, 13835622328086954007);
        0x1::vector::swap_remove<0x2::object::ID>(arg0, v1);
    }

    public fun remove_operator<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624303771910167);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg2);
        assert!(v0, 13837313162222895139);
        0x1::vector::swap_remove<address>(&mut arg0.operators, v1);
        let v2 = OperatorChanged{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            operator : arg2,
            enabled  : false,
            admin    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OperatorChanged>(v2);
    }

    public fun replace_guardian<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: address) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && arg2 != @0x0, 13835624063253741591);
        while (!0x1::vector::is_empty<address>(&arg0.pausers)) {
            let v0 = PauserChanged{
                pool    : 0x2::object::id<Pool<T0>>(arg0),
                pauser  : 0x1::vector::pop_back<address>(&mut arg0.pausers),
                enabled : false,
            };
            0x2::event::emit<PauserChanged>(v0);
        };
        0x1::vector::push_back<address>(&mut arg0.pausers, arg2);
        let v1 = PauserChanged{
            pool    : 0x2::object::id<Pool<T0>>(arg0),
            pauser  : arg2,
            enabled : true,
        };
        0x2::event::emit<PauserChanged>(v1);
    }

    fun require_owner<T0>(arg0: &Pool<T0>, arg1: &Position<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        available<T0>(arg0);
        let v0 = 0x2::object::id<Position<T0>>(arg1);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, v0).owner == 0x2::tx_context::sender(arg2), 13835622134813425687);
        v0
    }

    public fun restake_position<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 1 == 0, 13836185784846778395);
        let v0 = debit_short_position<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::split<T0>(&mut arg0.vault, arg2);
        credit<T0>(arg0, v0, v1, arg2);
    }

    public fun resume_action<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624033188970519);
        change_pause<T0>(arg0, arg2, false, arg3);
    }

    public fun reward_claims_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.reward_claims_paused
    }

    public fun reward_duration_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.reward_duration_ms
    }

    public fun reward_reserve<T0>(arg0: &Pool<T0>) : &0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::Reserve {
        &arg0.reserve
    }

    public fun reward_start_ms<T0>(arg0: &Pool<T0>) : u64 {
        if (0x1::option::is_some<u64>(&arg0.scheduled_start_ms)) {
            *0x1::option::borrow<u64>(&arg0.scheduled_start_ms)
        } else {
            arg0.start
        }
    }

    public(friend) fun schedule_distributor<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        mark_distributor<T0>(arg0, arg4);
        let v0 = if (arg1 >= 0x2::clock::timestamp_ms(arg3)) {
            if (arg2 > 0) {
                if (arg1 <= 8640000000000000) {
                    arg2 <= (8640000000000000 - arg1) / 86400000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835905873238032409);
        arg0.scheduled_start_ms = 0x1::option::some<u64>(arg1);
        arg0.reward_duration_ms = arg2 * 86400000;
    }

    public fun set_cooldown_ms<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623827030540311);
        assert!(arg2 > 0 && arg2 <= 31536000000, 13836468256256032797);
        arg0.cooldown_ms = arg2;
        let v0 = CooldownChanged{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            old_ms : arg0.cooldown_ms,
            new_ms : arg2,
            admin  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CooldownChanged>(v0);
    }

    public fun set_epoch_budget<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg4)), 13836749426290196511);
        let v0 = if (!arg0.started) {
            true
        } else if (0x2::clock::timestamp_ms(arg3) < reward_start_ms<T0>(arg0)) {
            true
        } else {
            arg1 > current_epoch<T0>(arg0, arg3)
        };
        assert!(v0, 13835060580724113427);
        0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::configure<T1>(&mut arg0.reserve, 0x2::object::id<Pool<T0>>(arg0), arg1, arg2);
    }

    public fun set_instant_fee_bps<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623723951325207);
        assert!(arg2 <= 500, 13837875528061026343);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"instant_exit_fee_bps")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"instant_exit_fee_bps") = arg2;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"instant_exit_fee_bps", arg2);
        };
        let v0 = InstantFeeChanged{
            pool    : 0x2::object::id<Pool<T0>>(arg0),
            old_bps : instant_fee_bps<T0>(arg0),
            new_bps : arg2,
            admin   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<InstantFeeChanged>(v0);
    }

    public fun set_paused<T0>(arg0: &mut Pool<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1, 13836750014700716063);
        pause_action<T0>(arg0, 16, arg2);
    }

    public fun set_pauser<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: address, arg3: bool) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && arg2 != @0x0, 13835623865685245975);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.pausers, &arg2);
        assert!(v0 != arg3, 13835623874275180567);
        if (arg3) {
            0x1::vector::push_back<address>(&mut arg0.pausers, arg2);
        } else {
            0x1::vector::swap_remove<address>(&mut arg0.pausers, v1);
        };
        let v2 = PauserChanged{
            pool    : 0x2::object::id<Pool<T0>>(arg0),
            pauser  : arg2,
            enabled : arg3,
        };
        0x2::event::emit<PauserChanged>(v2);
    }

    public fun set_reward_claims_paused<T0>(arg0: &mut Pool<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1, 13836750040470519839);
        pause_action<T0>(arg0, 4, arg2);
    }

    public fun setup_pool<T0>(arg0: Setup, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = setup_pool_with_publisher<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun setup_pool_with_publisher<T0>(arg0: Setup, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::Publisher {
        let Setup {
            id        : v0,
            publisher : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, 0x2::tx_context::sender(arg2));
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, 0x2::tx_context::sender(arg2));
        let v4 = Pool<T0>{
            id                     : 0x2::object::new(arg2),
            version                : 3,
            accounts               : 0x2::table::new<address, Account>(arg2),
            positions              : 0x2::table::new<0x2::object::ID, PositionState<T0>>(arg2),
            vault                  : 0x2::balance::zero<T0>(),
            active                 : 0,
            short                  : 0,
            reserve                : 0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::new(arg2),
            cooldown_ms            : 1209600000,
            live                   : false,
            paused                 : false,
            reward_claims_paused   : false,
            operators              : v2,
            pausers                : v3,
            distributor_registered : false,
            scheduled_start_ms     : 0x1::option::none<u64>(),
            reward_duration_ms     : 604800000,
            start                  : 0,
            started                : false,
            migration_root         : b"",
            context_hash           : b"",
        };
        let v5 = 0x2::object::id<Pool<T0>>(&v4);
        let v6 = PoolAdmin{
            id   : 0x2::object::new(arg2),
            pool : v5,
        };
        0x2::transfer::transfer<PoolAdmin>(v6, 0x2::tx_context::sender(arg2));
        let v7 = ImportCap{
            id     : 0x2::object::new(arg2),
            pool   : v5,
            source : arg1,
        };
        0x2::transfer::transfer<ImportCap>(v7, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Pool<T0>>(v4);
        v1
    }

    public fun start_exit<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 2 == 0, 13836185557213511707);
        let v0 = require_owner<T0>(arg0, arg1, arg4);
        let v1 = take_active<T0>(arg0, v0, 0x2::tx_context::sender(arg4), arg2);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        let v3 = v2.next_order;
        v2.next_order = v3 + 1;
        let v4 = 0x2::clock::timestamp_ms(arg3) + arg0.cooldown_ms;
        let v5 = Cooling<T0>{
            principal : v1,
            ready_at  : v4,
        };
        0x2::table::add<u64, Cooling<T0>>(&mut v2.orders, v3, v5);
        let v6 = PositionOrder{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            position : v0,
            order    : v3,
            amount   : arg2,
            ready_at : v4,
            owner    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PositionOrder>(v6);
        changed<T0>(arg0, v0);
    }

    fun take_active<T0>(arg0: &mut Pool<T0>, arg1: 0x2::object::ID, arg2: address, arg3: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, arg1);
        assert!(arg3 > 0 && v0.active >= arg3, 13835341093628280853);
        v0.active = v0.active - arg3;
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg2);
        v1.active = v1.active - arg3;
        arg0.active = arg0.active - arg3;
        0x2::balance::split<T0>(&mut arg0.vault, arg3)
    }

    public fun transfer_position<T0>(arg0: &mut Pool<T0>, arg1: Position<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, &arg1, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg2 != @0x0 && arg2 != v1, 13835622362446692375);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        v2.owner = arg2;
        let v3 = v2.active;
        let v4 = v2.short;
        let v5 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v1);
        let v6 = &mut v5.positions;
        remove_id(v6, v0);
        v5.active = v5.active - v3;
        v5.short = v5.short - v4;
        let v7 = account<T0>(arg0, arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&v7.positions) < 10, 13835340926124556309);
        0x1::vector::push_back<0x2::object::ID>(&mut v7.positions, v0);
        v7.active = v7.active + v3;
        v7.short = v7.short + v4;
        emit_balance<T0>(arg0, v1);
        changed<T0>(arg0, v0);
        let v8 = PositionTransferred{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            position : v0,
            from     : v1,
            to       : arg2,
        };
        0x2::event::emit<PositionTransferred>(v8);
        0x2::transfer::transfer<Position<T0>>(arg1, arg2);
    }

    public fun withdraw_instant<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(pause_flags<T0>(arg0) & 8 == 0, 13836185681767563291);
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = take_active<T0>(arg0, v0, 0x2::tx_context::sender(arg3), arg2);
        let v2 = instant_fee<T0>(arg0, arg2);
        assert!(v2 < arg2, 13835341274016907285);
        let v3 = 0x2::object::id<Pool<T0>>(arg0);
        if (v2 > 0) {
            0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::fee_distributor::distribute<T0>(&mut arg0.reserve, v3, 0x2::balance::split<T0>(&mut v1, v2));
        };
        let v4 = InstantExited{
            pool   : v3,
            owner  : 0x2::tx_context::sender(arg3),
            amount : arg2,
            fee    : v2,
        };
        0x2::event::emit<InstantExited>(v4);
        changed<T0>(arg0, v0);
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun withdraw_order<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = require_owner<T0>(arg0, arg1, arg4);
        let Cooling {
            principal : v1,
            ready_at  : v2,
        } = 0x2::table::remove<u64, Cooling<T0>>(&mut 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0).orders, arg2);
        let v3 = v1;
        assert!(0x2::clock::timestamp_ms(arg3) >= v2, 13835904181020917785);
        let v4 = PositionOrderClosed{
            pool      : 0x2::object::id<Pool<T0>>(arg0),
            position  : v0,
            order     : arg2,
            owner     : 0x2::tx_context::sender(arg4),
            amount    : 0x2::balance::value<T0>(&v3),
            cancelled : false,
        };
        0x2::event::emit<PositionOrderClosed>(v4);
        0x2::coin::from_balance<T0>(v3, arg4)
    }

    public fun withdraw_short<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(pause_flags<T0>(arg0) & 2 == 0, 13836185814911549467);
        let v0 = debit_short_position<T0>(arg0, arg1, arg2, arg3);
        let v1 = ShortClaimed{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            owner  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<ShortClaimed>(v1);
        changed<T0>(arg0, v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

