module 0x567939b189f4f983a59bbb4589f730c60c17e671001e6b966cd2c3eee2f0c748::krusty {
    struct KRUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRUSTY>(arg0, 6, b"KRUSTY", b"KrustySui", b"$KRUSTY Meme-based cryptocurrency built around humor, laughter, and community. Inspired by the quirky, humorous nature of characters Krusty the Clown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RAN_7_Hn_WJ_400x400_5bc425d031.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

