module 0x9d694117fcdaa3a38f76b8fb1fb8f193dcedc6845325e3a83770d20928bb37d7::switchboard_price_fetcher {
    public fun fetch_price(arg0: 0x1::ascii::String, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: u8) : 0x1::option::Option<0x9d694117fcdaa3a38f76b8fb1fb8f193dcedc6845325e3a83770d20928bb37d7::current_price::CurrentPrice> {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg1);
        let v1 = (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::scale_to_decimals(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0), arg2) as u64);
        if (v1 == 0) {
            return 0x1::option::none<0x9d694117fcdaa3a38f76b8fb1fb8f193dcedc6845325e3a83770d20928bb37d7::current_price::CurrentPrice>()
        };
        0x1::option::some<0x9d694117fcdaa3a38f76b8fb1fb8f193dcedc6845325e3a83770d20928bb37d7::current_price::CurrentPrice>(0x9d694117fcdaa3a38f76b8fb1fb8f193dcedc6845325e3a83770d20928bb37d7::current_price::new_current_price(arg0, v1, arg2, (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0) as u64)))
    }

    // decompiled from Move bytecode v6
}

