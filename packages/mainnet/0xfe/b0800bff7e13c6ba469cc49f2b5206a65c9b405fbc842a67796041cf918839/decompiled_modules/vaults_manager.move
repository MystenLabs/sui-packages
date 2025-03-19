module 0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::vaults_manager {
    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
    }

    struct VaultsManager has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        acl: 0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::ACL,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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

    public fun add_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address) {
        checked_package_version(arg1);
        0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_compound_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 1), 1006);
    }

    public fun check_operation_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 1) || 0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 2), 1002);
    }

    public fun check_pool_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 3), 1003);
    }

    public fun check_protocol_fee_claim_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 0), 1004);
    }

    public fun check_rebalance_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 2), 1005);
    }

    public fun check_rewarder_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::has_role(&arg0.acl, arg1, 4), 1008);
    }

    public fun checked_package_version(arg0: &VaultsManager) {
        assert!(1 >= arg0.package_version, 1001);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultsManager{
            id              : 0x2::object::new(arg0),
            package_version : 1,
            acl             : 0xfeb0800bff7e13c6ba469cc49f2b5206a65c9b405fbc842a67796041cf918839::acl::new(arg0),
        };
        let v2 = InitEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            manager_id   : 0x2::object::id<VaultsManager>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
        let v3 = 0x2::tx_context::sender(arg0);
        let v4 = &mut v1;
        set_roles(&v0, v4, v3, 31);
        0x2::transfer::transfer<AdminCap>(v0, v3);
        0x2::transfer::share_object<VaultsManager>(v1);
    }

    public fun package_version() : u64 {
        1
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: u64) {
        let v0 = arg1.package_version;
        assert!(arg2 > v0, 1007);
        arg1.package_version = arg2;
        let v1 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersionEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

