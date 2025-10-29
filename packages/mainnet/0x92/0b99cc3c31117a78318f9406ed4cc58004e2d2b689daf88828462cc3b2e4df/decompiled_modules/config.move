module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        acl: 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::ACL,
        package_version: u64,
    }

    struct PackageVersionUpgraded has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct RoleAdded has copy, drop {
        member: address,
        role: u8,
    }

    struct RoleRemoved has copy, drop {
        member: address,
        role: u8,
    }

    public fun add_role(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        check_package_version(arg1);
        add_role_internal(arg1, arg2, arg3);
    }

    public fun has_role(arg0: &GlobalConfig, arg1: address, arg2: u8) : bool {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::has_role(&arg0.acl, arg1, arg2)
    }

    public fun remove_member(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        check_package_version(arg1);
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::remove_member(&mut arg1.acl, arg2);
    }

    public fun remove_role(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        check_package_version(arg1);
        remove_role_internal(arg1, arg2, arg3);
    }

    public(friend) fun add_role_internal(arg0: &mut GlobalConfig, arg1: address, arg2: u8) {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::add_role(&mut arg0.acl, arg1, arg2);
        let v0 = RoleAdded{
            member : arg1,
            role   : arg2,
        };
        0x2::event::emit<RoleAdded>(v0);
    }

    public fun check_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 3, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::new(arg0);
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::add_role(&mut v0, @0x337f3bad574e6338551b71932c449e20c81abb371364811de3ee93b58343eb3c, 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::roles::role_rewarder());
        let v1 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            acl             : v0,
            package_version : 3,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public(friend) fun remove_role_internal(arg0: &mut GlobalConfig, arg1: address, arg2: u8) {
        0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::acl::remove_role(&mut arg0.acl, arg1, arg2);
        let v0 = RoleRemoved{
            member : arg1,
            role   : arg2,
        };
        0x2::event::emit<RoleRemoved>(v0);
    }

    public fun upgrade_package_version(arg0: &0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::admin_cap::AdminCap, arg1: &mut GlobalConfig) {
        assert!(arg1.package_version < 3, 1);
        arg1.package_version = 3;
        let v0 = PackageVersionUpgraded{
            new_version : arg1.package_version,
            old_version : arg1.package_version,
        };
        0x2::event::emit<PackageVersionUpgraded>(v0);
    }

    // decompiled from Move bytecode v6
}

