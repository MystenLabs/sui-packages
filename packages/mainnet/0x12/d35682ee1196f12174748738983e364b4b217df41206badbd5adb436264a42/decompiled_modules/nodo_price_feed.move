module 0x12d35682ee1196f12174748738983e364b4b217df41206badbd5adb436264a42::nodo_price_feed {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NodoPriceFeedInfo has store, key {
        id: 0x2::object::UID,
        token_type: 0x1::ascii::String,
        price: u64,
        decimals: u8,
        last_update_ts: u64,
    }

    struct CreatePriceFeedEvent has copy, drop, store {
        id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        decimals: u8,
    }

    struct PushPriceEvent has copy, drop, store {
        id: 0x2::object::ID,
        token_type: 0x1::ascii::String,
        decimals: u8,
        price: u64,
        update_ts: u64,
    }

    entry fun create_price_feed(arg0: &AdminCap, arg1: 0x1::ascii::String, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 <= 0x2::clock::timestamp_ms(arg5), 5);
        let v0 = NodoPriceFeedInfo{
            id             : 0x2::object::new(arg6),
            token_type     : arg1,
            price          : arg3,
            decimals       : arg2,
            last_update_ts : arg4,
        };
        let v1 = CreatePriceFeedEvent{
            id         : 0x2::object::id<NodoPriceFeedInfo>(&v0),
            token_type : arg1,
            decimals   : arg2,
        };
        0x2::event::emit<CreatePriceFeedEvent>(v1);
        0x2::transfer::share_object<NodoPriceFeedInfo>(v0);
    }

    public fun get_price(arg0: &NodoPriceFeedInfo) : (vector<u8>, 0x1::ascii::String, u64, u8, u64) {
        (0x2::object::id_bytes<NodoPriceFeedInfo>(arg0), arg0.token_type, arg0.price, arg0.decimals, arg0.last_update_ts)
    }

    public fun get_price_no_older_than(arg0: &NodoPriceFeedInfo, arg1: u64, arg2: &0x2::clock::Clock) : (vector<u8>, 0x1::ascii::String, u64, u8, u64) {
        assert!((0x2::clock::timestamp_ms(arg2) - arg0.last_update_ts) / 1000 <= arg1, 6);
        (0x2::object::id_bytes<NodoPriceFeedInfo>(arg0), arg0.token_type, arg0.price, arg0.decimals, arg0.last_update_ts)
    }

    fun has_duplicates(arg0: &vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                if (0x1::vector::borrow<vector<u8>>(arg0, v1) == 0x1::vector::borrow<vector<u8>>(arg0, v2)) {
                    return true
                };
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun push_price(arg0: &0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::PriceFeedConfig, arg1: &mut NodoPriceFeedInfo, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg3 <= v0, 5);
        if (arg1.last_update_ts < arg3 && v0 - arg3 <= 0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::get_max_staleness(arg0)) {
            let v1 = 0x2::object::id<0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::PriceFeedConfig>(arg0);
            let v2 = 0x2::object::id<NodoPriceFeedInfo>(arg1);
            let v3 = 0x1::vector::empty<vector<u8>>();
            let v4 = &mut v3;
            0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<0x2::object::ID>(&v1));
            0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<0x2::object::ID>(&v2));
            0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<u64>(&arg2));
            0x1::vector::push_back<vector<u8>>(v4, 0x2::bcs::to_bytes<u64>(&arg3));
            verify_signature(arg0, 0x1::vector::flatten<u8>(v3), arg4, arg5);
            arg1.price = arg2;
            arg1.last_update_ts = arg3;
            let v5 = PushPriceEvent{
                id         : 0x2::object::id<NodoPriceFeedInfo>(arg1),
                token_type : arg1.token_type,
                decimals   : arg1.decimals,
                price      : arg2,
                update_ts  : arg3,
            };
            0x2::event::emit<PushPriceEvent>(v5);
        };
    }

    fun verify_signature(arg0: &0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::PriceFeedConfig, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>) : bool {
        let v0 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v0 >= (0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::get_quorum(arg0) as u64), 2);
        assert!(!has_duplicates(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            assert!(0x35cf1945256c4ae43e32458151c961b5daf4161772f39b34b65587f92bf6ffbd::price_feed::is_pusher(arg0, 0x1::vector::borrow<vector<u8>>(&arg2, v1)), 3);
            assert!(0x2::ed25519::ed25519_verify(0x1::vector::borrow<vector<u8>>(&arg3, v1), 0x1::vector::borrow<vector<u8>>(&arg2, v1), &arg1), 4);
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

