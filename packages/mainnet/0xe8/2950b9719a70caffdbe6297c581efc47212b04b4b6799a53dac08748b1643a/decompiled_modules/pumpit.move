module 0xe82950b9719a70caffdbe6297c581efc47212b04b4b6799a53dac08748b1643a::pumpit {
    struct PUMPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4WMcTsfEMNwhpPhfWDrnKAGintoFhmRcN5p1UDB6pump.png?claimId=_LKE-0ZbBOeq5Z6z                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMPIT      ")))), trim_right(b"BOGDANOFF                       "), trim_right(b"A memecoin inspired by the legendary Bogdanoff twins, the unseen architects of the crypto-world and beyond. From an undisclosed location, they continue to control the markets and shape our future. The plan is in motion...                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPIT>>(v4);
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

