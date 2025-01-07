module 0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::valuts {
    struct VaultPools has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, Pool>,
    }

    struct Pool has drop, store {
        pool_address: address,
        pool_name: 0x1::ascii::String,
        pool_strategy: 0x1::ascii::String,
        is_closed: bool,
        is_show_rewarder: bool,
        extension_fields: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    struct InitVaultPoolsEvent has copy, drop, store {
        pools_id: 0x2::object::ID,
    }

    struct AddPoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct UpdatePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct RemovePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct ClosePoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct OpenPoolEvent has copy, drop, store {
        pool_address: address,
    }

    struct UpdatePoolStrategyEvent has copy, drop, store {
        pool_address: address,
        old_pool_strategy: 0x1::ascii::String,
        new_pool_strategy: 0x1::ascii::String,
    }

    struct UpdatePoolNameEvent has copy, drop, store {
        pool_address: address,
        old_pool_name: 0x1::ascii::String,
        new_pool_name: 0x1::ascii::String,
    }

    struct AddExtensionToPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::ascii::String,
        value: 0x1::ascii::String,
    }

    struct UpdateExtensionFromPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::ascii::String,
        old_value: 0x1::ascii::String,
        new_value: 0x1::ascii::String,
    }

    struct RemoveExtensionFromPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::ascii::String,
    }

    struct UpdatePoolRewarderDisplayEvent has copy, drop, store {
        pool_address: address,
        old_value: bool,
        new_value: bool,
    }

    public entry fun add_extension_to_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(!0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(&v0.extension_fields, &arg3), 2);
        0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0.extension_fields, arg3, arg4);
        let v1 = AddExtensionToPoolEvent{
            pool_address : arg2,
            key          : arg3,
            value        : arg4,
        };
        0x2::event::emit<AddExtensionToPoolEvent>(v1);
    }

    public entry fun add_valut_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: bool, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(!0x2::table::contains<address, Pool>(&arg1.pools, arg2), 0);
        let v0 = Pool{
            pool_address     : arg2,
            pool_name        : arg3,
            pool_strategy    : arg4,
            is_closed        : arg5,
            is_show_rewarder : arg6,
            extension_fields : 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>(),
        };
        0x2::table::add<address, Pool>(&mut arg1.pools, arg2, v0);
        let v1 = AddPoolEvent{pool_address: arg2};
        0x2::event::emit<AddPoolEvent>(v1);
    }

    public entry fun close_vault_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_closed = true;
        let v0 = ClosePoolEvent{pool_address: arg2};
        0x2::event::emit<ClosePoolEvent>(v0);
    }

    public entry fun init_vaults(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::AdminCap, arg1: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg1);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_add_role(arg1, 0x2::tx_context::sender(arg2));
        let v0 = VaultPools{
            id    : 0x2::object::new(arg2),
            pools : 0x2::table::new<address, Pool>(arg2),
        };
        0x2::transfer::share_object<VaultPools>(v0);
        let v1 = InitVaultPoolsEvent{pools_id: 0x2::object::id<VaultPools>(&v0)};
        0x2::event::emit<InitVaultPoolsEvent>(v1);
    }

    public entry fun open_vault_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_closed = false;
        let v0 = OpenPoolEvent{pool_address: arg2};
        0x2::event::emit<OpenPoolEvent>(v0);
    }

    public entry fun remove_extension_from_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(&v0.extension_fields, &arg3), 3);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x1::ascii::String>(&mut v0.extension_fields, &arg3);
        let v3 = RemoveExtensionFromPoolEvent{
            pool_address : arg2,
            key          : arg3,
        };
        0x2::event::emit<RemoveExtensionFromPoolEvent>(v3);
    }

    public entry fun remove_vault_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::remove<address, Pool>(&mut arg1.pools, arg2);
        let v0 = RemovePoolEvent{pool_address: arg2};
        0x2::event::emit<RemovePoolEvent>(v0);
    }

    public entry fun update_extension_from_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::ascii::String, 0x1::ascii::String>(&v0.extension_fields, &arg3), 3);
        let v1 = 0x2::vec_map::get_mut<0x1::ascii::String, 0x1::ascii::String>(&mut v0.extension_fields, &arg3);
        *v1 = arg4;
        let v2 = UpdateExtensionFromPoolEvent{
            pool_address : arg2,
            key          : arg3,
            old_value    : *v1,
            new_value    : arg4,
        };
        0x2::event::emit<UpdateExtensionFromPoolEvent>(v2);
    }

    public entry fun update_pool_name(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.pool_name = arg3;
        let v1 = UpdatePoolNameEvent{
            pool_address  : arg2,
            old_pool_name : v0.pool_name,
            new_pool_name : arg3,
        };
        0x2::event::emit<UpdatePoolNameEvent>(v1);
    }

    public entry fun update_pool_strategy(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.pool_strategy = arg3;
        let v1 = UpdatePoolStrategyEvent{
            pool_address      : arg2,
            old_pool_strategy : v0.pool_strategy,
            new_pool_strategy : arg3,
        };
        0x2::event::emit<UpdatePoolStrategyEvent>(v1);
    }

    public entry fun update_rewarder_display(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.is_show_rewarder = arg3;
        let v1 = UpdatePoolRewarderDisplayEvent{
            pool_address : arg2,
            old_value    : v0.is_show_rewarder,
            new_value    : arg3,
        };
        0x2::event::emit<UpdatePoolRewarderDisplayEvent>(v1);
    }

    public entry fun update_vault_pool(arg0: &0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::GlobalConfig, arg1: &mut VaultPools, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: bool, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_package_version(arg0);
        0x95b8d278b876cae22206131fb9724f701c9444515813042f54f0a426c9a3bc2f::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.pool_name = arg3;
        v0.pool_strategy = arg4;
        v0.is_closed = arg5;
        v0.is_show_rewarder = arg6;
        let v1 = UpdatePoolEvent{pool_address: arg2};
        0x2::event::emit<UpdatePoolEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

