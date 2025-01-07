module 0x4da5c2c269730c1a0f6ccee3fde439585c1d0593cb3f4a3b6b39746cf0efffcb::cactus {
    struct CACTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CACTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CACTUS>(arg0, 6, b"CACTUS", b"Scared Cactus", b"Cactus  is the prickly yet cool meme coin ready to bloom in the crypto world!  With its spiky charm and desert vibes, its here to stand out and grow your portfolio.  Whether you're a crypto explorer  or just in it for the fun, Cactus is the token that packs a punch!  Get ready for some wild growth and unexpected gains . #CactusCoin #CryptoSpikes #DesertRiches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_6_1_192e6d935c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CACTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CACTUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

