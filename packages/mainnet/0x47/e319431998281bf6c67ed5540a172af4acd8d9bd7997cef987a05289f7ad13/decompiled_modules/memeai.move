module 0x47e319431998281bf6c67ed5540a172af4acd8d9bd7997cef987a05289f7ad13::memeai {
    struct MEMEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEAI>(arg0, 6, b"MemeAi", b"Meme Ai", b"MemeAi generates random memes using AI, bringing endless humor and creativity with every click!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0653_459c5132fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

