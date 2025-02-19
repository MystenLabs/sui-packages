module 0x86c25df4615aa3a70ff1b2eccc663d07e8033bd83216da88567c6f1db0cb48fe::brat {
    struct BRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DPHXHFRFAVW4Vx1r171zNMz8nSvPVoheQaoHNoQipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRAT        ")))), trim_right(b"Brat                            "), trim_right(b"Merges the iconic characters of Brett by Matt Furie and Bart Simpson into the world of cryptocurrency                                                                                                                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAT>>(v4);
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

