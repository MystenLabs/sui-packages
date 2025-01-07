module 0x3c690df2fd4ecd3fa9a31b5c87c69a6d316a3641eb6a760c9aebb22b597a7977::musk {
    struct MUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSK>(arg0, 6, b"Musk", b"Obi sui", b"First meme coin  obi pnut kenobi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0055_2f27f1f82e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

