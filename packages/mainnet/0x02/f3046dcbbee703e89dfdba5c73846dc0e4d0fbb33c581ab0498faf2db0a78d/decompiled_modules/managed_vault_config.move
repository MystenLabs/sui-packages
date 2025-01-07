module 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::managed_vault_config {
    struct ManagedVaultConfig has key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>,
        uids: 0x2::table::Table<address, 0x2::object::UID>,
    }

    struct NewConfigEvent has copy, drop {
        config: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagedVaultConfig{
            id      : 0x2::object::new(arg0),
            configs : 0x2::table::new<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(arg0),
            uids    : 0x2::table::new<address, 0x2::object::UID>(arg0),
        };
        0x2::transfer::transfer<ManagedVaultConfig>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_config(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::AdminCap, arg2: &mut ManagedVaultConfig, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: address, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg3);
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = &mut arg2.configs;
        assert!(!0x2::table::contains<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(v2, v1), 3);
        0x2::table::add<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(v2, v1, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::register_for_uid(arg1, &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10));
        0x2::table::add<address, 0x2::object::UID>(&mut arg2.uids, v1, v0);
        let v3 = NewConfigEvent{config: v1};
        0x2::event::emit<NewConfigEvent>(v3);
    }

    public entry fun set_max_kill_bps(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::AdminCap, arg2: &mut ManagedVaultConfig, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: address, arg5: u64) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg3);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::set_max_kill_bps(arg1, 0x2::table::borrow<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(&arg2.configs, arg4), arg3, arg5);
    }

    public entry fun set_params(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::AdminCap, arg2: &mut ManagedVaultConfig, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: address) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg3);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::set_params(arg1, 0x2::table::borrow<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(&arg2.configs, arg4), arg3, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun set_whitelisted_liquidator(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::AdminCap, arg2: &mut ManagedVaultConfig, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: address, arg5: address, arg6: bool) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg3);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::set_whitelisted_liquidator(arg1, 0x2::table::borrow<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(&arg2.configs, arg4), arg3, arg5, arg6);
    }

    public entry fun set_worker_config(arg0: &AdminCap, arg1: &0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::AdminCap, arg2: &mut ManagedVaultConfig, arg3: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg4: address, arg5: address, arg6: address) {
        0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::checked_package_version(arg3);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::set_worker_config(arg1, 0x2::table::borrow<address, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault_config::ConfigCapability>(&arg2.configs, arg4), arg3, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

