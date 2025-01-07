module 0x1ef9ec0e9223f91ff231f4821b4dbb2abde304ffdcaf65615514056e45002079::qazaq {
    struct QAZAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QAZAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QAZAQ>(arg0, 9, b"QAZAQ", b"QAZAQs", b"It's just a meme. Kazakh without show-offs, non-show-off Kazakh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86e71ed2-cfa4-43b3-8551-532c7e423e74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QAZAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QAZAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

