module 0x7983d079499971ea92b006a7a985b4f14d718576a4dc5dfc747ff9b96b73b170::jn {
    struct JN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JN>(arg0, 9, b"JN", b"JOURNAL", b"Inspired Halloween meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4f6dc8b-cf56-475e-8c5b-7bee64b241d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JN>>(v1);
    }

    // decompiled from Move bytecode v6
}

