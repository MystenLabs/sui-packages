module 0x8805583ed963ad35fcb4c93884317d34bad3d8b2e7938ec3fbac9c7160e7993e::horse {
    struct HORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSE>(arg0, 9, b"HORSE", b"Horse", b"Neighing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eba35d4e-dd7a-47f6-a328-3095c3ac3b23.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

