module 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::move_registry {
    struct MoveRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>,
        version: u8,
    }

    struct VersionCap has store, key {
        id: 0x2::object::UID,
    }

    struct MOVE_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun remove(arg0: &mut MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_valid_version(arg0);
        let v0 = 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::new(arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg3), 9223372556546277384);
        assert!(0x2::table::contains<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&arg0.registry, v0), 9223372560841113606);
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::burn(0x2::table::remove<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&mut arg0.registry, v0));
    }

    public fun assign_package(arg0: &mut MoveRegistry, arg1: &mut 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap, arg2: &0xf6b71233780a3f362137b44ac219290f4fd34eb81e0cb62ddf4bb38d1f9a3a1::package_info::PackageInfo) {
        assert_is_valid_version(arg0);
        let v0 = borrow_record_mut(arg0, arg1);
        assert!(!0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::is_immutable(v0), 9223372638150262786);
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::assign_package(v0, arg1, arg2);
    }

    public fun burn_cap(arg0: &mut MoveRegistry, arg1: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap) {
        assert_is_valid_version(arg0);
        if (0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::is_valid_for(&arg1, 0x2::table::borrow<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&arg0.registry, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::app(&arg1)))) {
            0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::burn(0x2::table::remove<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&mut arg0.registry, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::app(&arg1)));
        };
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::burn_cap(arg1);
    }

    public fun set_network(arg0: &mut MoveRegistry, arg1: &0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap, arg2: 0x1::string::String, arg3: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info::AppInfo) {
        assert_is_valid_version(arg0);
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::set_network(borrow_record_mut(arg0, arg1), arg2, arg3);
    }

    public fun unset_network(arg0: &mut MoveRegistry, arg1: &0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap, arg2: 0x1::string::String) {
        assert_is_valid_version(arg0);
        0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::unset_network(borrow_record_mut(arg0, arg1), arg2);
    }

    public fun app_exists(arg0: &MoveRegistry, arg1: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name) : bool {
        0x2::table::contains<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&arg0.registry, arg1)
    }

    fun assert_is_valid_version(arg0: &MoveRegistry) {
        assert!(arg0.version == 1, 9223372951683399690);
    }

    fun borrow_record_mut(arg0: &mut MoveRegistry, arg1: &0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap) : &mut 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord {
        assert!(app_exists(arg0, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::app(arg1)), 9223372917323399174);
        let v0 = 0x2::table::borrow_mut<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&mut arg0.registry, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::app(arg1));
        assert!(0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::is_valid_for(arg1, v0), 9223372925913202692);
        v0
    }

    fun init(arg0: MOVE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MOVE_REGISTRY>(arg0, arg1);
        let v0 = VersionCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<VersionCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MoveRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(arg1),
            version  : 1,
        };
        0x2::transfer::share_object<MoveRegistry>(v1);
    }

    public fun register(arg0: &mut MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap {
        assert_is_valid_version(arg0);
        let v0 = 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::new(arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg3), 9223372453467062280);
        let (v1, v2) = 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::new(v0, 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1), arg4);
        0x2::table::add<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>(&mut arg0.registry, v0, v1);
        v2
    }

    public fun set_version(arg0: &mut MoveRegistry, arg1: &VersionCap, arg2: u8) {
        assert_is_valid_version(arg0);
        arg0.version = arg2;
    }

    // decompiled from Move bytecode v6
}

