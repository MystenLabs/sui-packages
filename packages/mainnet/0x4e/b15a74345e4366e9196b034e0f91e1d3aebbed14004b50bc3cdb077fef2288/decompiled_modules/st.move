module 0x4eb15a74345e4366e9196b034e0f91e1d3aebbed14004b50bc3cdb077fef2288::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4FWubzC5xt36hA4o75hzZEo9PjhzaTGmGJBhJ7Gmpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ST          ")))), trim_right(b"Super Trencher                  "), trim_right(b"Super Trencher mashes Super Mariostyle platforming with trenching. Collect coins, dodge rug pulls, avoid red candles and use green candles, conquer al the DEXs for generational wealth. Meet Super Trencher, our hero: a 20-something memecoin junkie still crashing at his moms place, trading memecoins instead of social out"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST>>(v4);
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

