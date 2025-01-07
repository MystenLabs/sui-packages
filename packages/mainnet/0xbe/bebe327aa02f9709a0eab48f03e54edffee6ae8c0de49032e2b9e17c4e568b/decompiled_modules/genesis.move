module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis {
    struct GovernanceCap {
        dummy_field: bool,
    }

    struct GovernanceManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceGenesis has key {
        id: 0x2::object::UID,
        upgrade_cap: 0x2::package::UpgradeCap,
        manager_ids: vector<0x2::object::ID>,
    }

    struct Version has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_0 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_1 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_2 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_3 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_4 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_5 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_6 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_7 has copy, drop, store {
        dummy_field: bool,
    }

    struct Version_1_0_8 has copy, drop, store {
        dummy_field: bool,
    }

    public fun authorize_upgrade(arg0: &GovernanceCap, arg1: &mut GovernanceGenesis, arg2: u8, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(&mut arg1.upgrade_cap, arg2, arg3)
    }

    public fun commit_upgrade(arg0: &mut GovernanceGenesis, arg1: 0x2::package::UpgradeReceipt) {
        0x2::package::commit_upgrade(&mut arg0.upgrade_cap, arg1);
    }

    public fun check_latest_version(arg0: &GovernanceGenesis) {
        let v0 = Version{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_with_type<Version, Version_1_0_6>(&arg0.id, v0)) {
            true
        } else {
            let v2 = Version{dummy_field: false};
            0x2::dynamic_field::exists_with_type<Version, Version_1_0_7>(&arg0.id, v2)
        };
        assert!(v1, 4);
    }

    public fun create(arg0: &GovernanceManagerCap) : GovernanceCap {
        GovernanceCap{dummy_field: false}
    }

    public fun destroy(arg0: GovernanceCap) {
        let GovernanceCap {  } = arg0;
    }

    public fun destroy_manager(arg0: &mut GovernanceGenesis, arg1: GovernanceManagerCap) {
        let v0 = 0x2::object::id<GovernanceManagerCap>(&arg1);
        let (_, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.manager_ids, &v0);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.manager_ids, v2);
        let GovernanceManagerCap { id: v3 } = arg1;
        0x2::object::delete(v3);
    }

    public fun get_version_1_0_1() : Version_1_0_1 {
        Version_1_0_1{dummy_field: false}
    }

    public fun get_version_1_0_2() : Version_1_0_2 {
        Version_1_0_2{dummy_field: false}
    }

    public fun get_version_1_0_3() : Version_1_0_3 {
        Version_1_0_3{dummy_field: false}
    }

    public fun get_version_1_0_4() : Version_1_0_4 {
        Version_1_0_4{dummy_field: false}
    }

    public fun get_version_1_0_5() : Version_1_0_5 {
        Version_1_0_5{dummy_field: false}
    }

    public fun get_version_1_0_6() : Version_1_0_6 {
        Version_1_0_6{dummy_field: false}
    }

    public fun get_version_1_0_7() : Version_1_0_7 {
        Version_1_0_7{dummy_field: false}
    }

    public fun get_version_1_0_8() : Version_1_0_8 {
        Version_1_0_8{dummy_field: false}
    }

    public(friend) fun init_genesis(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : GovernanceManagerCap {
        let v0 = GovernanceGenesis{
            id          : 0x2::object::new(arg1),
            upgrade_cap : arg0,
            manager_ids : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = GovernanceManagerCap{id: 0x2::object::new(arg1)};
        let v2 = Version{dummy_field: false};
        let v3 = Version_1_0_0{dummy_field: false};
        0x2::dynamic_field::add<Version, Version_1_0_0>(&mut v0.id, v2, v3);
        0x1::vector::push_back<0x2::object::ID>(&mut v0.manager_ids, 0x2::object::id<GovernanceManagerCap>(&v1));
        0x2::transfer::share_object<GovernanceGenesis>(v0);
        v1
    }

    public fun migrate_version<T0: drop + store, T1: drop + store>(arg0: &GovernanceCap, arg1: &mut GovernanceGenesis, arg2: T1) {
        let v0 = Version{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Version, T0>(&mut arg1.id, v0), 1);
        let v1 = Version{dummy_field: false};
        0x2::dynamic_field::remove<Version, T0>(&mut arg1.id, v1);
        let v2 = 0x1::type_name::get<T1>();
        assert!(v2 != 0x1::type_name::get<T0>(), 2);
        assert!(0x1::ascii::into_bytes(0x1::type_name::get_module(&v2)) == b"genesis", 3);
        let v3 = Version{dummy_field: false};
        0x2::dynamic_field::add<Version, T1>(&mut arg1.id, v3, arg2);
    }

    public fun restore<T0: drop + store>(arg0: &GovernanceCap, arg1: &mut GovernanceGenesis, arg2: T0) {
        let v0 = Version{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<Version>(&mut arg1.id, v0), 5);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::ascii::into_bytes(0x1::type_name::get_module(&v1)) == b"genesis", 3);
        let v2 = Version{dummy_field: false};
        0x2::dynamic_field::add<Version, T0>(&mut arg1.id, v2, arg2);
    }

    public fun shutdown<T0: drop + store>(arg0: &GovernanceCap, arg1: &mut GovernanceGenesis) {
        let v0 = Version{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<Version, T0>(&mut arg1.id, v0), 4);
        let v1 = Version{dummy_field: false};
        0x2::dynamic_field::remove<Version, T0>(&mut arg1.id, v1);
        let v2 = Version{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<Version>(&mut arg1.id, v2), 6);
    }

    // decompiled from Move bytecode v6
}

