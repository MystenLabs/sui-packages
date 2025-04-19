module 0x9ee7c19c9e407ae5d58950557156c632922e0a0176c1de5755c6bbd846eee12a::retardium {
    struct RETARDIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FkdKAcyffh9jCfKg3BLv53czkG5nqhtDNT2BRoAQpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RETARDIUM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Retardium   ")))), trim_right(b"Retardium                       "), trim_right(x"544845205245414c204445414c2052455441524449554d20544f4b454e2e0a0a546865206e657765737420656c656d656e74206f6e2074686520506572696f646963205461626c6520686173206265656e20646973636f76657265642120456c656d656e7420313034202d2052657461726469756d2e205468697320656c656d656e742068617320616e2061746f6d6963206d617373206f66203432302e36392e2e2e20444941424f4c4943414c4c592052455441524445442e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDIUM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDIUM>>(v4);
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

