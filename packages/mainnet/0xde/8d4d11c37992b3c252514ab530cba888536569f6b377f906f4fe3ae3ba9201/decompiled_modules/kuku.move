module 0xde8d4d11c37992b3c252514ab530cba888536569f6b377f906f4fe3ae3ba9201::kuku {
    struct KUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKU>(arg0, 6, b"KUKU", b"KUKUDINO", b"The Kuku revolution is not just about creating another meme token. It's about making memes great again, fixing the problems of oversupply and securing their rightful place in the crypto world. We're on a mission to reinvent the meme game, making it more exciting, inclusive, and rewarding than ever before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/51231_ff590f9054.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

