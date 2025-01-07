module 0x1edfeb44a64627c282b3cef0acefc90d1699af6011ede4fd634fd116a561ece0::sdsss {
    struct SDSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDSSS>(arg0, 6, b"SDSSS", b"testing", b"asdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953657275.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDSSS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDSSS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

