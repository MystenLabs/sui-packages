module 0xa05e5b70a3b7e1e20dd4f60dfef50f8188a51b83d1e5ea6c1a3acc10f4dc9c99::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMI>(arg0, 6, b"NGMI", b"NGMI(Not Gonna Make It)", b"$NGMI isnt just a token! Its a statement, a meme, and a movement for those who are unapologetically embracing the chaos of crypto trading.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5250_fa52dfe714.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

