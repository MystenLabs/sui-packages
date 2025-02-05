module 0xf2b504a03413ef86771cf3f35d2b1b0a7b1cfc098b549a5d053a48a11fbe0264::pedo {
    struct PEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G3o28X1DkqmQKyHzFL6rK5ghTHjYiUirtQstiz7qpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEDO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEDO        ")))), trim_right(b"PEDOBEAR                        "), trim_right(b"Pedobear is a cartoon mascot that became a well-known icon through its usage on4chanto signal moderators and other users that illegal pornographic content had been posted. Due to the widespread nature of its application, Pedobear has been often misinterpreted as a symbol of pedophilia andlolita complex, especially in t"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEDO>>(v4);
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

