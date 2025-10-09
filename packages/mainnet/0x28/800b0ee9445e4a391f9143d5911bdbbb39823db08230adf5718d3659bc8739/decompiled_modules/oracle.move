module 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle {
    struct AdminCap has store, key {
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

    struct MmtOracle has key {
        id: 0x2::object::UID,
        version: 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::Version,
        prices: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        sources: 0x2::table::Table<0x1::type_name::TypeName, PriceSources>,
        staleness_threshold: u64,
    }

    struct PriceReceipt<phantom T0> {
        primary_price: 0x1::option::Option<Price>,
        secondary_price: 0x1::option::Option<Price>,
    }

    struct SourceUpdatedEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        source_type: 0x1::option::Option<0x1::type_name::TypeName>,
        is_primary: bool,
    }

    struct PriceUpdatedEvent has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        price: Price,
    }

    struct VersionUpgradedEvent has copy, drop, store {
        major_version: u64,
        minor_version: u64,
    }

    struct StalenessThresholdUpdatedEvent has copy, drop, store {
        old_threshold: u64,
        new_threshold: u64,
    }

    public fun get_price(arg0: &MmtOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : u64 {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg0.version);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 - v0.updated_at <= arg0.staleness_threshold / 1000, 0);
        v0.price
    }

    public fun get_price_receipt<T0>(arg0: &MmtOracle) : PriceReceipt<T0> {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg0.version);
        PriceReceipt<T0>{
            primary_price   : 0x1::option::none<Price>(),
            secondary_price : 0x1::option::none<Price>(),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MmtOracle{
            id                  : 0x2::object::new(arg0),
            version             : 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::initialize(),
            prices              : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            sources             : 0x2::table::new<0x1::type_name::TypeName, PriceSources>(arg0),
            staleness_threshold : 10000,
        };
        0x2::transfer::share_object<MmtOracle>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_reasonable_diff(arg0: &Price, arg1: &Price) : bool {
        let v0 = 1000;
        let v1 = 5 * v0 / 100;
        let v2 = arg0.price * v0 / arg1.price;
        v2 <= v0 + v1 && v2 >= v0 - v1
    }

    public fun remove_primary_source<T0>(arg0: &AdminCap, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg1.sources, v0), 0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0).primary_source);
        let v1 = SourceUpdatedEvent{
            coin_type   : v0,
            source_type : 0x1::option::none<0x1::type_name::TypeName>(),
            is_primary  : true,
        };
        0x2::event::emit<SourceUpdatedEvent>(v1);
    }

    public fun remove_secondary_source<T0>(arg0: &AdminCap, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg1.version);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceSources>(&arg1.sources, v0), 0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceSources>(&mut arg1.sources, v0).secondary_source);
        let v1 = SourceUpdatedEvent{
            coin_type   : v0,
            source_type : 0x1::option::none<0x1::type_name::TypeName>(),
            is_primary  : false,
        };
        0x2::event::emit<SourceUpdatedEvent>(v1);
    }

    public fun set_primary_price<T0, T1: drop>(arg0: T1, arg1: &mut PriceReceipt<T0>, arg2: &MmtOracle, arg3: u64, arg4: u64) {
        abort 0
    }

    public fun set_primary_price_safe<T0, T1: drop>(arg0: T1, arg1: &mut PriceReceipt<T0>, arg2: &MmtOracle, arg3: u64, arg4: u64, arg5: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::SetPriceCap, arg6: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::SetPriceCapRegistry) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg2.version);
        assert!(!0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::is_revoked(arg6, arg5), 0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&0x2::table::borrow<0x1::type_name::TypeName, PriceSources>(&arg2.sources, 0x1::type_name::get<T0>()).primary_source) == 0x1::type_name::get<T1>(), 0);
        let v0 = Price{
            price      : arg3,
            updated_at : arg4,
        };
        0x1::option::fill<Price>(&mut arg1.primary_price, v0);
    }

    public fun set_primary_source<T0, T1: drop>(arg0: &AdminCap, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg1.version);
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
        let v2 = SourceUpdatedEvent{
            coin_type   : v0,
            source_type : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()),
            is_primary  : true,
        };
        0x2::event::emit<SourceUpdatedEvent>(v2);
    }

    public fun set_secondary_price<T0, T1: drop>(arg0: T1, arg1: &mut PriceReceipt<T0>, arg2: &MmtOracle, arg3: u64, arg4: u64) {
        abort 0
    }

    public fun set_secondary_price_safe<T0, T1: drop>(arg0: T1, arg1: &mut PriceReceipt<T0>, arg2: &MmtOracle, arg3: u64, arg4: u64, arg5: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::SetPriceCap, arg6: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::SetPriceCapRegistry) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg2.version);
        assert!(!0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::registry::is_revoked(arg6, arg5), 0);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&0x2::table::borrow<0x1::type_name::TypeName, PriceSources>(&arg2.sources, 0x1::type_name::get<T0>()).secondary_source) == 0x1::type_name::get<T1>(), 0);
        let v0 = Price{
            price      : arg3,
            updated_at : arg4,
        };
        0x1::option::fill<Price>(&mut arg1.secondary_price, v0);
    }

    public fun set_secondary_source<T0, T1: drop>(arg0: &AdminCap, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg1.version);
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
        let v2 = SourceUpdatedEvent{
            coin_type   : v0,
            source_type : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()),
            is_primary  : false,
        };
        0x2::event::emit<SourceUpdatedEvent>(v2);
    }

    public fun update_price<T0>(arg0: PriceReceipt<T0>, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(&arg1.version);
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
        let v6 = PriceUpdatedEvent{
            coin_type : v0,
            price     : *v5,
        };
        0x2::event::emit<PriceUpdatedEvent>(v6);
    }

    public fun update_staleness_threshold(arg0: &AdminCap, arg1: &mut MmtOracle, arg2: u64) {
        abort 0
    }

    public fun update_staleness_threshold_safe(arg0: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::Version, arg1: &AdminCap, arg2: &mut MmtOracle, arg3: u64) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::assert_current_version(arg0);
        arg2.staleness_threshold = arg3;
        let v0 = StalenessThresholdUpdatedEvent{
            old_threshold : arg2.staleness_threshold,
            new_threshold : arg3,
        };
        0x2::event::emit<StalenessThresholdUpdatedEvent>(v0);
    }

    public fun version(arg0: &MmtOracle) : &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::Version {
        &arg0.version
    }

    public fun upgrade_major(arg0: &AdminCap, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::upgrade_major(&mut arg1.version);
        let v0 = VersionUpgradedEvent{
            major_version : 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::value_major(&arg1.version),
            minor_version : 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::value_minor(&arg1.version),
        };
        0x2::event::emit<VersionUpgradedEvent>(v0);
    }

    public fun upgrade_minor(arg0: &AdminCap, arg1: &mut MmtOracle) {
        0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::upgrade_minor(&mut arg1.version);
        let v0 = VersionUpgradedEvent{
            major_version : 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::value_major(&arg1.version),
            minor_version : 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::version::value_minor(&arg1.version),
        };
        0x2::event::emit<VersionUpgradedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

