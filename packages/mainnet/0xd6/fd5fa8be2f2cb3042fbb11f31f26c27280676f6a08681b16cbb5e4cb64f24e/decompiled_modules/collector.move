module 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector {
    struct PriceCollector {
        symbol: 0x1::string::String,
        contents: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>,
    }

    struct PriceObservation has copy, drop, store {
        price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        timestamp_ms: 0x1::option::Option<u64>,
    }

    public(friend) fun remove(arg0: &mut PriceCollector, arg1: &0x1::type_name::TypeName) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>(&arg0.contents, arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>(&mut arg0.contents, arg1);
        };
    }

    public fun collect<T0: drop>(arg0: &mut PriceCollector, arg1: T0, arg2: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>) {
        let v0 = if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg2)) {
            let v1 = PriceObservation{
                price        : 0x1::option::destroy_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(arg2),
                timestamp_ms : 0x1::option::none<u64>(),
            };
            0x1::option::some<PriceObservation>(v1)
        } else {
            0x1::option::destroy_none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(arg2);
            0x1::option::none<PriceObservation>()
        };
        upsert<T0>(arg0, v0);
    }

    public fun collect_at<T0: drop>(arg0: &mut PriceCollector, arg1: T0, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: u64) {
        let v0 = PriceObservation{
            price        : arg2,
            timestamp_ms : 0x1::option::some<u64>(arg3),
        };
        upsert<T0>(arg0, 0x1::option::some<PriceObservation>(v0));
    }

    public fun contents(arg0: &PriceCollector) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>> {
        &arg0.contents
    }

    public(friend) fun new(arg0: 0x1::string::String) : PriceCollector {
        PriceCollector{
            symbol   : arg0,
            contents : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>(),
        }
    }

    public fun observation_price(arg0: &PriceObservation) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.price
    }

    public fun observation_timestamp_ms(arg0: &PriceObservation) : 0x1::option::Option<u64> {
        arg0.timestamp_ms
    }

    public fun symbol(arg0: &PriceCollector) : 0x1::string::String {
        arg0.symbol
    }

    public(friend) fun unpack(arg0: PriceCollector) : (0x1::string::String, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>) {
        let PriceCollector {
            symbol   : v0,
            contents : v1,
        } = arg0;
        (v0, v1)
    }

    fun upsert<T0: drop>(arg0: &mut PriceCollector, arg1: 0x1::option::Option<PriceObservation>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>(&arg0.contents, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>(&mut arg0.contents, &v0) = arg1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::option::Option<PriceObservation>>(&mut arg0.contents, v0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

