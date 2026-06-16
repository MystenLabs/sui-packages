module 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::ACL,
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

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::Member> {
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        checked_package_version(arg1);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_emergency_pause_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::has_role(&arg0.acl, arg1, 2), 5);
    }

    public fun check_emergency_restore_version(arg0: &GlobalConfig) {
        assert!(arg0.package_version == 18446744073709551000, 4);
    }

    public fun check_pool_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::has_role(&arg0.acl, arg1, 0), 1);
    }

    public fun check_rewarder_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::has_role(&arg0.acl, arg1, 1), 2);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(package_version() >= arg0.package_version, 3);
    }

    public fun emergency_pause(arg0: &mut GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        check_emergency_pause_role(arg0, 0x2::tx_context::sender(arg1));
        arg0.package_version = 9223372036854775808;
    }

    public fun emergency_unpause(arg0: &mut GlobalConfig, arg1: &AdminCap) {
        assert!(arg0.package_version == 9223372036854775808, 7);
        arg0.package_version = package_version();
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            acl             : 0x5fcfe31c479b3d83db28dd5e5d40ddfe01b1451b30677aad9f273e5322c0ee15::acl::new(arg0),
            package_version : 1,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        let v3 = &mut v1;
        set_roles(&v2, v3, v0, 7);
        0x2::transfer::transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<GlobalConfig>(v1);
        let v4 = InitConfigEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v2),
            global_config_id : 0x2::object::id<GlobalConfig>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v4);
    }

    public fun package_version() : u64 {
        1
    }

    public fun set_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 > arg1.package_version && arg2 <= package_version(), 6);
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
    }

    // decompiled from Move bytecode v6
}

