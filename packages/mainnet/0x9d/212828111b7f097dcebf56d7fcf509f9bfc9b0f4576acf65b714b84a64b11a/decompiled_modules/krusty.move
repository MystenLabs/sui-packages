module 0x9d212828111b7f097dcebf56d7fcf509f9bfc9b0f4576acf65b714b84a64b11a::krusty {
    struct KRUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRUSTY>(arg0, 6, b"KRUSTY", b"Krusty", b" Meme-based cryptocurrency built around humor, laughter, and community. Inspired by the quirky, humorous nature of characters Krusty the Clown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RAN_7_Hn_WJ_400x400_378d0f6248.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

