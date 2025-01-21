module 0x3f10d2bfbdfcb698e4f94ad0a4d8315c97a8e2296b78aa2d22473e17c94a88c5::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 9, b"RONALDO", b"c.Ronaldo", b"Ronaldo's first token is managed by artificial intelligence itself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/493077d5-3e2e-4fef-9a4a-57aca1024a29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

