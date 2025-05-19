module 0x17960a47d70bd5798bfe61c81d73edfea26c6b467d03177ef870a8c28c19e017::pepecn {
    struct PEPECN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EASG47ZTGkQx2e5HqYmikc1scsMjCoD4mHinT1Kgac4s.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPECN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPECN      ")))), trim_right(b"Pepe Chinese                    "), trim_right(x"50657065204368696e65736520202450455045434e0a5468652066726f672068617320656e74657265642074686520456173742e200a4b756e672d6675206d656d65732e2043686f70737469636b20707265636973696f6e2e0a4368617274206d6f766573206c696b65206120647261676f6e2c2064756d7073206c696b6520612066697265637261636b65722e0a546869732069736e74206a75737420506570652e20546869732069732020285a686e67677520516e6777292e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECN>>(v4);
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

