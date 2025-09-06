module 0xcb387e7a8bcd34adb1bde0780add8e9138afdfe4ff9aa2dc5437124c29c60e8e::match {
    struct MATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"35cbd9138910c72d13cd7837eac24cf4186426a263c91daefe005a6ad25cb080                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MATCH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MATCH       ")))), trim_right(b"SolMatch                        "), trim_right(b"SolMatch is the premier platform in finding your solana trading partners with just a swipe. Connect with like-minded traders who share your passion for Solana and Memecoins. Collaborate for smarter trades, stronger conviction, and better outcomes.                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATCH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATCH>>(v4);
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

