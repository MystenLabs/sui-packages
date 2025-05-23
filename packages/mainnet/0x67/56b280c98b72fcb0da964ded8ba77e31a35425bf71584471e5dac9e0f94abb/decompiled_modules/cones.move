module 0x6756b280c98b72fcb0da964ded8ba77e31a35425bf71584471e5dac9e0f94abb::cones {
    struct CONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONES>(arg0, 9, b"CONES", b"Bitcones", b"Bitcone from r/coneheads subreddit. The OG meme coin based on the Reddit Collectible Avatars Conehead art piece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8a0066f0a90e2d754f3f3b2501b04abdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

