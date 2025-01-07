module 0xf4f197d5b99244b2d771396142cda2902025b9e158c5e9dbe25d00f1c0be557d::chi77 {
    struct CHI77 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHI77, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHI77>(arg0, 9, b"CHI77", b"Chizzy", b"Simplicity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3417f248-e206-4f82-a995-27feb801b3e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHI77>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHI77>>(v1);
    }

    // decompiled from Move bytecode v6
}

