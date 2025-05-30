module 0x48240cf0bf26ca97c4aa8b46364ef3bc42a385adf5b7ede35ff83978b755182b::oracle {
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

    entry fun update_supra_oracle(arg0: &mut Oracle, arg1: &ManagerCap, arg2: u32) {
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"supra_pair"))) {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u32>(&mut arg0.id, 0x1::string::utf8(b"supra_pair")) = arg2;
        } else {
            0x2::dynamic_field::add<0x1::string::String, u32>(&mut arg0.id, 0x1::string::utf8(b"supra_pair"), arg2);
        };
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

    entry fun update_with_supra(arg0: &mut Oracle, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x48240cf0bf26ca97c4aa8b46364ef3bc42a385adf5b7ede35ff83978b755182b::supra::retrieve_price(arg1, *0x2::dynamic_field::borrow<0x1::string::String, u32>(&arg0.id, 0x1::string::utf8(b"supra_pair")));
        assert!(v0 > 0, 2);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        assert!(v3 - (v2 as u64) < arg0.time_interval, 1);
        let v4 = (arg0.decimal as u16);
        let v5 = if (v1 > v4) {
            v0 / (0x2::math::pow(10, ((v1 - v4) as u8)) as u128)
        } else {
            v0 * (0x2::math::pow(10, ((v4 - v1) as u8)) as u128)
        };
        let v6 = (v5 as u64);
        arg0.price = v6;
        arg0.twap_price = v6;
        arg0.ts_ms = v3;
        arg0.epoch = 0x2::tx_context::epoch(arg3);
        let v7 = PriceEvent{
            id    : 0x2::object::id<Oracle>(arg0),
            price : v6,
            ts_ms : v3,
        };
        0x2::event::emit<PriceEvent>(v7);
    }

    entry fun update_with_switchboard(arg0: &mut Oracle, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.switchboard), 3);
        let v0 = 0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.switchboard) == &v0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let (v2, v3) = 0x48240cf0bf26ca97c4aa8b46364ef3bc42a385adf5b7ede35ff83978b755182b::switchboard_feed_parser::log_aggregator_info(arg1);
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

