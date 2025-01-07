module 0x7d076dae8ebb154d67c75ec428f83b55ea32ad53895923ff2fc8be525f5d2592::crypto75 {
    struct CRYPTO75 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO75, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTO75>(arg0, 9, b"CRYPTO75", b"Hsa", b"Hsa7575 crypto lover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/093872cc-9a46-4f41-96b0-3cc11ceb8d9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO75>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTO75>>(v1);
    }

    // decompiled from Move bytecode v6
}

