module 0x2b1b13a75926a6b4fca097cc3630ba73cd8c1178e7aaf50c0aa89e5678f628e6::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"WTF", b"What The Fuck", b"wtf ! The unpredictable memecoin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731338332418.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

