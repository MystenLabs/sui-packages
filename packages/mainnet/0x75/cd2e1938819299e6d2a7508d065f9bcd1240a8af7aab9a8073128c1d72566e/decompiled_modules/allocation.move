module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::allocation {
    struct Recipient has copy, drop, store {
        destination: address,
        meme: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        quote: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
    }

    struct AllocationPlan has copy, drop, store {
        curve_meme: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        pool_meme: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        pool_quote: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        recipients: vector<Recipient>,
    }

    struct Route has copy, drop, store {
        destination: address,
        bps: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
    }

    struct FeeSplit has copy, drop, store {
        creator: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        auto_lp: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        rewards: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        burn: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        recipients: vector<Route>,
    }

    public fun curve_meme(arg0: &AllocationPlan) : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps {
        arg0.curve_meme
    }

    public fun fee_split(arg0: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg1: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg2: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg3: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg4: vector<Route>) : FeeSplit {
        assert!(0x1::vector::length<Route>(&arg4) <= 16, 2);
        let v0 = 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg0) + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg1) + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg2) + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg3);
        let v1 = &arg4;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Route>(v1)) {
            v0 = v0 + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&0x1::vector::borrow<Route>(v1, v2).bps);
            v2 = v2 + 1;
        };
        assert!(v0 == 10000, 1);
        FeeSplit{
            creator    : arg0,
            auto_lp    : arg1,
            rewards    : arg2,
            burn       : arg3,
            recipients : arg4,
        }
    }

    public fun plan(arg0: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg1: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg2: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg3: vector<Recipient>) : AllocationPlan {
        assert!(0x1::vector::length<Recipient>(&arg3) <= 16, 2);
        let v0 = 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg0) + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg1);
        let v1 = 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&arg2);
        let v2 = &arg3;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Recipient>(v2)) {
            let v4 = 0x1::vector::borrow<Recipient>(v2, v3);
            v0 = v0 + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&v4.meme);
            v1 = v1 + 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::value(&v4.quote);
            v3 = v3 + 1;
        };
        assert!(v0 == 10000 && v1 == 10000, 1);
        AllocationPlan{
            curve_meme : arg0,
            pool_meme  : arg1,
            pool_quote : arg2,
            recipients : arg3,
        }
    }

    public fun recipient(arg0: address, arg1: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg2: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps) : Recipient {
        Recipient{
            destination : arg0,
            meme        : arg1,
            quote       : arg2,
        }
    }

    public fun route(arg0: address, arg1: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps) : Route {
        Route{
            destination : arg0,
            bps         : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

