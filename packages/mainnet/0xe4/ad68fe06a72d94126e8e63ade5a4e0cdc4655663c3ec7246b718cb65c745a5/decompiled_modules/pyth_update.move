module 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_update {
    struct NewPythPriceFeed has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        pyth_pro_feed_id: u32,
        expected_channel_id: u8,
    }

    public fun register_pyth_feed<T0>(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: u32, arg3: u8, arg4: u16, arg5: u64, arg6: u64) {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg1);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_adaptor::register_pyth_feed<T0>(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::pyth_pro_feeds_mut(arg1), arg2, arg3, arg4, arg5, arg6);
        let v0 = NewPythPriceFeed{
            oracle              : 0x2::object::id<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle>(arg1),
            asset               : 0x1::type_name::with_defining_ids<T0>(),
            pyth_pro_feed_id    : arg2,
            expected_channel_id : arg3,
        };
        0x2::event::emit<NewPythPriceFeed>(v0);
    }

    public fun refresh_pyth_price_feed<T0>(arg0: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::update::OracleUpdateHotPotato<T0>, arg3: &0x2::clock::Clock) : 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::update::OracleUpdateHotPotato<T0> {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg0);
        let v0 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::borrow_mut<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_adaptor::PythProFeedInfo>(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::pyth_pro_feeds_mut(arg0), 0x1::type_name::with_defining_ids<T0>());
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::channel(arg1);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_adaptor::assert_channel_matches(v0, &v1);
        let v2 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds_ref(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2)) {
            let v4 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v2, v3);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v4) == 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_adaptor::feed_id(v0)) {
                let (v5, v6) = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::pyth_adaptor::refresh_pyth_price(v0, v4, arg3);
                return 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::update::insert_price_feed<T0>(arg2, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::pyth_source(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::new(v6, v5))
            };
            v3 = v3 + 1;
        };
        abort 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::oracle_error::oracle_price_not_found_error()
    }

    // decompiled from Move bytecode v7
}

