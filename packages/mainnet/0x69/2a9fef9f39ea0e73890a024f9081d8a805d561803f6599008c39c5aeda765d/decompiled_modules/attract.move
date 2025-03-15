module 0x692a9fef9f39ea0e73890a024f9081d8a805d561803f6599008c39c5aeda765d::attract {
    struct ATTRACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EVyHS76CS6ojt2DzyJJ7HBPirmxRfsbkhdDYBae6pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ATTRACT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ATTRACT     ")))), trim_right(b"Don't Chase Attract             "), trim_right(b"In the wild world of crypto, most traders chase pumps and end up holding bags. But the real winners? They let success come to them. $ATTRACT is more than just a Solana coinits a mindset. You dont need to run after moonshots when the right play naturally pulls in the gains. Sit back, stack up, and let the market come to"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTRACT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATTRACT>>(v4);
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

