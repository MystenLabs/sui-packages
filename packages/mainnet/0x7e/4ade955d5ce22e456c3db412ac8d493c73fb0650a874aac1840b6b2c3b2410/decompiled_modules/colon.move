module 0x7e4ade955d5ce22e456c3db412ac8d493c73fb0650a874aac1840b6b2c3b2410::colon {
    struct COLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FZqHDGiCWAQgoWnx7bnW5SGU7SdSqy75ZNryJH9Bbonk.png?claimId=CcP-la39FbTfUnXm                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COLON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"COLON       ")))), trim_right(b"                                "), trim_right(b"COLON                                                                                                                                                                                                                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLON>>(v4);
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

