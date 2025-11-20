module 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        swap_slippages: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        protocol_fee_rate: u64,
        max_price_deviation_bps: u64,
        package_version: u64,
        acl: 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::ACL,
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
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::add_role(&mut arg0.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        checked_package_version(arg0);
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::remove_member(&mut arg0.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u8) {
        checked_package_version(arg0);
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::remove_role(&mut arg0.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u128) {
        checked_package_version(arg0);
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_operation_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 1) || 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 2), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::no_operation_manager_permission());
    }

    public fun check_oracle_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 4), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::no_oracle_manager_permission());
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 3), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::no_pool_manager_permission());
    }

    public fun check_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 0), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::no_protocol_fee_claim_permission());
    }

    public fun check_rebalance_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 2), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::no_operation_manager_permission());
    }

    public fun check_reinvest_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 1), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::no_operation_manager_permission());
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::package_version_deprecate());
    }

    public fun get_max_price_deviation_bps(arg0: &GlobalConfig) : u64 {
        arg0.max_price_deviation_bps
    }

    public fun get_max_protocol_fee_rate() : u64 {
        5000
    }

    public fun get_protocol_fee_denominator() : u64 {
        10000
    }

    public fun get_protocol_fee_rate(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_rate
    }

    public fun get_role_oracle_manager() : u8 {
        4
    }

    public fun get_role_pool_manager() : u8 {
        3
    }

    public fun get_role_protocol_fee_claim() : u8 {
        0
    }

    public fun get_role_rebalance() : u8 {
        2
    }

    public fun get_role_reinvest() : u8 {
        1
    }

    public fun get_swap_slippage<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)
        } else {
            50
        }
    }

    public fun get_swap_slippage_denominator() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id                      : 0x2::object::new(arg0),
            swap_slippages          : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            protocol_fee_rate       : 0,
            max_price_deviation_bps : 200,
            package_version         : 1,
            acl                     : 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::new(arg0),
        };
        let v2 = InitConfigEvent{
            admin_cap     : 0x2::object::id<AdminCap>(&v0),
            global_config : 0x2::object::id<GlobalConfig>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v2);
        let v3 = &mut v1;
        set_roles(v3, &v0, 0x2::tx_context::sender(arg0), 1 << 0 | 1 << 3 | 1 << 4);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_operation_manager_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 1) || 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 2)
    }

    public fun is_oracle_manager_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 4)
    }

    public fun is_pool_manager_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 3)
    }

    public fun is_protocol_fee_claim_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 0)
    }

    public fun is_rebalance_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 2)
    }

    public fun is_reinvest_role(arg0: &GlobalConfig, arg1: address) : bool {
        0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::vault_acl::has_role(&arg0.acl, arg1, 1)
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun package_version() : u64 {
        1
    }

    public fun set_swap_slippage<T0>(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 <= get_swap_slippage_denominator(), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::invalid_swap_slippage());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.swap_slippages, &v0)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, &v0);
            v1 = v3;
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.swap_slippages, v0, arg1);
        let v4 = SetSwapSlippageEvent{
            type_name    : v0,
            old_slippage : v1,
            new_slippage : arg1,
        };
        0x2::event::emit<SetSwapSlippageEvent>(v4);
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

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        let v0 = arg0.package_version;
        assert!(arg2 > v0, 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::wrong_package_version());
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
        assert!(arg1 <= get_max_protocol_fee_rate(), 0x752fdfc2e62df51d48db2b2ec2fdbf05ef0e990647a069e34e850289e7397b43::error::invalid_protocol_fee_rate());
        arg0.protocol_fee_rate = arg1;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg0.protocol_fee_rate,
            new_fee_rate : arg1,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

