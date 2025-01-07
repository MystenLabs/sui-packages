module 0x983d9c0015aa6475f2ef303053eb1a0229b7d3ccfd5daba204fad86950006512::fergal {
    struct FERGAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERGAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERGAL>(arg0, 6, b"FERGAL", b"Fergal", b"Meet Fergal, the new meme on the block, He loves to Degen, Rekt 24/7, and needs to change his life, after many years of trading Fergal has never been able to break even So.. he decided to launch his own shit coin, a quick flip? absolutely not! he is here for the long run! Come join the action and have some fun with Fergal and make some X's on the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/portal_283cb381e2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERGAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERGAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

