module 0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::registry {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        price_info_ids: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    public fun assert_pyth_price_info_object<T0>(arg0: &Registry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
        assert!(&v0 == 0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_info_ids, 0x1::type_name::get<T0>()), 0);
    }

    public fun get_pair_id<T0>(arg0: &Registry, arg1: &0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::version::Version) : 0x2::object::ID {
        0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::version::assert_current_version(arg1);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_info_ids, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id             : 0x2::object::new(arg0),
            price_info_ids : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_price_pair_id<T0>(arg0: &AdminCap, arg1: &mut Registry, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::version::Version) {
        0x726b2646dfc09d20ae1240bbd99592d15c04113789f98a340b68f929395ae0bf::version::assert_current_version(arg3);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.price_info_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_info_ids, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.price_info_ids, v0, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2));
    }

    // decompiled from Move bytecode v6
}

