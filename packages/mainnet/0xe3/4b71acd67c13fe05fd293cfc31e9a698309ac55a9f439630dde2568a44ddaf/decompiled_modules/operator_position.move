module 0xe34b71acd67c13fe05fd293cfc31e9a698309ac55a9f439630dde2568a44ddaf::operator_position {
    struct OperatorConfig has key {
        id: 0x2::object::UID,
        default_operator: address,
        admin: address,
        total_positions: u64,
        total_rebalances: u64,
    }

    struct ManagedPosition<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: 0x2::object::ID,
        operators: vector<address>,
        range_bps: u64,
        rebalance_on_out_of_range: bool,
        timer_duration_ms: u64,
        next_execution_at: u64,
        rebalance_count: u64,
        last_rebalance_at: u64,
        is_active: bool,
        has_position: bool,
    }

    struct PositionCreated has copy, drop {
        position_id: address,
        owner: address,
        pool_id: 0x2::object::ID,
        range_bps: u64,
        rebalance_on_out_of_range: bool,
    }

    struct OperatorAdded has copy, drop {
        position_id: address,
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        position_id: address,
        operator: address,
    }

    struct RebalanceExecuted has copy, drop {
        position_id: address,
        executor: address,
        reason: 0x1::string::String,
        rebalance_count: u64,
    }

    struct PositionClosed has copy, drop {
        position_id: address,
        owner: address,
    }

    struct SettingsUpdated has copy, drop {
        position_id: address,
        range_bps: u64,
        rebalance_on_out_of_range: bool,
        timer_duration_ms: u64,
    }

    public entry fun add_operator<T0, T1>(arg0: &mut ManagedPosition<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(!0x1::vector::contains<address>(&arg0.operators, &arg1), 3);
        0x1::vector::push_back<address>(&mut arg0.operators, arg1);
        let v0 = OperatorAdded{
            position_id : 0x2::object::id_address<ManagedPosition<T0, T1>>(arg0),
            operator    : arg1,
        };
        0x2::event::emit<OperatorAdded>(v0);
    }

    public fun close_position<T0, T1, T2: store + key>(arg0: &mut OperatorConfig, arg1: ManagedPosition<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<T2> {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        let v0 = if (arg1.has_position) {
            0x1::option::some<T2>(0x2::dynamic_object_field::remove<vector<u8>, T2>(&mut arg1.id, b"position"))
        } else {
            0x1::option::none<T2>()
        };
        let ManagedPosition {
            id                        : v1,
            owner                     : v2,
            pool_id                   : _,
            operators                 : _,
            range_bps                 : _,
            rebalance_on_out_of_range : _,
            timer_duration_ms         : _,
            next_execution_at         : _,
            rebalance_count           : _,
            last_rebalance_at         : _,
            is_active                 : _,
            has_position              : _,
        } = arg1;
        let v13 = v1;
        let v14 = PositionClosed{
            position_id : 0x2::object::uid_to_address(&v13),
            owner       : v2,
        };
        0x2::event::emit<PositionClosed>(v14);
        0x2::object::delete(v13);
        v0
    }

    public entry fun create_and_share_position<T0, T1>(arg0: &mut OperatorConfig, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ManagedPosition<T0, T1>>(create_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun create_position<T0, T1>(arg0: &mut OperatorConfig, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ManagedPosition<T0, T1> {
        assert!(arg4 > 0 || arg3, 8);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, arg0.default_operator);
        let v3 = if (arg4 > 0) {
            v1 + arg4
        } else {
            18446744073709551615
        };
        let v4 = ManagedPosition<T0, T1>{
            id                        : 0x2::object::new(arg6),
            owner                     : v0,
            pool_id                   : arg1,
            operators                 : v2,
            range_bps                 : arg2,
            rebalance_on_out_of_range : arg3,
            timer_duration_ms         : arg4,
            next_execution_at         : v3,
            rebalance_count           : 0,
            last_rebalance_at         : v1,
            is_active                 : true,
            has_position              : false,
        };
        let v5 = 0x2::object::id_address<ManagedPosition<T0, T1>>(&v4);
        arg0.total_positions = arg0.total_positions + 1;
        let v6 = PositionCreated{
            position_id               : v5,
            owner                     : v0,
            pool_id                   : arg1,
            range_bps                 : arg2,
            rebalance_on_out_of_range : arg3,
        };
        0x2::event::emit<PositionCreated>(v6);
        let v7 = OperatorAdded{
            position_id : v5,
            operator    : arg0.default_operator,
        };
        0x2::event::emit<OperatorAdded>(v7);
        v4
    }

    public fun get_config_info(arg0: &OperatorConfig) : (address, address, u64, u64) {
        (arg0.default_operator, arg0.admin, arg0.total_positions, arg0.total_rebalances)
    }

    public fun get_position_info<T0, T1>(arg0: &ManagedPosition<T0, T1>) : (address, 0x2::object::ID, u64, bool, u64, u64, u64, u64, bool, bool) {
        (arg0.owner, arg0.pool_id, arg0.range_bps, arg0.rebalance_on_out_of_range, arg0.timer_duration_ms, arg0.next_execution_at, arg0.rebalance_count, arg0.last_rebalance_at, arg0.is_active, arg0.has_position)
    }

    public fun has_position<T0, T1>(arg0: &ManagedPosition<T0, T1>) : bool {
        arg0.has_position
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = OperatorConfig{
            id               : 0x2::object::new(arg0),
            default_operator : v0,
            admin            : v0,
            total_positions  : 0,
            total_rebalances : 0,
        };
        0x2::transfer::share_object<OperatorConfig>(v1);
    }

    public fun is_active<T0, T1>(arg0: &ManagedPosition<T0, T1>) : bool {
        arg0.is_active
    }

    fun is_authorized<T0, T1>(arg0: &ManagedPosition<T0, T1>, arg1: address) : bool {
        arg1 == arg0.owner || 0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_operator<T0, T1>(arg0: &ManagedPosition<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_ready_for_timer_rebalance<T0, T1>(arg0: &ManagedPosition<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.timer_duration_ms == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.next_execution_at
    }

    public fun next_execution_at<T0, T1>(arg0: &ManagedPosition<T0, T1>) : u64 {
        arg0.next_execution_at
    }

    public fun operators<T0, T1>(arg0: &ManagedPosition<T0, T1>) : &vector<address> {
        &arg0.operators
    }

    public fun owner<T0, T1>(arg0: &ManagedPosition<T0, T1>) : address {
        arg0.owner
    }

    public entry fun pause<T0, T1>(arg0: &mut ManagedPosition<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.is_active = false;
    }

    public fun pool_id<T0, T1>(arg0: &ManagedPosition<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun range_bps<T0, T1>(arg0: &ManagedPosition<T0, T1>) : u64 {
        arg0.range_bps
    }

    public fun rebalance_count<T0, T1>(arg0: &ManagedPosition<T0, T1>) : u64 {
        arg0.rebalance_count
    }

    public fun rebalance_on_out_of_range<T0, T1>(arg0: &ManagedPosition<T0, T1>) : bool {
        arg0.rebalance_on_out_of_range
    }

    public fun record_rebalance<T0, T1>(arg0: &mut OperatorConfig, arg1: &mut ManagedPosition<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_authorized<T0, T1>(arg1, v0), 2);
        assert!(arg1.is_active, 7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg1.rebalance_count = arg1.rebalance_count + 1;
        arg1.last_rebalance_at = v1;
        if (arg1.timer_duration_ms > 0) {
            arg1.next_execution_at = v1 + arg1.timer_duration_ms;
        };
        arg0.total_rebalances = arg0.total_rebalances + 1;
        let v2 = RebalanceExecuted{
            position_id     : 0x2::object::id_address<ManagedPosition<T0, T1>>(arg1),
            executor        : v0,
            reason          : arg2,
            rebalance_count : arg1.rebalance_count,
        };
        0x2::event::emit<RebalanceExecuted>(v2);
    }

    public entry fun remove_operator<T0, T1>(arg0: &mut ManagedPosition<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.operators, v1);
        let v2 = OperatorRemoved{
            position_id : 0x2::object::id_address<ManagedPosition<T0, T1>>(arg0),
            operator    : arg1,
        };
        0x2::event::emit<OperatorRemoved>(v2);
    }

    public entry fun resume<T0, T1>(arg0: &mut ManagedPosition<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.is_active = true;
        if (arg0.timer_duration_ms > 0) {
            arg0.next_execution_at = 0x2::clock::timestamp_ms(arg1) + arg0.timer_duration_ms;
        };
    }

    public fun retrieve_mmt_position<T0, T1, T2: store + key>(arg0: &mut ManagedPosition<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : T2 {
        assert!(is_authorized<T0, T1>(arg0, 0x2::tx_context::sender(arg1)), 2);
        assert!(arg0.has_position, 5);
        arg0.has_position = false;
        0x2::dynamic_object_field::remove<vector<u8>, T2>(&mut arg0.id, b"position")
    }

    public entry fun set_default_operator(arg0: &mut OperatorConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.default_operator = arg1;
    }

    public fun should_rebalance_on_out_of_range<T0, T1>(arg0: &ManagedPosition<T0, T1>) : bool {
        arg0.is_active && arg0.rebalance_on_out_of_range
    }

    public fun store_mmt_position<T0, T1, T2: store + key>(arg0: &mut ManagedPosition<T0, T1>, arg1: T2, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_authorized<T0, T1>(arg0, 0x2::tx_context::sender(arg2)), 2);
        assert!(!arg0.has_position, 6);
        0x2::dynamic_object_field::add<vector<u8>, T2>(&mut arg0.id, b"position", arg1);
        arg0.has_position = true;
    }

    public fun timer_duration_ms<T0, T1>(arg0: &ManagedPosition<T0, T1>) : u64 {
        arg0.timer_duration_ms
    }

    public entry fun transfer_admin(arg0: &mut OperatorConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public entry fun update_settings<T0, T1>(arg0: &mut ManagedPosition<T0, T1>, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        assert!(arg3 > 0 || arg2, 8);
        arg0.range_bps = arg1;
        arg0.rebalance_on_out_of_range = arg2;
        arg0.timer_duration_ms = arg3;
        let v0 = SettingsUpdated{
            position_id               : 0x2::object::id_address<ManagedPosition<T0, T1>>(arg0),
            range_bps                 : arg1,
            rebalance_on_out_of_range : arg2,
            timer_duration_ms         : arg3,
        };
        0x2::event::emit<SettingsUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

