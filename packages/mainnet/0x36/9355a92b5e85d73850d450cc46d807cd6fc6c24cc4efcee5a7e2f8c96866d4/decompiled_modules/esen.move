module 0x369355a92b5e85d73850d450cc46d807cd6fc6c24cc4efcee5a7e2f8c96866d4::esen {
    struct ESEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESEN>(arg0, 6, b"Esen", b"EmoSense AI", b"EmoSense is here to understand you, listen to your feelings, and engage with empathy, clarity, and intelligence. Whether you need a friendly conversation, emotional support, or just someone to chat with, EmoSense is ready to connect with you in a meaningful way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2299_b8cc6d9427.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

