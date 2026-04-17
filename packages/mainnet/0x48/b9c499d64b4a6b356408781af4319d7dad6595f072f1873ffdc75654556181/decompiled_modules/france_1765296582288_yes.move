module 0x48b9c499d64b4a6b356408781af4319d7dad6595f072f1873ffdc75654556181::france_1765296582288_yes {
    struct FRANCE_1765296582288_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANCE_1765296582288_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANCE_1765296582288_YES>(arg0, 0, b"FRANCE_1765296582288_YES", b"FRANCE_1765296582288 YES", b"FRANCE_1765296582288 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANCE_1765296582288_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANCE_1765296582288_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

