module 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::move_registry {
    struct MoveRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>,
        version: u8,
    }

    struct MOVE_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun remove(arg0: &mut MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::new(arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg3), 9223372509301637128);
        assert!(0x2::table::contains<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&arg0.registry, v0), 9223372513596473350);
        0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::burn(0x2::table::remove<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&mut arg0.registry, v0));
    }

    public fun assign_package(arg0: &mut MoveRegistry, arg1: &mut 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppCap, arg2: &0x3f59564f9caa6769a2b16e30ab0756441bad340339858373c6c38bbc15f67eb9::package_info::PackageInfo) {
        let v0 = borrow_record_mut(arg0, arg1);
        assert!(!0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::is_immutable(v0), 9223372586610655234);
        0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::assign_package(v0, arg1, arg2);
    }

    public fun burn_cap(arg0: &mut MoveRegistry, arg1: 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppCap) {
        if (0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::is_valid_for(&arg1, 0x2::table::borrow<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&arg0.registry, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::app(&arg1)))) {
            0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::burn(0x2::table::remove<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&mut arg0.registry, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::app(&arg1)));
        };
        0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::burn_cap(arg1);
    }

    public fun set_network(arg0: &mut MoveRegistry, arg1: &0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppCap, arg2: 0x1::string::String, arg3: 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_info::AppInfo) {
        0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::set_network(borrow_record_mut(arg0, arg1), arg2, arg3);
    }

    public fun unset_network(arg0: &mut MoveRegistry, arg1: &0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppCap, arg2: 0x1::string::String) {
        0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::unset_network(borrow_record_mut(arg0, arg1), arg2);
    }

    public(friend) fun app_exists(arg0: &MoveRegistry, arg1: 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name) : bool {
        0x2::table::contains<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&arg0.registry, arg1)
    }

    fun borrow_record_mut(arg0: &mut MoveRegistry, arg1: &0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppCap) : &mut 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord {
        assert!(app_exists(arg0, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::app(arg1)), 9223372809949216774);
        let v0 = 0x2::table::borrow_mut<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&mut arg0.registry, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::app(arg1));
        assert!(0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::is_valid_for(arg1, v0), 9223372818539020292);
        v0
    }

    fun init(arg0: MOVE_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MOVE_REGISTRY>(arg0, arg1);
        let v0 = MoveRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(arg1),
            version  : 1,
        };
        0x2::transfer::share_object<MoveRegistry>(v0);
    }

    public fun register(arg0: &mut MoveRegistry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppCap {
        let v0 = 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::new(arg2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(arg1, arg3), 9223372401927454728);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(&v1), 9223372410517520394);
        let (v2, v3) = 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::new(v0, 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1), arg4);
        0x2::table::add<0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::name::Name, 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_record::AppRecord>(&mut arg0.registry, v0, v2);
        v3
    }

    // decompiled from Move bytecode v6
}

