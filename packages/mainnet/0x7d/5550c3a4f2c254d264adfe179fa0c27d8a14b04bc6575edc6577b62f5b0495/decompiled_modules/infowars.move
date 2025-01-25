module 0x7d5550c3a4f2c254d264adfe179fa0c27d8a14b04bc6575edc6577b62f5b0495::infowars {
    struct INFOWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFOWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6f9yB743Cf4RiRL7fAn9yRQ5VEnDEFVVYVoKwNr6pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<INFOWARS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"INFOWARS    ")))), trim_right(b"FREE INFOWARS                   "), trim_right(b"In October of 2022, Alex Jones was court ordered to pay nearly $1B to Sandy Hook families in a defamation lawsuit. The largest defamation penalty in history. Alex was forced to declare bankruptcy, despite claiming to be worth a small fraction of the $1B figure proposed. While Alex's claims were extreme, it's clear this"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFOWARS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFOWARS>>(v4);
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

