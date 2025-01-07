module 0x2f90e3e75eccc51c4762141f588dd92177d484d2955d8d073cf0fdfd8477df2e::bushi {
    struct BUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSHI>(arg0, 6, b"BUSHI", b"$BUSHI", b"Bushi, The Last Samurai. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240927_183901_1_349c3e7ccb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

