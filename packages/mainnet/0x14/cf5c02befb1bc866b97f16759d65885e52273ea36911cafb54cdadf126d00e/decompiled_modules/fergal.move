module 0x14cf5c02befb1bc866b97f16759d65885e52273ea36911cafb54cdadf126d00e::fergal {
    struct FERGAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERGAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERGAL>(arg0, 6, b"FERGAL", b"Fergal", b"Meet Fergal, the new meme on the block, He loves to Degen, Rekt 24/7, and needs to change his life, after many years of trading Fergal has never been able to break even So.. he decided to launch his own shit coin, a quick flip? absolutely not! he is here for the long run! Come join the action and have some fun with Fergal and make some X's on the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_a964d134b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERGAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERGAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

