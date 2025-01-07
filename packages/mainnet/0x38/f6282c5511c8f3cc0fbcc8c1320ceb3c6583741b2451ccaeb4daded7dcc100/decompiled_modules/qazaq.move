module 0x38f6282c5511c8f3cc0fbcc8c1320ceb3c6583741b2451ccaeb4daded7dcc100::qazaq {
    struct QAZAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QAZAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QAZAQ>(arg0, 9, b"QAZAQ", b"QAZAQs", b"It's just a meme. Kazakh without show-offs, non-show-off Kazakh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba1be424-3de3-40a0-8b04-9b9e232f2e16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QAZAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QAZAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

