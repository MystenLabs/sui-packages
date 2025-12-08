module 0xeb77e3752224e966be3faf3adfb0c17ba70b97438f23546d7a87d4f8bbe5e5a2::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOraclePriceUpdateRequest<0x3b658094a22be42459d664689c4d2ac0e8b30b2727530e32a06187adc874bcc::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::set_primary_price<0x3b658094a22be42459d664689c4d2ac0e8b30b2727530e32a06187adc874bcc::coin_gr::COIN_GR, Rule>(v0, arg0, 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOraclePriceUpdateRequest<0x3b658094a22be42459d664689c4d2ac0e8b30b2727530e32a06187adc874bcc::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::set_secondary_price<0x3b658094a22be42459d664689c4d2ac0e8b30b2727530e32a06187adc874bcc::coin_gr::COIN_GR, Rule>(v0, arg0, 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

