module 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::global_config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        permissions: u32,
        before_version: u64,
    }

    struct GlobalConfigInitEvent has copy, drop {
        global_config_id: 0x2::object::ID,
        permissions: u32,
    }

    struct PermissionUpdatedEvent has copy, drop {
        permission_type: u8,
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct EmergencyPauseEvent has copy, drop {
        before_version: u64,
        sender: address,
        timestamp: u64,
    }

    struct EmergencyUnpauseEvent has copy, drop {
        restored_version: u64,
        sender: address,
        timestamp: u64,
    }

    public fun check_borrow_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::borrow_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::borrow_denied());
    }

    public fun check_conditional_order_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::conditional_order_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::conditional_order_denied());
    }

    public fun check_deposit_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::deposit_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::deposit_denied());
    }

    public fun check_liquidate_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::liquidate_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::liquidate_denied());
    }

    public fun check_repay_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::repay_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::repay_denied());
    }

    public fun check_supplier_withdraw_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::supplier_withdraw_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::supplier_withdraw_denied());
    }

    public fun check_supply_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::supply_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::supply_denied());
    }

    public fun check_trade_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::trade_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::trade_denied());
    }

    public fun check_withdraw_permission(arg0: &GlobalConfig) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::withdraw_permission()), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::withdraw_denied());
    }

    public fun emergency_pause(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: &mut 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg2);
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::version(arg2) != 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::emergency_pause_version(), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::protocol_already_emergency_pause());
        arg1.before_version = 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::version(arg2);
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::set_version(arg2, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::emergency_pause_version());
        let v0 = EmergencyPauseEvent{
            before_version : arg1.before_version,
            sender         : 0x2::tx_context::sender(arg4),
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EmergencyPauseEvent>(v0);
    }

    public fun emergency_unpause(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &GlobalConfig, arg2: &mut 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::version(arg2) == 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::emergency_pause_version(), 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::protocol_not_emergency_pause());
        assert!(arg3 <= 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::current_version() && arg3 >= arg1.before_version, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::errors::invalid_version());
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::set_version(arg2, arg3);
        let v0 = EmergencyUnpauseEvent{
            restored_version : arg3,
            sender           : 0x2::tx_context::sender(arg5),
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EmergencyUnpauseEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id             : 0x2::object::new(arg0),
            permissions    : 4294967295,
            before_version : 0,
        };
        let v1 = GlobalConfigInitEvent{
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
            permissions      : 4294967295,
        };
        0x2::event::emit<GlobalConfigInitEvent>(v1);
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun is_permission_enabled(arg0: &GlobalConfig, arg1: u8) : bool {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::check_permission(arg0.permissions, arg1)
    }

    public fun permissions(arg0: &GlobalConfig) : u32 {
        arg0.permissions
    }

    public fun update_borrow_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::borrow_permission(), arg2, arg3, arg5);
    }

    public fun update_conditional_order_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::conditional_order_permission(), arg2, arg3, arg5);
    }

    public fun update_deposit_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::deposit_permission(), arg2, arg3, arg5);
    }

    public fun update_liquidate_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::liquidate_permission(), arg2, arg3, arg5);
    }

    fun update_permission_internal(arg0: &mut GlobalConfig, arg1: u8, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        if (!arg2) {
            0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::set_permission(&mut arg0.permissions, arg1);
        } else {
            0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::unset_permission(&mut arg0.permissions, arg1);
        };
        let v0 = PermissionUpdatedEvent{
            permission_type : arg1,
            is_pause        : arg2,
            sender          : 0x2::tx_context::sender(arg4),
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PermissionUpdatedEvent>(v0);
    }

    public fun update_repay_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::repay_permission(), arg2, arg3, arg5);
    }

    public fun update_supplier_withdraw_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::supplier_withdraw_permission(), arg2, arg3, arg5);
    }

    public fun update_supply_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::supply_permission(), arg2, arg3, arg5);
    }

    public fun update_trade_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::trade_permission(), arg2, arg3, arg5);
    }

    public fun update_withdraw_permission(arg0: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::versioned::check_version(arg4);
        update_permission_internal(arg1, 0x7f523884376d4be39773393fbee81b70e2c703d83a4737af040246b498494106::permissions::withdraw_permission(), arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

