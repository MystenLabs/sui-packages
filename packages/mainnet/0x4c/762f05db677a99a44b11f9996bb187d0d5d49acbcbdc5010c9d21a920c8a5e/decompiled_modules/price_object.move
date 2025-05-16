module 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_object {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        price_object_addr: address,
    }

    struct PriceObject has store, key {
        id: 0x2::object::UID,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        base_decimals: u8,
        quote_decimals: u8,
        price_feed_addrs: vector<0x1::option::Option<address>>,
        weights: vector<0x1::option::Option<u64>>,
        total_weight: u64,
        min_weight: u64,
        median_price: 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::Price,
    }

    struct PriceObjectCreatedEvent has copy, drop {
        price_object_addr: address,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        base_decimals: u8,
        quote_decimals: u8,
    }

    struct MinWeightChangedEvent has copy, drop {
        price_object_addr: address,
        old_min_weight: u64,
        new_min_weight: u64,
    }

    struct PriceFeedAddedEvent has copy, drop {
        price_object_addr: address,
        price_feed_addr: address,
        pool_addr: address,
        is_reverse_pool: bool,
        weight: u64,
        index: u64,
    }

    struct WeightChangedEvent has copy, drop {
        price_object_addr: address,
        index: u64,
        price_feed_addr: address,
        old_weight: u64,
        new_weight: u64,
    }

    struct UpdatedEvent has copy, drop {
        price_object_addr: address,
        old_price: u64,
        old_timestamp_ms: u64,
        new_price: u64,
        new_timestamp_ms: u64,
    }

    public fun new<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x2::coin::get_decimals<T0>(arg0);
        let v3 = 0x2::coin::get_decimals<T1>(arg1);
        let v4 = 0x2::object::new(arg2);
        let v5 = 0x2::object::uid_to_address(&v4);
        let v6 = PriceObject{
            id               : v4,
            base_asset       : v0,
            quote_asset      : v1,
            base_decimals    : v2,
            quote_decimals   : v3,
            price_feed_addrs : 0x1::vector::empty<0x1::option::Option<address>>(),
            weights          : 0x1::vector::empty<0x1::option::Option<u64>>(),
            total_weight     : 0,
            min_weight       : 0,
            median_price     : 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::new(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0), 0),
        };
        0x2::transfer::share_object<PriceObject>(v6);
        let v7 = AdminCap{
            id                : 0x2::object::new(arg2),
            price_object_addr : v5,
        };
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg2));
        let v8 = PriceObjectCreatedEvent{
            price_object_addr : v5,
            base_asset        : v0,
            quote_asset       : v1,
            base_decimals     : v2,
            quote_decimals    : v3,
        };
        0x2::event::emit<PriceObjectCreatedEvent>(v8);
    }

    public fun get_price(arg0: &PriceObject) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::get_price(arg0.median_price)
    }

    public fun get_timestamp_ms(arg0: &PriceObject) : u64 {
        0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::get_timestamp_ms(arg0.median_price)
    }

    public fun add_price_feed(arg0: &AdminCap, arg1: &mut PriceObject, arg2: &0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed, arg3: u64) : u64 {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::errors::EForbidden());
        let v0 = find_available_index(arg1);
        0x1::option::fill<address>(0x1::vector::borrow_mut<0x1::option::Option<address>>(&mut arg1.price_feed_addrs, v0), 0x2::object::id_address<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>(arg2));
        0x1::vector::push_back<0x1::option::Option<u64>>(&mut arg1.weights, 0x1::option::none<u64>());
        0x1::option::fill<u64>(0x1::vector::borrow_mut<0x1::option::Option<u64>>(&mut arg1.weights, v0), arg3);
        arg1.total_weight = arg1.total_weight + arg3;
        let v1 = PriceFeedAddedEvent{
            price_object_addr : arg0.price_object_addr,
            price_feed_addr   : 0x2::object::id_address<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>(arg2),
            pool_addr         : 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::get_pool_addr(arg2),
            is_reverse_pool   : 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::get_is_reverse_pool(arg2),
            weight            : arg3,
            index             : v0,
        };
        0x2::event::emit<PriceFeedAddedEvent>(v1);
        v0
    }

    fun find_available_index(arg0: &mut PriceObject) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<address>>(&arg0.price_feed_addrs)) {
            if (0x1::option::is_none<address>(0x1::vector::borrow<0x1::option::Option<address>>(&arg0.price_feed_addrs, v0))) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::option::Option<address>>(&mut arg0.price_feed_addrs, 0x1::option::none<address>());
        v0
    }

    public fun get_base_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.base_asset
    }

    public fun get_quote_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.quote_asset
    }

    public fun set_min_weight(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::errors::EForbidden());
        arg1.min_weight = arg2;
        let v0 = MinWeightChangedEvent{
            price_object_addr : arg0.price_object_addr,
            old_min_weight    : arg1.min_weight,
            new_min_weight    : arg2,
        };
        0x2::event::emit<MinWeightChangedEvent>(v0);
    }

    public fun set_weight(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64, arg3: u64) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::errors::EForbidden());
        assert!(arg2 < 0x1::vector::length<0x1::option::Option<address>>(&arg1.price_feed_addrs), 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::errors::EIndexOutOfBounds());
        let v0 = 0x1::vector::borrow_mut<0x1::option::Option<u64>>(&mut arg1.weights, arg2);
        let v1 = *0x1::option::borrow<u64>(v0);
        arg1.total_weight = arg1.total_weight - v1 + arg3;
        0x1::option::fill<u64>(v0, arg3);
        let v2 = WeightChangedEvent{
            price_object_addr : arg0.price_object_addr,
            index             : arg2,
            price_feed_addr   : *0x1::option::borrow<address>(0x1::vector::borrow<0x1::option::Option<address>>(&arg1.price_feed_addrs, arg2)),
            old_weight        : v1,
            new_weight        : arg3,
        };
        0x2::event::emit<WeightChangedEvent>(v2);
    }

    public fun update(arg0: &mut PriceObject, arg1: &vector<0x1::option::Option<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>>, arg2: &0x2::clock::Clock) {
        assert!(0x1::vector::length<0x1::option::Option<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>>(arg1) == 0x1::vector::length<0x1::option::Option<address>>(&arg0.price_feed_addrs), 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::errors::EIndexOutOfBounds());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::option::Option<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>>(arg1)) {
            let (v4, v5) = validate_and_get_value_and_weight(0x1::vector::borrow<0x1::option::Option<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>>(arg1, v3), 0x1::vector::borrow<0x1::option::Option<address>>(&arg0.price_feed_addrs, v3));
            if (v5 == v0) {
                let v6 = *0x1::option::borrow<u64>(0x1::vector::borrow<0x1::option::Option<u64>>(&arg0.weights, v3));
                if (v6 > 0) {
                    v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::add(v1, v4);
                    v2 = v2 + v6;
                };
            };
            v3 = v3 + 1;
        };
        assert!(v2 >= arg0.min_weight, 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::errors::ENotEnoughPriceFeedCandidates());
        let v7 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(v1, 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v2)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from((arg0.base_decimals as u64))), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from((arg0.quote_decimals as u64)));
        arg0.median_price = 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::new(v7, v0);
        let v8 = UpdatedEvent{
            price_object_addr : 0x2::object::id_address<PriceObject>(arg0),
            old_price         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::get_price(arg0.median_price)),
            old_timestamp_ms  : 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::get_timestamp_ms(arg0.median_price),
            new_price         : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::floor(v7),
            new_timestamp_ms  : v0,
        };
        0x2::event::emit<UpdatedEvent>(v8);
    }

    fun validate_and_get_value_and_weight(arg0: &0x1::option::Option<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>, arg1: &0x1::option::Option<address>) : (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal, u64) {
        if (0x1::option::is_some<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>(arg0) && 0x1::option::is_some<address>(arg1)) {
            let v0 = 0x1::option::borrow<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>(arg0);
            let v1 = 0x2::object::id_address<0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::PriceFeed>(v0);
            if (&v1 == 0x1::option::borrow<address>(arg1)) {
                return (0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::get_price(v0), 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price_feed::get_timestamp_ms(v0))
            };
        };
        (0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(0), 0)
    }

    // decompiled from Move bytecode v6
}

