module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker {
    struct BreakerState has copy, drop, store {
        frozen_price: u64,
        last_valid_timestamp_ms: u64,
        session_status: u8,
        n_max_halved: bool,
        original_n_max: u64,
    }

    struct BreakerRegistry has key {
        id: 0x2::object::UID,
        states: 0x2::table::Table<vector<u8>, BreakerState>,
    }

    struct PriceAccepted has copy, drop {
        symbol: vector<u8>,
        old_price: u64,
        new_price: u64,
        deviation_bps: u64,
    }

    struct PriceRejected has copy, drop {
        symbol: vector<u8>,
        old_price: u64,
        attempted_price: u64,
        deviation_bps: u64,
    }

    struct EmergencyActivated has copy, drop {
        symbol: vector<u8>,
        frozen_price: u64,
        reason: vector<u8>,
    }

    struct EmergencyDeactivated has copy, drop {
        symbol: vector<u8>,
        resumed_price: u64,
    }

    struct NMaxHalved has copy, drop {
        symbol: vector<u8>,
        original_n_max: u64,
        halved_n_max: u64,
    }

    struct NMaxRestored has copy, drop {
        symbol: vector<u8>,
        restored_n_max: u64,
    }

    struct BreakerRegistered has copy, drop {
        symbol: vector<u8>,
        initial_price: u64,
        n_max: u64,
    }

    public fun admin_activate_emergency(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut BreakerRegistry, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg1.states, arg2), 3);
        let v0 = 0x2::table::borrow_mut<vector<u8>, BreakerState>(&mut arg1.states, arg2);
        assert!(v0.session_status != 1, 1);
        v0.session_status = 1;
        let v1 = EmergencyActivated{
            symbol       : arg2,
            frozen_price : v0.frozen_price,
            reason       : b"admin_override",
        };
        0x2::event::emit<EmergencyActivated>(v1);
    }

    public fun admin_deactivate_emergency(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut BreakerRegistry, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg1.states, arg2), 3);
        assert!(arg3 > 0, 7);
        let v0 = 0x2::table::borrow_mut<vector<u8>, BreakerState>(&mut arg1.states, arg2);
        assert!(v0.session_status == 1, 2);
        v0.session_status = 0;
        v0.frozen_price = arg3;
        v0.last_valid_timestamp_ms = 0x2::clock::timestamp_ms(arg4);
        if (v0.n_max_halved) {
            v0.n_max_halved = false;
            let v1 = NMaxRestored{
                symbol         : arg2,
                restored_n_max : v0.original_n_max,
            };
            0x2::event::emit<NMaxRestored>(v1);
        };
        let v2 = EmergencyDeactivated{
            symbol        : arg2,
            resumed_price : arg3,
        };
        0x2::event::emit<EmergencyDeactivated>(v2);
    }

    public fun admin_update_n_max(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut BreakerRegistry, arg2: vector<u8>, arg3: u64) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg1.states, arg2), 3);
        assert!(arg3 > 0, 8);
        0x2::table::borrow_mut<vector<u8>, BreakerState>(&mut arg1.states, arg2).original_n_max = arg3;
    }

    public fun assert_funding_allowed(arg0: &BreakerRegistry, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        assert!(0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).session_status != 1, 5);
    }

    public fun assert_not_emergency(arg0: &BreakerRegistry, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        assert!(0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).session_status != 1, 6);
    }

    public fun breaker_exists(arg0: &BreakerRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1)
    }

    fun compute_deviation_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        (((v0 as u128) * (10000 as u128) / (arg0 as u128)) as u64)
    }

    public fun freeze_on_oracle_failure(arg0: &mut BreakerRegistry, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        let v0 = 0x2::table::borrow_mut<vector<u8>, BreakerState>(&mut arg0.states, arg1);
        if (v0.session_status != 1) {
            v0.session_status = 1;
            let v1 = EmergencyActivated{
                symbol       : arg1,
                frozen_price : v0.frozen_price,
                reason       : b"oracle_failure",
            };
            0x2::event::emit<EmergencyActivated>(v1);
        };
    }

    public fun get_effective_n_max(arg0: &BreakerRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        get_effective_n_max_internal(0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1))
    }

    fun get_effective_n_max_internal(arg0: &BreakerState) : u64 {
        if (arg0.n_max_halved) {
            arg0.original_n_max / 2
        } else {
            arg0.original_n_max
        }
    }

    public fun get_frozen_price(arg0: &BreakerRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).frozen_price
    }

    public fun get_last_valid_timestamp(arg0: &BreakerRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).last_valid_timestamp_ms
    }

    public fun get_original_n_max(arg0: &BreakerRegistry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).original_n_max
    }

    public fun get_session_status(arg0: &BreakerRegistry, arg1: vector<u8>) : u8 {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).session_status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BreakerRegistry{
            id     : 0x2::object::new(arg0),
            states : 0x2::table::new<vector<u8>, BreakerState>(arg0),
        };
        0x2::transfer::share_object<BreakerRegistry>(v0);
    }

    public fun is_emergency(arg0: &BreakerRegistry, arg1: vector<u8>) : bool {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).session_status == 1
    }

    public fun is_funding_allowed(arg0: &BreakerRegistry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1)) {
            return true
        };
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).session_status != 1
    }

    public fun is_n_max_halved(arg0: &BreakerRegistry, arg1: vector<u8>) : bool {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        0x2::table::borrow<vector<u8>, BreakerState>(&arg0.states, arg1).n_max_halved
    }

    public fun register_breaker(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut BreakerRegistry, arg2: vector<u8>, arg3: u64, arg4: u64) {
        assert!(!0x2::table::contains<vector<u8>, BreakerState>(&arg1.states, arg2), 4);
        assert!(arg3 > 0, 7);
        assert!(arg4 > 0, 8);
        let v0 = BreakerState{
            frozen_price            : arg3,
            last_valid_timestamp_ms : 0,
            session_status          : 0,
            n_max_halved            : false,
            original_n_max          : arg4,
        };
        0x2::table::add<vector<u8>, BreakerState>(&mut arg1.states, arg2, v0);
        let v1 = BreakerRegistered{
            symbol        : arg2,
            initial_price : arg3,
            n_max         : arg4,
        };
        0x2::event::emit<BreakerRegistered>(v1);
    }

    public fun validate_price_update(arg0: &mut BreakerRegistry, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64, bool) {
        assert!(0x2::table::contains<vector<u8>, BreakerState>(&arg0.states, arg1), 3);
        assert!(arg2 > 0, 7);
        let v0 = 0x2::table::borrow_mut<vector<u8>, BreakerState>(&mut arg0.states, arg1);
        let v1 = v0.frozen_price;
        let v2 = compute_deviation_bps(v1, arg2);
        if (v2 > 1000) {
            v0.session_status = 1;
            if (!v0.n_max_halved) {
                v0.n_max_halved = true;
                let v3 = NMaxHalved{
                    symbol         : arg1,
                    original_n_max : v0.original_n_max,
                    halved_n_max   : v0.original_n_max / 2,
                };
                0x2::event::emit<NMaxHalved>(v3);
            };
            let v4 = EmergencyActivated{
                symbol       : arg1,
                frozen_price : v1,
                reason       : b"gap_exceeds_10pct",
            };
            0x2::event::emit<EmergencyActivated>(v4);
            let v5 = PriceRejected{
                symbol          : arg1,
                old_price       : v1,
                attempted_price : arg2,
                deviation_bps   : v2,
            };
            0x2::event::emit<PriceRejected>(v5);
            return (v1, get_effective_n_max_internal(v0), false)
        };
        if (v2 > 500) {
            let v6 = PriceRejected{
                symbol          : arg1,
                old_price       : v1,
                attempted_price : arg2,
                deviation_bps   : v2,
            };
            0x2::event::emit<PriceRejected>(v6);
            abort 0
        };
        v0.frozen_price = arg2;
        v0.last_valid_timestamp_ms = 0x2::clock::timestamp_ms(arg3);
        if (v0.n_max_halved) {
            v0.n_max_halved = false;
            let v7 = NMaxRestored{
                symbol         : arg1,
                restored_n_max : v0.original_n_max,
            };
            0x2::event::emit<NMaxRestored>(v7);
        };
        let v8 = PriceAccepted{
            symbol        : arg1,
            old_price     : v1,
            new_price     : arg2,
            deviation_bps : v2,
        };
        0x2::event::emit<PriceAccepted>(v8);
        (arg2, get_effective_n_max_internal(v0), true)
    }

    // decompiled from Move bytecode v7
}

