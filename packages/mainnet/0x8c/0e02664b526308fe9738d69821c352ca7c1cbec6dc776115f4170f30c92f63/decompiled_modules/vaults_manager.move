module 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::vaults_manager {
    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
    }

    struct VaultsManager has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        acl: 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::ACL,
        index: u64,
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

    struct IncreaseIndexEvent has copy, drop {
        new_index: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address) {
        checked_package_version(arg1);
        0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun package_version() : u64 {
        0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::package_version()
    }

    public fun check_compound_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::pool_compound_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::compound_role());
    }

    public fun check_operation_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::pool_fee_claim_role()) || 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::pool_compound_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::operation_role());
    }

    public fun check_oracle_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::oracle_manager_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::oracle_manager_role());
    }

    public fun check_pool_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::pool_manager_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::pool_manager_role());
    }

    public fun check_protocol_fee_claim_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::pool_fee_claim_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::protocol_fee_claim_role());
    }

    public fun check_rebalance_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::pool_rebalance_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::rebalance_role());
    }

    public fun check_rewarder_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::has_role(&arg0.acl, arg1, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::rewarder_manager_role()), 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::rewarder_manager_role());
    }

    public fun checked_package_version(arg0: &VaultsManager) {
        assert!(0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::package_version() >= arg0.package_version, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::package_version());
    }

    public(friend) fun increase_index(arg0: &mut VaultsManager) : u64 {
        arg0.index = arg0.index + 1;
        let v0 = IncreaseIndexEvent{new_index: arg0.index};
        0x2::event::emit<IncreaseIndexEvent>(v0);
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultsManager{
            id              : 0x2::object::new(arg0),
            package_version : 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::constants::package_version(),
            acl             : 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::acl::new(arg0),
            index           : 0,
        };
        let v2 = InitEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            manager_id   : 0x2::object::id<VaultsManager>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
        let v3 = 0x2::tx_context::sender(arg0);
        let v4 = &mut v1;
        set_roles(&v0, v4, v3, 63);
        0x2::transfer::transfer<AdminCap>(v0, v3);
        0x2::transfer::share_object<VaultsManager>(v1);
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: u64) {
        let v0 = arg1.package_version;
        assert!(arg2 > v0, 0x8c0e02664b526308fe9738d69821c352ca7c1cbec6dc776115f4170f30c92f63::error::version_update());
        arg1.package_version = arg2;
        let v1 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersionEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

