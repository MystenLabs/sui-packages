module 0x8c2a204d1ac443a925cec8f55190454600205ac46bee92fe5c5904e892dd6b::zx {
    struct ZX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZX>(arg0, 9, b"ZX", b"Zx25", b"Meme 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e53c5a09-30b0-44e7-b1fb-dd82b30b1b93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZX>>(v1);
    }

    // decompiled from Move bytecode v6
}

