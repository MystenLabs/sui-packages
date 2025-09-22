module 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        collect_obligation_owner_cap_address: address,
        permissions: u32,
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

    public fun check_borrow_permission(arg0: &GlobalConfig) : bool {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::check_permission(arg0.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::borrow_permission())
    }

    public fun check_close_permission(arg0: &GlobalConfig) : bool {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::check_permission(arg0.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::close_position_permission())
    }

    public fun check_deposit_permission(arg0: &GlobalConfig) : bool {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::check_permission(arg0.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::deposit_permission())
    }

    public fun check_open_permission(arg0: &GlobalConfig) : bool {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::check_permission(arg0.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::open_position_permission())
    }

    public fun check_repay_permission(arg0: &GlobalConfig) : bool {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::check_permission(arg0.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::repay_permission())
    }

    public fun check_withdraw_permission(arg0: &GlobalConfig) : bool {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::check_permission(arg0.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::withdraw_permission())
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
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun permissions(arg0: &GlobalConfig) : u32 {
        arg0.permissions
    }

    public fun set_collect_obligation_owner_cap_address(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        arg1.collect_obligation_owner_cap_address = arg2;
        let v0 = SetCollectObligationOwnerCapAddressEvent{
            collect_obligation_owner_cap_address : arg2,
            sender                               : 0x2::tx_context::sender(arg5),
            timestamp                            : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SetCollectObligationOwnerCapAddressEvent>(v0);
    }

    public fun update_global_borrow_permissions(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        if (!arg2) {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::set_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::borrow_permission());
        } else {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::unset_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::borrow_permission());
        };
        let v0 = UpdateGlobalBorrowPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalBorrowPermissionsEvent>(v0);
    }

    public fun update_global_close_position_permissions(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        if (!arg2) {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::set_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::close_position_permission());
        } else {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::unset_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::close_position_permission());
        };
        let v0 = UpdateGlobalClosePositionPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalClosePositionPermissionsEvent>(v0);
    }

    public fun update_global_deposit_permissions(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        if (!arg2) {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::set_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::deposit_permission());
        } else {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::unset_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::deposit_permission());
        };
        let v0 = UpdateGlobalDepositPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalDepositPermissionsEvent>(v0);
    }

    public fun update_global_open_position_permissions(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        if (!arg2) {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::set_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::open_position_permission());
        } else {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::unset_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::open_position_permission());
        };
        let v0 = UpdateGlobalOpenPositionPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalOpenPositionPermissionsEvent>(v0);
    }

    public fun update_global_repay_permissions(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        if (!arg2) {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::set_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::repay_permission());
        } else {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::unset_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::repay_permission());
        };
        let v0 = UpdateGlobalRepayPermissionsEvent{
            is_pause  : arg2,
            sender    : 0x2::tx_context::sender(arg5),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UpdateGlobalRepayPermissionsEvent>(v0);
    }

    public fun update_global_withdraw_permissions(arg0: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::versioned::check_version(arg4);
        if (!arg2) {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::set_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::withdraw_permission());
        } else {
            0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::unset_permission(&mut arg1.permissions, 0xa319744e8a273b4cbc3695ecff1ada520a770a7934005eba8d88e36952d8d66b::permissions::withdraw_permission());
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

