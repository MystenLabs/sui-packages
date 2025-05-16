module 0x9d08f9cd13d5bef51f5ba04cbbcfc1ab57921e87d18993d7d31978c6a8dddef1::suidos {
    struct SUIDOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOS>(arg0, 6, b"Suidos", b"Gyarados on Sui", b"Two lifelong Pokemon fans, fueled by childhood memories of ripping open booster packs and hunting for that perfect pull, have teamed up to launch Suidos on Sui a community driven meme coin inspired by the mighty Gyarados. Built on the Sui Blockchain. Join us on the road to millions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicahx3x4fmxcmfmdz42q5c3bysyf7qfwunbbu7ctxpygi5xejxgbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

