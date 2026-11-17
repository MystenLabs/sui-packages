module 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::ledger {
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
        reserve: 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::Reserve,
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
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623573626880014);
        assert!(arg2 != @0x0, 13835623577921847310);
        assert!(!is_operator<T0>(arg0, arg2), 13837030957101023256);
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
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= 10000000000, 13835340509512138764);
        credit<T0>(arg0, v0, 0x2::coin::into_balance<T0>(arg2), v1);
        let v2 = Staked{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            owner  : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<Staked>(v2);
    }

    public(friend) fun assert_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 13837593374478762012);
    }

    fun available<T0>(arg0: &Pool<T0>) {
        assert_version<T0>(arg0);
        assert!(arg0.live, 13835060576428556298);
        assert!(!arg0.paused, 13836186480630890514);
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
        assert!(!arg1.started, 13835059897823723530);
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
        assert!(v0, 13835623784080277518);
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
        assert!(v0, 13835623805555113998);
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
        assert!(v2, 13835340672720896012);
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
        available<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000000, 13835340470857433100);
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
        assert!(arg0.started && v0 >= v1, 13835060327320453130);
        (v0 - v1) / arg0.reward_duration_ms
    }

    fun debit_short_position<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        assert!(arg2 > 0 && v1.short >= arg2, 13835340999138410508);
        v1.short = v1.short - arg2;
        let v2 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, 0x2::tx_context::sender(arg3));
        v2.short = v2.short - arg2;
        arg0.short = arg0.short - arg2;
        v0
    }

    public(friend) fun draw_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T1> {
        assert_version<T0>(arg0);
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::draw<T1>(&mut arg0.reserve, arg1, arg2)
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
        assert!(arg0.live, 13835060353090256906);
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg1)), 13836749207246274582);
        reward_start_ms<T0>(arg0)
    }

    public fun fund_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_operator<T0>(arg0, v0), 13836749022562680854);
        let v1 = 0x2::object::id<Pool<T0>>(arg0);
        let v2 = 0x2::coin::value<T1>(&arg1);
        assert!(v2 > 0, 13835341660563374092);
        let v3 = RewardDeposited<T1>{
            pool     : v1,
            operator : v0,
            amount   : v2,
        };
        0x2::event::emit<RewardDeposited<T1>>(v3);
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::deposit<T1>(&mut arg0.reserve, v1, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun import_position<T0>(arg0: &ImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_import<T0>(arg0, arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg4) > 0 && (arg5 == 0 || arg5 == 0x2::balance::value<T0>(&arg4)), 13835340715670568972);
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

    public fun is_operator<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public(friend) fun mark_distributor<T0>(arg0: &mut Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        epoch_start<T0>(arg0, arg1);
        assert!(!arg0.distributor_registered, 13835623719655768078);
        arg0.distributor_registered = true;
    }

    public fun migrate_version<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623071115706382);
        assert!(arg0.version < 1, 13837593400248565788);
        arg0.version = 1;
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
        assert!(0x1::vector::length<0x2::object::ID>(&v2.positions) < 10, 13835340290468806668);
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
        assert!(v3, 13835622955151589390);
        let v4 = if (0x1::vector::length<u8>(&arg5) == 32) {
            if (0x1::vector::length<u8>(&arg6) == 32) {
                arg1.active + arg1.short == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 13835622972331458574);
        0x2::object::delete(v0);
        arg1.migration_root = arg5;
        arg1.context_hash = arg6;
        arg1.live = true;
        assert!(!arg1.started || arg1.start == arg4, 13835904473078104080);
        arg1.started = true;
        arg1.start = arg4;
    }

    public fun position_balance<T0>(arg0: &Pool<T0>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, arg1);
        (v0.active, v0.short)
    }

    public fun position_metadata() : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (0x1::string::utf8(b"veHAEDAL Position #{id}"), 0x1::string::utf8(b"A veHAEDAL NFT representing staked HAEDAL in the Haedal Protocol on Sui."), 0x1::string::utf8(b"veHAEDAL NFT"), 0x1::string::utf8(b"data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNTYgMjU2IiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgcm9sZT0iaW1nIiBhcmlhLWxhYmVsPSJIYWVkYWwgb3R0ZXIgd2VhcmluZyBwaXhlbCBzdW5nbGFzc2VzIG9uIGEgYnJvbnplIG1lZGFsbGlvbiI+CiAgPGRlZnM+CiAgICA8bGluZWFyR3JhZGllbnQgaWQ9ImJnIiB4Mj0iLjgiIHkyPSIxIiBncmFkaWVudFVuaXRzPSJvYmplY3RCb3VuZGluZ0JveCI+PHN0b3Agc3RvcC1jb2xvcj0iIzI5MjUyNCIvPjxzdG9wIG9mZnNldD0iLjYiIHN0b3AtY29sb3I9IiMzNzMzMzAiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiMxNzE2MTYiLz48L2xpbmVhckdyYWRpZW50PgogICAgPGxpbmVhckdyYWRpZW50IGlkPSJlZGdlIiB4Mj0iLjkiIHkyPSIuNSI+PHN0b3Agc3RvcC1jb2xvcj0iI2ZmODM1MCIvPjxzdG9wIG9mZnNldD0iLjI2IiBzdG9wLWNvbG9yPSIjYWY4MDZhIi8+PHN0b3Agb2Zmc2V0PSIuNTIiIHN0b3AtY29sb3I9IiM2MDQ3M2IiLz48c3RvcCBvZmZzZXQ9Ii44MiIgc3RvcC1jb2xvcj0iIzNlMzMyYyIvPjxzdG9wIG9mZnNldD0iMSIgc3RvcC1jb2xvcj0iI2M2YTk3NiIvPjwvbGluZWFyR3JhZGllbnQ+CiAgICA8cmFkaWFsR3JhZGllbnQgaWQ9ImdvbGQiIGN4PSIuMzMiIGN5PSIuMjgiIHI9Ii44MiI+PHN0b3Agc3RvcC1jb2xvcj0iI2ZkZTVjZCIvPjxzdG9wIG9mZnNldD0iLjYzIiBzdG9wLWNvbG9yPSIjZWRjYmE3Ii8+PHN0b3Agb2Zmc2V0PSIuOTIiIHN0b3AtY29sb3I9IiNjY2E2ODYiLz48c3RvcCBvZmZzZXQ9IjEiIHN0b3AtY29sb3I9IiNhMDc4NjIiLz48L3JhZGlhbEdyYWRpZW50PgogICAgPGxpbmVhckdyYWRpZW50IGlkPSJmdXIiIHgyPSIuMjIiIHkyPSIxIj48c3RvcCBzdG9wLWNvbG9yPSIjOWI3MTVhIi8+PHN0b3Agb2Zmc2V0PSIuNSIgc3RvcC1jb2xvcj0iI2FlODc2ZCIvPjxzdG9wIG9mZnNldD0iLjUyIiBzdG9wLWNvbG9yPSIjZDZhZDhkIi8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjZjFkNGI3Ii8+PC9saW5lYXJHcmFkaWVudD4KICAgIDxsaW5lYXJHcmFkaWVudCBpZD0iZ2xhc3MiPjxzdG9wIHN0b3AtY29sb3I9IiM2NjUzNGYiLz48c3RvcCBvZmZzZXQ9Ii4yOCIgc3RvcC1jb2xvcj0iI2U4YzlhZCIvPjxzdG9wIG9mZnNldD0iLjcyIiBzdG9wLWNvbG9yPSIjNjU1OTU2Ii8+PHN0b3Agb2Zmc2V0PSIxIiBzdG9wLWNvbG9yPSIjZGZkZmI1Ii8+PC9saW5lYXJHcmFkaWVudD4KICA8L2RlZnM+CiAgPHBhdGggZmlsbD0idXJsKCNiZykiIGQ9Ik0wIDBoMjU2djI1NkgweiIvPgogIDxlbGxpcHNlIGN4PSIxMjMiIGN5PSI5MiIgcng9Ijg4IiByeT0iOTAiIGZpbGw9IiNmZmU1YzAiLz4KICA8cGF0aCBmaWxsPSIjZmY4MTRlIiBkPSJNMCAxODNsNjgtNDV2MjdMMCAyMDd6Ii8+CiAgPHBhdGggZmlsbD0iI2U2ZmYwMCIgZD0iTTE4MCAxNjJsNzYtNTN2MjlsLTc2IDUzeiIvPgogIDxwYXRoIGZpbGw9IiNkZmZmMDAiIGQ9Ik0yMjAgMjloN3Y3aC03em03LTdoN3Y3aC03em03LTdoN3Y3aC03eiIvPgogIDxwYXRoIGZpbGw9IiNmZjhiNTUiIGQ9Ik0xMSAyNDFoNnY2aC02em02LTZoNnY2aC02em03LTZoNnY2aC02eiIvPgogIDxlbGxpcHNlIGN4PSIxMzAiIGN5PSIyMzQiIHJ4PSI5MyIgcnk9IjYiIGZpbGw9IiMyMDFiMTkiIG9wYWNpdHk9Ii44Ii8+CiAgPGcgc3Ryb2tlPSIjZWZkNWJlIiBzdHJva2Utd2lkdGg9Ii41NSIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCI+CiAgICA8cGF0aCBmaWxsPSJ1cmwoI2dsYXNzKSIgZD0iTTM0IDIwN2w0Ni0xMCAxMzkgNi0zOCAxM3oiLz4KICAgIDxwYXRoIGZpbGw9InVybCgjZ2xhc3MpIiBkPSJNMzQgMjA3bDE0NyA5djE5bC0xNDctOXoiLz4KICAgIDxwYXRoIGZpbGw9IiM2ZDYyNTEiIGQ9Ik0xODEgMjE2bDM4LTEzdjE5bC0zOCAxM3oiLz4KICA8L2c+CiAgPGVsbGlwc2UgY3g9IjEzMiIgY3k9IjExNyIgcng9Ijg1IiByeT0iOTEuNSIgZmlsbD0idXJsKCNlZGdlKSIvPgogIDxlbGxpcHNlIGN4PSIxMjIiIGN5PSIxMTciIHJ4PSI3OSIgcnk9IjkxIiBmaWxsPSJ1cmwoI2dvbGQpIiBzdHJva2U9InVybCgjZWRnZSkiIHN0cm9rZS13aWR0aD0iNCIvPgogIDxwYXRoIGQ9Ik02MSAxMTVxLTktMTEgNS0yMWMxMC02IDEyLTI4IDM2LTI2cTEzLTggMjgtMyAxMC03IDIzIDVjOS0xIDE1IDEyIDE4IDE4cTEzIDQgOSAxOWMxIDM1LTYgNjEtMzggNjctMzcgNy03MC0zLTc3LTI4cS00LTEzLTQtMzF6IiBmaWxsPSJ1cmwoI2Z1cikiIHN0cm9rZT0iI2Y1ZTFkMyIgc3Ryb2tlLXdpZHRoPSI2IiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+CiAgPHBhdGggZD0iTTcyIDkyaDEwOXYxNmgtNXY2aC01djVoLTI4di01aC01di02aC04di0xMGgtMTF2MTBoLTV2NmgtNnY2SDgydi02aC01di02aC02eiIgZmlsbD0iIzE3MTQxMyIgc3Ryb2tlPSIjNTAzZDMyIiBzdHJva2Utd2lkdGg9IjEuNCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPgogIDxwYXRoIGZpbGw9IiNmZmY0ZTgiIGQ9Ik03NiA5OGg1djVoLTV6bTUgNWg1djVoLTV6bTUgNWg1djVoLTV6bTQ4LTEwaDV2NWgtNXptNSA1aDV2NWgtNXptNSA1aDV2NWgtNXoiLz4KICA8cGF0aCBmaWxsPSIjNDIzMTI5IiBkPSJNMTEyIDEyNWMwLTQgOC0xMyAxMy0xM3MxMyAxMCAxMyAxNC0xMCAxMy0xMyAxMy0xMy05LTEzLTE0eiIvPgogIDxnIGZpbGw9Im5vbmUiIHN0cm9rZT0iIzQ1MzIyYSIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIj4KICAgIDxwYXRoIHN0cm9rZS13aWR0aD0iMyIgZD0iTTEyMSAxNDhsNC01IDQgNSIvPgogICAgPHBhdGggc3Ryb2tlLXdpZHRoPSIyIiBkPSJNODUgMTMwcS0xMyAyLTI0IDEybTI2LTZxLTE1IDYtMjIgMTdtMjUtMTJxLTkgNy0xNiAxN204Ni0yN3ExMiA0IDIwIDEzbS0yMi04cTEyIDcgMTggMTdtLTIxLTEycTggNyAxMiAxNiIvPgogIDwvZz4KPC9zdmc+Cg=="))
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(arg0, &arg1);
        assert!(v0, 13835622014553751566);
        0x1::vector::swap_remove<0x2::object::ID>(arg0, v1);
    }

    public fun remove_operator<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623655231258638);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg2);
        assert!(v0, 13837312513682243610);
        0x1::vector::swap_remove<address>(&mut arg0.operators, v1);
        let v2 = OperatorChanged{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            operator : arg2,
            enabled  : false,
            admin    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OperatorChanged>(v2);
    }

    fun require_owner<T0>(arg0: &Pool<T0>, arg1: &Position<T0>, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        available<T0>(arg0);
        let v0 = 0x2::object::id<Position<T0>>(arg1);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, v0).owner == 0x2::tx_context::sender(arg2), 13835621829870157838);
        v0
    }

    public fun restake_position<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = debit_short_position<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x2::balance::split<T0>(&mut arg0.vault, arg2);
        credit<T0>(arg0, v0, v1, arg2);
    }

    public fun reward_claims_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.reward_claims_paused
    }

    public fun reward_duration_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.reward_duration_ms
    }

    public fun reward_reserve<T0>(arg0: &Pool<T0>) : &0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::Reserve {
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
        assert!(v0, 13835905224697380880);
        arg0.scheduled_start_ms = 0x1::option::some<u64>(arg1);
        arg0.reward_duration_ms = arg2 * 86400000;
    }

    public fun set_cooldown_ms<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623376058384398);
        assert!(arg2 > 0 && arg2 <= 31536000000, 13836467805283876884);
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
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg4)), 13836749069807321110);
        let v0 = if (!arg0.started) {
            true
        } else if (0x2::clock::timestamp_ms(arg3) < reward_start_ms<T0>(arg0)) {
            true
        } else {
            arg1 > current_epoch<T0>(arg0, arg3)
        };
        assert!(v0, 13835060224241238026);
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::configure<T1>(&mut arg0.reserve, 0x2::object::id<Pool<T0>>(arg0), arg1, arg2);
    }

    public fun set_paused<T0>(arg0: &mut Pool<T0>, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.pausers, &v0), 13836749353275162646);
        arg0.paused = arg1;
        let v1 = PauseChanged{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            paused : arg1,
        };
        0x2::event::emit<PauseChanged>(v1);
    }

    public fun set_pauser<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdmin, arg2: address, arg3: bool) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && arg2 != @0x0, 13835623414713090062);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.pausers, &arg2);
        assert!(v0 != arg3, 13835623423303024654);
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
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.pausers, &v0), 13836749387634901014);
        arg0.reward_claims_paused = arg1;
        let v1 = RewardClaimsPauseChanged{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            paused : arg1,
        };
        0x2::event::emit<RewardClaimsPauseChanged>(v1);
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
            version                : 1,
            accounts               : 0x2::table::new<address, Account>(arg2),
            positions              : 0x2::table::new<0x2::object::ID, PositionState<T0>>(arg2),
            vault                  : 0x2::balance::zero<T0>(),
            active                 : 0,
            short                  : 0,
            reserve                : 0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::incentives::new(arg2),
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
        assert!(arg3 > 0 && v0.active >= arg3, 13835340780095078412);
        v0.active = v0.active - arg3;
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg2);
        v1.active = v1.active - arg3;
        arg0.active = arg0.active - arg3;
        0x2::balance::split<T0>(&mut arg0.vault, arg3)
    }

    public fun transfer_position<T0>(arg0: &mut Pool<T0>, arg1: Position<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, &arg1, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg2 != @0x0 && arg2 != v1, 13835622048913489934);
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
        assert!(0x1::vector::length<0x2::object::ID>(&v7.positions) < 10, 13835340612591353868);
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
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = take_active<T0>(arg0, v0, 0x2::tx_context::sender(arg3), arg2);
        let v2 = ((((arg2 as u128) + 19) / 20) as u64);
        assert!(v2 < arg2, 13835340951893770252);
        let v3 = 0x2::object::id<Pool<T0>>(arg0);
        0xff471c958d77df019c9261779348c7aa4f8e318663409682a4ea26f858f69459::fee_distributor::distribute<T0>(&mut arg0.reserve, v3, 0x2::balance::split<T0>(&mut v1, v2));
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
        assert!(0x2::clock::timestamp_ms(arg3) >= v2, 13835903863192748048);
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

