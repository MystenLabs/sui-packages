module 0x6826bd407563d2a859662c70446b91b50b6309f1eab84128207d93bfe3b520b0::price_feed {
    struct PriceFeed has drop, store {
        source_id: u16,
        from: 0x2::object::ID,
        price: u128,
        timestamp_ms: u64,
        twap_price: u128,
        twap_period_ms: u64,
    }

    public(friend) fun add_feed(arg0: &mut vector<PriceFeed>, arg1: u16, arg2: 0x2::object::ID, arg3: u128, arg4: u64, arg5: u64) {
        let (v0, v1) = binary_search(arg0, arg1);
        assert!(!v0, 13835058922865557505);
        0x1::vector::insert<PriceFeed>(arg0, new(arg1, arg2, arg3, arg4, arg5), v1);
    }

    public(friend) fun as_parts(arg0: &PriceFeed) : (u128, u64, u128, u64) {
        (arg0.price, arg0.timestamp_ms, arg0.twap_price, arg0.twap_period_ms)
    }

    public(friend) fun binary_search(arg0: &vector<PriceFeed>, arg1: u16) : (bool, u64) {
        let v0 = 0;
        let v1 = 0x1::vector::length<PriceFeed>(arg0);
        while (v0 < v1) {
            v1 = v0 + v1 >> 1;
            if (0x1::vector::borrow<PriceFeed>(arg0, v1).source_id < arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        let v2 = v0 < 0x1::vector::length<PriceFeed>(arg0) && 0x1::vector::borrow<PriceFeed>(arg0, v0).source_id == arg1;
        (v2, v0)
    }

    public(friend) fun borrow_feed(arg0: &vector<PriceFeed>, arg1: u16) : &PriceFeed {
        let (v0, v1) = binary_search(arg0, arg1);
        assert!(v0, 13835340153029263363);
        0x1::vector::borrow<PriceFeed>(arg0, v1)
    }

    public(friend) fun borrow_feed_mut(arg0: &mut vector<PriceFeed>, arg1: u16) : &mut PriceFeed {
        let (v0, v1) = binary_search(arg0, arg1);
        assert!(v0, 13835340208863838211);
        0x1::vector::borrow_mut<PriceFeed>(arg0, v1)
    }

    public(friend) fun contains(arg0: &vector<PriceFeed>, arg1: u16) : bool {
        let (v0, _) = binary_search(arg0, arg1);
        v0
    }

    public fun from(arg0: &PriceFeed) : 0x2::object::ID {
        arg0.from
    }

    public(friend) fun new(arg0: u16, arg1: 0x2::object::ID, arg2: u128, arg3: u64, arg4: u64) : PriceFeed {
        assert!(arg4 > 0, 13835621284408721413);
        PriceFeed{
            source_id      : arg0,
            from           : arg1,
            price          : arg2,
            timestamp_ms   : arg3,
            twap_price     : arg2,
            twap_period_ms : arg4,
        }
    }

    public fun price(arg0: &PriceFeed) : u128 {
        arg0.price
    }

    public fun price_and_timestamp_ms(arg0: &PriceFeed) : (u128, u64) {
        (arg0.price, arg0.timestamp_ms)
    }

    public(friend) fun price_timestamp_ms_twap_price(arg0: &PriceFeed) : (u128, u64, u128) {
        (arg0.price, arg0.timestamp_ms, arg0.twap_price)
    }

    public(friend) fun remove_feed(arg0: &mut vector<PriceFeed>, arg1: u16) {
        let (v0, v1) = binary_search(arg0, arg1);
        assert!(v0, 13835340462266908675);
        0x1::vector::remove<PriceFeed>(arg0, v1);
    }

    public(friend) fun set_feed_twap_period_ms(arg0: &mut PriceFeed, arg1: u64) : u64 {
        assert!(arg1 > 0, 13835622074682703877);
        arg0.twap_period_ms = arg1;
        arg0.twap_period_ms
    }

    public(friend) fun set_price(arg0: &mut PriceFeed, arg1: u128, arg2: u64) {
        if (arg2 <= arg0.timestamp_ms) {
            return
        };
        arg0.twap_price = update_twap(arg1, arg0.twap_price, arg2, arg0.timestamp_ms, arg0.twap_period_ms);
        arg0.price = arg1;
        arg0.timestamp_ms = arg2;
    }

    public fun source_id(arg0: &PriceFeed) : u16 {
        arg0.source_id
    }

    public fun timestamp_ms(arg0: &PriceFeed) : u64 {
        arg0.timestamp_ms
    }

    public fun twap_period_ms(arg0: &PriceFeed) : u64 {
        arg0.twap_period_ms
    }

    public fun twap_price(arg0: &PriceFeed) : u128 {
        arg0.twap_price
    }

    public(friend) fun update_twap(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : u128 {
        if (arg2 == arg3) {
            if (arg4 <= 1) {
                return ((((arg0 as u256) + (arg1 as u256)) / 2) as u128)
            };
            return ((((arg0 as u256) + (arg1 as u256) * ((arg4 - 1) as u256)) / (arg4 as u256)) as u128)
        };
        let v0 = arg2 - arg3;
        if (arg4 <= v0) {
            return ((((arg0 as u256) * (v0 as u256) + (arg1 as u256)) / ((v0 + 1) as u256)) as u128)
        };
        ((((arg0 as u256) * (v0 as u256) + (arg1 as u256) * ((arg4 - v0) as u256)) / (arg4 as u256)) as u128)
    }

    // decompiled from Move bytecode v7
}

