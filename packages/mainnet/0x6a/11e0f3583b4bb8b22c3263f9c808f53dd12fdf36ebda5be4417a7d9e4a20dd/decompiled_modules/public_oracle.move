module 0x6a11e0f3583b4bb8b22c3263f9c808f53dd12fdf36ebda5be4417a7d9e4a20dd::public_oracle {
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
    }

    struct Key<phantom T0> has key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct PriceEvent has copy, drop {
        token: 0x1::ascii::String,
        price: u64,
        ts_ms: u64,
        epoch: u64,
    }

    public entry fun copy_key<T0>(arg0: &Key<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Key<T0>{
            id  : 0x2::object::new(arg2),
            for : arg0.for,
        };
        0x2::transfer::transfer<Key<T0>>(v0, arg1);
    }

    public fun get_oracle<T0>(arg0: &Oracle<T0>) : (u64, u64, u64, u64) {
        (arg0.price, arg0.decimal, arg0.ts_ms, arg0.epoch)
    }

    public fun get_price<T0>(arg0: &Oracle<T0>, arg1: u64) : (u64, u64) {
        assert!(arg1 - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.price, arg0.decimal)
    }

    public fun get_twap_price<T0>(arg0: &Oracle<T0>, arg1: u64) : (u64, u64) {
        assert!(arg1 - arg0.ts_ms < arg0.time_interval, 1);
        (arg0.twap_price, arg0.decimal)
    }

    public entry fun new_oracle<T0>(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = Oracle<T0>{
            id            : v0,
            quote_token   : arg0,
            base_token    : arg1,
            decimal       : arg2,
            price         : 0,
            twap_price    : 0,
            ts_ms         : 0,
            epoch         : 0x2::tx_context::epoch(arg3),
            time_interval : 300000,
        };
        0x2::transfer::share_object<Oracle<T0>>(v1);
        let v2 = Key<T0>{
            id  : 0x2::object::new(arg3),
            for : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<Key<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun update<T0>(arg0: &mut Oracle<T0>, arg1: &Key<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(&arg1.for == 0x2::object::borrow_id<Oracle<T0>>(arg0), 0);
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

    public entry fun update_time_interval<T0>(arg0: &mut Oracle<T0>, arg1: &Key<T0>, arg2: u64) {
        assert!(&arg1.for == 0x2::object::borrow_id<Oracle<T0>>(arg0), 0);
        arg0.time_interval = arg2;
    }

    // decompiled from Move bytecode v6
}

