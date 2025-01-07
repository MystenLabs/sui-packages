module 0x16274739e709d80ad9b7b16005592ad0a2b9e94ed3ee09c10655136399dacba4::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/69EsdaPzBbLS3VnBhSDwUJsFgGCUBhqinnyeDHiHiCDu.png?size=lg&key=2e986f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FROGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Froge   ")))), trim_right(b"FROGE On Sui                    "), trim_right(b"Froge isn't just another meme -- it's also a mascot! Although FROGE is now known as the unofficial official mascot for OpenAI, its original origins date back to 2014. MUCH WOW. Our frog is as memeable as pepe and as cute as doge  now that's something to be hoppy about!                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGE>>(v4);
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

