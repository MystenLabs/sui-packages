module 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::staking {
    struct STAKING has drop {
        dummy_field: bool,
    }

    struct Setup has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct MigrationImportCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        source: 0x2::object::ID,
    }

    struct PoolAdminCap has store, key {
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
        serial_label: 0x1::string::String,
    }

    struct PositionState<phantom T0> has store {
        owner: address,
        active: u64,
        short: u64,
        migrated_short: bool,
        orders: 0x2::table::Table<u64, CooldownOrder<T0>>,
        next_order: u64,
    }

    struct CooldownOrder<phantom T0> has store {
        principal: 0x2::balance::Balance<T0>,
        ready_at: u64,
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
        positions: vector<0x2::object::ID>,
        long_import: 0x1::option::Option<0x2::object::ID>,
        short_import: 0x1::option::Option<0x2::object::ID>,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        accounts: 0x2::table::Table<address, Account>,
        positions: 0x2::table::Table<0x2::object::ID, PositionState<T0>>,
        last_position_serial: u64,
        vault: 0x2::balance::Balance<T0>,
        active: u64,
        short: u64,
        reserve: 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::Reserve,
        cooldown_ms: u64,
        instant_fee_bps: u64,
        live: bool,
        pause_flags: u8,
        reward_claims_paused: bool,
        operators: vector<address>,
        reward_robots: vector<address>,
        pausers: vector<address>,
        distributor_registered: bool,
        epoch_schedule: 0x2::table::Table<u64, EpochWindow>,
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

    struct EpochWindow has copy, drop, store {
        start_ms: u64,
        end_ms: u64,
    }

    struct EpochScheduled has copy, drop {
        pool: 0x2::object::ID,
        epoch: u64,
        start_ms: u64,
        end_ms: u64,
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

    struct RewardWithdrawn<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        operator: address,
        recipient: address,
        amount: u64,
    }

    struct ActionPauseChanged has copy, drop {
        pool: 0x2::object::ID,
        action: u8,
        paused: bool,
        actor: address,
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

    struct RewardRobotChanged has copy, drop {
        pool: 0x2::object::ID,
        robot: address,
        enabled: bool,
        admin: address,
    }

    fun account<T0>(arg0: &mut Pool<T0>, arg1: address) : &mut Account {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            let v0 = Account{
                active       : 0,
                short        : 0,
                positions    : 0x1::vector::empty<0x2::object::ID>(),
                long_import  : 0x1::option::none<0x2::object::ID>(),
                short_import : 0x1::option::none<0x2::object::ID>(),
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1, v0);
        };
        0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1)
    }

    public fun active_epoch<T0>(arg0: &Pool<T0>, arg1: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        let v2 = 0x2::table::length<u64, EpochWindow>(&arg0.epoch_schedule);
        while (v1 < v2) {
            v2 = v1 + (v2 - v1) / 2;
            let v3 = 0x2::table::borrow<u64, EpochWindow>(&arg0.epoch_schedule, v2);
            if (v0 < v3.start_ms) {
                continue
            };
            if (v0 >= v3.end_ms) {
                v1 = v2 + 1;
                continue
            };
            return 0x1::option::some<u64>(v2)
        };
        0x1::option::none<u64>()
    }

    public fun add_operator<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624617304260627);
        assert!(arg2 != @0x0, 13835624621599227923);
        assert!(!is_operator<T0>(arg0, arg2), 13837032000778403869);
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
        assert!(pause_flags<T0>(arg0) & 1 == 0, 13836185346759852055);
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= 10000000000, 13835340934714228753);
        credit<T0>(arg0, v0, 0x2::coin::into_balance<T0>(arg2), v1);
        let v2 = Staked{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            owner  : 0x2::tx_context::sender(arg3),
            amount : v1,
        };
        0x2::event::emit<Staked>(v2);
    }

    public fun admin_fund_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623736835964947);
        deposit_rewards<T0, T1>(arg0, arg2, arg3);
    }

    public(friend) fun assert_reward_operator<T0>(arg0: &Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.live, 13835061276508553231);
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg1)), 13836750130664570907);
    }

    public(friend) fun assert_reward_publisher<T0>(arg0: &Pool<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg0.live, 13835061250738749455);
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg1)) || is_reward_robot<T0>(arg0, 0x2::tx_context::sender(arg1)), 13836750104894767131);
    }

    public(friend) fun assert_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 13837593859810394145);
    }

    fun available<T0>(arg0: &Pool<T0>) {
        assert_version<T0>(arg0);
        assert!(arg0.live, 13835061624400904207);
    }

    public fun balance_of<T0>(arg0: &Pool<T0>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        (v0.active, v0.short)
    }

    public fun begin_epochs<T0>(arg0: &MigrationImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        check_empty_import<T0>(arg0, arg1, arg2);
        assert!(!arg1.started, 13835060383155355663);
        arg1.start = 0x2::clock::timestamp_ms(arg3);
        arg1.started = true;
    }

    public fun cancel_epochs<T0>(arg0: &MigrationImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID) {
        check_empty_import<T0>(arg0, arg1, arg2);
        arg1.started = false;
        arg1.start = 0;
    }

    public fun cancel_order<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let CooldownOrder {
            principal : v1,
            ready_at  : _,
        } = 0x2::table::remove<u64, CooldownOrder<T0>>(&mut 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0).orders, arg2);
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
            let v1 = if (arg1 == 1) {
                true
            } else if (arg1 == 2) {
                true
            } else {
                arg1 == 8
            };
            assert!(v1, 13835624479865307155);
            let v2 = if (arg2) {
                arg0.pause_flags | arg1
            } else {
                arg0.pause_flags & (255 ^ arg1)
            };
            arg0.pause_flags = v2;
        };
        let v3 = ActionPauseChanged{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            action : arg1,
            paused : arg2,
            actor  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ActionPauseChanged>(v3);
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

    public fun check_empty_import<T0>(arg0: &MigrationImportCap, arg1: &Pool<T0>, arg2: 0x2::object::ID) {
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
        assert!(v0, 13835624763333148691);
    }

    public fun check_import<T0>(arg0: &MigrationImportCap, arg1: &Pool<T0>, arg2: 0x2::object::ID) {
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
        assert!(v0, 13835624784807985171);
    }

    public fun close_position<T0>(arg0: &mut Pool<T0>, arg1: Position<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, &arg1, arg2);
        let v1 = 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, v0);
        let v2 = if (v1.active == 0) {
            if (v1.short == 0) {
                0x2::table::is_empty<u64, CooldownOrder<T0>>(&v1.orders)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 13835341106512920593);
        let v3 = &mut 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, 0x2::tx_context::sender(arg2)).positions;
        remove_id(v3, v0);
        let Position {
            id           : v4,
            pool         : _,
            serial_label : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    public fun cooldown_ms<T0>(arg0: &Pool<T0>) : u64 {
        arg0.cooldown_ms
    }

    public fun create_position<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 1 == 0, 13836185303810179095);
        available<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000000, 13835340891764555793);
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
        let v0 = active_epoch<T0>(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 13835060997335678991);
        *0x1::option::borrow<u64>(&v0)
    }

    fun debit_short_position<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        assert!(arg2 > 0 && v1.short >= arg2, 13835341454405271569);
        v1.short = v1.short - arg2;
        if (v1.short == 0) {
            v1.migrated_short = false;
        };
        let v2 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, 0x2::tx_context::sender(arg3));
        v2.short = v2.short - arg2;
        arg0.short = arg0.short - arg2;
        v0
    }

    fun deposit_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::object::id<Pool<T0>>(arg0);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v1 > 0, 13835342300513828881);
        let v2 = RewardDeposited<T1>{
            pool     : v0,
            operator : 0x2::tx_context::sender(arg2),
            amount   : v1,
        };
        0x2::event::emit<RewardDeposited<T1>>(v2);
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::deposit<T1>(&mut arg0.reserve, v0, 0x2::coin::into_balance<T1>(arg1));
    }

    public(friend) fun draw_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T1> {
        assert_version<T0>(arg0);
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::draw<T1>(&mut arg0.reserve, arg1, arg2)
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

    public fun epoch_ended<T0>(arg0: &Pool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : bool {
        0x2::table::contains<u64, EpochWindow>(&arg0.epoch_schedule, arg1) && 0x2::clock::timestamp_ms(arg2) >= 0x2::table::borrow<u64, EpochWindow>(&arg0.epoch_schedule, arg1).end_ms
    }

    public fun fund_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg2)), 13836749563728887835);
        deposit_rewards<T0, T1>(arg0, arg1, arg2);
    }

    public fun import_position<T0>(arg0: &MigrationImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_import<T0>(arg0, arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg4) > 0 && (arg5 == 0 || arg5 == 0x2::balance::value<T0>(&arg4)), 13835341149462593553);
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
        if (arg5 == 0) {
            0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg1.positions, v3).migrated_short = true;
        };
        credit<T0>(arg1, v3, arg4, arg5);
        v3
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Setup{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<STAKING>(arg0, arg1),
        };
        0x2::transfer::transfer<Setup>(v0, 0x2::tx_context::sender(arg1));
    }

    fun instant_fee<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        ((((arg1 as u128) * (instant_fee_bps<T0>(arg0) as u128) + 10000 - 1) / 10000) as u64)
    }

    public fun instant_fee_bps<T0>(arg0: &Pool<T0>) : u64 {
        arg0.instant_fee_bps
    }

    public fun is_migrated_short_position<T0>(arg0: &Pool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, arg1).migrated_short
    }

    public fun is_operator<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_reward_robot<T0>(arg0: &Pool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.reward_robots, &arg1)
    }

    public fun migrate_version<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623556447338515);
        assert!(arg0.version < 1, 13837593885580197921);
        arg0.version = 1;
    }

    public fun migration_context<T0>(arg0: &Pool<T0>) : vector<u8> {
        arg0.context_hash
    }

    fun mint_position<T0>(arg0: &mut Pool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<Pool<T0>>(arg0);
        let v1 = next_position_label<T0>(arg0);
        let v2 = Position<T0>{
            id           : 0x2::object::new(arg2),
            pool         : v0,
            serial_label : v1,
        };
        let v3 = 0x2::object::id<Position<T0>>(&v2);
        let v4 = account<T0>(arg0, arg1);
        assert!(0x1::vector::length<0x2::object::ID>(&v4.positions) < 10, 13835340681311158289);
        0x1::vector::push_back<0x2::object::ID>(&mut v4.positions, v3);
        let v5 = PositionState<T0>{
            owner          : arg1,
            active         : 0,
            short          : 0,
            migrated_short : false,
            orders         : 0x2::table::new<u64, CooldownOrder<T0>>(arg2),
            next_order     : 0,
        };
        0x2::table::add<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v3, v5);
        0x2::transfer::transfer<Position<T0>>(v2, arg1);
        v3
    }

    fun next_position_label<T0>(arg0: &mut Pool<T0>) : 0x1::string::String {
        arg0.last_position_serial = arg0.last_position_serial + 1;
        let v0 = if (arg0.last_position_serial < 10) {
            0x1::string::utf8(b"0")
        } else {
            0x1::string::utf8(b"")
        };
        let v1 = v0;
        0x1::string::append(&mut v1, 0x1::u64::to_string(arg0.last_position_serial));
        v1
    }

    public fun open<T0>(arg0: MigrationImportCap, arg1: &mut Pool<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) {
        assert_version<T0>(arg1);
        let MigrationImportCap {
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
        assert!(v3, 13835623440483221523);
        let v4 = if (0x1::vector::length<u8>(&arg5) == 32) {
            if (0x1::vector::length<u8>(&arg6) == 32) {
                arg1.active + arg1.short == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 13835623457663090707);
        0x2::object::delete(v0);
        arg1.migration_root = arg5;
        arg1.context_hash = arg6;
        arg1.live = true;
        assert!(!arg1.started || arg1.start == arg4, 13835904958409736213);
        arg1.started = true;
        arg1.start = arg4;
    }

    public fun pause_action<T0>(arg0: &mut Pool<T0>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.pausers, &v0), 13836750414132412443);
        change_pause<T0>(arg0, arg1, true, arg2);
    }

    public fun pause_flags<T0>(arg0: &Pool<T0>) : u8 {
        arg0.pause_flags
    }

    public fun position_balance<T0>(arg0: &Pool<T0>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, arg1);
        (v0.active, v0.short)
    }

    public fun position_metadata() : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (0x1::string::utf8(b"veHAEDAL Position #{serial_label}"), 0x1::string::utf8(b"A veHAEDAL NFT representing staked HAEDAL in the Haedal Protocol on Sui."), 0x1::string::utf8(b"veHAEDAL NFT"), 0x1::string::utf8(b"https://assets.haedal.xyz/images/veHAEDALV2.svg"))
    }

    public(friend) fun reconcile_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: &mut 0x2::balance::Balance<T1>, arg3: u64) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835623603691978771);
        assert!(arg0.reward_claims_paused, 13835060658033262607);
        let v0 = 0x2::balance::value<T1>(arg2);
        if (arg3 > v0) {
            0x2::balance::join<T1>(arg2, 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::withdraw<T1>(&mut arg0.reserve, arg3 - v0));
        } else if (arg3 < v0) {
            0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::deposit<T1>(&mut arg0.reserve, 0x2::object::id<Pool<T0>>(arg0), 0x2::balance::split<T1>(arg2, v0 - arg3));
        };
    }

    fun remove_id(arg0: &mut vector<0x2::object::ID>, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(arg0, &arg1);
        assert!(v0, 13835622439755841555);
        0x1::vector::swap_remove<0x2::object::ID>(arg0, v1);
    }

    public fun remove_operator<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624698908639251);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg2);
        assert!(v0, 13837313557359624223);
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
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && 0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, v0).owner == 0x2::tx_context::sender(arg2), 13835622246482313235);
        v0
    }

    public fun restake_position<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 1 == 0, 13836185922285469719);
        let v0 = debit_short_position<T0>(arg0, arg1, arg2, arg3);
        0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0).migrated_short = false;
        let v1 = 0x2::balance::split<T0>(&mut arg0.vault, arg2);
        credit<T0>(arg0, v0, v1, arg2);
        let v2 = Staked{
            pool   : 0x2::object::id<Pool<T0>>(arg0),
            owner  : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<Staked>(v2);
    }

    public fun resume_action<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624539994849299);
        change_pause<T0>(arg0, arg2, false, arg3);
    }

    public fun reward_claims_paused<T0>(arg0: &Pool<T0>) : bool {
        arg0.reward_claims_paused
    }

    public fun reward_reserve<T0>(arg0: &Pool<T0>) : &0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::Reserve {
        &arg0.reserve
    }

    public fun set_cooldown_ms<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624368196157459);
        assert!(arg2 > 0 && arg2 <= 31536000000, 13836468797421649945);
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
        assert!(is_operator<T0>(arg0, 0x2::tx_context::sender(arg4)), 13836749709757775899);
        assert!(!0x2::table::contains<u64, EpochWindow>(&arg0.epoch_schedule, arg1) || 0x2::clock::timestamp_ms(arg3) < 0x2::table::borrow<u64, EpochWindow>(&arg0.epoch_schedule, arg1).end_ms, 13835060864191692815);
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::configure<T1>(&mut arg0.reserve, 0x2::object::id<Pool<T0>>(arg0), arg1, arg2);
    }

    public fun set_instant_fee_bps<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0), 13835624269411909651);
        assert!(arg2 <= 1000, 13837876073521610787);
        arg0.instant_fee_bps = arg2;
        let v0 = InstantFeeChanged{
            pool    : 0x2::object::id<Pool<T0>>(arg0),
            old_bps : arg0.instant_fee_bps,
            new_bps : arg2,
            admin   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<InstantFeeChanged>(v0);
    }

    public fun set_pauser<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: address, arg3: bool) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && arg2 != @0x0, 13835624406850863123);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.pausers, &arg2);
        assert!(v0 != arg3, 13835624415440797715);
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

    public fun set_reward_robot<T0>(arg0: &mut Pool<T0>, arg1: &PoolAdminCap, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        assert!(arg1.pool == 0x2::object::id<Pool<T0>>(arg0) && arg2 != @0x0, 13835624157742759955);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.reward_robots, &arg2);
        assert!(v0 != arg3, 13835624166332694547);
        if (arg3) {
            0x1::vector::push_back<address>(&mut arg0.reward_robots, arg2);
        } else {
            0x1::vector::swap_remove<address>(&mut arg0.reward_robots, v1);
        };
        let v2 = RewardRobotChanged{
            pool    : 0x2::object::id<Pool<T0>>(arg0),
            robot   : arg2,
            enabled : arg3,
            admin   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardRobotChanged>(v2);
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
            last_position_serial   : 0,
            vault                  : 0x2::balance::zero<T0>(),
            active                 : 0,
            short                  : 0,
            reserve                : 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::new(arg2),
            cooldown_ms            : 1209600000,
            instant_fee_bps        : 500,
            live                   : false,
            pause_flags            : 0,
            reward_claims_paused   : false,
            operators              : v2,
            reward_robots          : vector[],
            pausers                : v3,
            distributor_registered : false,
            epoch_schedule         : 0x2::table::new<u64, EpochWindow>(arg2),
            start                  : 0,
            started                : false,
            migration_root         : b"",
            context_hash           : b"",
        };
        let v5 = 0x2::object::id<Pool<T0>>(&v4);
        let v6 = PoolAdminCap{
            id   : 0x2::object::new(arg2),
            pool : v5,
        };
        0x2::transfer::transfer<PoolAdminCap>(v6, 0x2::tx_context::sender(arg2));
        let v7 = MigrationImportCap{
            id     : 0x2::object::new(arg2),
            pool   : v5,
            source : arg1,
        };
        0x2::transfer::transfer<MigrationImportCap>(v7, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Pool<T0>>(v4);
        v1
    }

    public fun start_exit<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(pause_flags<T0>(arg0) & 2 == 0, 13836185681767301143);
        let v0 = require_owner<T0>(arg0, arg1, arg4);
        assert!(0x2::table::length<u64, CooldownOrder<T0>>(&0x2::table::borrow<0x2::object::ID, PositionState<T0>>(&arg0.positions, v0).orders) < 10, 13838156015195127845);
        let v1 = take_active<T0>(arg0, v0, 0x2::tx_context::sender(arg4), arg2);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        let v3 = v2.next_order;
        v2.next_order = v3 + 1;
        let v4 = 0x2::clock::timestamp_ms(arg3) + arg0.cooldown_ms;
        let v5 = CooldownOrder<T0>{
            principal : v1,
            ready_at  : v4,
        };
        0x2::table::add<u64, CooldownOrder<T0>>(&mut v2.orders, v3, v5);
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
        assert!(arg3 > 0 && v0.active >= arg3, 13835341218182070289);
        v0.active = v0.active - arg3;
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg2);
        v1.active = v1.active - arg3;
        arg0.active = arg0.active - arg3;
        0x2::balance::split<T0>(&mut arg0.vault, arg3)
    }

    public fun transfer_position<T0>(arg0: &mut Pool<T0>, arg1: Position<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = require_owner<T0>(arg0, &arg1, arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(arg2 != @0x0 && arg2 != v1, 13835622474115579923);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0);
        assert!(v2.active + v2.short >= 10000000000, 13835341012023640081);
        v2.owner = arg2;
        let v3 = v2.active;
        let v4 = v2.short;
        let v5 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v1);
        let v6 = &mut v5.positions;
        remove_id(v6, v0);
        v5.active = v5.active - v3;
        v5.short = v5.short - v4;
        let v7 = account<T0>(arg0, arg2);
        assert!(0x1::vector::length<0x2::object::ID>(&v7.positions) < 10, 13835341046383378449);
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
        assert!(pause_flags<T0>(arg0) & 8 == 0, 13836185814911287319);
        let v0 = require_owner<T0>(arg0, arg1, arg3);
        let v1 = take_active<T0>(arg0, v0, 0x2::tx_context::sender(arg3), arg2);
        let v2 = instant_fee<T0>(arg0, arg2);
        assert!(v2 < arg2, 13835341407160631313);
        let v3 = 0x2::object::id<Pool<T0>>(arg0);
        if (v2 > 0) {
            0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::fee_distributor::distribute<T0>(&mut arg0.reserve, v3, 0x2::balance::split<T0>(&mut v1, v2));
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
        let CooldownOrder {
            principal : v1,
            ready_at  : v2,
        } = 0x2::table::remove<u64, CooldownOrder<T0>>(&mut 0x2::table::borrow_mut<0x2::object::ID, PositionState<T0>>(&mut arg0.positions, v0).orders, arg2);
        let v3 = v1;
        assert!(0x2::clock::timestamp_ms(arg3) >= v2, 13835904314164641813);
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

    public fun withdraw_rewards<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_operator<T0>(arg0, v0), 13836749598088626203);
        assert!(arg1 > 0, 13835342227499384849);
        assert!(arg2 != @0x0, 13835623706771193875);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::withdraw<T1>(&mut arg0.reserve, arg1), arg3), arg2);
        let v1 = RewardWithdrawn<T1>{
            pool      : 0x2::object::id<Pool<T0>>(arg0),
            operator  : v0,
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<RewardWithdrawn<T1>>(v1);
    }

    public fun withdraw_short<T0>(arg0: &mut Pool<T0>, arg1: &Position<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(pause_flags<T0>(arg0) & 2 == 0, 13836185960940175383);
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

    public(friend) fun write_epoch_window<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : bool {
        assert_reward_operator<T0>(arg0, arg5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg2 < arg3 && arg3 <= 8640000000000000, 13835905469510844437);
        let v1 = 0x2::table::length<u64, EpochWindow>(&arg0.epoch_schedule);
        assert!(arg1 <= v1, 13835905478100779029);
        if (arg1 > 0) {
            assert!(0x2::table::borrow<u64, EpochWindow>(&arg0.epoch_schedule, arg1 - 1).end_ms <= arg2, 13835905482395746325);
        };
        let v2 = EpochWindow{
            start_ms : arg2,
            end_ms   : arg3,
        };
        if (arg1 == v1) {
            assert!(v0 <= arg2, 13835905499575615509);
            0x2::table::add<u64, EpochWindow>(&mut arg0.epoch_schedule, arg1, v2);
        } else {
            let v3 = 0x2::table::borrow<u64, EpochWindow>(&arg0.epoch_schedule, arg1);
            if (v0 < v3.start_ms) {
                assert!(v0 <= arg2, 13835905525345419285);
            } else {
                assert!(v0 < v3.end_ms, 13835905538230321173);
                let v4 = if (arg2 == v3.start_ms) {
                    if (v0 < arg3) {
                        arg3 != v3.end_ms
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v4, 13835905546820255765);
            };
            if (arg1 + 1 < v1) {
                assert!(arg3 <= 0x2::table::borrow<u64, EpochWindow>(&arg0.epoch_schedule, arg1 + 1).start_ms, 13835905559705157653);
            };
            *0x2::table::borrow_mut<u64, EpochWindow>(&mut arg0.epoch_schedule, arg1) = v2;
        };
        let v5 = v1 == 0;
        if (v5) {
            arg0.distributor_registered = true;
        };
        let v6 = EpochScheduled{
            pool     : 0x2::object::id<Pool<T0>>(arg0),
            epoch    : arg1,
            start_ms : arg2,
            end_ms   : arg3,
        };
        0x2::event::emit<EpochScheduled>(v6);
        v5
    }

    // decompiled from Move bytecode v7
}

