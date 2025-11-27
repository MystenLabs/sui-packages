module 0xb1d144ba063cc12fb8c9fe5efacd0e69509394de8759e05bfa613a14faae6026::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOraclePriceUpdateRequest<0xbf037e13ae31fa694fa7917c22f5575f6977f24a1f6c49693272d3ea7026fc15::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::set_primary_price<0xbf037e13ae31fa694fa7917c22f5575f6977f24a1f6c49693272d3ea7026fc15::coin_gr::COIN_GR, Rule>(v0, arg0, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOraclePriceUpdateRequest<0xbf037e13ae31fa694fa7917c22f5575f6977f24a1f6c49693272d3ea7026fc15::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::set_secondary_price<0xbf037e13ae31fa694fa7917c22f5575f6977f24a1f6c49693272d3ea7026fc15::coin_gr::COIN_GR, Rule>(v0, arg0, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

