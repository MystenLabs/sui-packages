module 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_oracle {
    struct NewStorkFeed has copy, drop {
        feed_id: vector<u8>,
        ema_feed_id: vector<u8>,
        asset: 0x1::type_name::TypeName,
        who: address,
        timestamp: u64,
    }

    public fun refresh_stork_price_feed<T0>(arg0: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg2: 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::update::OracleUpdateHotPotato<T0>, arg3: &0x2::clock::Clock) : 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::update::OracleUpdateHotPotato<T0> {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg0);
        let (v0, v1) = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::refresh_stork_price(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::borrow_mut<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::StorkFeedInfo>(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::stork_feed_registry_mut(arg0), 0x1::type_name::with_defining_ids<T0>()), arg1, arg3);
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::update::insert_price_feed<T0>(arg2, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset::stork_source(), 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::price_feed::new(v0, v1))
    }

    public fun upsert_stork_feed<T0>(arg0: &0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::AdminCap, arg1: &mut 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::XOracle, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::ensure_version_matches(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::x_oracle::stork_feed_registry_mut(arg1);
        if (0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::has_asset<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::StorkFeedInfo>(v1, v0)) {
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::update_feed_ids(0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::borrow_mut<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::StorkFeedInfo>(v1, v0), arg2, arg3);
        } else {
            0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::asset_registry::set<0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::StorkFeedInfo>(v1, v0, 0x6d801b4d9099b78a67477cdc0ddd6018113b280226a0b1708169a605453ec4cb::stork_feed::new(arg2, arg3));
        };
        let v2 = NewStorkFeed{
            feed_id     : arg2,
            ema_feed_id : arg3,
            asset       : v0,
            who         : 0x2::tx_context::sender(arg5),
            timestamp   : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<NewStorkFeed>(v2);
    }

    // decompiled from Move bytecode v7
}

