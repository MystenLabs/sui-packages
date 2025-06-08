module 0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::switchboard_price_fetcher {
    public fun fetch_price<T0>(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: u8) : 0x1::option::Option<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>> {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg0);
        let v1 = (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::scale_to_decimals(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0), arg1) as u64);
        if (v1 == 0) {
            return 0x1::option::none<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>()
        };
        0x1::option::some<0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::CurrentPrice<T0>>(0x524c9e4983970477bf711cad5a21c92e03b7dc17cda9fe738c99cceed24a0e7a::current_price::new_current_price<T0>(v1, arg1, (0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0) as u64)))
    }

    // decompiled from Move bytecode v6
}

