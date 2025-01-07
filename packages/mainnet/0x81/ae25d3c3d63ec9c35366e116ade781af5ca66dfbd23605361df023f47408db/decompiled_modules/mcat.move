module 0x81ae25d3c3d63ec9c35366e116ade781af5ca66dfbd23605361df023f47408db::mcat {
    struct MCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 9, b"MCAT", b"Meme", b"Hahaha bauiaha. Auajaja", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb4855d7-f85b-45f3-b5ef-7cd5c2e18a6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

