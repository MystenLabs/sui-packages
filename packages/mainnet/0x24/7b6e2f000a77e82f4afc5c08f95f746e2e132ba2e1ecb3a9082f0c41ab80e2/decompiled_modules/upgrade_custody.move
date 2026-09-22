module 0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::upgrade_custody {
    struct UpgradeCustody<phantom T0: drop> has store {
        publisher: 0x2::package::Publisher,
        upgrade_cap: 0x1::option::Option<0x2::package::UpgradeCap>,
    }

    public fun authorize_upgrade<T0: drop>(arg0: &mut UpgradeCustody<T0>, arg1: 0x2::object::ID, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 22);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 21);
        let v0 = 0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap);
        let v1 = 0x2::package::upgrade_policy(v0);
        let v2 = 0x2::package::authorize_upgrade(v0, v1, arg2);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::upgrade_authorized<T0>(arg1, 0x2::object::id<0x2::package::UpgradeCap>(v0), 0x2::package::upgrade_package(v0), 0x2::package::version(v0), v1, *0x2::package::ticket_digest(&v2));
        v2
    }

    public fun commit_upgrade<T0: drop>(arg0: &mut UpgradeCustody<T0>, arg1: 0x2::object::ID, arg2: 0x2::package::UpgradeReceipt) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 22);
        let v0 = 0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap);
        0x2::package::commit_upgrade(v0, arg2);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::upgrade_committed<T0>(arg1, 0x2::object::id<0x2::package::UpgradeCap>(v0), 0x1::type_name::original_id<T0>(), 0x2::package::receipt_package(&arg2), 0x2::package::version(v0), 0x2::package::version(v0));
    }

    public fun make_immutable<T0: drop>(arg0: &mut UpgradeCustody<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 22);
        let v0 = 0x1::option::extract<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap);
        0x2::package::make_immutable(v0);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::upgrade_cap_destroyed<T0>(arg1, 0x2::object::id<0x2::package::UpgradeCap>(&v0), 0x1::type_name::original_id<T0>(), 0x2::package::version(&v0), 0x2::package::upgrade_policy(&v0));
    }

    public fun has_upgrade_cap<T0: drop>(arg0: &UpgradeCustody<T0>) : bool {
        0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap)
    }

    public fun new<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::package::Publisher, arg2: 0x2::package::UpgradeCap) : UpgradeCustody<T0> {
        assert!(0x2::package::from_package<T0>(&arg1), 19);
        let v0 = 0x2::package::upgrade_package(&arg2);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::original_id<T0>() && 0x2::package::version(&arg2) == 1, 20);
        let v1 = UpgradeCustody<T0>{
            publisher   : arg1,
            upgrade_cap : 0x1::option::some<0x2::package::UpgradeCap>(arg2),
        };
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::upgrade_custody_created<T0>(arg0, 0x2::object::id<0x2::package::Publisher>(&arg1), 0x2::object::id<0x2::package::UpgradeCap>(&arg2), v0, 0x2::package::version(&arg2), 0x2::package::upgrade_policy(&arg2));
        v1
    }

    public fun restrict_to_additive<T0: drop>(arg0: &mut UpgradeCustody<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 22);
        let v0 = 0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap);
        let v1 = 0x2::package::upgrade_policy(v0);
        assert!(0x2::package::additive_policy() > v1, 23);
        0x2::package::only_additive_upgrades(v0);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::upgrade_policy_restricted<T0>(arg1, 0x2::object::id<0x2::package::UpgradeCap>(v0), 0x1::type_name::original_id<T0>(), 0x2::package::version(v0), v1, 0x2::package::upgrade_policy(v0));
    }

    public fun restrict_to_dependency_only<T0: drop>(arg0: &mut UpgradeCustody<T0>, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::package::UpgradeCap>(&arg0.upgrade_cap), 22);
        let v0 = 0x1::option::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_cap);
        let v1 = 0x2::package::upgrade_policy(v0);
        assert!(0x2::package::dep_only_policy() > v1, 23);
        0x2::package::only_dep_upgrades(v0);
        0x247b6e2f000a77e82f4afc5c08f95f746e2e132ba2e1ecb3a9082f0c41ab80e2::events::upgrade_policy_restricted<T0>(arg1, 0x2::object::id<0x2::package::UpgradeCap>(v0), 0x1::type_name::original_id<T0>(), 0x2::package::version(v0), v1, 0x2::package::upgrade_policy(v0));
    }

    // decompiled from Move bytecode v7
}

