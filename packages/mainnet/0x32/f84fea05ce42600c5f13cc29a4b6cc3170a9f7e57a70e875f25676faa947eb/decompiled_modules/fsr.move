module 0x32f84fea05ce42600c5f13cc29a4b6cc3170a9f7e57a70e875f25676faa947eb::fsr {
    struct FSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8ihkFrPHVb8SEv61LMye84HE78zCYqjNAwxb1SBQpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FSR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FSR         ")))), trim_right(b"fartcoin strategic reserve      "), trim_right(b"Fartcoin Strategic Reserve is a token designed to ensure the long-term stability and liquidity of the Fartcoin ecosystem. Held in a strategic reserve fund, it helps regulate supply, support development efforts, and protect the token's value during market fluctuations. This token also plays a key role in governance, ena"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSR>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

