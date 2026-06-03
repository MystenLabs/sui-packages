module 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle {
    struct VersionAllowed has copy, drop {
        version: u16,
    }

    struct VersionDisallowed has copy, drop {
        version: u16,
    }

    struct Oracle has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
    }

    struct ListingCap has store, key {
        id: 0x2::object::UID,
    }

    public fun aggregator(arg0: &Oracle, arg1: 0x1::string::String) : &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator {
        borrow_aggregator(arg0, arg1)
    }

    public fun remove_price_at_timestamp(arg0: &mut Oracle, arg1: 0x1::string::String, arg2: u64) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::remove_price_at_timestamp(borrow_aggregator_mut(arg0, arg1), arg2)
    }

    public fun set_outlier_tolerance(arg0: &mut Oracle, arg1: &ListingCap, arg2: 0x1::string::String, arg3: u64) {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::set_outlier_tolerance(borrow_aggregator_mut(arg0, arg2), arg3);
    }

    public fun set_rule_weight<T0>(arg0: &mut Oracle, arg1: &ListingCap, arg2: 0x1::string::String, arg3: u8) {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::set_rule_weight<T0>(borrow_aggregator_mut(arg0, arg2), arg3);
    }

    public fun set_weight_threshold(arg0: &mut Oracle, arg1: &ListingCap, arg2: 0x1::string::String, arg3: u64) {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::set_weight_threshold(borrow_aggregator_mut(arg0, arg2), arg3);
    }

    public fun add_aggregator(arg0: &mut Oracle, arg1: &ListingCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        if (0x2::dynamic_object_field::exists_with_type<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&arg0.id, arg2)) {
            abort 13906834616725012481
        };
        0x2::dynamic_object_field::add<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&mut arg0.id, arg2, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::new(arg2, arg3, arg4, arg5));
    }

    public fun aggregate(arg0: &mut Oracle, arg1: 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::aggregate_into(borrow_aggregator_mut(arg0, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(&arg1)), arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun allow_version(arg0: &mut Oracle, arg1: &ListingCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
            let v0 = VersionAllowed{version: arg2};
            0x2::event::emit<VersionAllowed>(v0);
        };
    }

    public fun assert_version(arg0: &Oracle) {
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            abort 13906834474991484935
        };
    }

    fun borrow_aggregator(arg0: &Oracle, arg1: 0x1::string::String) : &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator {
        if (!0x2::dynamic_object_field::exists_with_type<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&arg0.id, arg1)) {
            abort 13906835123531284483
        };
        0x2::dynamic_object_field::borrow<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&arg0.id, arg1)
    }

    fun borrow_aggregator_mut(arg0: &mut Oracle, arg1: 0x1::string::String) : &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator {
        if (!0x2::dynamic_object_field::exists_with_type<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&arg0.id, arg1)) {
            abort 13906835145006120963
        };
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&mut arg0.id, arg1)
    }

    public fun disallow_version(arg0: &mut Oracle, arg1: &ListingCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
            let v0 = VersionDisallowed{version: arg2};
            0x2::event::emit<VersionDisallowed>(v0);
        };
    }

    public fun get_price(arg0: &Oracle, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        assert_version(arg0);
        let v0 = borrow_aggregator(arg0, arg1);
        if (0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::last_update_ms(v0) != 0x2::clock::timestamp_ms(arg2)) {
            abort 13906834908783050757
        };
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::price_at_timestamp(v0, 0x1::option::none<u64>())
    }

    public fun get_price_at_timestamp(arg0: &Oracle, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::price_at_timestamp(borrow_aggregator(arg0, arg1), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u16>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::version::package_version()),
        };
        0x2::transfer::share_object<Oracle>(v0);
        let v1 = ListingCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ListingCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_listed(arg0: &Oracle, arg1: 0x1::string::String) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::string::String, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::PriceAggregator>(&arg0.id, arg1)
    }

    public fun is_version_allowed(arg0: &Oracle, arg1: u16) : bool {
        0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg1)
    }

    public fun new_collector(arg0: 0x1::string::String) : 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector {
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::new(arg0)
    }

    public fun register_price_at_timestamp(arg0: &mut Oracle, arg1: 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector) : u64 {
        assert_version(arg0);
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::register_history_into(borrow_aggregator_mut(arg0, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(&arg1)), arg1)
    }

    public fun unsafe_get_latest_price(arg0: &Oracle, arg1: 0x1::string::String) : (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, u64) {
        assert_version(arg0);
        let v0 = borrow_aggregator(arg0, arg1);
        (0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::latest_price(v0), 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator::last_update_ms(v0))
    }

    // decompiled from Move bytecode v7
}

