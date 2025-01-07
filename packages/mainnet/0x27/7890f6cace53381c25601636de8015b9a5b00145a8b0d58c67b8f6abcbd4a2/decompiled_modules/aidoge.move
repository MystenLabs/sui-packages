module 0x277890f6cace53381c25601636de8015b9a5b00145a8b0d58c67b8f6abcbd4a2::aidoge {
    struct AIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDOGE>(arg0, 6, b"AIDOGE", b"AIDOGEX", b"AI DogeX brings the principles of aerospace technology and artificial intelligence to the world of meme cryptocurrencies. Tapping into the power of AI, the space industry, and blockchain technology, AI DogeX aims to revolutionize the cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ai_doge_logo_67ee251745.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

