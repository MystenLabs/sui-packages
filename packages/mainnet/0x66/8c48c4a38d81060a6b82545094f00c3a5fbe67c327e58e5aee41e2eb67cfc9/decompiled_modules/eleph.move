module 0x668c48c4a38d81060a6b82545094f00c3a5fbe67c327e58e5aee41e2eb67cfc9::eleph {
    struct ELEPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELEPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELEPH>(arg0, 6, b"ELEPH", b"Elephino Meme Token", b"The name Elephino plays on the phrase Hell if I know, capturing the humorous unpredictability of crypto markets. It's a token that embraces chaos, celebrates the thrill of the unknown, and keeps the community guessing with hilarious memes. Elephino isn't just a token; it's a ride, and no one knows where it'll go next. Hell, if we know Elephino!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ELEPH_png_89515be702.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELEPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELEPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

