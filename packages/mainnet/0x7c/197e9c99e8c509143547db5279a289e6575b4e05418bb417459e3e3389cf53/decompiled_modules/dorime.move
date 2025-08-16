module 0x7c197e9c99e8c509143547db5279a289e6575b4e05418bb417459e3e3389cf53::dorime {
    struct DORIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3vbEjG3Mtyu8WA4NxSbw4GopNgN1Qk54xpN7c25wx777.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DORIME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DORIME      ")))), trim_right(b"Dorime                          "), trim_right(x"416e64207768656e20776520656e746572207468656d20676f20706c617920446f72696d650a446f72696d652061680a416e64207768656e20776520656e746572207468656d20676f20706c617920616d656e6f0a416d656e6f2061680a416e642077686e20776520656e7465722074686d20676f20706c617920446f72696d650a446f72696d652061680a416e64207768656e20776520656e746572207468656d20676f20706c617920616d656e6f0a416d656e6f206168202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORIME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORIME>>(v4);
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

