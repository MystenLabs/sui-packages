module 0x130affbaf4f5b4af0dc62ba29f9b58b3d0df6e5c492f07397f289bd0f92d2d19::abl {
    struct ABL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABL>(arg0, 9, b"ABL", b"Abhanda ", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc448e61-13bf-4613-8ce5-89fe75525155.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABL>>(v1);
    }

    // decompiled from Move bytecode v6
}

