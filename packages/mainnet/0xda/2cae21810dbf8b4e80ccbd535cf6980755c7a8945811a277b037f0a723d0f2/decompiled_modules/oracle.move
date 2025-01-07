module 0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::oracle {
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
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        sources: 0x2::table::Table<0x1::type_name::TypeName, PriceSources>,
        staleness_threshold: u64,
    }

    struct PriceReceipt<phantom T0> {
        primary_price: 0x1::option::Option<Price>,
        secondary_price: 0x1::option::Option<Price>,
    }

    public fun get_price(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: &KriyaOracle, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) : u64 {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg1.prices, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) - v0.updated_at <= arg1.staleness_threshold, 0);
        v0.price
    }

    public fun get_price_receipt<T0>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version) : PriceReceipt<T0> {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        PriceReceipt<T0>{
            primary_price   : 0x1::option::none<Price>(),
            secondary_price : 0x1::option::none<Price>(),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KriyaOracle{
            id                  : 0x2::object::new(arg0),
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

    public fun remove_primary_source<T0>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: &AdminCap, arg2: &mut KriyaOracle) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg2.sources, v0), 0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg2.sources, v0).primary_source);
    }

    public fun remove_secondary_source<T0>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: &AdminCap, arg2: &mut KriyaOracle) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg2.sources, v0), 0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg2.sources, v0).secondary_source);
    }

    public fun set_primary_price<T0, T1: drop>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: T1, arg2: &mut PriceReceipt<T0>, arg3: &KriyaOracle, arg4: u64, arg5: u64) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&0x2::table::borrow<0x1::type_name::TypeName, PriceSources>(&arg3.sources, 0x1::type_name::get<T0>()).primary_source) == 0x1::type_name::get<T1>(), 0);
        let v0 = Price{
            price      : arg4,
            updated_at : arg5,
        };
        0x1::option::fill<Price>(&mut arg2.primary_price, v0);
    }

    public fun set_primary_source<T0, T1: drop>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: &AdminCap, arg2: &mut KriyaOracle) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg2.sources, v0)) {
            0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg2.sources, v0).primary_source, 0x1::type_name::get<T1>());
        } else {
            let v1 = PriceSources{
                primary_source   : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()),
                secondary_source : 0x1::option::none<0x1::type_name::TypeName>(),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceSources>(&mut arg2.sources, v0, v1);
        };
    }

    public fun set_secondary_price<T0, T1: drop>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: T1, arg2: &mut PriceReceipt<T0>, arg3: &KriyaOracle, arg4: u64, arg5: u64) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&0x2::table::borrow<0x1::type_name::TypeName, PriceSources>(&arg3.sources, 0x1::type_name::get<T0>()).secondary_source) == 0x1::type_name::get<T1>(), 0);
        let v0 = Price{
            price      : arg4,
            updated_at : arg5,
        };
        0x1::option::fill<Price>(&mut arg2.secondary_price, v0);
    }

    public fun set_secondary_source<T0, T1: drop>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: &AdminCap, arg2: &mut KriyaOracle) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg2.sources, v0)) {
            0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg2.sources, v0).secondary_source, 0x1::type_name::get<T1>());
        } else {
            let v1 = PriceSources{
                primary_source   : 0x1::option::none<0x1::type_name::TypeName>(),
                secondary_source : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()),
            };
            0x2::table::add<0x1::type_name::TypeName, PriceSources>(&mut arg2.sources, v0, v1);
        };
    }

    public fun update_price<T0>(arg0: &0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::Version, arg1: PriceReceipt<T0>, arg2: &mut KriyaOracle) {
        0xda2cae21810dbf8b4e80ccbd535cf6980755c7a8945811a277b037f0a723d0f2::version::assert_current_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let PriceReceipt {
            primary_price   : v1,
            secondary_price : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::option::borrow<Price>(&v4);
        if (0x1::option::is_some<Price>(&v3)) {
            assert!(is_reasonable_diff(v5, 0x1::option::borrow<Price>(&v3)), 0);
        };
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg2.prices, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg2.prices, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg2.prices, v0, *v5);
    }

    // decompiled from Move bytecode v6
}

