module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slots {
    struct MachineKey has copy, drop, store {
        machine_id: u64,
    }

    struct VersionKey has copy, drop, store {
        machine_id: u64,
        version: u64,
    }

    struct RetiredKey has copy, drop, store {
        machine_id: u64,
        version: u64,
    }

    struct Machine has copy, drop, store {
        name: 0x1::string::String,
        latest_version: u64,
        paused: bool,
        max_spin_exposure_bps: u64,
    }

    struct Spin has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        player: address,
        machine_id: u64,
        version: u64,
        stake: u64,
        max_payout: u64,
        stops: vector<u8>,
        bet: 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet,
    }

    struct SpinDrawn has copy, drop {
        pool_id: 0x2::object::ID,
        spin_id: 0x2::object::ID,
        player: address,
        machine_id: u64,
        version: u64,
        stake: u64,
        stops: vector<u8>,
    }

    struct MachineCreated has copy, drop {
        pool_id: 0x2::object::ID,
        machine_id: u64,
        name: 0x1::string::String,
    }

    struct VersionPublished has copy, drop {
        pool_id: 0x2::object::ID,
        machine_id: u64,
        version: u64,
        layout: u8,
        reels: u64,
        rows: u64,
        paylines: u64,
        features: u64,
        max_win_mult: u64,
        min_bet: u64,
        max_bet: u64,
        rtp_bps: u64,
        draws_per_spin: u64,
    }

    struct VersionRetired has copy, drop {
        pool_id: 0x2::object::ID,
        machine_id: u64,
        version: u64,
    }

    struct MachineSettingsUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        machine_id: u64,
        paused: bool,
        max_spin_exposure_bps: u64,
    }

    struct SpinResolved has copy, drop {
        pool_id: 0x2::object::ID,
        spin_id: 0x2::object::ID,
        player: address,
        machine_id: u64,
        version: u64,
        stake: u64,
        stops: vector<u8>,
        base_grid: vector<u8>,
        base_units: u64,
        base_scatters: u64,
        free_spins_awarded: u64,
        free_spins_played: u64,
        retriggers: u64,
        final_multiplier: u64,
        fs_units: u64,
        total_units: u64,
        payout: u64,
        max_payout: u64,
        capped: bool,
    }

    fun assert_cap(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap) {
        assert!(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::admin_cap_pool_id(arg1) == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 0);
    }

    public fun config(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64) : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig {
        *config_ref(arg0, arg1, arg2)
    }

    fun config_ref(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64) : &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0);
        let v1 = VersionKey{
            machine_id : arg1,
            version    : arg2,
        };
        assert!(0x2::dynamic_field::exists<VersionKey>(v0, v1), 3);
        let v2 = VersionKey{
            machine_id : arg1,
            version    : arg2,
        };
        0x2::dynamic_field::borrow<VersionKey, 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig>(v0, v2)
    }

    public fun create_machine(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: u64, arg3: 0x1::string::String) {
        assert_cap(arg0, arg1);
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid_mut(arg0);
        let v1 = MachineKey{machine_id: arg2};
        assert!(!0x2::dynamic_field::exists<MachineKey>(v0, v1), 2);
        let v2 = MachineKey{machine_id: arg2};
        let v3 = Machine{
            name                  : arg3,
            latest_version        : 0,
            paused                : false,
            max_spin_exposure_bps : 150,
        };
        0x2::dynamic_field::add<MachineKey, Machine>(v0, v2, v3);
        let v4 = MachineCreated{
            pool_id    : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            machine_id : arg2,
            name       : arg3,
        };
        0x2::event::emit<MachineCreated>(v4);
    }

    public fun default_max_spin_exposure_bps() : u64 {
        150
    }

    fun draw_stops(arg0: &mut 0x2::random::RandomGenerator, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig) : vector<u8> {
        let v0 = 0x2::random::generate_bytes(arg0, (0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::random_bytes_per_spin(arg1) as u16));
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::stops_from_bytes(arg1, &v0)
    }

    fun emit_drawn(arg0: &Spin) {
        let v0 = SpinDrawn{
            pool_id    : arg0.pool_id,
            spin_id    : 0x2::object::id<Spin>(arg0),
            player     : arg0.player,
            machine_id : arg0.machine_id,
            version    : arg0.version,
            stake      : arg0.stake,
            stops      : arg0.stops,
        };
        0x2::event::emit<SpinDrawn>(v0);
    }

    fun emit_settings(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) {
        let v0 = machine(arg0, arg1);
        let v1 = MachineSettingsUpdated{
            pool_id               : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            machine_id            : arg1,
            paused                : v0.paused,
            max_spin_exposure_bps : v0.max_spin_exposure_bps,
        };
        0x2::event::emit<MachineSettingsUpdated>(v1);
    }

    public fun is_playable(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64) : bool {
        if (machine_exists(arg0, arg1)) {
            if (version_exists(arg0, arg1, arg2)) {
                if (!is_retired(arg0, arg1, arg2)) {
                    !machine_paused(arg0, arg1)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_retired(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64) : bool {
        let v0 = RetiredKey{
            machine_id : arg1,
            version    : arg2,
        };
        0x2::dynamic_field::exists<RetiredKey>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0), v0)
    }

    public fun latest_version(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : u64 {
        let v0 = machine(arg0, arg1);
        v0.latest_version
    }

    fun machine(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : Machine {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0);
        let v1 = MachineKey{machine_id: arg1};
        assert!(0x2::dynamic_field::exists<MachineKey>(v0, v1), 1);
        let v2 = MachineKey{machine_id: arg1};
        *0x2::dynamic_field::borrow<MachineKey, Machine>(v0, v2)
    }

    public fun machine_exists(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : bool {
        let v0 = MachineKey{machine_id: arg1};
        0x2::dynamic_field::exists<MachineKey>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0), v0)
    }

    fun machine_mut(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : &mut Machine {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid_mut(arg0);
        let v1 = MachineKey{machine_id: arg1};
        assert!(0x2::dynamic_field::exists<MachineKey>(v0, v1), 1);
        let v2 = MachineKey{machine_id: arg1};
        0x2::dynamic_field::borrow_mut<MachineKey, Machine>(v0, v2)
    }

    public fun machine_name(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : 0x1::string::String {
        let v0 = machine(arg0, arg1);
        v0.name
    }

    public fun machine_paused(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : bool {
        let v0 = machine(arg0, arg1);
        v0.paused
    }

    public fun max_spin_exposure_bps(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64) : u64 {
        let v0 = machine(arg0, arg1);
        v0.max_spin_exposure_bps
    }

    public fun max_stake_for_exposure(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64) : u64 {
        let v0 = machine(arg0, arg1);
        let v1 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::house_capital(arg0);
        let v2 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_liability(arg0);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        (((v3 as u128) * (v0.max_spin_exposure_bps as u128) / (10000 as u128) / ((0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::max_win_mult(config_ref(arg0, arg1, arg2)) - 1) as u128)) as u64)
    }

    fun open_spin(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : Spin {
        let v0 = machine(arg0, arg1);
        assert!(!v0.paused, 5);
        let v1 = config_ref(arg0, arg1, arg2);
        let v2 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::max_bet(v1);
        let v3 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rtp_bps(v1);
        assert!(!is_retired(arg0, arg1, arg2), 4);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v4 >= 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::min_bet(v1), 6);
        assert!(v2 == 0 || v4 <= v2, 7);
        let v5 = (v4 as u128) * (0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::max_win_mult(v1) as u128);
        assert!(v5 <= 18446744073709551615, 10);
        let v6 = (v5 as u64) - v4;
        let v7 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::house_capital(arg0);
        let v8 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_liability(arg0);
        let v9 = if (v7 > v8) {
            v7 - v8
        } else {
            0
        };
        assert!((v6 as u128) * (10000 as u128) <= (v9 as u128) * (v0.max_spin_exposure_bps as u128), 8);
        let v10 = 0x2::tx_context::sender(arg4);
        Spin{
            id         : 0x2::object::new(arg4),
            pool_id    : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            player     : v10,
            machine_id : arg1,
            version    : arg2,
            stake      : v4,
            max_payout : (v5 as u64),
            stops      : b"",
            bet        : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_position(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), v6, v10, slot_edge_bps(v3)),
        }
    }

    fun play(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = open_spin(arg0, arg2, arg3, arg4, arg5);
        let v1 = 0x2::random::new_generator(arg1, arg5);
        let v2 = &mut v1;
        v0.stops = draw_stops(v2, config_ref(arg0, arg2, arg3));
        emit_drawn(&v0);
        0x2::transfer::share_object<Spin>(v0);
        0x2::object::id<Spin>(&v0)
    }

    public fun publish_version(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: u64, arg3: 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig) : u64 {
        assert_cap(arg0, arg1);
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::validate(&arg3);
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid_mut(arg0);
        let v1 = MachineKey{machine_id: arg2};
        assert!(0x2::dynamic_field::exists<MachineKey>(v0, v1), 1);
        let v2 = MachineKey{machine_id: arg2};
        let v3 = 0x2::dynamic_field::borrow_mut<MachineKey, Machine>(v0, v2);
        let v4 = v3.latest_version + 1;
        v3.latest_version = v4;
        let v5 = VersionKey{
            machine_id : arg2,
            version    : v4,
        };
        0x2::dynamic_field::add<VersionKey, 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig>(v0, v5, arg3);
        let v6 = VersionPublished{
            pool_id        : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            machine_id     : arg2,
            version        : v4,
            layout         : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::layout(&arg3),
            reels          : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(&arg3),
            rows           : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rows(&arg3),
            paylines       : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::payline_count(&arg3),
            features       : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::features(&arg3),
            max_win_mult   : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::max_win_mult(&arg3),
            min_bet        : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::min_bet(&arg3),
            max_bet        : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::max_bet(&arg3),
            rtp_bps        : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rtp_bps(&arg3),
            draws_per_spin : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::draws_per_spin(&arg3),
        };
        0x2::event::emit<VersionPublished>(v6);
        v4
    }

    public fun retire_version(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: u64, arg3: u64) {
        assert_cap(arg0, arg1);
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid_mut(arg0);
        let v1 = VersionKey{
            machine_id : arg2,
            version    : arg3,
        };
        assert!(0x2::dynamic_field::exists<VersionKey>(v0, v1), 3);
        let v2 = RetiredKey{
            machine_id : arg2,
            version    : arg3,
        };
        assert!(!0x2::dynamic_field::exists<RetiredKey>(v0, v2), 4);
        let v3 = RetiredKey{
            machine_id : arg2,
            version    : arg3,
        };
        0x2::dynamic_field::add<RetiredKey, bool>(v0, v3, true);
        let v4 = VersionRetired{
            pool_id    : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            machine_id : arg2,
            version    : arg3,
        };
        0x2::event::emit<VersionRetired>(v4);
    }

    public fun set_machine_paused(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: u64, arg3: bool) {
        assert_cap(arg0, arg1);
        let v0 = machine_mut(arg0, arg2);
        v0.paused = arg3;
        emit_settings(arg0, arg2);
    }

    public fun set_max_spin_exposure_bps(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: u64, arg3: u64) {
        assert_cap(arg0, arg1);
        assert!(arg3 >= 10 && arg3 <= 1500, 9);
        let v0 = machine_mut(arg0, arg2);
        v0.max_spin_exposure_bps = arg3;
        emit_settings(arg0, arg2);
    }

    fun settle_inner(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: Spin, arg2: &mut 0x2::tx_context::TxContext) {
        let Spin {
            id         : v0,
            pool_id    : _,
            player     : v2,
            machine_id : v3,
            version    : v4,
            stake      : v5,
            max_payout : v6,
            stops      : v7,
            bet        : v8,
        } = arg1;
        let v9 = v7;
        let v10 = v0;
        0x2::object::delete(v10);
        let v11 = config_ref(arg0, v3, v4);
        let v12 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::evaluate(v11, &v9);
        let (v13, v14) = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::payout(v11, v5, 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::total_units(&v12), v6);
        let v15 = SpinResolved{
            pool_id            : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            spin_id            : 0x2::object::uid_to_inner(&v10),
            player             : v2,
            machine_id         : v3,
            version            : v4,
            stake              : v5,
            stops              : v9,
            base_grid          : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::base_grid(&v12),
            base_units         : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::base_units(&v12),
            base_scatters      : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::base_scatters(&v12),
            free_spins_awarded : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::free_spins_awarded(&v12),
            free_spins_played  : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::free_spins_played(&v12),
            retriggers         : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::retriggers(&v12),
            final_multiplier   : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::final_multiplier(&v12),
            fs_units           : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::fs_units(&v12),
            total_units        : 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine::total_units(&v12),
            payout             : v13,
            max_payout         : v6,
            capped             : v14,
        };
        0x2::event::emit<SpinResolved>(v15);
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::settle_position(arg0, v8, v13), arg2), v2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::settle_position(arg0, v8, v13));
        };
    }

    public fun settle_spin(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: Spin, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 11);
        settle_inner(arg0, arg1, arg2);
    }

    public fun slot_edge_bps(arg0: u64) : u64 {
        if (arg0 >= 10000) {
            0
        } else {
            10000 - arg0
        }
    }

    entry fun spin(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        play(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun spin_machine_id(arg0: &Spin) : u64 {
        arg0.machine_id
    }

    public fun spin_max_payout(arg0: &Spin) : u64 {
        arg0.max_payout
    }

    public fun spin_player(arg0: &Spin) : address {
        arg0.player
    }

    public fun spin_pool_id(arg0: &Spin) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun spin_stake(arg0: &Spin) : u64 {
        arg0.stake
    }

    public fun spin_stops(arg0: &Spin) : vector<u8> {
        arg0.stops
    }

    public fun spin_version(arg0: &Spin) : u64 {
        arg0.version
    }

    entry fun spin_with_referrer(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::try_bind_referrer(arg0, 0x2::tx_context::sender(arg6), arg5);
        play(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    public fun version_exists(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: u64, arg2: u64) : bool {
        let v0 = VersionKey{
            machine_id : arg1,
            version    : arg2,
        };
        0x2::dynamic_field::exists<VersionKey>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0), v0)
    }

    // decompiled from Move bytecode v7
}

