module 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        collect_obligation_owner_cap_address: address,
        permissions: u32,
    }

    struct InitEvent has copy, drop {
        global_config_id: 0x2::object::ID,
    }

    struct SetCollectObligationOwnerCapAddressEvent has copy, drop {
        collect_obligation_owner_cap_address: address,
        sender: address,
        timestamp: u64,
    }

    struct UpdateGlobalOpenPositionPermissionsEvent has copy, drop {
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct UpdateGlobalClosePositionPermissionsEvent has copy, drop {
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct UpdateGlobalDepositPermissionsEvent has copy, drop {
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct UpdateGlobalBorrowPermissionsEvent has copy, drop {
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct UpdateGlobalWithdrawPermissionsEvent has copy, drop {
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    struct UpdateGlobalRepayPermissionsEvent has copy, drop {
        is_pause: bool,
        sender: address,
        timestamp: u64,
    }

    public fun check_borrow_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::borrow_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun check_claim_reward_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::claim_reward_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun check_close_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::close_position_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun check_deposit_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::deposit_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun check_open_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::open_position_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun check_repay_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::repay_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun check_withdraw_permission(arg0: &GlobalConfig) {
        assert!(0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::withdraw_permission()), 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::errors::err_invalid_config_permission());
    }

    public fun collect_obligation_owner_cap_address(arg0: &GlobalConfig) : address {
        arg0.collect_obligation_owner_cap_address
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                                   : 0x2::object::new(arg0),
            collect_obligation_owner_cap_address : @0x0,
            permissions                          : 4294967295,
        };
        let v1 = InitEvent{global_config_id: 0x2::object::id<GlobalConfig>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun is_borrow_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::borrow_permission())
    }

    public fun is_claim_reward_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::claim_reward_permission())
    }

    public fun is_close_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::close_position_permission())
    }

    public fun is_deposit_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::deposit_permission())
    }

    public fun is_open_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::open_position_permission())
    }

    public fun is_repay_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::repay_permission())
    }

    public fun is_withdraw_permission_enabled(arg0: &GlobalConfig) : bool {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::check_permission(arg0.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::withdraw_permission())
    }

    public fun permissions(arg0: &GlobalConfig) : u32 {
        arg0.permissions
    }

    public fun set_collect_obligation_owner_cap_address(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        arg1.collect_obligation_owner_cap_address = arg2;
        let v0 = SetCollectObligationOwnerCapAddressEvent{
            collect_obligation_owner_cap_address : arg2,
            sender                               : 0x2::tx_context::sender(arg5),
            timestamp                            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetCollectObligationOwnerCapAddressEvent>(v0);
    }

    public fun update_global_borrow_permissions(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        if (!arg2) {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::set_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::borrow_permission());
        } else {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::unset_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::borrow_permission());
        };
        let v0 = UpdateGlobalBorrowPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalBorrowPermissionsEvent>(v0);
    }

    public fun update_global_close_position_permissions(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        if (!arg2) {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::set_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::close_position_permission());
        } else {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::unset_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::close_position_permission());
        };
        let v0 = UpdateGlobalClosePositionPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalClosePositionPermissionsEvent>(v0);
    }

    public fun update_global_deposit_permissions(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        if (!arg2) {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::set_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::deposit_permission());
        } else {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::unset_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::deposit_permission());
        };
        let v0 = UpdateGlobalDepositPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalDepositPermissionsEvent>(v0);
    }

    public fun update_global_open_position_permissions(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        if (!arg2) {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::set_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::open_position_permission());
        } else {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::unset_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::open_position_permission());
        };
        let v0 = UpdateGlobalOpenPositionPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalOpenPositionPermissionsEvent>(v0);
    }

    public fun update_global_repay_permissions(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        if (!arg2) {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::set_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::repay_permission());
        } else {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::unset_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::repay_permission());
        };
        let v0 = UpdateGlobalRepayPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalRepayPermissionsEvent>(v0);
    }

    public fun update_global_withdraw_permissions(arg0: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::versioned::check_version(arg4);
        if (!arg2) {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::set_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::withdraw_permission());
        } else {
            0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::unset_permission(&mut arg1.permissions, 0xa079129c989dacac4f5ccb7b2bb2b8f233b13694c465466a344e2e095e987407::permissions::withdraw_permission());
        };
        let v0 = UpdateGlobalWithdrawPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalWithdrawPermissionsEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

