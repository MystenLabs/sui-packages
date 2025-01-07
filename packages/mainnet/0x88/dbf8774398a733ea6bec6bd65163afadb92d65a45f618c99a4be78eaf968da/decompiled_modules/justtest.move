module 0x88dbf8774398a733ea6bec6bd65163afadb92d65a45f618c99a4be78eaf968da::justtest {
    struct JUSTTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUSTTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUSTTEST>(arg0, 6, b"JUSTTEST", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUSTTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

