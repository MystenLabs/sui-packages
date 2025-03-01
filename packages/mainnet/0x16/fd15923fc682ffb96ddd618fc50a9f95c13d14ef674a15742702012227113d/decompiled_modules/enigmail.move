module 0x16fd15923fc682ffb96ddd618fc50a9f95c13d14ef674a15742702012227113d::enigmail {
    struct ENIGMAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENIGMAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9RcsxxzHP41oemEqcKFS86b8piDGLQ1PwkLDrqeZjpDE.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ENIGMAIL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ENIGMAIL    ")))), trim_right(b" ENIGMAIL                       "), trim_right(b"EnigMail is a decentralized, end-to-end encrypted messaging platform that eliminates surveillance, tracking, and third-party control. Powered by blockchain, it offers tamper-proof messaging, dApp connectivity, and crypto wallet integration for secure, censorship-resistant communication.                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENIGMAIL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENIGMAIL>>(v4);
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

