module 0x6dfb56af01584829777e00da811da3a318aa7d988ef4c6954b66bde8d07ab9a4::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOraclePriceUpdateRequest<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::set_primary_price<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOraclePriceUpdateRequest<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::set_secondary_price<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

