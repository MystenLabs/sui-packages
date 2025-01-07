module 0xd81a0cb79357b5ccc223281113d176b89c06cabccb785ea9b3a0319fe15acc96::humanscoin {
    struct HUMANSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMANSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMANSCOIN>(arg0, 9, b"HUMANSCOIN", b"Human", x"746f2062652072696368f09f91be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80fda8b9-3897-448d-8508-acb310a4ab93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMANSCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUMANSCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

