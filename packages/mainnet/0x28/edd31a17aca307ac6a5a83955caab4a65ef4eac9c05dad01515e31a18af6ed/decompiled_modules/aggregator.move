module 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::aggregator {
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
        outlier_tolerance: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float,
    }

    public fun new<T0>(arg0: &mut 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::ListingCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PriceAggregator<T0> {
        if (arg1 == 0) {
            err_invalid_threshold();
        };
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = PriceAggregator<T0>{
            id                : v0,
            weights           : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
            weight_threshold  : arg1,
            outlier_tolerance : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(arg2),
        };
        let v3 = NewPriceAggregator{
            aggregator_id         : v1,
            coin_type             : 0x1::type_name::into_string(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::register<T0>(arg0, v1)),
            weight_threshold      : arg1,
            outlier_tolerance_bps : arg2,
        };
        0x2::event::emit<NewPriceAggregator>(v3);
        v2
    }

    public fun aggregate<T0>(arg0: &PriceAggregator<T0>, arg1: 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::PriceCollector<T0>) : 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::PriceResult<T0> {
        let v0 = &mut arg1;
        remove_outlier<T0>(arg0, v0);
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::contents<T0>(&arg1));
        let v2 = 0;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            v2 = v2 + (*0x2::vec_map::get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v4) as u64);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        if (v2 < weight_threshold<T0>(arg0)) {
            err_total_weight_not_enough();
        };
        let v5 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v6 = vector[];
        let v7 = b"";
        let v8 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::zero();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v10 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            let v11 = *0x2::vec_map::get<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::contents<T0>(&arg1), &v10);
            let v12 = *0x2::vec_map::get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v10);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v5, v10);
            0x1::vector::push_back<u128>(&mut v6, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::to_scaled_val(v11));
            0x1::vector::push_back<u8>(&mut v7, v12);
            v8 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::add(v8, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::mul_u64(v11, (v12 as u64)));
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v1);
        let v13 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::div_u64(v8, v2);
        let v14 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v5);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::type_name::TypeName>(&v5)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v14, 0x1::type_name::into_string(0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v5)));
            v15 = v15 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v5);
        let v16 = PriceAggregated<T0>{
            aggregator_id     : 0x2::object::id<PriceAggregator<T0>>(arg0),
            sources           : v14,
            prices            : v6,
            weights           : v7,
            current_threshold : arg0.weight_threshold,
            result            : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::to_scaled_val(v13),
        };
        0x2::event::emit<PriceAggregated<T0>>(v16);
        0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result::new<T0>(v13)
    }

    entry fun create<T0>(arg0: &mut 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::ListingCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PriceAggregator<T0>>(new<T0>(arg0, arg1, arg2, arg3));
    }

    fun err_invalid_threshold() {
        abort 203
    }

    fun err_invalid_weight() {
        abort 202
    }

    fun err_total_weight_not_enough() {
        abort 201
    }

    public fun outlier_tolerance<T0>(arg0: &PriceAggregator<T0>) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float {
        arg0.outlier_tolerance
    }

    fun remove_outlier<T0>(arg0: &PriceAggregator<T0>, arg1: &mut 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::PriceCollector<T0>) {
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::contents<T0>(arg1));
        let v1 = 0;
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0);
            let v4 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v3);
            let v5 = if (0x1::option::is_some<u8>(&v4)) {
                0x1::option::destroy_some<u8>(v4)
            } else {
                0x1::option::destroy_none<u8>(v4);
                0
            };
            v1 = v1 + (v5 as u64);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v0);
        if (v1 == 0) {
            err_total_weight_not_enough();
        };
        let v6 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::zero();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v0);
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v8 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v0);
            let v9 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(weights<T0>(arg0), &v8);
            let v10 = if (0x1::option::is_some<u8>(&v9)) {
                0x1::option::destroy_some<u8>(v9)
            } else {
                0x1::option::destroy_none<u8>(v9);
                0
            };
            v6 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::add(v6, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::mul_u64(*0x2::vec_map::get<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::contents<T0>(arg1), &v8), (v10 as u64)));
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v0);
        let v11 = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::div_u64(v6, v1);
        let v12 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v13 = 0x2::vec_map::keys<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::contents<T0>(arg1));
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut v13);
        let v14 = 0;
        while (v14 < 0x1::vector::length<0x1::type_name::TypeName>(&v13)) {
            let v15 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v13);
            let v16 = &v15;
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, u8>(weights<T0>(arg0), v16) || 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::gt(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::div(0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::diff(v11, *0x2::vec_map::get<0x1::type_name::TypeName, 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float>(0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::contents<T0>(arg1), v16)), v11), outlier_tolerance<T0>(arg0))) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v12, v15);
            };
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(v13);
        let v17 = &v12;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::type_name::TypeName>(v17)) {
            0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::collector::remove<T0>(arg1, 0x1::vector::borrow<0x1::type_name::TypeName>(v17, v18));
            v18 = v18 + 1;
        };
    }

    public fun set_outlier_tolerance<T0>(arg0: &mut PriceAggregator<T0>, arg1: &0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::ListingCap, arg2: u64) {
        arg0.outlier_tolerance = 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::from_bps(arg2);
        let v0 = OutlierToleranceUpdated<T0>{
            aggregator_id         : 0x2::object::id<PriceAggregator<T0>>(arg0),
            outlier_tolerance_bps : arg2,
        };
        0x2::event::emit<OutlierToleranceUpdated<T0>>(v0);
    }

    public fun set_rule_weight<T0, T1>(arg0: &mut PriceAggregator<T0>, arg1: &0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::ListingCap, arg2: u8) {
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

    public fun set_weight_threshold<T0>(arg0: &mut PriceAggregator<T0>, arg1: &0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::listing::ListingCap, arg2: u64) {
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

