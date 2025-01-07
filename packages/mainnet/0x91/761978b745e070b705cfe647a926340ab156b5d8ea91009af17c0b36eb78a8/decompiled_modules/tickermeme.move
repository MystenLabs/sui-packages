module 0x91761978b745e070b705cfe647a926340ab156b5d8ea91009af17c0b36eb78a8::tickermeme {
    struct TICKERMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERMEME>(arg0, 9, b"TICKERMEME", b"memefa", x"205741564520f09f8c8a20666f6c6c6f77206d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f71bd52-5b2e-4064-a26d-33a3ec4030cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKERMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

