module 0x4a54ce05484889b622371c3e6e470c093064c63c652b257471065781859b7ab::access_control {
    struct ACCESS_CONTROL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UtilityAccountCap has store, key {
        id: 0x2::object::UID,
    }

    struct CapabilityRegistry has key {
        id: 0x2::object::UID,
        active_admins: 0x2::vec_set::VecSet<0x2::object::ID>,
        active_utility_accounts: 0x2::vec_set::VecSet<0x2::object::ID>,
        admin_count: u64,
    }

    struct AdminGranted has copy, drop {
        cap_id: 0x2::object::ID,
        granted_to: address,
    }

    struct AdminRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        revoked_from: address,
    }

    struct UtilityAccountGranted has copy, drop {
        cap_id: 0x2::object::ID,
        granted_to: address,
    }

    struct UtilityAccountRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        revoked_from: address,
    }

    public fun admin_count(arg0: &CapabilityRegistry) : u64 {
        arg0.admin_count
    }

    public fun assert_admin_active(arg0: &AdminCap, arg1: &CapabilityRegistry) {
        assert!(is_admin_active(arg0, arg1), 101);
    }

    public fun assert_utility_account_active(arg0: &UtilityAccountCap, arg1: &CapabilityRegistry) {
        assert!(is_utility_account_active(arg0, arg1), 101);
    }

    public fun get_all_admin_ids(arg0: &CapabilityRegistry) : vector<0x2::object::ID> {
        *0x2::vec_set::keys<0x2::object::ID>(&arg0.active_admins)
    }

    public fun get_all_utility_account_ids(arg0: &CapabilityRegistry) : vector<0x2::object::ID> {
        *0x2::vec_set::keys<0x2::object::ID>(&arg0.active_utility_accounts)
    }

    public fun grant_admin_cap(arg0: &AdminCap, arg1: &mut CapabilityRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_active(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.active_admins, v1);
        arg1.admin_count = arg1.admin_count + 1;
        let v2 = AdminGranted{
            cap_id     : v1,
            granted_to : arg2,
        };
        0x2::event::emit<AdminGranted>(v2);
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public fun grant_utility_account_cap(arg0: &AdminCap, arg1: &mut CapabilityRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin_active(arg0, arg1);
        let v0 = UtilityAccountCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<UtilityAccountCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.active_utility_accounts, v1);
        let v2 = UtilityAccountGranted{
            cap_id     : v1,
            granted_to : arg2,
        };
        0x2::event::emit<UtilityAccountGranted>(v2);
        0x2::transfer::transfer<UtilityAccountCap>(v0, arg2);
    }

    fun init(arg0: ACCESS_CONTROL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CapabilityRegistry{
            id                      : 0x2::object::new(arg1),
            active_admins           : 0x2::vec_set::empty<0x2::object::ID>(),
            active_utility_accounts : 0x2::vec_set::empty<0x2::object::ID>(),
            admin_count             : 1,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x2::object::id<AdminCap>(&v1);
        0x2::vec_set::insert<0x2::object::ID>(&mut v0.active_admins, v2);
        let v3 = AdminGranted{
            cap_id     : v2,
            granted_to : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AdminGranted>(v3);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CapabilityRegistry>(v0);
    }

    public fun is_admin_active(arg0: &AdminCap, arg1: &CapabilityRegistry) : bool {
        let v0 = 0x2::object::id<AdminCap>(arg0);
        0x2::vec_set::contains<0x2::object::ID>(&arg1.active_admins, &v0)
    }

    public fun is_utility_account_active(arg0: &UtilityAccountCap, arg1: &CapabilityRegistry) : bool {
        let v0 = 0x2::object::id<UtilityAccountCap>(arg0);
        0x2::vec_set::contains<0x2::object::ID>(&arg1.active_utility_accounts, &v0)
    }

    public fun revoke_admin_cap_by_id(arg0: &AdminCap, arg1: &mut CapabilityRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_admin_active(arg0, arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.active_admins, &arg2), 102);
        assert!(arg1.admin_count > 1, 100);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.active_admins, &arg2);
        arg1.admin_count = arg1.admin_count - 1;
        let v0 = AdminRevoked{
            cap_id       : arg2,
            revoked_from : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<AdminRevoked>(v0);
    }

    public fun revoke_utility_account_cap_by_id(arg0: &AdminCap, arg1: &mut CapabilityRegistry, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_admin_active(arg0, arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.active_utility_accounts, &arg2), 102);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.active_utility_accounts, &arg2);
        let v0 = UtilityAccountRevoked{
            cap_id       : arg2,
            revoked_from : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UtilityAccountRevoked>(v0);
    }

    public fun utility_account_count(arg0: &CapabilityRegistry) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.active_utility_accounts)
    }

    // decompiled from Move bytecode v6
}

