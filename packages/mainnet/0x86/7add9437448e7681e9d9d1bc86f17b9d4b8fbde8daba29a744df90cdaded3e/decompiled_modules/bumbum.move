module 0x867add9437448e7681e9d9d1bc86f17b9d4b8fbde8daba29a744df90cdaded3e::bumbum {
    struct BUMBUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBUM>(arg0, 6, b"BUMBUM", b"WillyBumBum", x"4a6f696e206e6f773a68747470733a2f2f77696c6c7962756d62756d7375692e70726f0a68747470733a2f2f782e636f6d2f42554d6f6e5375690a68747470733a2f2f742e6d652f42756d4f6e537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Willy_Bum_Bum_Logo_Favicon_5efd37cf6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMBUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

