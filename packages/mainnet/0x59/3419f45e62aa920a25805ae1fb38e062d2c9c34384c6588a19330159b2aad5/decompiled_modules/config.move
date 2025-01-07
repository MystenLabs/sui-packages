module 0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::ACL,
        package_version: u64,
    }

    struct InitFactoryEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
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

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::Member> {
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 == arg0.package_version, 0);
    }

    public fun checked_vault_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::has_role(&arg0.acl, arg1, 0), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            acl             : 0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::acl::new(arg0),
            package_version : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = &mut v0;
        set_roles(&v1, v3, v2, 0 | 1 << 0);
        0x2::transfer::transfer<AdminCap>(v1, v2);
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v4 = InitFactoryEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::event::emit<InitFactoryEvent>(v4);
    }

    public fun package_version() : u64 {
        1
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    // decompiled from Move bytecode v6
}

