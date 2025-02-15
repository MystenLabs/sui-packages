module 0x9d0f6786bc2ce755304b0837f045681268e818416487dd243a000689259dbbad::usa_savior {
    struct USA_SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: USA_SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"EehEL2bK5Pf9VFMJ                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USA_SAVIOR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USA_Savior  ")))), trim_right(b"USA_Savior                      "), trim_right(b"SaviorCoin (SAV) isnt just a meme coinits a patriotic movement forged in the fires of freedom, memes, and Elon Musks Twitter chaos. Born from the legendary tweet He who saves his Country does not violate any Law, SAV is here to unite diamond-handed patriots, crypto degenerates, and fans of big walls, bigger rockets, an"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USA_SAVIOR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USA_SAVIOR>>(v4);
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

