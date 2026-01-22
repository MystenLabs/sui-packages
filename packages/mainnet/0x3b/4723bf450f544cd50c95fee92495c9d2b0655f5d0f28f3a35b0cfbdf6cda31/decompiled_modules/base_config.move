module 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BaseConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::ACL,
        package_version: u64,
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

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut BaseConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &BaseConfig) : vector<0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::Member> {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::get_members(&arg0.acl)
    }

    public fun get_permission(arg0: &BaseConfig, arg1: address) : u128 {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::get_permission(&arg0.acl, arg1)
    }

    public fun has_role(arg0: &BaseConfig, arg1: address, arg2: u8) : bool {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::has_role(&arg0.acl, arg1, arg2)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut BaseConfig, arg2: address) {
        checked_package_version(arg1);
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut BaseConfig, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut BaseConfig, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun checked_package_version(arg0: &BaseConfig) {
        assert!(1 >= arg0.package_version, 0);
    }

    public fun get_package_version(arg0: &BaseConfig) : u64 {
        arg0.package_version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BaseConfig{
            id              : 0x2::object::new(arg0),
            acl             : 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::acl::new(arg0),
            package_version : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<BaseConfig>(v0);
    }

    public fun package_version() : u64 {
        1
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut BaseConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

