module 0xfd0f9b9e3d8a32f162fbb2cdeccecd6594ca8978f77b2c151e260b3466f4f41f::chilloween {
    struct CHILLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3bd3829cbeb185db53e8ed76acab37caf8b05a2c88cf0be174c683b6fd3e185f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHILLOWEEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHILLOWEEN  ")))), trim_right(b"CHILLOWEEN                      "), trim_right(b"CHILLOWEEN (Chill Guy + Halloween)  isnt just a coin, its a haunted movement.  Were summoning gains from the crypt, flipping tricks into treats, and sending boring coins straight to the graveyard. This is more than Halloweenits CHILLOWEEN, the meme coin where the vibes are eternal and the markets rise from the dead.   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLOWEEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLOWEEN>>(v4);
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

