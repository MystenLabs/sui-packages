module 0xdf42c5183b8287feefc6e8bf0e606d0b11665313e9b316b95162d59289eba43b::rotate {
    struct ROTATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROTATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROTATE>(arg0, 6, b"Rotate", b"Rotatoooor", b"I'm rotatingggggggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_Ax_P3_SXM_Ak7hj_B_d31864d660.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROTATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROTATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

