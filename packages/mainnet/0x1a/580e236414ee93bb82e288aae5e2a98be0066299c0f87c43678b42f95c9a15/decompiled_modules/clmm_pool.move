module 0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::clmm_pool {
    struct ClmmPools has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, Pool>,
    }

    struct Pool has drop, store {
        pool_address: address,
        pool_type: 0x1::string::String,
        project_url: 0x1::string::String,
        is_closed: bool,
        is_show_rewarder: bool,
        show_rewarder_1: bool,
        show_rewarder_2: bool,
        show_rewarder_3: bool,
        extension_fields: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct InitClmmPoolsEvent has copy, drop, store {
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

    struct UpdatePoolTypeEvent has copy, drop, store {
        pool_address: address,
        old_pool_type: 0x1::string::String,
        new_pool_type: 0x1::string::String,
    }

    struct AddExtensionToPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct UpdateExtensionFromPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::string::String,
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
    }

    struct RemoveExtensionFromPoolEvent has copy, drop, store {
        pool_address: address,
        key: 0x1::string::String,
    }

    struct UpdatePoolRewarderDisplayEvent has copy, drop, store {
        pool_address: address,
        rewarder_index: u64,
        is_show_rewarder: bool,
    }

    public entry fun add_clmm_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg10));
        assert!(!0x2::table::contains<address, Pool>(&arg1.pools, arg2), 0);
        let v0 = Pool{
            pool_address     : arg2,
            pool_type        : arg3,
            project_url      : arg4,
            is_closed        : arg5,
            is_show_rewarder : arg6,
            show_rewarder_1  : arg7,
            show_rewarder_2  : arg8,
            show_rewarder_3  : arg9,
            extension_fields : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        0x2::table::add<address, Pool>(&mut arg1.pools, arg2, v0);
        let v1 = AddPoolEvent{pool_address: arg2};
        0x2::event::emit<AddPoolEvent>(v1);
    }

    public entry fun add_extension_to_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_add_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.extension_fields, &arg3), 3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.extension_fields, arg3, arg4);
        let v1 = AddExtensionToPoolEvent{
            pool_address : arg2,
            key          : arg3,
            value        : arg4,
        };
        0x2::event::emit<AddExtensionToPoolEvent>(v1);
    }

    public entry fun close_clmm_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_closed = true;
        let v0 = ClosePoolEvent{pool_address: arg2};
        0x2::event::emit<ClosePoolEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClmmPools{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<address, Pool>(arg0),
        };
        0x2::transfer::share_object<ClmmPools>(v0);
        let v1 = InitClmmPoolsEvent{pools_id: 0x2::object::id<ClmmPools>(&v0)};
        0x2::event::emit<InitClmmPoolsEvent>(v1);
    }

    public entry fun open_clmm_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_closed = false;
        let v0 = OpenPoolEvent{pool_address: arg2};
        0x2::event::emit<OpenPoolEvent>(v0);
    }

    public entry fun remove_clmm_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        0x2::table::remove<address, Pool>(&mut arg1.pools, arg2);
        let v0 = RemovePoolEvent{pool_address: arg2};
        0x2::event::emit<RemovePoolEvent>(v0);
    }

    public entry fun remove_extension_from_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_delete_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.extension_fields, &arg3), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.extension_fields, &arg3);
        let v3 = RemoveExtensionFromPoolEvent{
            pool_address : arg2,
            key          : arg3,
        };
        0x2::event::emit<RemoveExtensionFromPoolEvent>(v3);
    }

    public entry fun update_clmm_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg10));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.pool_address = arg2;
        v0.pool_type = arg3;
        v0.project_url = arg4;
        v0.is_closed = arg5;
        v0.is_show_rewarder = arg6;
        v0.show_rewarder_1 = arg7;
        v0.show_rewarder_2 = arg8;
        v0.show_rewarder_3 = arg9;
        let v1 = UpdatePoolEvent{pool_address: arg2};
        0x2::event::emit<UpdatePoolEvent>(v1);
    }

    public entry fun update_extension_from_pool(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        assert!(0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.extension_fields, &arg3), 2);
        let v1 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut v0.extension_fields, &arg3);
        *v1 = arg4;
        let v2 = UpdateExtensionFromPoolEvent{
            pool_address : arg2,
            key          : arg3,
            old_value    : *v1,
            new_value    : arg4,
        };
        0x2::event::emit<UpdateExtensionFromPoolEvent>(v2);
    }

    public entry fun update_pool_type(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2);
        v0.pool_type = arg3;
        let v1 = UpdatePoolTypeEvent{
            pool_address  : arg2,
            old_pool_type : v0.pool_type,
            new_pool_type : arg3,
        };
        0x2::event::emit<UpdatePoolTypeEvent>(v1);
    }

    public entry fun update_rewarder_display(arg0: &0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::GlobalConfig, arg1: &mut ClmmPools, arg2: address, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_package_version(arg0);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config::checked_has_update_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(0x2::table::contains<address, Pool>(&arg1.pools, arg2), 1);
        let v0 = if (arg3 == 0) {
            &mut 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).is_show_rewarder
        } else if (arg3 == 1) {
            &mut 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).show_rewarder_1
        } else if (arg3 == 2) {
            &mut 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).show_rewarder_2
        } else {
            assert!(arg3 == 3, 4);
            &mut 0x2::table::borrow_mut<address, Pool>(&mut arg1.pools, arg2).show_rewarder_3
        };
        *v0 = arg4;
        let v1 = UpdatePoolRewarderDisplayEvent{
            pool_address     : arg2,
            rewarder_index   : arg3,
            is_show_rewarder : arg4,
        };
        0x2::event::emit<UpdatePoolRewarderDisplayEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

