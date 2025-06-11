module 0xed39128051f0c50a2c837d99fbcd80c6166c4f1dcdc16111b892956844c542c3::switchboard_provider {
    struct SwitchboardProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_switchboard_aggregator(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::new(price_from_switchboard_price(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0)), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0) / 1000, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::stdev(v0)))
    }

    fun price_from_switchboard_price(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal) : 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::Price {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::new(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(arg0), 18, true)
    }

    public fun update_switchboard_as_primary<T0>(arg0: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::XOracle, arg1: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::UpdatePriceRequest, arg2: &0x2::clock::Clock, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::update_price_feed_as_primary<T0, SwitchboardProvider>(arg0, arg1, price_feed_from_switchboard_aggregator(arg3), arg2);
    }

    public fun update_switchboard_as_secondary<T0>(arg0: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::XOracle, arg1: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::UpdatePriceRequest, arg2: &0x2::clock::Clock, arg3: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::update_price_feed_as_secondary<T0, SwitchboardProvider>(arg0, arg1, price_feed_from_switchboard_aggregator(arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

