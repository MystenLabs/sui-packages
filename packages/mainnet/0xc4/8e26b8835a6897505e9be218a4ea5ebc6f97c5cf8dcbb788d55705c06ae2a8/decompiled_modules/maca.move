module 0xc48e26b8835a6897505e9be218a4ea5ebc6f97c5cf8dcbb788d55705c06ae2a8::maca {
    struct MACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACA>(arg0, 6, b"MACA", b"Macarena", b"Macarena (MACA) is a playful meme token inspired by the iconic dance. Embracing humor and community spirit, MACA aims to bring joy and laughter to the crypto space. Join the fun, share the memes, and lets dance our way through the blockchain together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_1_5230fd8fa0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

