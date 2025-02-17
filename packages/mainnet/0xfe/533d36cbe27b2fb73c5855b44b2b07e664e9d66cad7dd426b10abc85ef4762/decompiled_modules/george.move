module 0xfe533d36cbe27b2fb73c5855b44b2b07e664e9d66cad7dd426b10abc85ef4762::george {
    struct GEORGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EVC76b5NryJGr58TyJjW3G1JNWfuyjryn9YFJW4w3mQJ.png?claimId=5BIW-qh0kAflW_AF                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GEORGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"George      ")))), trim_right(b"Washington First President      "), trim_right(b"George Washington - the OG man in office, the first and foremost to ever serve as the head of this beautiful country! The man whose birth is celebrated today as a National American holiday: Presidents Day. A day we can drink beers, celebrate our freedom, and get our money up while we honor George and all his bad assery"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEORGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEORGE>>(v4);
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

