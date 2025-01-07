module 0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::pricer {
    struct Pricer has store, key {
        id: 0x2::object::UID,
        price_cap: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceCap,
        oracle_source: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig,
        ob_source: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig,
        ltp_source: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig,
        max_variance: u64,
    }

    struct PricerPriceRequest<phantom T0> {
        oracle_price_request: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>,
        ob_price_request: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>,
        ltp_request: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::PriceRequest<T0>,
    }

    struct PriceUpdatedEvent<phantom T0> has copy, drop {
        price: u64,
        timestamp: u64,
    }

    public fun new<T0: drop, T1: drop, T2: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg2: 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg1);
        let v0 = Pricer{
            id            : 0x2::object::new(arg3),
            price_cap     : arg2,
            oracle_source : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::new<T0>(arg3),
            ob_source     : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::new<T1>(arg3),
            ltp_source    : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::new<T2>(arg3),
            max_variance  : 0,
        };
        0x2::transfer::share_object<Pricer>(v0);
    }

    fun assert_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig) {
        assert!(0x1::type_name::get<T0>() == 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::source(arg0), 0);
    }

    fun get_funding_factor<T0>(arg0: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::deduction_interval<T0>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let (v2, v3, v4) = 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::get_last_funding_rate<T0>(arg0);
        if (v4 == 0 || v0 < v1 - v4) {
            return 1
        };
        if (v3) {
            1 + 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::div(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::mul(v2, v0 - v1 - v4), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::mul(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_rate_scaling()))
        } else {
            1 - 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::div(0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::mul(v2, v0 - v1 - v4), 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::safe_math::mul(v0, 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::constants::funding_rate_scaling()))
        }
    }

    fun is_reasonable_price_diff(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = (((arg0 as u128) * (arg3 as u128) / (1000000 as u128)) as u64);
        let v1 = arg0 >= arg1 && arg0 - arg1 < v0 || arg1 - arg0 < v0;
        let v2 = arg0 >= arg2 && arg0 - arg2 < v0 || arg2 - arg0 < v0;
        v1 && v2
    }

    fun median_price(arg0: vector<u64>) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        if (v0 == 0) {
            return 0
        };
        if (v0 == 1) {
            return *0x1::vector::borrow<u64>(&arg0, 0)
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                v2 = v2 + 1;
            };
            if (v1 != v1) {
                0x1::vector::swap<u64>(&mut arg0, v1, v1);
            };
            v1 = v1 + 1;
        };
        if (v0 % 2 == 0) {
            (*0x1::vector::borrow<u64>(&arg0, v0 / 2 - 1) + *0x1::vector::borrow<u64>(&arg0, v0 / 2)) / 2
        } else {
            *0x1::vector::borrow<u64>(&arg0, v0 / 2)
        }
    }

    public fun price_request<T0>(arg0: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg1: &Pricer) : PricerPriceRequest<T0> {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg0);
        PricerPriceRequest<T0>{
            oracle_price_request : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price_request<T0>(&arg1.oracle_source),
            ob_price_request     : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price_request<T0>(&arg1.ob_source),
            ltp_request          : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price_request<T0>(&arg1.ltp_source),
        }
    }

    fun process_price_request<T0>(arg0: PricerPriceRequest<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price {
        let PricerPriceRequest {
            oracle_price_request : v0,
            ob_price_request     : v1,
            ltp_request          : v2,
        } = arg0;
        let v3 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::burn<T0>(v0);
        let v4 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::burn<T0>(v1);
        let v5 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&v4);
        let v6 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::burn<T0>(v2);
        let v7 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&v6);
        let v8 = 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&v3) * arg1;
        if (is_reasonable_price_diff(v8, v5, v7, arg2)) {
            let v10 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v10, v8);
            0x1::vector::push_back<u64>(&mut v10, v5);
            0x1::vector::push_back<u64>(&mut v10, v7);
            0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price(median_price(v10), 9, 0x2::clock::timestamp_ms(arg3))
        } else {
            0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::new_price(v8, 9, 0x2::clock::timestamp_ms(arg3))
        }
    }

    public fun set_ltp<T0, T1: drop>(arg0: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg1: &Pricer, arg2: T1, arg3: &mut PricerPriceRequest<T0>, arg4: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg0);
        assert_source<T1>(&arg1.ltp_source);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::set_price<T0, T1>(arg2, &mut arg3.ltp_request, &arg1.ltp_source, arg4);
    }

    public fun set_ltp_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg2: &mut Pricer) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg1);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::set_source<T0>(&mut arg2.ltp_source);
    }

    public fun set_max_variance(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg2: &mut Pricer, arg3: u64) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg1);
        arg2.max_variance = arg3;
    }

    public fun set_ob_price<T0, T1: drop>(arg0: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg1: &Pricer, arg2: T1, arg3: &mut PricerPriceRequest<T0>, arg4: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg0);
        assert_source<T1>(&arg1.ob_source);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::set_price<T0, T1>(arg2, &mut arg3.ob_price_request, &arg1.ob_source, arg4);
    }

    public fun set_ob_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg2: &mut Pricer) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg1);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::set_source<T0>(&mut arg2.ob_source);
    }

    public fun set_oracle_price<T0, T1: drop>(arg0: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg1: &Pricer, arg2: T1, arg3: &mut PricerPriceRequest<T0>, arg4: 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::Price) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg0);
        assert_source<T1>(&arg1.oracle_source);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::set_price<T0, T1>(arg2, &mut arg3.oracle_price_request, &arg1.oracle_source, arg4);
    }

    public fun set_oracle_source<T0: drop>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::admin::AdminCap, arg1: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg2: &mut Pricer) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg1);
        0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::set_source<T0>(&mut arg2.oracle_source);
    }

    public fun set_protocol_price<T0>(arg0: &0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::Version, arg1: &mut Pricer, arg2: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::funding_rate::FundingRate<T0>, arg3: &mut 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::PriceRequest<T0>, arg4: PricerPriceRequest<T0>, arg5: &0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::version::Version, arg6: &0x2::clock::Clock) {
        0x40d686d9e04572b1f4157b4ed13999505264dae6de0119301ff4f754e48bbc02::version::assert_current_version(arg0);
        let v0 = process_price_request<T0>(arg4, get_funding_factor<T0>(arg2, arg6), arg1.max_variance, arg6);
        0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::price::set_mark_price<T0>(&arg1.price_cap, arg3, arg5, 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&v0));
        let v1 = PriceUpdatedEvent<T0>{
            price     : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_value(&v0),
            timestamp : 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request::price_updated_at(&v0),
        };
        0x2::event::emit<PriceUpdatedEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

