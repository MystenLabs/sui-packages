module 0xd794dd80040003fb76bf57faa8b26a04cb6ebaf20eb6fa6586577a2672121a8::fozer {
    struct FOZER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOZER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HmQhWUPiinN5nsTQTuWAaQhBaZV6d5buakEzb3gPpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FOZER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FOZER       ")))), trim_right(b"Fozer Pro Ai                    "), trim_right(b"Fozer Pro AI is an advanced AI technology for health, designed to find out which foods are suitable for your body. Get detailed nutritional information from any food image in seconds with our advanced AI technology. View calories, macronutrients, serving sizes, and health insights all in one place. Perfect for tracking"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOZER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOZER>>(v4);
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

