module 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        swap_slippages: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        protocol_fee_rate: u64,
        max_price_deviation_bps: u64,
        package_version: u64,
        acl: 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::ACL,
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

    struct SetSwapSlippageEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        old_slippage: u64,
        new_slippage: u64,
    }

    struct UpdateMaxPriceDeviationEvent has copy, drop {
        old_max_price_deviation_bps: u64,
        new_max_price_deviation_bps: u64,
    }

    public fun add_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::add_role(&mut arg0.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        checked_package_version(arg0);
        0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::remove_member(&mut arg0.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::remove_role(&mut arg0.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u128) {
        checked_package_version(arg0);
        0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_emergency_pause_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 5), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_emergency_pause_permission());
    }

    public fun check_emergency_restore_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 18446744073709551000, 100);
    }

    public fun check_operation_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 1) || 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 2), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_operation_manager_permission());
    }

    public fun check_oracle_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 4), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_oracle_manager_permission());
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 3), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_pool_manager_permission());
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 0), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_protocol_fee_claim_permission());
    }

    public fun check_rebalance_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 2), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_operation_manager_permission());
    }

    public fun check_reinvest_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::has_role(&arg0.acl, arg1, 1), 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::no_operation_manager_permission());
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(6 >= arg0.package_version, 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::package_version_deprecate());
    }

    public fun emergency_pause(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        check_emergency_pause_role(arg0, 0x2::tx_context::sender(arg1));
        arg0.package_version = 9223372036854775808;
    }

    public fun get_max_price_deviation_bps(arg0: &GlobalConfig) : u64 {
        arg0.max_price_deviation_bps
    }

    public fun get_max_protocol_fee_rate() : u64 {
        2000
    }

    public fun get_protocol_fee_denominator() : u64 {
        10000
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun get_swap_slippage<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)
        } else {
            50
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id                      : 0x2::object::new(arg0),
            swap_slippages          : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            protocol_fee_rate       : 0,
            max_price_deviation_bps : 200,
            package_version         : 6,
            acl                     : 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::acl::new(arg0),
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
        6
    }

    public fun set_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            let v2 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, &v0);
            v1 = *v2;
            *v2 = arg1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, v0, arg1);
        };
        let v3 = SetSwapSlippageEvent{
            type_name    : v0,
            old_slippage : v1,
            new_slippage : arg1,
        };
        0x2::event::emit<SetSwapSlippageEvent>(v3);
    }

    public fun update_max_price_deviation_bps(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg0.max_price_deviation_bps = arg1;
        let v0 = UpdateMaxPriceDeviationEvent{
            old_max_price_deviation_bps : arg0.max_price_deviation_bps,
            new_max_price_deviation_bps : arg1,
        };
        0x2::event::emit<UpdateMaxPriceDeviationEvent>(v0);
    }

    public entry fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.package_version = arg2;
        let v0 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : arg0.package_version,
        };
        0x2::event::emit<SetPackageVersionEvent>(v0);
    }

    public fun update_protocol_fee_rate(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= 2000, 0xc4ebf35be1478318d78c324342854dd2735a036139373a9d41a1aa3a46a01d05::error::invalid_protocol_fee_rate());
        arg0.protocol_fee_rate = arg1;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

