module 0xe622909f9252d4ef1737c41ea430ef44203d8f5dc8e01e1b3950a31405bc54eb::pyth_registry {
    struct PythFeedData has drop, store {
        feed: 0x2::object::ID,
        conf_tolerance: u64,
    }

    struct PythRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, PythFeedData>,
    }

    struct PythRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_pyth_price_info_object<T0>(arg0: &PythRegistry, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == 0x2::table::borrow<0x1::type_name::TypeName, PythFeedData>(&arg0.table, 0x1::type_name::get<T0>()).feed, 70149);
    }

    public fun conf_tolerance_scale() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, PythFeedData>(arg0),
        };
        let v1 = PythRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<PythRegistry>(&v0),
        };
        0x2::transfer::share_object<PythRegistry>(v0);
        0x2::transfer::transfer<PythRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun price_conf_tolerance(arg0: &PythFeedData) : u64 {
        arg0.conf_tolerance
    }

    public fun price_feed_id(arg0: &PythFeedData) : 0x2::object::ID {
        arg0.feed
    }

    public fun pyth_feed_data(arg0: &PythRegistry, arg1: 0x1::type_name::TypeName) : &PythFeedData {
        0x2::table::borrow<0x1::type_name::TypeName, PythFeedData>(&arg0.table, arg1)
    }

    public entry fun register_pyth_feed<T0>(arg0: &mut PythRegistry, arg1: &PythRegistryCap, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64) {
        assert!(0x2::object::id<PythRegistry>(arg0) == arg1.for, 70150);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PythFeedData>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, PythFeedData>(&mut arg0.table, v0);
        };
        let v1 = PythFeedData{
            feed           : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2),
            conf_tolerance : arg3,
        };
        0x2::table::add<0x1::type_name::TypeName, PythFeedData>(&mut arg0.table, v0, v1);
    }

    // decompiled from Move bytecode v6
}

