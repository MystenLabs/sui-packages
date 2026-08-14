module 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::pyth_update {
    struct NewPythPriceFeed has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        pyth_pro_feed_id: u32,
        expected_channel_id: u8,
    }

    public fun register_pyth_feed<T0>(arg0: &0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::AdminCap, arg1: &mut 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg2: u32, arg3: u8, arg4: u16, arg5: u64, arg6: u64) {
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::ensure_version_matches(arg1);
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::pyth_adaptor::register_pyth_feed<T0>(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::pyth_pro_feeds_mut(arg1), arg2, arg3, arg4, arg5, arg6);
        let v0 = NewPythPriceFeed{
            oracle              : 0x2::object::id<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle>(arg1),
            asset               : 0x1::type_name::with_defining_ids<T0>(),
            pyth_pro_feed_id    : arg2,
            expected_channel_id : arg3,
        };
        0x2::event::emit<NewPythPriceFeed>(v0);
    }

    public fun refresh_pyth_price_feed<T0>(arg0: &mut 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::XOracle, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::update::OracleUpdateHotPotato<T0>, arg3: &0x2::clock::Clock) : 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::update::OracleUpdateHotPotato<T0> {
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset_registry::borrow_mut<0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::pyth_adaptor::PythProFeedInfo>(0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::x_oracle::pyth_pro_feeds_mut(arg0), 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::channel(arg1);
        0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::pyth_adaptor::assert_channel_matches(v0, &v1);
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds_ref(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2)) {
            let v4 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2, v3);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v4) == 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::pyth_adaptor::feed_id(v0)) {
                let (v5, v6) = 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::pyth_adaptor::refresh_pyth_price(v0, v4, arg3);
                return 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::update::insert_price_feed<T0>(arg2, 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::asset::pyth_source(), 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::price_feed::new(v6, v5))
            };
            v3 = v3 + 1;
        };
        abort 0xa9f3151ca9229c8bf46daa4d6be781d7f422d58a8bca7e1ac3f1861668ec47e9::oracle_error::oracle_price_not_found_error()
    }

    // decompiled from Move bytecode v6
}

