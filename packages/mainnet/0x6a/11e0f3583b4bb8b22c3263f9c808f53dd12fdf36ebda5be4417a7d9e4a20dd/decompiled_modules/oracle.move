module 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::oracle {
    struct ManagerCap has key {
        id: 0x2::object::UID,
    }

    struct Oracle<phantom T0> has key {
        id: 0x2::object::UID,
        quote_token: 0x1::ascii::String,
        base_token: 0x1::ascii::String,
        decimal: u64,
        price: u64,
        twap_price: u64,
        ts_ms: u64,
        epoch: u64,
        time_interval: u64,
        switchboard: 0x1::option::Option<0x2::object::ID>,
    }

    struct PriceEvent has copy, drop {
        token: 0x1::ascii::String,
        price: u64,
        ts_ms: u64,
        epoch: u64,
    }

    public entry fun copy_manager_cap<T0>(arg0: &ManagerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ManagerCap>(v0, arg1);
    }

    public fun get_oracle<T0>(arg0: &Oracle<T0>) : (u64, u64, u64, u64) {
        (arg0.price, arg0.decimal, arg0.ts_ms, arg0.epoch)
    }

    public fun get_price<T0>(arg0: &Oracle<T0>, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.price, arg0.decimal)
    }

    public fun get_twap_price<T0>(arg0: &Oracle<T0>, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.twap_price, arg0.decimal)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ManagerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_oracle<T0>(arg0: &ManagerCap, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle<T0>{
            id            : 0x2::object::new(arg4),
            quote_token   : arg1,
            base_token    : arg2,
            decimal       : arg3,
            price         : 0,
            twap_price    : 0,
            ts_ms         : 0,
            epoch         : 0x2::tx_context::epoch(arg4),
            time_interval : 300000,
            switchboard   : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Oracle<T0>>(v0);
    }

    public entry fun update<T0>(arg0: &mut Oracle<T0>, arg1: &ManagerCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(arg3 > 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.price = arg2;
        arg0.twap_price = arg3;
        arg0.ts_ms = v0;
        arg0.epoch = 0x2::tx_context::epoch(arg5);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = PriceEvent{
            token : *0x1::type_name::borrow_string(&v1),
            price : arg2,
            ts_ms : v0,
            epoch : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<PriceEvent>(v2);
    }

    entry fun update_switchboard_oracle<T0>(arg0: &mut Oracle<T0>, arg1: &ManagerCap, arg2: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        arg0.switchboard = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg2));
    }

    public entry fun update_time_interval<T0>(arg0: &mut Oracle<T0>, arg1: &ManagerCap, arg2: u64) {
        arg0.time_interval = arg2;
    }

    entry fun update_with_switchboard<T0>(arg0: &mut Oracle<T0>, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.switchboard), 3);
        let v0 = 0x2::object::id<0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator>(arg1);
        assert!(0x1::option::borrow<0x2::object::ID>(&arg0.switchboard) == &v0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let (v2, v3) = 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::switchboard_feed_parser::log_aggregator_info(arg1);
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
        let v7 = 0x1::type_name::get<T0>();
        let v8 = PriceEvent{
            token : *0x1::type_name::borrow_string(&v7),
            price : v6,
            ts_ms : v1,
            epoch : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<PriceEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

