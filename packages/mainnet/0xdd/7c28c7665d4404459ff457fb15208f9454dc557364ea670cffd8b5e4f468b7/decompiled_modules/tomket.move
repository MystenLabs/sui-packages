module 0xdd7c28c7665d4404459ff457fb15208f9454dc557364ea670cffd8b5e4f468b7::tomket {
    struct TOMKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMKET>(arg0, 9, b"TOMKET", b"Tomket lov", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec92c7a7-5691-4dfc-ba78-56b8696788bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMKET>>(v1);
    }

    // decompiled from Move bytecode v6
}

