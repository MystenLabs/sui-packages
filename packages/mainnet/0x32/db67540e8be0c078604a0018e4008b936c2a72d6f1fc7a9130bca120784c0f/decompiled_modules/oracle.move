module 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Oracle has key {
        id: 0x2::object::UID,
        base_token: 0x1::ascii::String,
        quote_token: 0x1::ascii::String,
        base_token_type: 0x1::type_name::TypeName,
        quote_token_type: 0x1::type_name::TypeName,
        decimal: u64,
        price: u64,
        twap_price: u64,
        ts_ms: u64,
        epoch: u64,
        time_interval: u64,
        switchboard: 0x1::option::Option<0x2::object::ID>,
        pyth: 0x1::option::Option<0x2::object::ID>,
    }

    struct PriceEvent has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        ts_ms: u64,
    }

    public entry fun copy_manager_cap(arg0: &ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ManagerCap>(v0, arg1);
    }

    public fun get_oracle(arg0: &Oracle) : (u64, u64, u64, u64) {
        (arg0.price, arg0.decimal, arg0.ts_ms, arg0.epoch)
    }

    public fun get_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.price, arg0.decimal)
    }

    public fun get_token(arg0: &Oracle) : (0x1::ascii::String, 0x1::ascii::String, 0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.base_token, arg0.quote_token, arg0.base_token_type, arg0.quote_token_type)
    }

    public fun get_twap_price(arg0: &Oracle, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.twap_price, arg0.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_oracle<T0, T1>(arg0: &ManagerCap, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id               : 0x2::object::new(arg4),
            base_token       : arg1,
            quote_token      : arg2,
            base_token_type  : 0x1::type_name::get<T0>(),
            quote_token_type : 0x1::type_name::get<T1>(),
            decimal          : arg3,
            price            : 0,
            twap_price       : 0,
            ts_ms            : 0,
            epoch            : 0x2::tx_context::epoch(arg4),
            time_interval    : 300000,
            switchboard      : 0x1::option::none<0x2::object::ID>(),
            pyth             : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Oracle>(v0);
    }

    public entry fun update(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.price = arg2;
        arg0.twap_price = arg3;
        arg0.ts_ms = v0;
        arg0.epoch = 0x2::tx_context::epoch(arg5);
        let v1 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : arg2,
            ts_ms : v0,
        };
        0x2::event::emit<PriceEvent>(v1);
    }

    entry fun update_pyth_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        arg0.pyth = 0x1::option::some<0x2::object::ID>(0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2));
    }

    entry fun update_switchboard_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        arg0.switchboard = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg2));
    }

    public entry fun update_time_interval(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u64) {
        arg0.time_interval = arg2;
    }

    public entry fun update_token(arg0: &mut Oracle, arg1: &ManagerCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        arg0.quote_token = arg2;
        arg0.base_token = arg3;
    }

    entry fun update_with_pyth(arg0: &mut Oracle, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::state::State, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pyth), 5);
        let v0 = 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.pyth) == &v0, 6);
        let (v1, v2) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_price(arg1, arg2, arg3);
        assert!(v1 > 0, 2);
        let v3 = if (v2 > arg0.decimal) {
            v1 / 0x2::math::pow(10, ((v2 - arg0.decimal) as u8))
        } else {
            v1 * 0x2::math::pow(10, ((arg0.decimal - v2) as u8))
        };
        arg0.price = v3;
        let v4 = 0x2::clock::timestamp_ms(arg3);
        arg0.ts_ms = v4;
        arg0.epoch = 0x2::tx_context::epoch(arg4);
        let (v5, v6, v7) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::pyth_parser::get_ema_price(arg2);
        assert!(v5 > 0, 2);
        assert!(v4 / 1000 - v7 < arg0.time_interval, 1);
        let v8 = if (v6 > arg0.decimal) {
            v5 / 0x2::math::pow(10, ((v6 - arg0.decimal) as u8))
        } else {
            v5 * 0x2::math::pow(10, ((arg0.decimal - v6) as u8))
        };
        arg0.twap_price = v8;
        let v9 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v8,
            ts_ms : v4,
        };
        0x2::event::emit<PriceEvent>(v9);
    }

    entry fun update_with_switchboard(arg0: &mut Oracle, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.switchboard), 3);
        let v0 = 0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.switchboard) == &v0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let (v2, v3) = 0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::switchboard_feed_parser::log_aggregator_info(arg1);
        assert!(v2 > 0, 2);
        let v4 = (v3 as u64);
        let v5 = if (v4 > arg0.decimal) {
            v2 / (0x2::math::pow(10, ((v4 - arg0.decimal) as u8)) as u128)
        } else {
            v2 * (0x2::math::pow(10, ((arg0.decimal - v4) as u8)) as u128)
        };
        let v6 = (v5 as u64);
        arg0.price = v6;
        arg0.twap_price = v6;
        arg0.ts_ms = v1;
        arg0.epoch = 0x2::tx_context::epoch(arg3);
        let v7 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v6,
            ts_ms : v1,
        };
        0x2::event::emit<PriceEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

