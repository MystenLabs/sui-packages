module 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::price_aggregator {
    struct PriceInfo has copy, drop {
        price: u64,
        timestamp: u64,
    }

    struct PriceVector has copy, drop {
        vec: vector<u64>,
    }

    public(friend) fun aggregate_price(arg0: &0x2::clock::Clock, arg1: vector<PriceInfo>, arg2: u64, arg3: u64) : u64 {
        let v0 = vector[];
        while (!0x1::vector::is_empty<PriceInfo>(&arg1)) {
            let PriceInfo {
                price     : v1,
                timestamp : v2,
            } = 0x1::vector::pop_back<PriceInfo>(&mut arg1);
            if (0x2::math::diff(0x2::clock::timestamp_ms(arg0), v2) <= arg2) {
                0x1::vector::push_back<u64>(&mut v0, v1);
            };
        };
        process_prices(v0, arg3)
    }

    public fun extract(arg0: &PriceInfo) : (u64, u64) {
        (arg0.price, arg0.timestamp)
    }

    public fun new(arg0: u64, arg1: u64) : PriceInfo {
        PriceInfo{
            price     : arg0,
            timestamp : arg1,
        }
    }

    fun process_prices(arg0: vector<u64>, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 >= arg1, 0);
        let v1 = PriceVector{vec: arg0};
        0x2::event::emit<PriceVector>(v1);
        if (v0 == 1) {
            *0x1::vector::borrow<u64>(&arg0, 0)
        } else {
            let v3 = *0x1::vector::borrow<u64>(&arg0, 0);
            let v4 = *0x1::vector::borrow<u64>(&arg0, 1);
            let v5 = (v3 + v4) / 2;
            assert!(0x2::math::diff(v3, v4) * 50 <= v5, 1);
            v5
        }
    }

    public fun push_price(arg0: &mut vector<PriceInfo>, arg1: 0x1::option::Option<PriceInfo>) {
        if (0x1::option::is_some<PriceInfo>(&arg1)) {
            0x1::vector::push_back<PriceInfo>(arg0, 0x1::option::destroy_some<PriceInfo>(arg1));
        } else {
            0x1::option::destroy_none<PriceInfo>(arg1);
        };
    }

    // decompiled from Move bytecode v6
}

