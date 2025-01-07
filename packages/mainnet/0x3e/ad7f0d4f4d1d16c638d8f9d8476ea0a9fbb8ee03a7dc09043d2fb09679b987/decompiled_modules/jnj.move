module 0x3ead7f0d4f4d1d16c638d8f9d8476ea0a9fbb8ee03a7dc09043d2fb09679b987::jnj {
    struct JNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNJ>(arg0, 9, b"JNJ", b"Joni Joni", b"Fulata andei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cef5e9ac-e51b-4e11-a5cc-75228941d2b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JNJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

