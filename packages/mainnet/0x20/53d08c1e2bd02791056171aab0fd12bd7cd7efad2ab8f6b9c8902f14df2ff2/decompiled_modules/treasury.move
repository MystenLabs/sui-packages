module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury {
    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DenyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ManagedTreasury<phantom T0> has key {
        id: 0x2::object::UID,
        roles: 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::Roles,
        version: u16,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : ManagedTreasury<T0> {
        let v0 = 0x2::object::new(arg2);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, v1, arg0);
        let v2 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<DenyCapKey, 0x2::coin::DenyCap<T0>>(&mut v0, v2, arg1);
        ManagedTreasury<T0>{
            id      : v0,
            roles   : 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new(arg2),
            version : 1,
        }
    }

    public(friend) fun roles<T0>(arg0: &ManagedTreasury<T0>) : &0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::Roles {
        &arg0.roles
    }

    fun assert_is_valid_version<T0>(arg0: &ManagedTreasury<T0>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun denylist_cap_mut<T0>(arg0: &mut ManagedTreasury<T0>) : &mut 0x2::coin::DenyCap<T0> {
        assert_is_valid_version<T0>(arg0);
        let v0 = DenyCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<DenyCapKey, 0x2::coin::DenyCap<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun roles_mut<T0>(arg0: &mut ManagedTreasury<T0>) : &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::Roles {
        assert_is_valid_version<T0>(arg0);
        &mut arg0.roles
    }

    public(friend) fun set_version<T0>(arg0: &mut ManagedTreasury<T0>, arg1: u16) {
        arg0.version = arg1;
    }

    public fun share<T0>(arg0: ManagedTreasury<T0>) {
        0x2::transfer::share_object<ManagedTreasury<T0>>(arg0);
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut ManagedTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        assert_is_valid_version<T0>(arg0);
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun uid<T0>(arg0: &ManagedTreasury<T0>) : &0x2::object::UID {
        assert_is_valid_version<T0>(arg0);
        &arg0.id
    }

    public(friend) fun uid_mut<T0>(arg0: &mut ManagedTreasury<T0>) : &mut 0x2::object::UID {
        assert_is_valid_version<T0>(arg0);
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

