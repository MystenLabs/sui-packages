module 0x384fcdaf0483fd370f4636817ead931e4301e6113075a08753e2b11ca4815af1::config {
    struct ConfigAddedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        left_offset_percent: u64,
        right_offset_percent: u64,
        left_trigger_percent: u64,
        right_trigger_percent: u64,
        is_private_pool: bool,
        is_aligned: bool,
        last_position_id: 0x2::object::ID,
    }

    struct ConfigUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        old_pool_config: VaultRebalanceConfig,
        new_pool_config: VaultRebalanceConfig,
    }

    struct ConfigRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct AdminAddedEvent has copy, drop {
        admin: address,
    }

    struct AdminRemovedEvent has copy, drop {
        admin: address,
    }

    struct PrivatePoolUpdatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        before: bool,
        after: bool,
    }

    struct VaultRebalanceConfig has copy, drop, store {
        pool_id: 0x2::object::ID,
        left_offset_percent: u64,
        right_offset_percent: u64,
        left_trigger_percent: u64,
        right_trigger_percent: u64,
        is_private_pool: bool,
        is_aligned: bool,
        last_position_id: 0x2::object::ID,
    }

    struct VaultConfig has key {
        id: 0x2::object::UID,
        admin_list: vector<address>,
        rebalance_configs: 0x2::table::Table<0x2::object::ID, VaultRebalanceConfig>,
    }

    public fun add_admin(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 13906834861538148353);
        assert!(!0x1::vector::contains<address>(&arg0.admin_list, &arg1), 13906834865833508871);
        0x1::vector::push_back<address>(&mut arg0.admin_list, arg1);
        let v1 = AdminAddedEvent{admin: arg1};
        0x2::event::emit<AdminAddedEvent>(v1);
    }

    public fun add_config(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: 0x2::object::ID, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 13906834578070306817);
        assert!(!0x2::table::contains<0x2::object::ID, VaultRebalanceConfig>(&arg0.rebalance_configs, arg1), 13906834582365405187);
        let v1 = VaultRebalanceConfig{
            pool_id               : arg1,
            left_offset_percent   : arg2,
            right_offset_percent  : arg3,
            left_trigger_percent  : arg4,
            right_trigger_percent : arg5,
            is_private_pool       : arg6,
            is_aligned            : arg7,
            last_position_id      : arg8,
        };
        0x2::table::add<0x2::object::ID, VaultRebalanceConfig>(&mut arg0.rebalance_configs, arg1, v1);
        let v2 = ConfigAddedEvent{
            pool_id               : arg1,
            left_offset_percent   : arg2,
            right_offset_percent  : arg3,
            left_trigger_percent  : arg4,
            right_trigger_percent : arg5,
            is_private_pool       : arg6,
            is_aligned            : arg7,
            last_position_id      : arg8,
        };
        0x2::event::emit<ConfigAddedEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultConfig{
            id                : 0x2::object::new(arg0),
            admin_list        : 0x1::vector::empty<address>(),
            rebalance_configs : 0x2::table::new<0x2::object::ID, VaultRebalanceConfig>(arg0),
        };
        0x1::vector::push_back<address>(&mut v0.admin_list, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultConfig>(v0);
    }

    public fun remove_admin(arg0: &mut VaultConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 13906834913077755905);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &arg1), 13906834917373247497);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.admin_list, &arg1);
        if (v1) {
            0x1::vector::remove<address>(&mut arg0.admin_list, v2);
        };
        assert!(0x1::vector::length<address>(&arg0.admin_list) > 1, 13906834947438149643);
        let v3 = AdminRemovedEvent{admin: arg1};
        0x2::event::emit<AdminRemovedEvent>(v3);
    }

    public fun remove_config(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 13906834818588475393);
        assert!(0x2::table::contains<0x2::object::ID, VaultRebalanceConfig>(&arg0.rebalance_configs, arg1), 13906834822883704837);
        0x2::table::remove<0x2::object::ID, VaultRebalanceConfig>(&mut arg0.rebalance_configs, arg1);
        let v1 = ConfigRemovedEvent{pool_id: arg1};
        0x2::event::emit<ConfigRemovedEvent>(v1);
    }

    public fun update_config(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 13906834732689129473);
        assert!(0x2::table::contains<0x2::object::ID, VaultRebalanceConfig>(&arg0.rebalance_configs, arg1), 13906834736984358917);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, VaultRebalanceConfig>(&mut arg0.rebalance_configs, arg1);
        v1.left_offset_percent = arg2;
        v1.right_offset_percent = arg3;
        v1.left_trigger_percent = arg4;
        v1.right_trigger_percent = arg5;
        let v2 = ConfigUpdatedEvent{
            pool_id         : arg1,
            old_pool_config : *0x2::table::borrow<0x2::object::ID, VaultRebalanceConfig>(&arg0.rebalance_configs, arg1),
            new_pool_config : *v1,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v2);
    }

    public fun update_private_pool(arg0: &mut VaultConfig, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.admin_list, &v0), 13906835007567036417);
        assert!(0x2::table::contains<0x2::object::ID, VaultRebalanceConfig>(&arg0.rebalance_configs, arg1), 13906835011862265861);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, VaultRebalanceConfig>(&mut arg0.rebalance_configs, arg1);
        v1.is_private_pool = arg2;
        let v2 = PrivatePoolUpdatedEvent{
            pool_id : arg1,
            before  : v1.is_private_pool,
            after   : arg2,
        };
        0x2::event::emit<PrivatePoolUpdatedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

