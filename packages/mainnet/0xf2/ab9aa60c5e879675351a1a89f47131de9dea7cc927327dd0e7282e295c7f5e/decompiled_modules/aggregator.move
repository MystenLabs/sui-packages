module 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::aggregator {
    struct NewPriceAggregator has copy, drop {
        aggregator_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        weight_threshold: u64,
        outlier_tolerance_bps: u64,
    }

    struct WeightUpdated<phantom T0> has copy, drop {
        aggregator_id: 0x2::object::ID,
        rule_type: 0x1::ascii::String,
        weight: u8,
    }

    struct ThresholdUpdated<phantom T0> has copy, drop {
        aggregator_id: 0x2::object::ID,
        weight_threshold: u64,
    }

    struct OutlierToleranceUpdated<phantom T0> has copy, drop {
        aggregator_id: 0x2::object::ID,
        outlier_tolerance_bps: u64,
    }

    struct PriceAggregated<phantom T0> has copy, drop {
        aggregator_id: 0x2::object::ID,
        sources: vector<0x1::ascii::String>,
        prices: vector<u128>,
        weights: vector<u8>,
        current_threshold: u64,
        result: u128,
    }

    struct PriceAggregator<phantom T0> has store, key {
        id: 0x2::object::UID,
        weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
        weight_threshold: u64,
        outlier_tolerance: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
    }

    public fun new<T0>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        if (arg1 == 0) {
            err_invalid_threshold();
        };
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = PriceAggregator<T0>{
            id                : v0,
            weights           : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
            weight_threshold  : arg1,
            outlier_tolerance : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg2),
        };
        let v3 = NewPriceAggregator{
            aggregator_id         : v1,
            coin_type             : 0x1::type_name::into_string(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::register<T0>(arg0, v1)),
            weight_threshold      : arg1,
            outlier_tolerance_bps : arg2,
        };
        0x2::event::emit<NewPriceAggregator>(v3);
        v2
    }

    public fun aggregate<T0>(arg0: &PriceAggregator<T0>, arg1: 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>) : 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0> {
        let v0 = &mut arg1;
        remove_outliers<T0>(arg0, v0);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = vector[];
        let v3 = b"";
        let v4 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        let v5 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(&arg1));
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5);
            let v8 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(&arg1), &v7);
            let v9 = *0x2::vec_map::get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v7);
            let v10 = if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v8)) {
                let v11 = *0x1::option::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v8);
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1, v7);
                0x1::vector::push_back<u128>(&mut v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v11));
                0x1::vector::push_back<u8>(&mut v3, v9);
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v11, (v9 as u64)))
            } else {
                v4
            };
            v4 = v10;
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
        let v12 = 0;
        0x1::vector::reverse<u8>(&mut v3);
        let v13 = 0;
        while (v13 < 0x1::vector::length<u8>(&v3)) {
            v12 = v12 + 0x1::vector::pop_back<u8>(&mut v3);
            v13 = v13 + 1;
        };
        0x1::vector::destroy_empty<u8>(v3);
        let v14 = (v12 as u64);
        if (v14 < weight_threshold<T0>(arg0)) {
            err_total_weight_not_enough();
        };
        let v15 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(v4, v14);
        let v16 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v16, 0x1::type_name::into_string(0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1)));
            v17 = v17 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        let v18 = PriceAggregated<T0>{
            aggregator_id     : 0x2::object::id<PriceAggregator<T0>>(arg0),
            sources           : v16,
            prices            : v2,
            weights           : v3,
            current_threshold : arg0.weight_threshold,
            result            : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::to_scaled_val(v15),
        };
        0x2::event::emit<PriceAggregated<T0>>(v18);
        0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::new<T0>(v15)
    }

    entry fun create<T0>(arg0: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PriceAggregator<T0>>(new<T0>(arg0, arg1, arg2, arg3));
    }

    fun err_invalid_threshold() {
        abort 203
    }

    fun err_invalid_weight() {
        abort 202
    }

    fun err_missing_price_source() {
        abort 201
    }

    fun err_total_weight_not_enough() {
        abort 204
    }

    public fun outlier_tolerance<T0>(arg0: &PriceAggregator<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.outlier_tolerance
    }

    fun remove_outliers<T0>(arg0: &PriceAggregator<T0>, arg1: &mut 0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::PriceCollector<T0>) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, u8>(&arg0.weights);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1), 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2))) {
                v3 = false;
                /* label 6 */
                if (!v3) {
                    err_missing_price_source();
                };
                let v4 = 0x1::vector::empty<0x1::type_name::TypeName>();
                let v5 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1));
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v5);
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
                    let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5);
                    if (0x1::option::is_none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1), &v7))) {
                        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v4, v7);
                    };
                    v6 = v6 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
                let v8 = &v4;
                let v9 = 0;
                while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(v8)) {
                    0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::remove<T0>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v8, v9));
                    v9 = v9 + 1;
                };
                let v10 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1));
                let v11 = 0;
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v10);
                let v12 = 0;
                while (v12 < 0x1::vector::length<0x1::type_name::TypeName>(&v10)) {
                    let v13 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v10);
                    let v14 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v13);
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
                    err_total_weight_not_enough();
                };
                let v16 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v10);
                let v17 = 0;
                while (v17 < 0x1::vector::length<0x1::type_name::TypeName>(&v10)) {
                    let v18 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v10);
                    let v19 = 0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1), &v18);
                    let v20 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v18);
                    let v21 = if (0x1::option::is_some<u8>(&v20)) {
                        0x1::option::destroy_some<u8>(v20)
                    } else {
                        0x1::option::destroy_none<u8>(v20);
                        0
                    };
                    let v22 = if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v19)) {
                        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v16, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(*0x1::option::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v19), (v21 as u64)))
                    } else {
                        v16
                    };
                    v16 = v22;
                    v17 = v17 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v10);
                let v23 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(v16, v11);
                let v24 = 0x1::vector::empty<0x1::type_name::TypeName>();
                let v25 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1));
                0x1::vector::reverse<0x1::type_name::TypeName>(&mut v25);
                let v26 = 0;
                while (v26 < 0x1::vector::length<0x1::type_name::TypeName>(&v25)) {
                    let v27 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v25);
                    let v28 = &v27;
                    if (!0x2::vec_map::contains<0x1::type_name::TypeName, u8>(weights<T0>(arg0), v28) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::diff(v23, *0x1::option::borrow<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(0x2::vec_map::get<0x1::type_name::TypeName, 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>>(0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::contents<T0>(arg1), v28))), v23), outlier_tolerance<T0>(arg0))) {
                        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v24, v27);
                    };
                    v26 = v26 + 1;
                };
                0x1::vector::destroy_empty<0x1::type_name::TypeName>(v25);
                let v29 = &v24;
                let v30 = 0;
                while (v30 < 0x1::vector::length<0x1::type_name::TypeName>(v29)) {
                    0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::collector::remove<T0>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v29, v30));
                    v30 = v30 + 1;
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = true;
        /* goto 6 */
    }

    public fun set_outlier_tolerance<T0>(arg0: &mut PriceAggregator<T0>, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u64) {
        arg0.outlier_tolerance = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg2);
        let v0 = OutlierToleranceUpdated<T0>{
            aggregator_id         : 0x2::object::id<PriceAggregator<T0>>(arg0),
            outlier_tolerance_bps : arg2,
        };
        0x2::event::emit<OutlierToleranceUpdated<T0>>(v0);
    }

    public fun set_rule_weight<T0, T1>(arg0: &mut PriceAggregator<T0>, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u8) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = &mut arg0.weights;
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u8>(v1, &v0)) {
            if (arg2 > 0) {
                *0x2::vec_map::get_mut<0x1::type_name::TypeName, u8>(v1, &v0) = arg2;
            } else {
                let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u8>(v1, &v0);
            };
        } else if (arg2 > 0) {
            0x2::vec_map::insert<0x1::type_name::TypeName, u8>(v1, v0, arg2);
        } else {
            err_invalid_weight();
        };
        let v4 = WeightUpdated<T0>{
            aggregator_id : 0x2::object::id<PriceAggregator<T0>>(arg0),
            rule_type     : 0x1::type_name::into_string(v0),
            weight        : arg2,
        };
        0x2::event::emit<WeightUpdated<T0>>(v4);
    }

    public fun set_weight_threshold<T0>(arg0: &mut PriceAggregator<T0>, arg1: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::listing::ListingCap, arg2: u64) {
        if (arg2 == 0) {
            err_invalid_threshold();
        };
        arg0.weight_threshold = arg2;
        let v0 = ThresholdUpdated<T0>{
            aggregator_id    : 0x2::object::id<PriceAggregator<T0>>(arg0),
            weight_threshold : arg2,
        };
        0x2::event::emit<ThresholdUpdated<T0>>(v0);
    }

    public fun weight_threshold<T0>(arg0: &PriceAggregator<T0>) : u64 {
        arg0.weight_threshold
    }

    public fun weights<T0>(arg0: &PriceAggregator<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, u8> {
        &arg0.weights
    }

    // decompiled from Move bytecode v6
}

