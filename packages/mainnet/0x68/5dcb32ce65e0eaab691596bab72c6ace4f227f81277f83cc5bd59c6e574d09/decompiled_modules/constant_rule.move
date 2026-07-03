module 0x685dcb32ce65e0eaab691596bab72c6ace4f227f81277f83cc5bd59c6e574d09::constant_rule {
    struct ConstantRule has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        prices: 0x2::vec_map::VecMap<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>,
    }

    struct ConstantPriceSet has copy, drop {
        symbol: 0x1::string::String,
        scaled_price: 0x1::option::Option<u128>,
    }

    public fun feed(arg0: &mut 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::PriceCollector, arg1: &Config) {
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::symbol(arg0);
        let v1 = if (0x2::vec_map::contains<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg1.prices, &v0)) {
            0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(*0x2::vec_map::get<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg1.prices, &v0))
        } else {
            0x1::option::none<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>()
        };
        let v2 = ConstantRule{dummy_field: false};
        0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::collector::collect<ConstantRule>(arg0, v2, v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id     : 0x2::object::new(arg0),
            prices : 0x2::vec_map::empty<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun set_constant_price(arg0: &mut Config, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::ListingCap, arg2: 0x1::string::String, arg3: 0x1::option::Option<u128>) {
        let v0 = &mut arg0.prices;
        if (0x1::option::is_none<u128>(&arg3)) {
            if (0x2::vec_map::contains<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v0, &arg2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v0, &arg2);
            };
        } else if (0x2::vec_map::contains<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v0, &arg2)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v0, &arg2) = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(*0x1::option::borrow<u128>(&arg3));
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(v0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(*0x1::option::borrow<u128>(&arg3)));
        };
        let v3 = ConstantPriceSet{
            symbol       : arg2,
            scaled_price : arg3,
        };
        0x2::event::emit<ConstantPriceSet>(v3);
    }

    // decompiled from Move bytecode v7
}

