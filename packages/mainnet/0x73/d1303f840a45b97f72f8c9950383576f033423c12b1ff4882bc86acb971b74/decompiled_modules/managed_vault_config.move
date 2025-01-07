module 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::managed_vault_config {
    struct ManagedVaultConfig has key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>,
        uids: 0x2::table::Table<address, 0x2::object::UID>,
    }

    struct NewConfigEvent has copy, drop {
        config: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagedVaultConfig{
            id      : 0x2::object::new(arg0),
            configs : 0x2::table::new<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(arg0),
            uids    : 0x2::table::new<address, 0x2::object::UID>(arg0),
        };
        0x2::transfer::transfer<ManagedVaultConfig>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_config(arg0: &mut ManagedVaultConfig, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = &mut arg0.configs;
        assert!(!0x2::table::contains<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(v2, v1), 3);
        0x2::table::add<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(v2, v1, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::register_for_uid(&v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
        0x2::table::add<address, 0x2::object::UID>(&mut arg0.uids, v1, v0);
        let v3 = NewConfigEvent{config: v1};
        0x2::event::emit<NewConfigEvent>(v3);
    }

    public entry fun set_max_kill_bps(arg0: &mut ManagedVaultConfig, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address, arg3: u64) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::set_max_kill_bps(0x2::table::borrow<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(&arg0.configs, arg2), arg1, arg3);
    }

    public entry fun set_params(arg0: &mut ManagedVaultConfig, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: address) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::set_params(0x2::table::borrow<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(&arg0.configs, arg2), arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun set_whitelisted_liquidator(arg0: &mut ManagedVaultConfig, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address, arg3: address, arg4: bool) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::set_whitelisted_liquidator(0x2::table::borrow<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(&arg0.configs, arg2), arg1, arg3, arg4);
    }

    public entry fun set_worker_config(arg0: &mut ManagedVaultConfig, arg1: &mut 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::GlobalStorage, arg2: address, arg3: address, arg4: address) {
        0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::global_storage::checked_package_version(arg1);
        0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::set_worker_config(0x2::table::borrow<address, 0x73d1303f840a45b97f72f8c9950383576f033423c12b1ff4882bc86acb971b74::vault_config::ConfigCapability>(&arg0.configs, arg2), arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

