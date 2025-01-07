module 0xa3fe6100898393dd514fb5481583384e3d0e0c6b61822ff4a957cda0d978d032::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARC>(arg0, 9, b"ARC", b"Armin coin", b"Ai gen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5889b38-e4c8-4ebc-88fd-45f5a643c092.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

