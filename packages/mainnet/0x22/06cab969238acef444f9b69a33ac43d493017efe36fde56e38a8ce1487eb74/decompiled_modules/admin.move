module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin {
    public(friend) fun add_collector_to_allowlist(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg2: address, arg3: &0x2::tx_context::TxContext) {
        require_admin(arg0, arg3);
        0x2::table::add<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_allowlist_table_mut(arg1), arg2, true);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_allowlist_updated(b"collector", arg2, true, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public(friend) fun add_validator_to_allowlist(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg2: address, arg3: &0x2::tx_context::TxContext) {
        require_admin(arg0, arg3);
        0x2::table::add<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_allowlist_table_mut(arg1), arg2, true);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_allowlist_updated(b"validator", arg2, true, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public(friend) fun admin_activate_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2::tx_context::TxContext) {
        require_admin(arg0, arg2);
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::update_status(arg1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_empty(), arg2);
    }

    public(friend) fun admin_create_waste_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        require_admin(arg0, arg4);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::share_waste_bin(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::create_bin(arg1, arg2, arg3, arg4));
    }

    public(friend) fun admin_destroy_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2::tx_context::TxContext) {
        require_admin(arg0, arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::update_status(arg1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_waste_bin_linked_escrow(arg1, 0x1::option::none<0x2::object::ID>());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_waste_bin_linked_subscription(arg1, 0x1::option::none<0x2::object::ID>());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_waste_bin_assigned_collector(arg1, 0x1::option::none<address>());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_waste_bin_user(arg1, 0x1::option::none<address>());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_bin_destroyed(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_waste_bin_device_id(arg1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_waste_bin_owner(arg1), 0x2::tx_context::sender(arg2), 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public(friend) fun admin_freeze_bin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2::tx_context::TxContext) {
        require_admin(arg0, arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::update_status(arg1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), arg2);
    }

    public(friend) fun commit_package_upgrade(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::UpgradeCap, arg1: &mut 0x2::package::UpgradeCap, arg2: 0x2::package::UpgradeReceipt, arg3: &0x2::tx_context::TxContext) {
        require_upgrade_cap(arg0, arg3);
        0x2::package::commit_upgrade(arg1, arg2);
    }

    public(friend) fun create_additional_admin_cap(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap {
        require_root_admin(arg0, arg1, arg3);
        let v0 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_admin_cap(arg2, arg3);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_admin_cap_created(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap>(&v0), arg2);
        v0
    }

    public(friend) fun create_admin_system(arg0: &mut 0x2::tx_context::TxContext) : (0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::UpgradeCap, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_admin_cap(v0, arg0);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_admin_cap_created(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap>(&v1), v0);
        (v1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_upgrade_cap(v0, arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_system_config(false, 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap>(&v1), v0, arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_collector_allowlist(0x2::table::new<address, bool>(arg0), arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_validator_allowlist(0x2::table::new<address, bool>(arg0), arg0))
    }

    public(friend) fun is_collector_allowlisted(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg1: address) : bool {
        0x2::table::contains<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_allowlist_table(arg0), arg1) && *0x2::table::borrow<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_allowlist_table(arg0), arg1)
    }

    public(friend) fun is_system_paused(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_system_config_is_paused(arg0)
    }

    public(friend) fun is_validator_allowlisted(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg1: address) : bool {
        0x2::table::contains<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_allowlist_table(arg0), arg1) && *0x2::table::borrow<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_allowlist_table(arg0), arg1)
    }

    public(friend) fun pause_system(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: &0x2::tx_context::TxContext) {
        require_root_admin(arg0, arg1, arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_system_config_is_paused(arg1, true);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_system_paused(true, v0);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_system_config_updated(true, v0);
    }

    public(friend) fun remove_collector_from_allowlist(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg2: address, arg3: &0x2::tx_context::TxContext) {
        require_admin(arg0, arg3);
        if (0x2::table::contains<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_allowlist_table(arg1), arg2)) {
            0x2::table::remove<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_allowlist_table_mut(arg1), arg2);
        };
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_allowlist_updated(b"collector", arg2, false, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public(friend) fun remove_validator_from_allowlist(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg2: address, arg3: &0x2::tx_context::TxContext) {
        require_admin(arg0, arg3);
        if (0x2::table::contains<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_allowlist_table(arg1), arg2)) {
            0x2::table::remove<address, bool>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_allowlist_table_mut(arg1), arg2);
        };
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_allowlist_updated(b"validator", arg2, false, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    fun require_admin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_admin_cap_admin(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
    }

    fun require_root_admin(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: &0x2::tx_context::TxContext) {
        require_admin(arg0, arg2);
        assert!(0x2::tx_context::sender(arg2) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_system_config_root_admin(arg1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
    }

    fun require_upgrade_cap(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::UpgradeCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_upgrade_cap_admin(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
    }

    public(friend) fun revoke_admin_cap(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg3: &0x2::tx_context::TxContext) {
        require_root_admin(arg0, arg1, arg3);
        0x2::object::delete(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::extract_admin_cap_uid(arg2));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_admin_cap_revoked(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap>(&arg2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_admin_cap_admin(&arg2), 0x2::tx_context::sender(arg3), 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public(friend) fun share_collector_allowlist(arg0: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::share_collector_allowlist(arg0);
    }

    public(friend) fun share_system_config(arg0: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::share_system_config(arg0);
    }

    public(friend) fun share_validator_allowlist(arg0: 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist) {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::share_validator_allowlist(arg0);
    }

    public(friend) fun transfer_admin_cap(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_admin(arg0, arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_admin_cap_admin(arg0, arg1);
    }

    public(friend) fun transfer_upgrade_cap(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::UpgradeCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_upgrade_cap(arg0, arg2);
        assert!(0x2::tx_context::sender(arg2) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_upgrade_cap_admin(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_upgrade_cap_admin(arg0, arg1);
    }

    public(friend) fun unpause_system(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::AdminCap, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg2: &0x2::tx_context::TxContext) {
        require_root_admin(arg0, arg1, arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_system_config_is_paused(arg1, false);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_system_paused(false, v0);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_system_config_updated(false, v0);
    }

    // decompiled from Move bytecode v6
}

