module 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_object {
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
        exponent: u8,
        price_feed_addrs: vector<address>,
        weights: vector<u64>,
        total_weight: u64,
        min_weight: u64,
        median_price: 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::Price,
    }

    struct PriceObjectCreatedEvent has copy, drop {
        price_object_addr: address,
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        base_decimals: u8,
        quote_decimals: u8,
        exponent: u8,
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
        old_price: u256,
        old_timestamp_ms: u64,
        new_price: u256,
        new_timestamp_ms: u64,
    }

    public fun new<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x2::coin::get_decimals<T0>(arg0);
        let v3 = 0x2::coin::get_decimals<T1>(arg1);
        let v4 = 0x2::object::new(arg3);
        let v5 = 0x2::object::uid_to_address(&v4);
        let v6 = PriceObject{
            id               : v4,
            base_asset       : v0,
            quote_asset      : v1,
            base_decimals    : v2,
            quote_decimals   : v3,
            exponent         : arg2,
            price_feed_addrs : 0x1::vector::empty<address>(),
            weights          : 0x1::vector::empty<u64>(),
            total_weight     : 0,
            min_weight       : 0,
            median_price     : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::new(0, 0),
        };
        0x2::transfer::share_object<PriceObject>(v6);
        let v7 = AdminCap{
            id                : 0x2::object::new(arg3),
            price_object_addr : v5,
        };
        0x2::transfer::public_transfer<AdminCap>(v7, 0x2::tx_context::sender(arg3));
        let v8 = PriceObjectCreatedEvent{
            price_object_addr : v5,
            base_asset        : v0,
            quote_asset       : v1,
            base_decimals     : v2,
            quote_decimals    : v3,
            exponent          : arg2,
        };
        0x2::event::emit<PriceObjectCreatedEvent>(v8);
    }

    public fun get_timestamp_ms(arg0: &PriceObject) : u64 {
        0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::get_timestamp_ms(arg0.median_price)
    }

    public fun get_exponent(arg0: &PriceObject) : u8 {
        arg0.exponent
    }

    public fun get_price_with_exponent(arg0: &PriceObject) : (u256, u8) {
        (0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::get_value(arg0.median_price), arg0.exponent)
    }

    public fun add_price_feed(arg0: &AdminCap, arg1: &mut PriceObject, arg2: &0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed, arg3: u64) : u64 {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EForbidden());
        assert!(0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::get_exponent(arg2) == arg1.exponent, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EExponentMismatch());
        0x1::vector::push_back<address>(&mut arg1.price_feed_addrs, 0x2::object::id_address<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>(arg2));
        0x1::vector::push_back<u64>(&mut arg1.weights, arg3);
        arg1.total_weight = arg1.total_weight + arg3;
        let v0 = 0x1::vector::length<address>(&arg1.price_feed_addrs) - 1;
        let v1 = PriceFeedAddedEvent{
            price_object_addr : arg0.price_object_addr,
            price_feed_addr   : 0x2::object::id_address<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>(arg2),
            pool_addr         : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::get_pool_addr(arg2),
            is_reverse_pool   : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::get_is_reverse_pool(arg2),
            weight            : arg3,
            index             : v0,
        };
        0x2::event::emit<PriceFeedAddedEvent>(v1);
        v0
    }

    public fun get_base_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.base_asset
    }

    public fun get_quote_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.quote_asset
    }

    public fun set_min_weight(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EForbidden());
        arg1.min_weight = arg2;
        let v0 = MinWeightChangedEvent{
            price_object_addr : arg0.price_object_addr,
            old_min_weight    : arg1.min_weight,
            new_min_weight    : arg2,
        };
        0x2::event::emit<MinWeightChangedEvent>(v0);
    }

    public fun set_weight(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64, arg3: u64) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EForbidden());
        assert!(arg2 < 0x1::vector::length<address>(&arg1.price_feed_addrs), 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EIndexOutOfBounds());
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg1.weights, arg2);
        let v1 = *v0;
        arg1.total_weight = arg1.total_weight - v1 + arg3;
        *v0 = arg3;
        let v2 = WeightChangedEvent{
            price_object_addr : arg0.price_object_addr,
            index             : arg2,
            price_feed_addr   : *0x1::vector::borrow<address>(&arg1.price_feed_addrs, arg2),
            old_weight        : v1,
            new_weight        : arg3,
        };
        0x2::event::emit<WeightChangedEvent>(v2);
    }

    public fun update(arg0: &mut PriceObject, arg1: &vector<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>, arg2: &0x2::clock::Clock) {
        assert!(0x1::vector::length<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>(arg1) == 0x1::vector::length<address>(&arg0.price_feed_addrs), 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::EIndexOutOfBounds());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>(arg1)) {
            let (v4, v5) = validate_and_get_value_and_weight(0x1::vector::borrow<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>(arg1, v3), *0x1::vector::borrow<address>(&arg0.price_feed_addrs, v3));
            let v6 = *0x1::vector::borrow<u64>(&arg0.weights, v3);
            if (v5 == v0 && v6 > 0) {
                v1 = v1 + v4;
                v2 = v2 + v6;
            };
            v3 = v3 + 1;
        };
        assert!(v2 > 0 && v2 >= arg0.min_weight, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::errors::ENotEnoughPriceFeedCandidates());
        let v7 = v1 / (v2 as u256) * (arg0.quote_decimals as u256) / (arg0.base_decimals as u256);
        arg0.median_price = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::new(v7, v0);
        let v8 = UpdatedEvent{
            price_object_addr : 0x2::object::id_address<PriceObject>(arg0),
            old_price         : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::get_value(arg0.median_price),
            old_timestamp_ms  : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::get_timestamp_ms(arg0.median_price),
            new_price         : v7,
            new_timestamp_ms  : v0,
        };
        0x2::event::emit<UpdatedEvent>(v8);
    }

    fun validate_and_get_value_and_weight(arg0: &0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed, arg1: address) : (u256, u64) {
        if (0x2::object::id_address<0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::PriceFeed>(arg0) == arg1) {
            let (v0, _) = 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::get_price_with_exponent(arg0);
            return (v0, 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price_feed::get_timestamp_ms(arg0))
        };
        (0, 0)
    }

    // decompiled from Move bytecode v6
}

