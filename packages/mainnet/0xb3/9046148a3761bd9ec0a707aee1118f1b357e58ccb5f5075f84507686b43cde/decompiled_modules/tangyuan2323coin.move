module 0xb39046148a3761bd9ec0a707aee1118f1b357e58ccb5f5075f84507686b43cde::tangyuan2323coin {
    struct TANGYUAN2323COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANGYUAN2323COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANGYUAN2323COIN>(arg0, 6, b"TANGYUAN2323COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TANGYUAN2323COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANGYUAN2323COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

