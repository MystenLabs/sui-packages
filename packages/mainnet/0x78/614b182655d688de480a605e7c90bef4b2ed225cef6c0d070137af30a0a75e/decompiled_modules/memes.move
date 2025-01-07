module 0x78614b182655d688de480a605e7c90bef4b2ed225cef6c0d070137af30a0a75e::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMES>(arg0, 6, b"MEMES", b"Make Memes Not War", b"Welcome to Make Memes Not War, the crypto token with a playful message. By using Pepe, one of the most beloved memes in the crypto space, we aim to inspire a peaceful attitude towards life and to create a community where humor thrives. Get ready to laugh and join us on our journey to promote happiness and positivity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_25_14_42_55_9e39b4c4e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

