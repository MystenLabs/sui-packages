module 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::aggregator {
    struct NewPriceAggregator has copy, drop {
        aggregator_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        weight_threshold: u64,
        outlier_tolerance_bps: u64,
    }

    struct WeightUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        rule_type: 0x1::ascii::String,
        weight: u8,
    }

    struct ThresholdUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        weight_threshold: u64,
    }

    struct OutlierToleranceUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        outlier_tolerance_bps: u64,
    }

    struct PriceAggregated has copy, drop {
        aggregator_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        sources: vector<0x1::ascii::String>,
        prices: vector<u128>,
        weights: vector<u8>,
        current_threshold: u64,
        result: u128,
        timestamp_ms: u64,
    }

    struct HistoricalPriceRegistered has copy, drop {
        aggregator_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        sources: vector<0x1::ascii::String>,
        prices: vector<u128>,
        weights: vector<u8>,
        current_threshold: u64,
        result: u128,
        timestamp_ms: u64,
    }

    struct PriceAggregator has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
        weight_threshold: u64,
        outlier_tolerance: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        latest_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        last_update_ms: u64,
        history_count: u64,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PriceAggregator {
        if (arg1 == 0) {
            abort 13906834642495078405
        };
        let v0 = 0x2::object::new(arg3);
        let v1 = NewPriceAggregator{
            aggregator_id         : 0x2::object::uid_to_inner(&v0),
            symbol                : arg0,
            weight_threshold      : arg1,
            outlier_tolerance_bps : arg2,
        };
        0x2::event::emit<NewPriceAggregator>(v1);
        PriceAggregator{
            id                : v0,
            symbol            : arg0,
            weights           : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
            weight_threshold  : arg1,
            outlier_tolerance : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg2),
            latest_price      : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            last_update_ms    : 0,
            history_count     : 0,
        }
    }

    fun aggregate_collector(arg0: &PriceAggregator, arg1: 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg2: bool) : (vector<0x1::ascii::String>, vector<u128>, vector<u8>, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, 0x1::option::Option<u64>) {
        if (0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(&arg1) != arg0.symbol) {
            abort 13906835385524682761
        };
        let v0 = &mut arg1;
        remove_outliers(arg0, v0);
        let (_, v2) = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::unpack(arg1);
        let v3 = v2;
        let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v5 = vector[];
        let v6 = b"";
        let v7 = 0x1::option::none<u64>();
        let v8 = false;
        let v9 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        let v10 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(&v3);
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v10);
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::type_name::TypeName>(&v10)) {
            let v12 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v10);
            let v13 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(&v3, &v12);
            let v14 = *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg0.weights, &v12);
            let v15 = if (0x1::option::is_some<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>(v13)) {
                let v16 = 0x1::option::borrow<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>(v13);
                let v17 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::observation_price(v16);
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, v12);
                0x1::vector::push_back<u128>(&mut v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v17));
                0x1::vector::push_back<u8>(&mut v6, v14);
                let v18 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::observation_timestamp_ms(v16);
                if (0x1::option::is_some<u64>(&v18)) {
                    if (!arg2) {
                        abort 13906835488604422161
                    };
                    if (0x1::option::is_some<u64>(&v7)) {
                        if (*0x1::option::borrow<u64>(&v7) != *0x1::option::borrow<u64>(&v18)) {
                            abort 13906835505784160271
                        };
                    } else {
                        v7 = 0x1::option::some<u64>(*0x1::option::borrow<u64>(&v18));
                    };
                } else {
                    v8 = true;
                };
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v9, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v17, (v14 as u64)))
            } else {
                v9
            };
            v9 = v15;
            v11 = v11 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v10);
        let v19 = 0;
        0x1::vector::reverse<u8>(&mut v6);
        let v20 = 0;
        while (v20 < 0x1::vector::length<u8>(&v6)) {
            v19 = v19 + 0x1::vector::pop_back<u8>(&mut v6);
            v20 = v20 + 1;
        };
        0x1::vector::destroy_empty<u8>(v6);
        let v21 = (v19 as u64);
        if (v21 < arg0.weight_threshold) {
            abort 13906835565913178119
        };
        if (arg2 && (v8 || 0x1::option::is_none<u64>(&v7))) {
            abort 13906835574503505933
        };
        let v22 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v4);
        let v23 = 0;
        while (v23 < 0x1::vector::length<0x1::type_name::TypeName>(&v4)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v22, 0x1::type_name::into_string(0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v4)));
            v23 = v23 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v4);
        (v22, v5, v6, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(v9, v21), v7)
    }

    public(friend) fun aggregate_into(arg0: &mut PriceAggregator, arg1: 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg2: u64) {
        let (v0, v1, v2, v3, _) = aggregate_collector(arg0, arg1, false);
        arg0.latest_price = v3;
        arg0.last_update_ms = arg2;
        record_history(arg0, arg2, v3);
        let v5 = PriceAggregated{
            aggregator_id     : 0x2::object::id<PriceAggregator>(arg0),
            symbol            : arg0.symbol,
            sources           : v0,
            prices            : v1,
            weights           : v2,
            current_threshold : arg0.weight_threshold,
            result            : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v3),
            timestamp_ms      : arg2,
        };
        0x2::event::emit<PriceAggregated>(v5);
    }

    public fun has_price_at_timestamp(arg0: &PriceAggregator, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg0.id, arg1)
    }

    public fun history_count(arg0: &PriceAggregator) : u64 {
        arg0.history_count
    }

    public fun last_update_ms(arg0: &PriceAggregator) : u64 {
        arg0.last_update_ms
    }

    public fun latest_price(arg0: &PriceAggregator) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.latest_price
    }

    public fun outlier_tolerance(arg0: &PriceAggregator) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.outlier_tolerance
    }

    public fun price_at_timestamp(arg0: &PriceAggregator, arg1: 0x1::option::Option<u64>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        if (0x1::option::is_none<u64>(&arg1)) {
            return arg0.latest_price
        };
        let v0 = 0x1::option::destroy_some<u64>(arg1);
        if (!has_price_at_timestamp(arg0, v0)) {
            abort 13906835265265729547
        };
        *0x2::dynamic_field::borrow<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg0.id, v0)
    }

    fun record_history(arg0: &mut PriceAggregator, arg1: u64, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        if (0x2::dynamic_field::exists_with_type<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&mut arg0.id, arg1, arg2);
            arg0.history_count = arg0.history_count + 1;
        };
    }

    public(friend) fun register_history_into(arg0: &mut PriceAggregator, arg1: 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector) : u64 {
        let (v0, v1, v2, v3, v4) = aggregate_collector(arg0, arg1, true);
        let v5 = 0x1::option::destroy_some<u64>(v4);
        record_history(arg0, v5, v3);
        let v6 = HistoricalPriceRegistered{
            aggregator_id     : 0x2::object::id<PriceAggregator>(arg0),
            symbol            : arg0.symbol,
            sources           : v0,
            prices            : v1,
            weights           : v2,
            current_threshold : arg0.weight_threshold,
            result            : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v3),
            timestamp_ms      : v5,
        };
        0x2::event::emit<HistoricalPriceRegistered>(v6);
        v5
    }

    fun remove_outliers(arg0: &PriceAggregator, arg1: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, u8>(&arg0.weights);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1), 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2))) {
                v3 = false;
                /* label 6 */
                if (!v3) {
                    abort 13906835660402065409
                };
                let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
                let v5 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1));
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v5);
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
                    let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5);
                    if (0x1::option::is_none<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1), &v7))) {
                        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, v7);
                    };
                    v6 = v6 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
                let v8 = &v4;
                let v9 = 0;
                while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(v8)) {
                    0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::remove(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v8, v9));
                    v9 = v9 + 1;
                };
                let v10 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1));
                let v11 = 0;
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v10);
                let v12 = 0;
                while (v12 < 0x1::vector::length<0x1::type_name::TypeName>(&v10)) {
                    let v13 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v10);
                    let v14 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(&arg0.weights, &v13);
                    let v15 = if (0x1::option::is_some<u8>(&v14)) {
                        0x1::option::destroy_some<u8>(v14)
                    } else {
                        0x1::option::destroy_none<u8>(v14);
                        0
                    };
                    v11 = v11 + (v15 as u64);
                    v12 = v12 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v10);
                if (v11 == 0) {
                    abort 13906835716237033479
                };
                let v16 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v10);
                let v17 = 0;
                while (v17 < 0x1::vector::length<0x1::type_name::TypeName>(&v10)) {
                    let v18 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v10);
                    let v19 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1), &v18);
                    let v20 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(&arg0.weights, &v18);
                    let v21 = if (0x1::option::is_some<u8>(&v20)) {
                        0x1::option::destroy_some<u8>(v20)
                    } else {
                        0x1::option::destroy_none<u8>(v20);
                        0
                    };
                    let v22 = if (0x1::option::is_some<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>(v19)) {
                        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v16, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::observation_price(0x1::option::borrow<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>(v19)), (v21 as u64)))
                    } else {
                        v16
                    };
                    v16 = v22;
                    v17 = v17 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v10);
                let v23 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(v16, v11);
                let v24 = 0x1::vector::empty<0x1::type_name::TypeName>();
                let v25 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1));
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v25);
                let v26 = 0;
                while (v26 < 0x1::vector::length<0x1::type_name::TypeName>(&v25)) {
                    let v27 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v25);
                    let v28 = &v27;
                    if (!0x2::vec_map::contains<0x1::type_name::TypeName, u8>(&arg0.weights, v28) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::diff(v23, 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::observation_price(0x1::option::borrow<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceObservation>>(0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::contents(arg1), v28)))), v23), arg0.outlier_tolerance)) {
                        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v24, v27);
                    };
                    v26 = v26 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v25);
                let v29 = &v24;
                let v30 = 0;
                while (v30 < 0x1::vector::length<0x1::type_name::TypeName>(v29)) {
                    0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::remove(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v29, v30));
                    v30 = v30 + 1;
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = true;
        /* goto 6 */
    }

    public fun remove_price_at_timestamp(arg0: &mut PriceAggregator, arg1: u64) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        if (!has_price_at_timestamp(arg0, arg1)) {
            abort 13906835329690238987
        };
        arg0.history_count = arg0.history_count - 1;
        0x2::dynamic_field::remove<u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&mut arg0.id, arg1)
    }

    public(friend) fun set_outlier_tolerance(arg0: &mut PriceAggregator, arg1: u64) {
        arg0.outlier_tolerance = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg1);
        let v0 = OutlierToleranceUpdated{
            aggregator_id         : 0x2::object::id<PriceAggregator>(arg0),
            symbol                : arg0.symbol,
            outlier_tolerance_bps : arg1,
        };
        0x2::event::emit<OutlierToleranceUpdated>(v0);
    }

    public(friend) fun set_rule_weight<T0>(arg0: &mut PriceAggregator, arg1: u8) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &mut arg0.weights;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u8>(v1, &v0)) {
            if (arg1 > 0) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u8>(v1, &v0) = arg1;
            } else {
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u8>(v1, &v0);
            };
        } else {
            assert!(arg1 > 0, 13906834797113769987);
            0x2::vec_map::insert<0x1::type_name::TypeName, u8>(v1, v0, arg1);
        };
        let v4 = WeightUpdated{
            aggregator_id : 0x2::object::id<PriceAggregator>(arg0),
            symbol        : arg0.symbol,
            rule_type     : 0x1::type_name::into_string(v0),
            weight        : arg1,
        };
        0x2::event::emit<WeightUpdated>(v4);
    }

    public(friend) fun set_weight_threshold(arg0: &mut PriceAggregator, arg1: u64) {
        if (arg1 == 0) {
            abort 13906834848653508613
        };
        arg0.weight_threshold = arg1;
        let v0 = ThresholdUpdated{
            aggregator_id    : 0x2::object::id<PriceAggregator>(arg0),
            symbol           : arg0.symbol,
            weight_threshold : arg1,
        };
        0x2::event::emit<ThresholdUpdated>(v0);
    }

    public fun symbol(arg0: &PriceAggregator) : 0x1::string::String {
        arg0.symbol
    }

    public fun weight_threshold(arg0: &PriceAggregator) : u64 {
        arg0.weight_threshold
    }

    public fun weights(arg0: &PriceAggregator) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u8> {
        &arg0.weights
    }

    // decompiled from Move bytecode v7
}

