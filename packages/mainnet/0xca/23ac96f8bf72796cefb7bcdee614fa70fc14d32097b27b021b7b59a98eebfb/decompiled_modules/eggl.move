module 0xca23ac96f8bf72796cefb7bcdee614fa70fc14d32097b27b021b7b59a98eebfb::eggl {
    struct EGGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGL>(arg0, 9, b"EGGL", b"EAGLE GIR", b"LET'S FLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f99c458-b9be-47d3-81e6-9a4ac7b1f143.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

