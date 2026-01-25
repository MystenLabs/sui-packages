module 0x4ba618c2de25006f7d22d5765923e2e2a83e62dc9aaf5619dc2799b5d069ec0::lp_registry {
    struct LPRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        default_operator: address,
        total_registered: u64,
        total_rebalances: u64,
        owner_positions: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct PositionRegistration has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        token_x_type: 0x1::string::String,
        token_y_type: 0x1::string::String,
        operators: vector<address>,
        range_bps: u64,
        rebalance_on_out_of_range: bool,
        timer_duration_ms: u64,
        next_execution_at: u64,
        rebalance_count: u64,
        last_rebalance_at: u64,
        is_active: bool,
        registered_at: u64,
    }

    struct PositionRegistered has copy, drop {
        registry_id: address,
        registration_id: address,
        position_id: address,
        owner: address,
        pool_id: address,
        token_x_type: 0x1::string::String,
        token_y_type: 0x1::string::String,
    }

    struct PositionUnregistered has copy, drop {
        registration_id: address,
        position_id: address,
        owner: address,
    }

    struct OperatorAdded has copy, drop {
        registration_id: address,
        operator: address,
    }

    struct OperatorRemoved has copy, drop {
        registration_id: address,
        operator: address,
    }

    struct RebalanceExecuted has copy, drop {
        registration_id: address,
        position_id: address,
        executor: address,
        reason: 0x1::string::String,
        rebalance_count: u64,
    }

    struct SettingsUpdated has copy, drop {
        registration_id: address,
        range_bps: u64,
        rebalance_on_out_of_range: bool,
        timer_duration_ms: u64,
    }

    struct AutomationPaused has copy, drop {
        registration_id: address,
        owner: address,
    }

    struct AutomationResumed has copy, drop {
        registration_id: address,
        owner: address,
    }

    public entry fun add_operator(arg0: &mut PositionRegistration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        assert!(!0x1::vector::contains<address>(&arg0.operators, &arg1), 8);
        0x1::vector::push_back<address>(&mut arg0.operators, arg1);
        let v0 = OperatorAdded{
            registration_id : 0x2::object::id_address<PositionRegistration>(arg0),
            operator        : arg1,
        };
        0x2::event::emit<OperatorAdded>(v0);
    }

    public fun borrow_position_mut<T0: store + key>(arg0: &mut LPRegistry, arg1: &PositionRegistration, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        assert!(is_authorized(arg1, 0x2::tx_context::sender(arg2)), 3);
        assert!(arg1.is_active, 7);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, T0>(&mut arg0.id, arg1.position_id)
    }

    public fun get_owner_position_count(arg0: &LPRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_positions, arg1)) {
            0x1::vector::length<0x2::object::ID>(0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_positions, arg1))
        } else {
            0
        }
    }

    public fun get_owner_positions(arg0: &LPRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_positions, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owner_positions, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_registration_info(arg0: &PositionRegistration) : (0x2::object::ID, address, 0x2::object::ID, u64, bool, u64, u64, u64, bool) {
        (arg0.position_id, arg0.owner, arg0.pool_id, arg0.range_bps, arg0.rebalance_on_out_of_range, arg0.timer_duration_ms, arg0.next_execution_at, arg0.rebalance_count, arg0.is_active)
    }

    public fun get_registry_stats(arg0: &LPRegistry) : (address, address, u64, u64) {
        (arg0.admin, arg0.default_operator, arg0.total_registered, arg0.total_rebalances)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LPRegistry{
            id               : 0x2::object::new(arg0),
            admin            : v0,
            default_operator : v0,
            total_registered : 0,
            total_rebalances : 0,
            owner_positions  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<LPRegistry>(v1);
    }

    public fun is_active(arg0: &PositionRegistration) : bool {
        arg0.is_active
    }

    fun is_authorized(arg0: &PositionRegistration, arg1: address) : bool {
        arg1 == arg0.owner || 0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_operator(arg0: &PositionRegistration, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.operators, &arg1)
    }

    public fun is_ready_for_timer_rebalance(arg0: &PositionRegistration, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.timer_duration_ms == 0) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) >= arg0.next_execution_at
    }

    public fun operators(arg0: &PositionRegistration) : &vector<address> {
        &arg0.operators
    }

    public fun owner(arg0: &PositionRegistration) : address {
        arg0.owner
    }

    public entry fun pause_automation(arg0: &mut PositionRegistration, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 2);
        arg0.is_active = false;
        let v1 = AutomationPaused{
            registration_id : 0x2::object::id_address<PositionRegistration>(arg0),
            owner           : v0,
        };
        0x2::event::emit<AutomationPaused>(v1);
    }

    public fun pool_id(arg0: &PositionRegistration) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id(arg0: &PositionRegistration) : 0x2::object::ID {
        arg0.position_id
    }

    public fun range_bps(arg0: &PositionRegistration) : u64 {
        arg0.range_bps
    }

    public fun rebalance_count(arg0: &PositionRegistration) : u64 {
        arg0.rebalance_count
    }

    public fun record_rebalance(arg0: &mut LPRegistry, arg1: &mut PositionRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_authorized(arg1, v0), 3);
        assert!(arg1.is_active, 7);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg1.rebalance_count = arg1.rebalance_count + 1;
        arg1.last_rebalance_at = v1;
        if (arg1.timer_duration_ms > 0) {
            arg1.next_execution_at = v1 + arg1.timer_duration_ms;
        };
        arg0.total_rebalances = arg0.total_rebalances + 1;
        let v2 = RebalanceExecuted{
            registration_id : 0x2::object::id_address<PositionRegistration>(arg1),
            position_id     : 0x2::object::id_to_address(&arg1.position_id),
            executor        : v0,
            reason          : arg2,
            rebalance_count : arg1.rebalance_count,
        };
        0x2::event::emit<RebalanceExecuted>(v2);
    }

    public fun register_position<T0: store + key>(arg0: &mut LPRegistry, arg1: T0, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg7 > 0 || arg6, 6);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = 0x2::object::id<T0>(&arg1);
        let v3 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v3, arg0.default_operator);
        let v4 = if (arg7 > 0) {
            v1 + arg7
        } else {
            18446744073709551615
        };
        let v5 = PositionRegistration{
            id                        : 0x2::object::new(arg9),
            position_id               : v2,
            owner                     : v0,
            pool_id                   : arg2,
            token_x_type              : arg3,
            token_y_type              : arg4,
            operators                 : v3,
            range_bps                 : arg5,
            rebalance_on_out_of_range : arg6,
            timer_duration_ms         : arg7,
            next_execution_at         : v4,
            rebalance_count           : 0,
            last_rebalance_at         : v1,
            is_active                 : true,
            registered_at             : v1,
        };
        let v6 = 0x2::object::id<PositionRegistration>(&v5);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v2, arg1);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_positions, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.owner_positions, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.owner_positions, v0), v6);
        arg0.total_registered = arg0.total_registered + 1;
        let v7 = PositionRegistered{
            registry_id     : 0x2::object::uid_to_address(&arg0.id),
            registration_id : 0x2::object::id_address<PositionRegistration>(&v5),
            position_id     : 0x2::object::id_to_address(&v2),
            owner           : v0,
            pool_id         : 0x2::object::id_to_address(&arg2),
            token_x_type    : arg3,
            token_y_type    : arg4,
        };
        0x2::event::emit<PositionRegistered>(v7);
        let v8 = OperatorAdded{
            registration_id : 0x2::object::id_address<PositionRegistration>(&v5),
            operator        : arg0.default_operator,
        };
        0x2::event::emit<OperatorAdded>(v8);
        0x2::transfer::share_object<PositionRegistration>(v5);
        v6
    }

    public entry fun register_position_entry<T0: store + key>(arg0: &mut LPRegistry, arg1: T0, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        register_position<T0>(arg0, arg1, arg2, 0x1::string::utf8(arg3), 0x1::string::utf8(arg4), arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun remove_operator(arg0: &mut PositionRegistration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg1);
        assert!(v0, 9);
        0x1::vector::remove<address>(&mut arg0.operators, v1);
        let v2 = OperatorRemoved{
            registration_id : 0x2::object::id_address<PositionRegistration>(arg0),
            operator        : arg1,
        };
        0x2::event::emit<OperatorRemoved>(v2);
    }

    public entry fun resume_automation(arg0: &mut PositionRegistration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 2);
        arg0.is_active = true;
        if (arg0.timer_duration_ms > 0) {
            arg0.next_execution_at = 0x2::clock::timestamp_ms(arg1) + arg0.timer_duration_ms;
        };
        let v1 = AutomationResumed{
            registration_id : 0x2::object::id_address<PositionRegistration>(arg0),
            owner           : v0,
        };
        0x2::event::emit<AutomationResumed>(v1);
    }

    public fun return_position<T0: store + key>(arg0: &mut LPRegistry, arg1: &PositionRegistration, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert!(is_authorized(arg1, 0x2::tx_context::sender(arg3)), 3);
        assert!(0x2::object::id<T0>(&arg2) == arg1.position_id, 4);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, arg1.position_id, arg2);
    }

    public entry fun set_default_operator(arg0: &mut LPRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.default_operator = arg1;
    }

    public fun should_rebalance_on_out_of_range(arg0: &PositionRegistration) : bool {
        arg0.is_active && arg0.rebalance_on_out_of_range
    }

    public fun take_position<T0: store + key>(arg0: &mut LPRegistry, arg1: &PositionRegistration, arg2: &0x2::tx_context::TxContext) : T0 {
        assert!(is_authorized(arg1, 0x2::tx_context::sender(arg2)), 3);
        assert!(arg1.is_active, 7);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1.position_id)
    }

    public fun token_types(arg0: &PositionRegistration) : (0x1::string::String, 0x1::string::String) {
        (arg0.token_x_type, arg0.token_y_type)
    }

    public entry fun transfer_admin(arg0: &mut LPRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    public entry fun unregister_and_return<T0: store + key>(arg0: &mut LPRegistry, arg1: PositionRegistration, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = unregister_position<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun unregister_position<T0: store + key>(arg0: &mut LPRegistry, arg1: PositionRegistration, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 2);
        let PositionRegistration {
            id                        : v0,
            position_id               : v1,
            owner                     : v2,
            pool_id                   : _,
            token_x_type              : _,
            token_y_type              : _,
            operators                 : _,
            range_bps                 : _,
            rebalance_on_out_of_range : _,
            timer_duration_ms         : _,
            next_execution_at         : _,
            rebalance_count           : _,
            last_rebalance_at         : _,
            is_active                 : _,
            registered_at             : _,
        } = arg1;
        let v15 = v1;
        let v16 = v0;
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owner_positions, v2)) {
            let v17 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.owner_positions, v2);
            let v18 = 0x2::object::uid_to_inner(&v16);
            let (v19, v20) = 0x1::vector::index_of<0x2::object::ID>(v17, &v18);
            if (v19) {
                0x1::vector::remove<0x2::object::ID>(v17, v20);
            };
        };
        arg0.total_registered = arg0.total_registered - 1;
        let v21 = PositionUnregistered{
            registration_id : 0x2::object::uid_to_address(&v16),
            position_id     : 0x2::object::id_to_address(&v15),
            owner           : v2,
        };
        0x2::event::emit<PositionUnregistered>(v21);
        0x2::object::delete(v16);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, v15)
    }

    public entry fun update_settings(arg0: &mut PositionRegistration, arg1: u64, arg2: bool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 2);
        assert!(arg3 > 0 || arg2, 6);
        arg0.range_bps = arg1;
        arg0.rebalance_on_out_of_range = arg2;
        arg0.timer_duration_ms = arg3;
        let v0 = SettingsUpdated{
            registration_id           : 0x2::object::id_address<PositionRegistration>(arg0),
            range_bps                 : arg1,
            rebalance_on_out_of_range : arg2,
            timer_duration_ms         : arg3,
        };
        0x2::event::emit<SettingsUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

