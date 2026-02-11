module 0x4554604e6a3fcc8a412884a45c47d1265588644a99a32029b8070e5ff8067e94::lp_registry {
    struct LPRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        operators: 0x2::vec_set::VecSet<address>,
        total_registered: u64,
        total_rebalanced: u64,
        total_compounded: u64,
        total_exited: u64,
    }

    struct RegisteredPosition has key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: address,
        auto_rebalance: bool,
        auto_compound: bool,
        recurring_count: u64,
        rebalance_delay_ms: u64,
        range_percent_bps: u64,
        use_zap: bool,
        is_paused: bool,
        is_position_held: bool,
        out_of_range_since: u64,
        rebalance_pending: bool,
        rebalance_count: u64,
        compound_count: u64,
        registered_at: u64,
        last_activity_at: u64,
    }

    struct PositionRegistered has copy, drop {
        position_id: address,
        registry_id: address,
        owner: address,
        pool_id: address,
        auto_rebalance: bool,
        auto_compound: bool,
        rebalance_delay_ms: u64,
    }

    struct PositionRetrieved has copy, drop {
        registry_id: address,
        position_id: address,
        operator: address,
        reason: vector<u8>,
    }

    struct PositionStored has copy, drop {
        registry_id: address,
        position_id: address,
        operator: address,
    }

    struct RebalanceRecorded has copy, drop {
        registry_id: address,
        old_position_id: address,
        new_position_id: address,
        owner: address,
        rebalance_count: u64,
    }

    struct CompoundRecorded has copy, drop {
        registry_id: address,
        position_id: address,
        owner: address,
        compound_count: u64,
    }

    struct PositionPaused has copy, drop {
        registry_id: address,
        owner: address,
    }

    struct PositionResumed has copy, drop {
        registry_id: address,
        owner: address,
    }

    struct PositionExited has copy, drop {
        registry_id: address,
        position_id: address,
        owner: address,
    }

    struct SettingsUpdated has copy, drop {
        registry_id: address,
        owner: address,
        auto_rebalance: bool,
        auto_compound: bool,
        rebalance_delay_ms: u64,
        range_percent_bps: u64,
        use_zap: bool,
    }

    struct OutOfRangeDetected has copy, drop {
        registry_id: address,
        position_id: address,
        detected_at: u64,
        rebalance_at: u64,
    }

    struct RebalanceDelayCleared has copy, drop {
        registry_id: address,
        position_id: address,
        reason: vector<u8>,
    }

    struct OperatorAdded has copy, drop {
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        operator: address,
    }

    public entry fun add_operator(arg0: &mut LPRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (!0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
            let v0 = OperatorAdded{operator: arg1};
            0x2::event::emit<OperatorAdded>(v0);
        };
    }

    public fun can_rebalance(arg0: &RegisteredPosition, arg1: &0x2::clock::Clock) : bool {
        let v0 = if (!arg0.auto_rebalance) {
            true
        } else if (arg0.is_paused) {
            true
        } else {
            arg0.is_position_held
        };
        if (v0) {
            return false
        };
        if (!arg0.rebalance_pending) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.out_of_range_since + arg0.rebalance_delay_ms
    }

    public entry fun clear_out_of_range(arg0: &LPRegistry, arg1: &mut RegisteredPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
        if (arg1.rebalance_pending) {
            arg1.rebalance_pending = false;
            arg1.out_of_range_since = 0;
            arg1.last_activity_at = 0x2::clock::timestamp_ms(arg2);
            let v1 = RebalanceDelayCleared{
                registry_id : 0x2::object::id_address<RegisteredPosition>(arg1),
                position_id : get_position_id(arg1),
                reason      : b"price_returned",
            };
            0x2::event::emit<RebalanceDelayCleared>(v1);
        };
    }

    public fun exit<T0: store + key>(arg0: &mut LPRegistry, arg1: RegisteredPosition, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 2);
        assert!(!arg1.is_position_held, 7);
        let RegisteredPosition {
            id                 : v0,
            owner              : v1,
            pool_id            : _,
            auto_rebalance     : _,
            auto_compound      : _,
            recurring_count    : _,
            rebalance_delay_ms : _,
            range_percent_bps  : _,
            use_zap            : _,
            is_paused          : _,
            is_position_held   : _,
            out_of_range_since : _,
            rebalance_pending  : _,
            rebalance_count    : _,
            compound_count     : _,
            registered_at      : _,
            last_activity_at   : _,
        } = arg1;
        let v17 = v0;
        let v18 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v17, b"position");
        0x2::object::delete(v17);
        arg0.total_exited = arg0.total_exited + 1;
        let v19 = PositionExited{
            registry_id : 0x2::object::uid_to_address(&v17),
            position_id : 0x2::object::id_address<T0>(&v18),
            owner       : v1,
        };
        0x2::event::emit<PositionExited>(v19);
        v18
    }

    public entry fun exit_and_return<T0: store + key>(arg0: &mut LPRegistry, arg1: RegisteredPosition, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(exit<T0>(arg0, arg1, arg2), arg1.owner);
    }

    fun get_position_id(arg0: &RegisteredPosition) : address {
        0x2::object::id_address<RegisteredPosition>(arg0)
    }

    public fun get_position_info(arg0: &RegisteredPosition) : (address, address, bool, bool, u64, u64, u64, bool, bool, bool) {
        (arg0.owner, arg0.pool_id, arg0.auto_rebalance, arg0.auto_compound, arg0.recurring_count, arg0.rebalance_delay_ms, arg0.range_percent_bps, arg0.use_zap, arg0.is_paused, arg0.is_position_held)
    }

    public fun get_position_stats(arg0: &RegisteredPosition) : (u64, u64, u64, u64) {
        (arg0.rebalance_count, arg0.compound_count, arg0.registered_at, arg0.last_activity_at)
    }

    public fun get_rebalance_status(arg0: &RegisteredPosition, arg1: &0x2::clock::Clock) : (bool, u64, u64) {
        let v0 = if (arg0.rebalance_pending) {
            let v1 = 0x2::clock::timestamp_ms(arg1);
            let v2 = arg0.out_of_range_since + arg0.rebalance_delay_ms;
            if (v1 >= v2) {
                0
            } else {
                v2 - v1
            }
        } else {
            0
        };
        (arg0.rebalance_pending, arg0.out_of_range_since, v0)
    }

    public fun get_registry_stats(arg0: &LPRegistry) : (address, u64, u64, u64, u64) {
        (arg0.admin, arg0.total_registered, arg0.total_rebalanced, arg0.total_compounded, arg0.total_exited)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LPRegistry{
            id               : 0x2::object::new(arg0),
            admin            : v0,
            operators        : 0x2::vec_set::empty<address>(),
            total_registered : 0,
            total_rebalanced : 0,
            total_compounded : 0,
            total_exited     : 0,
        };
        0x2::vec_set::insert<address>(&mut v1.operators, v0);
        0x2::transfer::share_object<LPRegistry>(v1);
    }

    public fun is_operator(arg0: &LPRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_paused(arg0: &RegisteredPosition) : bool {
        arg0.is_paused
    }

    public entry fun mark_out_of_range(arg0: &LPRegistry, arg1: &mut RegisteredPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
        assert!(!arg1.is_paused, 4);
        assert!(arg1.auto_rebalance, 3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!arg1.rebalance_pending) {
            arg1.out_of_range_since = v1;
            arg1.rebalance_pending = true;
            let v2 = OutOfRangeDetected{
                registry_id  : 0x2::object::id_address<RegisteredPosition>(arg1),
                position_id  : get_position_id(arg1),
                detected_at  : v1,
                rebalance_at : v1 + arg1.rebalance_delay_ms,
            };
            0x2::event::emit<OutOfRangeDetected>(v2);
        };
    }

    public fun owner(arg0: &RegisteredPosition) : address {
        arg0.owner
    }

    public entry fun pause(arg0: &mut RegisteredPosition, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 2);
        assert!(!arg0.is_paused, 4);
        assert!(!arg0.is_position_held, 7);
        arg0.is_paused = true;
        arg0.last_activity_at = 0x2::clock::timestamp_ms(arg1);
        arg0.rebalance_pending = false;
        arg0.out_of_range_since = 0;
        let v1 = PositionPaused{
            registry_id : 0x2::object::id_address<RegisteredPosition>(arg0),
            owner       : v0,
        };
        0x2::event::emit<PositionPaused>(v1);
    }

    public fun pool_id(arg0: &RegisteredPosition) : address {
        arg0.pool_id
    }

    public entry fun record_compound(arg0: &mut LPRegistry, arg1: &mut RegisteredPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
        arg1.compound_count = arg1.compound_count + 1;
        arg1.last_activity_at = 0x2::clock::timestamp_ms(arg2);
        arg0.total_compounded = arg0.total_compounded + 1;
        let v1 = CompoundRecorded{
            registry_id    : 0x2::object::id_address<RegisteredPosition>(arg1),
            position_id    : get_position_id(arg1),
            owner          : arg1.owner,
            compound_count : arg1.compound_count,
        };
        0x2::event::emit<CompoundRecorded>(v1);
    }

    public entry fun register_position<T0: store + key>(arg0: &mut LPRegistry, arg1: T0, arg2: address, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 <= 86400000, 6);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = RegisteredPosition{
            id                 : 0x2::object::new(arg10),
            owner              : v0,
            pool_id            : arg2,
            auto_rebalance     : arg3,
            auto_compound      : arg4,
            recurring_count    : arg5,
            rebalance_delay_ms : arg6,
            range_percent_bps  : arg7,
            use_zap            : arg8,
            is_paused          : false,
            is_position_held   : false,
            out_of_range_since : 0,
            rebalance_pending  : false,
            rebalance_count    : 0,
            compound_count     : 0,
            registered_at      : v1,
            last_activity_at   : v1,
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v2.id, b"position", arg1);
        0x2::transfer::share_object<RegisteredPosition>(v2);
        arg0.total_registered = arg0.total_registered + 1;
        let v3 = PositionRegistered{
            position_id        : 0x2::object::id_address<T0>(&arg1),
            registry_id        : 0x2::object::id_address<RegisteredPosition>(&v2),
            owner              : v0,
            pool_id            : arg2,
            auto_rebalance     : arg3,
            auto_compound      : arg4,
            rebalance_delay_ms : arg6,
        };
        0x2::event::emit<PositionRegistered>(v3);
    }

    public entry fun remove_operator(arg0: &mut LPRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        if (0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
            let v0 = OperatorRemoved{operator: arg1};
            0x2::event::emit<OperatorRemoved>(v0);
        };
    }

    public entry fun request_rebalance(arg0: &mut RegisteredPosition, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(!arg0.is_paused, 4);
        assert!(!arg0.is_position_held, 7);
        assert!(arg0.auto_rebalance, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.out_of_range_since = v0;
        arg0.rebalance_pending = true;
        arg0.last_activity_at = v0;
        let v1 = OutOfRangeDetected{
            registry_id  : 0x2::object::id_address<RegisteredPosition>(arg0),
            position_id  : get_position_id(arg0),
            detected_at  : v0,
            rebalance_at : v0 + arg0.rebalance_delay_ms,
        };
        0x2::event::emit<OutOfRangeDetected>(v1);
    }

    public entry fun resume(arg0: &mut RegisteredPosition, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 2);
        assert!(arg0.is_paused, 5);
        arg0.is_paused = false;
        arg0.last_activity_at = 0x2::clock::timestamp_ms(arg1);
        let v1 = PositionResumed{
            registry_id : 0x2::object::id_address<RegisteredPosition>(arg0),
            owner       : v0,
        };
        0x2::event::emit<PositionResumed>(v1);
    }

    public fun retrieve_position<T0: store + key>(arg0: &LPRegistry, arg1: &mut RegisteredPosition, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
        assert!(!arg1.is_paused, 4);
        assert!(!arg1.is_position_held, 7);
        if (arg2 == b"rebalance") {
            assert!(arg1.rebalance_pending, 10);
            assert!(0x2::clock::timestamp_ms(arg3) >= arg1.out_of_range_since + arg1.rebalance_delay_ms, 9);
        };
        let v1 = 0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"position");
        arg1.is_position_held = true;
        arg1.last_activity_at = 0x2::clock::timestamp_ms(arg3);
        let v2 = PositionRetrieved{
            registry_id : 0x2::object::id_address<RegisteredPosition>(arg1),
            position_id : 0x2::object::id_address<T0>(&v1),
            operator    : v0,
            reason      : arg2,
        };
        0x2::event::emit<PositionRetrieved>(v2);
        v1
    }

    public fun store_new_position<T0: store + key>(arg0: &mut LPRegistry, arg1: &mut RegisteredPosition, arg2: T0, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 3);
        assert!(arg1.is_position_held, 8);
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut arg1.id, b"position", arg2);
        arg1.is_position_held = false;
        arg1.rebalance_pending = false;
        arg1.out_of_range_since = 0;
        arg1.rebalance_count = arg1.rebalance_count + 1;
        arg1.last_activity_at = 0x2::clock::timestamp_ms(arg4);
        if (arg1.recurring_count > 0) {
            arg1.recurring_count = arg1.recurring_count - 1;
            if (arg1.recurring_count == 0) {
                arg1.auto_rebalance = false;
            };
        };
        arg0.total_rebalanced = arg0.total_rebalanced + 1;
        let v1 = RebalanceRecorded{
            registry_id     : 0x2::object::id_address<RegisteredPosition>(arg1),
            old_position_id : arg3,
            new_position_id : 0x2::object::id_address<T0>(&arg2),
            owner           : arg1.owner,
            rebalance_count : arg1.rebalance_count,
        };
        0x2::event::emit<RebalanceRecorded>(v1);
    }

    public fun store_position<T0: store + key>(arg0: &mut RegisteredPosition, arg1: T0, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_position_held, 8);
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut arg0.id, b"position", arg1);
        arg0.is_position_held = false;
        arg0.last_activity_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = PositionStored{
            registry_id : 0x2::object::id_address<RegisteredPosition>(arg0),
            position_id : 0x2::object::id_address<T0>(&arg1),
            operator    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PositionStored>(v0);
    }

    public entry fun transfer_admin(arg0: &mut LPRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public entry fun update_settings(arg0: &mut RegisteredPosition, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == arg0.owner, 2);
        assert!(arg4 <= 86400000, 6);
        arg0.auto_rebalance = arg1;
        arg0.auto_compound = arg2;
        arg0.recurring_count = arg3;
        arg0.rebalance_delay_ms = arg4;
        arg0.range_percent_bps = arg5;
        arg0.use_zap = arg6;
        arg0.last_activity_at = 0x2::clock::timestamp_ms(arg7);
        let v1 = SettingsUpdated{
            registry_id        : 0x2::object::id_address<RegisteredPosition>(arg0),
            owner              : v0,
            auto_rebalance     : arg1,
            auto_compound      : arg2,
            rebalance_delay_ms : arg4,
            range_percent_bps  : arg5,
            use_zap            : arg6,
        };
        0x2::event::emit<SettingsUpdated>(v1);
    }

    public fun use_zap(arg0: &RegisteredPosition) : bool {
        arg0.use_zap
    }

    // decompiled from Move bytecode v6
}

