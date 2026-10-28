module 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation {
    struct Recipient has copy, drop, store {
        destination: address,
        meme_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        quote_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
    }

    struct AllocationPlan has copy, drop, store {
        curve_meme_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        lp_meme_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        lp_quote_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        protocol_meme_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        protocol_quote_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        recipients: vector<Recipient>,
    }

    struct ProtocolAllocation has copy, drop, store {
        meme_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        quote_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
    }

    struct Route has copy, drop, store {
        destination: address,
        bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
    }

    struct FeeSplit has copy, drop, store {
        creator_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        auto_lp_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        rewards_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        burn_bps: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps,
        recipients: vector<Route>,
    }

    public(friend) fun add_protocol(arg0: AllocationPlan, arg1: ProtocolAllocation) : AllocationPlan {
        assert!(0x1::vector::length<Recipient>(&arg0.recipients) <= 16, 8);
        arg0.protocol_meme_bps = arg1.meme_bps;
        arg0.protocol_quote_bps = arg1.quote_bps;
        let v0 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg0.curve_meme_bps) + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg0.lp_meme_bps) + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg1.meme_bps);
        let v1 = arg0.recipients;
        0x1::vector::reverse<Recipient>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recipient>(&v1)) {
            let v3 = 0x1::vector::pop_back<Recipient>(&mut v1);
            v0 = v0 + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v3.meme_bps);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Recipient>(v1);
        let v4 = if (v0 == 10000) {
            let v5 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg0.lp_quote_bps) + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg1.quote_bps);
            let v6 = arg0.recipients;
            0x1::vector::reverse<Recipient>(&mut v6);
            let v7 = 0;
            while (v7 < 0x1::vector::length<Recipient>(&v6)) {
                let v8 = 0x1::vector::pop_back<Recipient>(&mut v6);
                v5 = v5 + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v8.quote_bps);
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<Recipient>(v6);
            v5 == 10000
        } else {
            false
        };
        assert!(v4, 7);
        arg0
    }

    fun apportion(arg0: vector<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>, arg1: u64, arg2: 0x1::option::Option<u64>) : vector<u64> {
        let v0 = 10000;
        let v1 = vector[];
        0x1::vector::reverse<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(&mut arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(&arg0)) {
            0x1::vector::push_back<u128>(&mut v1, (arg1 as u128) * (0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(0x1::vector::pop_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(&mut arg0)) as u128));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(arg0);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0x1::vector::length<u128>(&v1)) {
            let v5 = if (0x1::option::contains<u64>(&arg2, &v4)) {
                (0x1::u128::div_ceil(*0x1::vector::borrow<u128>(&v1, v4), v0) as u64)
            } else {
                ((*0x1::vector::borrow<u128>(&v1, v4) / v0) as u64)
            };
            0x1::vector::push_back<u64>(&mut v3, v5);
            v4 = v4 + 1;
        };
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<u128>(&v1)) {
            0x1::vector::push_back<u64>(&mut v6, v7);
            v7 = v7 + 1;
        };
        let v8 = vector[];
        0x1::vector::reverse<u64>(&mut v6);
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v6)) {
            let v10 = 0x1::vector::pop_back<u64>(&mut v6);
            if (!0x1::option::contains<u64>(&arg2, &v10)) {
                0x1::vector::push_back<u64>(&mut v8, v10);
            };
            v9 = v9 + 1;
        };
        0x1::vector::destroy_empty<u64>(v6);
        let v11 = &mut v8;
        let v12 = 0x1::vector::length<u64>(v11);
        if (v12 < 2) {
        } else {
            let v13 = 1;
            while (v13 < v12) {
                loop {
                    let v14 = if (v13 > 0) {
                        let v15 = 0x1::vector::borrow<u64>(v11, v13 - 1);
                        let v16 = 0x1::vector::borrow<u64>(v11, v13);
                        let v17 = *0x1::vector::borrow<u128>(&v1, *v15) % v0;
                        let v18 = *0x1::vector::borrow<u128>(&v1, *v16) % v0;
                        let v19 = v17 > v18 || v17 == v18 && *v15 <= *v16;
                        !v19
                    } else {
                        false
                    };
                    if (v14) {
                        0x1::vector::swap<u64>(v11, v13, v13 - 1);
                        v13 = v13 - 1;
                    } else {
                        break
                    };
                };
                v13 = v13 + 1;
            };
        };
        let v20 = 0;
        0x1::vector::reverse<u64>(&mut v3);
        let v21 = 0;
        while (v21 < 0x1::vector::length<u64>(&v3)) {
            v20 = v20 + 0x1::vector::pop_back<u64>(&mut v3);
            v21 = v21 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        let v22 = 0;
        while (v22 < arg1 - v20) {
            *0x1::vector::borrow_mut<u64>(&mut v3, *0x1::vector::borrow<u64>(&v8, v22)) = *0x1::vector::borrow<u64>(&v3, *0x1::vector::borrow<u64>(&v8, v22)) + 1;
            v22 = v22 + 1;
        };
        v3
    }

    public fun apportion_fee_split(arg0: &FeeSplit, arg1: u64) : (u64, u64, u64, u64, vector<u64>) {
        let v0 = 0x1::vector::empty<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.creator_bps);
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.auto_lp_bps);
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.rewards_bps);
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.burn_bps);
        let v2 = &arg0.recipients;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Route>(v2)) {
            0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(&mut v0, 0x1::vector::borrow<Route>(v2, v3).bps);
            v3 = v3 + 1;
        };
        let v4 = apportion(v0, arg1, 0x1::option::none<u64>());
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v4) - 4) {
            0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v4, v6 + 4));
            v6 = v6 + 1;
        };
        (*0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 2), *0x1::vector::borrow<u64>(&v4, 3), v5)
    }

    public(friend) fun apportion_meme(arg0: &AllocationPlan, arg1: u64) : (u64, u64, u64, vector<u64>) {
        let v0 = 0x1::vector::empty<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.curve_meme_bps);
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.lp_meme_bps);
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.protocol_meme_bps);
        let v2 = &arg0.recipients;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Recipient>(v2)) {
            0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(&mut v0, 0x1::vector::borrow<Recipient>(v2, v3).meme_bps);
            v3 = v3 + 1;
        };
        let v4 = apportion(v0, arg1, 0x1::option::some<u64>(2));
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v4) - 3) {
            0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v4, v6 + 3));
            v6 = v6 + 1;
        };
        (*0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 2), v5)
    }

    public(friend) fun apportion_quote(arg0: &AllocationPlan, arg1: u64) : (u64, u64, vector<u64>) {
        let v0 = 0x1::vector::empty<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.lp_quote_bps);
        0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(v1, arg0.protocol_quote_bps);
        let v2 = &arg0.recipients;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Recipient>(v2)) {
            0x1::vector::push_back<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps>(&mut v0, 0x1::vector::borrow<Recipient>(v2, v3).quote_bps);
            v3 = v3 + 1;
        };
        let v4 = apportion(v0, arg1, 0x1::option::some<u64>(1));
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&v4) - 2) {
            0x1::vector::push_back<u64>(&mut v5, *0x1::vector::borrow<u64>(&v4, v6 + 2));
            v6 = v6 + 1;
        };
        (*0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), v5)
    }

    public fun destination(arg0: &Route) : address {
        arg0.destination
    }

    public(friend) fun destinations(arg0: &AllocationPlan) : vector<address> {
        let v0 = &arg0.recipients;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recipient>(v0)) {
            0x1::vector::push_back<address>(&mut v1, 0x1::vector::borrow<Recipient>(v0, v2).destination);
            v2 = v2 + 1;
        };
        v1
    }

    public fun fee_split(arg0: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg1: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg2: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg4: vector<Route>) : FeeSplit {
        assert!(0x1::vector::length<Route>(&arg4) <= 16, 8);
        let v0 = &arg4;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Route>(v0)) {
            let v2 = 0x1::vector::borrow<Route>(v0, v1);
            let v3 = &arg4;
            let v4 = 0;
            let v5 = 0;
            while (v5 < 0x1::vector::length<Route>(v3)) {
                if (0x1::vector::borrow<Route>(v3, v5).destination == v2.destination) {
                    v4 = v4 + 1;
                };
                v5 = v5 + 1;
            };
            assert!(v4 == 1, 24);
            v1 = v1 + 1;
        };
        let v6 = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg0) + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg1) + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg2) + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg3);
        0x1::vector::reverse<Route>(&mut arg4);
        let v7 = 0;
        while (v7 < 0x1::vector::length<Route>(&arg4)) {
            let v8 = 0x1::vector::pop_back<Route>(&mut arg4);
            v6 = v6 + 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(v8.bps);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<Route>(arg4);
        assert!(v6 == 10000, 7);
        FeeSplit{
            creator_bps : arg0,
            auto_lp_bps : arg1,
            rewards_bps : arg2,
            burn_bps    : arg3,
            recipients  : arg4,
        }
    }

    public fun plan(arg0: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg1: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg2: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg3: vector<Recipient>) : AllocationPlan {
        assert!(0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg0) > 0 && 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::value(arg1) > 0, 7);
        AllocationPlan{
            curve_meme_bps     : arg0,
            lp_meme_bps        : arg1,
            lp_quote_bps       : arg2,
            protocol_meme_bps  : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
            protocol_quote_bps : 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::new(0),
            recipients         : arg3,
        }
    }

    public(friend) fun protocol_allocation(arg0: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg1: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) : ProtocolAllocation {
        ProtocolAllocation{
            meme_bps  : arg0,
            quote_bps : arg1,
        }
    }

    public fun recipient(arg0: address, arg1: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps, arg2: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) : Recipient {
        assert!(arg0 != @0x0, 6);
        Recipient{
            destination : arg0,
            meme_bps    : arg1,
            quote_bps   : arg2,
        }
    }

    public fun recipients(arg0: &FeeSplit) : &vector<Route> {
        &arg0.recipients
    }

    public fun route(arg0: address, arg1: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::bps::Bps) : Route {
        assert!(arg0 != @0x0, 6);
        Route{
            destination : arg0,
            bps         : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

