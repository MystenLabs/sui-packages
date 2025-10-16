module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote_emit_result_action {
    struct QuoteVerified has copy, drop {
        timestamp_ms: u64,
        slot: u64,
        feed_id: vector<u8>,
        oracles: vector<0x2::object::ID>,
        queue: 0x2::object::ID,
    }

    public fun run(arg0: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quotes) {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::quotes_vec(&arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quote>(&v0)) {
            let v2 = 0x1::vector::borrow<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::Quote>(&v0, v1);
            let v3 = QuoteVerified{
                timestamp_ms : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::timestamp_ms(v2),
                slot         : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::slot(v2),
                feed_id      : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::feed_id(v2),
                oracles      : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::oracles(&arg0),
                queue        : 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::quote::queue_id(&arg0),
            };
            0x2::event::emit<QuoteVerified>(v3);
            v1 = v1 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

