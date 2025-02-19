module 0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::ACL,
        package_version: u64,
    }

    struct InitConfigEvent has copy, drop {
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

    public entry fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public entry fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public entry fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public entry fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun checked_has_add_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::has_role(&arg0.acl, arg1, 0), 2);
    }

    public fun checked_has_delete_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::has_role(&arg0.acl, arg1, 2), 4);
    }

    public fun checked_has_update_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::has_role(&arg0.acl, arg1, 1), 3);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 1, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            acl             : 0x1a580e236414ee93bb82e288aae5e2a98be0066299c0f87c43678b42f95c9a15::acl::new(),
            package_version : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = &mut v0;
        set_roles(&v1, v3, v2, 7);
        0x2::transfer::transfer<AdminCap>(v1, v2);
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v4 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
        };
        0x2::event::emit<InitConfigEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

