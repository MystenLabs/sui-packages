module 0xdbdd89211b47b5201a5eed9308c714fbe67cec1d86d4a080991e7ec27c26a251::mudkiponsu {
    struct MUDKIPONSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUDKIPONSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUDKIPONSU>(arg0, 6, b"Mudkiponsu", b"Mudkips", x"437574657374204d75646b6970206973206c61756e6368206f6e202353756920626c7570707020626c7570707020f09faba7f09faba7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955118200.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUDKIPONSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUDKIPONSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

