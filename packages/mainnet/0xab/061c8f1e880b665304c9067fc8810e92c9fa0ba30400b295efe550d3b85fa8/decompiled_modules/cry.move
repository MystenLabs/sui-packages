module 0xab061c8f1e880b665304c9067fc8810e92c9fa0ba30400b295efe550d3b85fa8::cry {
    struct CRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRY>(arg0, 9, b"CRY", b"Cherry", b"Dedicated to mi wifu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b2efb33-a04f-4f36-8d32-6879178c0f79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

