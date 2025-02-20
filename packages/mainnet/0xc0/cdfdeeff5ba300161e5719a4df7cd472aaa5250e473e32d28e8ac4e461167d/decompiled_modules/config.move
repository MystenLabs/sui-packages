module 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        swap_slippages: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        protocol_fee_rate: u64,
        package_version: u64,
        acl: 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::ACL,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap: 0x2::object::ID,
        global_config: 0x2::object::ID,
    }

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct AddSwapSlippageEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        slippage: u64,
    }

    struct UpdateSwapSlippageEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        old_slippage: u64,
        new_slippage: u64,
    }

    struct RemoveSwapSlippageEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
    }

    public fun add_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::add_role(&mut arg0.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        checked_package_version(arg0);
        0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::remove_member(&mut arg0.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::remove_role(&mut arg0.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u128) {
        checked_package_version(arg0);
        0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun add_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::slippage_config_exists());
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, v0, arg1);
        let v1 = AddSwapSlippageEvent{
            type_name : v0,
            slippage  : arg1,
        };
        0x2::event::emit<AddSwapSlippageEvent>(v1);
    }

    public fun calculate_fee_amount(arg0: &GlobalConfig, arg1: u64) : u64 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_floor(arg1, arg0.protocol_fee_rate, 10000)
    }

    public fun check_operation_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 1) || 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 2), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::no_operation_manager_permission());
    }

    public fun check_oracle_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 4), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::no_oracle_manager_permission());
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 3), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::no_pool_manager_permission());
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 0), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::no_protocol_fee_claim_permission());
    }

    public fun check_rebalance_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 2), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::no_operation_manager_permission());
    }

    public fun check_reinvest_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::has_role(&arg0.acl, arg1, 1), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::no_operation_manager_permission());
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::package_version_deprecate());
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun get_swap_slippage<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::slippage_config_not_exists());
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            swap_slippages    : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            protocol_fee_rate : 0,
            package_version   : 1,
            acl               : 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::acl::new(arg0),
        };
        let v2 = InitConfigEvent{
            admin_cap     : 0x2::object::id<AdminCap>(&v0),
            global_config : 0x2::object::id<GlobalConfig>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v2);
        let v3 = &mut v1;
        set_roles(v3, &v0, 0x2::tx_context::sender(arg0), 0 | 1 << 3 | 1 << 4);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg1));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::slippage_config_not_exists());
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, &v0);
        let v3 = RemoveSwapSlippageEvent{type_name: v0};
        0x2::event::emit<RemoveSwapSlippageEvent>(v3);
    }

    public entry fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        let v0 = arg0.package_version;
        assert!(arg2 > v0, 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::wrong_package_version());
        arg0.package_version = arg2;
        let v1 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersionEvent>(v1);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 2000, 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::invalid_protocol_fee_rate());
        arg0.protocol_fee_rate = arg1;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    public fun update_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0), 0xc926cbdf24f97c2c791a3f502a7de123099020e60c59e2305a771a383de0d84b::error::slippage_config_not_exists());
        *0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, &v0) = arg1;
        let v1 = UpdateSwapSlippageEvent{
            type_name    : v0,
            old_slippage : *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0),
            new_slippage : arg1,
        };
        0x2::event::emit<UpdateSwapSlippageEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

