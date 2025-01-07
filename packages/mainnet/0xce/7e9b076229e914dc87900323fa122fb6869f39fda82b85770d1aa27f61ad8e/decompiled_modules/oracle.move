module 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Price has copy, drop, store {
        price: u64,
        updated_at: u64,
    }

    struct PriceSources has store {
        primary_source: 0x1::option::Option<0x1::type_name::TypeName>,
        secondary_source: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct KriyaOracle has key {
        id: 0x2::object::UID,
        version: 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::Version,
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        sources: 0x2::table::Table<0x1::type_name::TypeName, PriceSources>,
        staleness_threshold: u64,
    }

    struct PriceReceipt<phantom T0> {
        primary_price: 0x1::option::Option<Price>,
        secondary_price: 0x1::option::Option<Price>,
    }

    public fun get_price(arg0: &KriyaOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : u64 {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg0.version);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 - v0.updated_at <= arg0.staleness_threshold / 1000, 0);
        v0.price
    }

    public fun get_price_receipt<T0>(arg0: &KriyaOracle) : PriceReceipt<T0> {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg0.version);
        PriceReceipt<T0>{
            primary_price   : 0x1::option::none<Price>(),
            secondary_price : 0x1::option::none<Price>(),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KriyaOracle{
            id                  : 0x2::object::new(arg0),
            version             : 0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::initialize(),
            prices              : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            sources             : 0x2::table::new<0x1::type_name::TypeName, PriceSources>(arg0),
            staleness_threshold : 10000,
        };
        0x2::transfer::share_object<KriyaOracle>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_reasonable_diff(arg0: &Price, arg1: &Price) : bool {
        let v0 = 1000;
        let v1 = 5 * v0 / 100;
        let v2 = arg0.price * v0 / arg1.price;
        v2 <= v0 + v1 && v2 >= v0 - v1
    }

    public fun remove_primary_source<T0>(arg0: &AdminCap, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg1.sources, v0), 0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0).primary_source);
    }

    public fun remove_secondary_source<T0>(arg0: &AdminCap, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg1.sources, v0), 0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0).secondary_source);
    }

    public fun set_primary_price<T0, T1: drop>(arg0: T1, arg1: &mut PriceReceipt<T0>, arg2: &KriyaOracle, arg3: u64, arg4: u64) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg2.version);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&0x2::table::borrow<0x1::type_name::TypeName, PriceSources>(&arg2.sources, 0x1::type_name::get<T0>()).primary_source) == 0x1::type_name::get<T1>(), 0);
        let v0 = Price{
            price      : arg3,
            updated_at : arg4,
        };
        0x1::option::fill<Price>(&mut arg1.primary_price, v0);
    }

    public fun set_primary_source<T0, T1: drop>(arg0: &AdminCap, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg1.sources, v0)) {
            0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0).primary_source, 0x1::type_name::get<T1>());
        } else {
            let v1 = PriceSources{
                primary_source   : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()),
                secondary_source : 0x1::option::none<0x1::type_name::TypeName>(),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0, v1);
        };
    }

    public fun set_secondary_price<T0, T1: drop>(arg0: T1, arg1: &mut PriceReceipt<T0>, arg2: &KriyaOracle, arg3: u64, arg4: u64) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg2.version);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&0x2::table::borrow<0x1::type_name::TypeName, PriceSources>(&arg2.sources, 0x1::type_name::get<T0>()).secondary_source) == 0x1::type_name::get<T1>(), 0);
        let v0 = Price{
            price      : arg3,
            updated_at : arg4,
        };
        0x1::option::fill<Price>(&mut arg1.secondary_price, v0);
    }

    public fun set_secondary_source<T0, T1: drop>(arg0: &AdminCap, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg1.sources, v0)) {
            0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0).secondary_source, 0x1::type_name::get<T1>());
        } else {
            let v1 = PriceSources{
                primary_source   : 0x1::option::none<0x1::type_name::TypeName>(),
                secondary_source : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0, v1);
        };
    }

    public fun update_price<T0>(arg0: PriceReceipt<T0>, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        let PriceReceipt {
            primary_price   : v1,
            secondary_price : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::option::borrow<Price>(&v4);
        if (0x1::option::is_some<Price>(&v3)) {
            assert!(is_reasonable_diff(v5, 0x1::option::borrow<Price>(&v3)), 0);
        };
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg1.prices, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg1.prices, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg1.prices, v0, *v5);
    }

    public fun upgrade_major(arg0: &AdminCap, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::upgrade_major(&mut arg1.version);
    }

    public fun upgrade_minor(arg0: &AdminCap, arg1: &mut KriyaOracle) {
        0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::upgrade_minor(&mut arg1.version);
    }

    public fun version(arg0: &KriyaOracle) : &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::version::Version {
        &arg0.version
    }

    // decompiled from Move bytecode v6
}

