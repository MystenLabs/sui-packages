module 0xb71c307f9d46b741b770b82607dbc89d078cd8e3d577ad976072c981d3a798cb::gengarsui {
    struct GENGARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGARSUI>(arg0, 9, b"GENSUI", b"Gengarsui", b"A mischievous phantom with a big meme grin, shadowy Sui droplets swirling around.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidgbaxjx4ixaz65ut6l2tmfm343fcm4kl6arypkvl7ybcfsosi6bu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENGARSUI>(&mut v2, 1000000000000000000, @0xb0ed1ff98508d0cd74fb515e595ae0879b652d21a6a93eb94a8e707bde83f73b, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGARSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

