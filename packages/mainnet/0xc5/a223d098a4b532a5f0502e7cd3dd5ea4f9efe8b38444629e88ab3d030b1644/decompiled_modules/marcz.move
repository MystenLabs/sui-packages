module 0xc5a223d098a4b532a5f0502e7cd3dd5ea4f9efe8b38444629e88ab3d030b1644::marcz {
    struct MARCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARCZ>(arg0, 9, b"MARCZ", b"MARC", b"MARC KUZKUBBER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5710a62e-7d58-4899-981c-2b3c6cb3f1a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARCZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARCZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

