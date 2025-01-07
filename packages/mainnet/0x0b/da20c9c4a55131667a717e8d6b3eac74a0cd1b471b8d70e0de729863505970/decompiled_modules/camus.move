module 0xbda20c9c4a55131667a717e8d6b3eac74a0cd1b471b8d70e0de729863505970::camus {
    struct CAMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMUS>(arg0, 9, b"CAMUS", b"AlbertCam", b"AlbertCamus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2c67e6d-08fd-42c5-aa4d-43b1cfed9d21.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

