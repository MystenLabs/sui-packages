module 0x3e25eaed75644e67a9a6cd3d1ac502bce630c876fdc5f699e8f0abb629e2d7c::shrimple {
    struct SHRIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMPLE>(arg0, 6, b"SHRIMPLE", b"Shrimple On Sui", b"Shrimple is a playful meme that combines the image of a shrimp with the word \"simple.\" It humorously captures the essence of simplicity while adding a fun seafood twist to everyday situations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_045507_06d6ace431.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

