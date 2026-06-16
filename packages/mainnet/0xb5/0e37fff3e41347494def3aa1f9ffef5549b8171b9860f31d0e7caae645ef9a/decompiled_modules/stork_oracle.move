module 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_oracle {
    public fun refresh_stork_rwa_price<T0>(arg0: &mut 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::XOracle, arg1: &0xbc96aa8e79e0831131f00e7d9568fb40f283e6b96c2516dd99aa26b67459b60a::state::StorkState, arg2: &0x2::clock::Clock) {
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::ensure_version_matches(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, v2) = 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::refresh_stork_price(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::borrow_mut<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::stork_feed::StorkFeedInfo>(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::stork_feed_registry_mut(arg0), v0), arg1, arg2);
        let v3 = v2;
        let v4 = v1;
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::ensure_within_bounds(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::asset_registry::borrow<0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets::BoundedAssetConfig>(0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::rwa_registry(arg0), v0), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::value(&v4), 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::price_feed::value(&v3));
        0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::update_price_feed(arg0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::x_oracle::usd(), v0, v4, v3);
    }

    // decompiled from Move bytecode v7
}

