module 0x3878c3f772baf563c0a20a22fabfe93ea822e7de48ec27e3b0271ba2aede7b95::cactus {
    struct CACTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUS>(arg0, 6, b"CACTUS", b"Scared Cactus", b"Cactus  is the prickly yet cool meme coin ready to bloom in the crypto world!  With its spiky charm and desert vibes, its here to stand out and grow your portfolio.  Whether you're a crypto explorer  or just in it for the fun, Cactus is the token that packs a punch!  Get ready for some wild growth and unexpected gains . #CactusCoin #CryptoSpikes #DesertRiches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_6_1_b1e1b9c656.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CACTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

