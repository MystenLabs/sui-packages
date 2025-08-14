module 0x82f604d4a2e6a196354216402a34a6ecd42d7d82ea91c47e8e2a57aac1f16167::HIPPO {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"Hippo Hype", b"HIPPO", b"A fun and playful meme coin inspired by the mighty hippopotamus. Join the Hippo Hype movement and ride the wave of meme magic! Perfect for those who love memes, community, and a bit of splash in their crypto portfolio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreiar7xzpe2oifs3ud7jlotwc5jol3z6dy27jdqd52mslxdeop56ixm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

