module 0xa1bc490581911497611a008c4934212cdf253df125237bebf446fd9f604274e7::CHAR {
    struct CHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHAR>(arg0, 9, 0x1::string::utf8(b"CHAR"), 0x1::string::utf8(b"Charizard"), 0x1::string::utf8(b"The ultimate fire-breathing dragon Pokemon. Charizard flies around the sky in search of powerful opponents. It breathes fire of such great heat that it melts anything."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHAR>>(0x2::coin_registry::finalize<CHAR>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHAR>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAR>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

