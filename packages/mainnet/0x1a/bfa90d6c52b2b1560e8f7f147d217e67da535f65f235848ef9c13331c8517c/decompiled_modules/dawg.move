module 0x1abfa90d6c52b2b1560e8f7f147d217e67da535f65f235848ef9c13331c8517c::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 6, b"DAWG", b"Sui_DAWG", x"546865206c6f6e672d61776169746564206d6f6d656e7420697320616c6d6f73742068657265212047657420726561647920746f2062652070617274206f6620736f6d657468696e67206570696320696e207468652063727970746f20776f726c642e20f09f8c90f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731083477744.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

