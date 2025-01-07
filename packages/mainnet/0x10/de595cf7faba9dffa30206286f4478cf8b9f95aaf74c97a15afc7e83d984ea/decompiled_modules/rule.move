module 0x10de595cf7faba9dffa30206286f4478cf8b9f95aaf74c97a15afc7e83d984ea::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price<T0>(arg0: &mut 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &mut 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x10de595cf7faba9dffa30206286f4478cf8b9f95aaf74c97a15afc7e83d984ea::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x10de595cf7faba9dffa30206286f4478cf8b9f95aaf74c97a15afc7e83d984ea::pyth_registry::assert_pyth_price_info_object<T0>(arg3, arg2);
        let (v0, _, v2, v3) = 0x10de595cf7faba9dffa30206286f4478cf8b9f95aaf74c97a15afc7e83d984ea::pyth_adaptor::get_pyth_price(arg1, arg2, arg4);
        let v4 = 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::decimals();
        let v5 = if (v2 < v4) {
            v0 * 0x2::math::pow(10, v4 - v2)
        } else {
            v0 / 0x2::math::pow(10, v2 - v4)
        };
        assert!(v5 > 0, 70148);
        let v6 = Rule{dummy_field: false};
        0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::new(v5, v3));
    }

    // decompiled from Move bytecode v6
}

