module 0x26ef689b1425cfa4cd6e38a1e19695dfcd38dc206605db669cf3a5eea32f3c27::catz {
    struct CATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZ>(arg0, 9, b"CATZ", b"Cats", b"Meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42428f2c-8236-4595-8d59-233881acb4fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

