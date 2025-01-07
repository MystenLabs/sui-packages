module 0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::k_oracle {
    struct KOracle has store, key {
        id: 0x2::object::UID,
        primary_source: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig,
        secondary_source: 0x1::option::Option<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>,
        staleness_threshold: u64,
        max_variance: u64,
        prices: 0x2::table::Table<0x1::type_name::TypeName, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price>,
    }

    struct KOraclePriceRequest<phantom T0> {
        primary_price_request: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>,
        secondary_price_request: 0x1::option::Option<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>,
    }

    struct KOraclePrice<phantom T0> {
        value: u64,
        decimals: u8,
    }

    struct PriceUpdatedEvent<phantom T0> has copy, drop {
        price: u64,
    }

    public fun new<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg1);
        let v0 = KOracle{
            id                  : 0x2::object::new(arg2),
            primary_source      : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::new<T0>(arg2),
            secondary_source    : 0x1::option::none<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(),
            staleness_threshold : 0,
            max_variance        : 0,
            prices              : 0x2::table::new<0x1::type_name::TypeName, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price>(arg2),
        };
        0x2::transfer::share_object<KOracle>(v0);
    }

    fun assert_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig) {
        assert!(0x1::type_name::get<T0>() == 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::source(arg0), 0);
    }

    public fun burn_price_response<T0>(arg0: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg1: KOraclePrice<T0>) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg0);
        let KOraclePrice {
            value    : _,
            decimals : _,
        } = arg1;
    }

    fun confirm_price_request<T0>(arg0: KOraclePriceRequest<T0>, arg1: u64) : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price {
        let KOraclePriceRequest {
            primary_price_request   : v0,
            secondary_price_request : v1,
        } = arg0;
        let v2 = v1;
        if (!0x1::option::is_some<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>(&v2)) {
            0x1::option::destroy_none<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>(v2);
            return 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::burn<T0>(v0)
        };
        determine_price(0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::burn<T0>(v0), 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::burn<T0>(0x1::option::destroy_some<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>(v2)), arg1)
    }

    public fun price_request<T0>(arg0: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg1: &KOracle) : KOraclePriceRequest<T0> {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg0);
        let v0 = if (0x1::option::is_some<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&arg1.secondary_source)) {
            0x1::option::some<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>(0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price_request<T0>(0x1::option::borrow<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&arg1.secondary_source)))
        } else {
            0x1::option::none<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>()
        };
        KOraclePriceRequest<T0>{
            primary_price_request   : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price_request<T0>(&arg1.primary_source),
            secondary_price_request : v0,
        }
    }

    fun determine_price(arg0: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price, arg1: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price, arg2: u64) : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price {
        assert!(price_feed_match(arg0, arg1, arg2), 0);
        arg0
    }

    public fun get_price_response<T0>(arg0: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg1: &KOracle, arg2: &0x2::clock::Clock) : KOraclePrice<T0> {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg0);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price>(&arg1.prices, 0x1::type_name::get<T0>());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_updated_at(v0) < arg1.staleness_threshold, 0);
        KOraclePrice<T0>{
            value    : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(v0),
            decimals : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_decimals(v0),
        }
    }

    fun price_feed_match(arg0: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price, arg1: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price, arg2: u64) : bool {
        let v0 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&arg0);
        let v1 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&arg1);
        v0 >= v1 && v0 - v1 < v0 * arg2 / 1000000 || v1 - v0 < v0 * arg2 / 1000000
    }

    public fun price_response_value<T0>(arg0: &KOraclePrice<T0>) : (u64, u8) {
        (arg0.value, arg0.decimals)
    }

    fun save_price<T0>(arg0: &mut KOracle, arg1: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price>(&arg0.prices, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price>(&mut arg0.prices, v0, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price(0, 0, 0));
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price>(&mut arg0.prices, v0) = arg1;
    }

    public fun set_max_variance(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg2: &mut KOracle, arg3: u64) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg1);
        arg2.max_variance = arg3;
    }

    public fun set_primary_price<T0, T1: drop>(arg0: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg1: &KOracle, arg2: T1, arg3: &mut KOraclePriceRequest<T0>, arg4: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg0);
        assert_source<T1>(&arg1.primary_source);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::set_price<T0, T1>(arg2, &mut arg3.primary_price_request, &arg1.primary_source, arg4);
    }

    public fun set_primary_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg2: &mut KOracle) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg1);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::set_source<T0>(&mut arg2.primary_source);
    }

    public fun set_secondary_price<T0, T1: drop>(arg0: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg1: &KOracle, arg2: T1, arg3: &mut KOraclePriceRequest<T0>, arg4: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg0);
        assert_source<T1>(0x1::option::borrow<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&arg1.secondary_source));
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::set_price<T0, T1>(arg2, 0x1::option::borrow_mut<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>>(&mut arg3.secondary_price_request), 0x1::option::borrow<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&arg1.secondary_source), arg4);
    }

    public fun set_secondary_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg2: &mut KOracle, arg3: &mut 0x2::tx_context::TxContext) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg1);
        if (0x1::option::is_some<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&arg2.secondary_source)) {
            0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::set_source<T0>(0x1::option::borrow_mut<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&mut arg2.secondary_source));
        } else {
            0x1::option::fill<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(&mut arg2.secondary_source, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::new<T0>(arg3));
        };
    }

    public fun set_staleness_threshold(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg2: &mut KOracle, arg3: u64) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg1);
        arg2.staleness_threshold = arg3;
    }

    public fun update_price<T0>(arg0: &0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::Version, arg1: &mut KOracle, arg2: KOraclePriceRequest<T0>) {
        0x6dbcf81d59c08559c35cf7b0b87c80b53fe98a2d91cf4019e9aa339cf3170c26::version::assert_current_version(arg0);
        let v0 = confirm_price_request<T0>(arg2, arg1.max_variance);
        save_price<T0>(arg1, v0);
        let v1 = PriceUpdatedEvent<T0>{price: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&v0)};
        0x2::event::emit<PriceUpdatedEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

