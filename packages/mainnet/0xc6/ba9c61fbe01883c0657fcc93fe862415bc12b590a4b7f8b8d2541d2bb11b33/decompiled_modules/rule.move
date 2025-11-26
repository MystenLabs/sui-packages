module 0xc6ba9c61fbe01883c0657fcc93fe862415bc12b590a4b7f8b8d2541d2bb11b33::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOraclePriceUpdateRequest<0xc6a7794b839669f78a637485e89da3430a9c494ea616643f02946575c490ce7::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::set_primary_price<0xc6a7794b839669f78a637485e89da3430a9c494ea616643f02946575c490ce7::coin_gr::COIN_GR, Rule>(v0, arg0, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOraclePriceUpdateRequest<0xc6a7794b839669f78a637485e89da3430a9c494ea616643f02946575c490ce7::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::set_secondary_price<0xc6a7794b839669f78a637485e89da3430a9c494ea616643f02946575c490ce7::coin_gr::COIN_GR, Rule>(v0, arg0, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

