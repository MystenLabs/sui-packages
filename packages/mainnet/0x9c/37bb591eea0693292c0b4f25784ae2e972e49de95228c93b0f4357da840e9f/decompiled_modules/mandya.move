module 0x9c37bb591eea0693292c0b4f25784ae2e972e49de95228c93b0f4357da840e9f::mandya {
    struct MANDYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANDYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7aBe9kywnhEroyPC7WZAv2QdbfLLmiDJuaAqHGkEFALX.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MANDYA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MANDY       ")))), trim_right(b"MANDY COIN                      "), trim_right(b"Mandy ($MANDY)  Your Go-To Crypto for Health & Vitality! Need quick health advice? Looking for a fast way to rejuvenate your body? Nurse Practitioner Mandy has you covered! Whether its boosting your energy, revitalizing your wellness, or solving those manhood issuesMandy gets the job done. Stay Hard. Stay Healthy. Stay"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANDYA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANDYA>>(v4);
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

