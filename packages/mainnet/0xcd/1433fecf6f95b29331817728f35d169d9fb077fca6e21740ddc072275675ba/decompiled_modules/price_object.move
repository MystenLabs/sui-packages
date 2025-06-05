module 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_object {
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
        price_feeds: 0x2::table::Table<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>,
        min_weight: u64,
        price: 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::Price,
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
        pool_addr: address,
        pool_type: u8,
        is_reverse_pool: bool,
        weight: u64,
        index: u64,
    }

    struct WeightChangedEvent has copy, drop {
        price_object_addr: address,
        index: u64,
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
            id             : v4,
            base_asset     : v0,
            quote_asset    : v1,
            base_decimals  : v2,
            quote_decimals : v3,
            exponent       : arg2,
            price_feeds    : 0x2::table::new<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(arg3),
            min_weight     : 0,
            price          : 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::new(0, 0),
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
        0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::get_timestamp_ms(arg0.price)
    }

    public fun get_price_with_exponent(arg0: &PriceObject) : (u256, u8) {
        (0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::get_value(arg0.price), arg0.exponent)
    }

    public fun set_weight(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64, arg3: u64) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EForbidden());
        assert!(arg2 < 0x2::table::length<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(&arg1.price_feeds), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EIndexOutOfBounds());
        let v0 = 0x2::table::borrow_mut<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(&mut arg1.price_feeds, arg2);
        0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::set_weight(v0, arg3);
        let v1 = WeightChangedEvent{
            price_object_addr : arg0.price_object_addr,
            index             : arg2,
            old_weight        : 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_weight(v0),
            new_weight        : arg3,
        };
        0x2::event::emit<WeightChangedEvent>(v1);
    }

    public fun add_price_feed(arg0: &AdminCap, arg1: &mut PriceObject, arg2: address, arg3: u8, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EForbidden());
        let v0 = &mut arg1.price_feeds;
        let v1 = 0x2::table::length<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0);
        0x2::table::add<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0, v1, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::new(arg2, arg3, arg4, arg1.exponent, arg5, arg6));
        let v2 = PriceFeedAddedEvent{
            price_object_addr : arg0.price_object_addr,
            pool_addr         : arg2,
            pool_type         : arg3,
            is_reverse_pool   : arg4,
            weight            : arg5,
            index             : v1,
        };
        0x2::event::emit<PriceFeedAddedEvent>(v2);
        v1
    }

    public fun get_base_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.base_asset
    }

    public fun get_exponent(arg0: &PriceObject) : u8 {
        arg0.exponent
    }

    public fun get_quote_asset(arg0: &PriceObject) : 0x1::type_name::TypeName {
        arg0.quote_asset
    }

    public fun set_min_weight(arg0: &AdminCap, arg1: &mut PriceObject, arg2: u64) {
        assert!(arg0.price_object_addr == 0x2::object::id_address<PriceObject>(arg1), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EForbidden());
        arg1.min_weight = arg2;
        let v0 = MinWeightChangedEvent{
            price_object_addr : arg0.price_object_addr,
            old_min_weight    : arg1.min_weight,
            new_min_weight    : arg2,
        };
        0x2::event::emit<MinWeightChangedEvent>(v0);
    }

    public fun update(arg0: &mut PriceObject, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = &arg0.price_feeds;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x2::table::length<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v1)) {
            let v5 = 0x2::table::borrow<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v1, v4);
            let v6 = 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_weight(v5);
            if (v6 == 0) {
                v4 = v4 + 1;
                continue
            };
            let (v7, _) = 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_price_with_exponent(v5);
            if (0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_timestamp_ms(v5) == v0) {
                v2 = v2 + v7;
                v3 = v3 + v6;
            };
            v4 = v4 + 1;
        };
        assert!(v3 > 0 && v3 >= arg0.min_weight, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::ENotEnoughPriceFeedCandidates());
        let v9 = v2 / (v3 as u256) * (arg0.quote_decimals as u256) / (arg0.base_decimals as u256);
        arg0.price = 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::new(v9, v0);
        let v10 = UpdatedEvent{
            price_object_addr : 0x2::object::id_address<PriceObject>(arg0),
            old_price         : 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::get_value(arg0.price),
            old_timestamp_ms  : 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price::get_timestamp_ms(arg0.price),
            new_price         : v9,
            new_timestamp_ms  : v0,
        };
        0x2::event::emit<UpdatedEvent>(v10);
    }

    public fun update_price_feed_bluefin_spot<T0, T1>(arg0: &mut PriceObject, arg1: u64, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.price_feeds;
        assert!(arg1 < 0x2::table::length<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EIndexOutOfBounds());
        let v1 = 0x2::table::borrow_mut<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0, arg1);
        if (0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_is_reverse_pool(v1)) {
            0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::update_bluefin_spot_reverse<T1, T0>(v1, arg2, arg3);
        } else {
            0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::update_bluefin_spot<T0, T1>(v1, arg2, arg3);
        };
    }

    public fun update_price_feed_cetus_clmm<T0, T1>(arg0: &mut PriceObject, arg1: u64, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.price_feeds;
        assert!(arg1 < 0x2::table::length<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EIndexOutOfBounds());
        let v1 = 0x2::table::borrow_mut<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0, arg1);
        if (0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_is_reverse_pool(v1)) {
            0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::update_cetus_clmm_reverse<T1, T0>(v1, arg2, arg3);
        } else {
            0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::update_cetus_clmm<T0, T1>(v1, arg2, arg3);
        };
    }

    public fun update_price_feed_mmt_v3<T0, T1>(arg0: &mut PriceObject, arg1: u64, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        let v0 = &mut arg0.price_feeds;
        assert!(arg1 < 0x2::table::length<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0), 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::errors::EIndexOutOfBounds());
        let v1 = 0x2::table::borrow_mut<u64, 0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::PriceFeed>(v0, arg1);
        if (0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::get_is_reverse_pool(v1)) {
            0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::update_mmt_v3_reverse<T1, T0>(v1, arg2, arg3);
        } else {
            0xcd1433fecf6f95b29331817728f35d169d9fb077fca6e21740ddc072275675ba::price_feed::update_mmt_v3<T0, T1>(v1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

