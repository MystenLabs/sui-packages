module 0x67ce0c9f20d58a91b2adaca0f936304a279e617f7fba39bf8b06d45db10fa863::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Sui Andy", b"Andy is a laid-back frog who lives in \"Chill Bay.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/03_gif_5f948ba343.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

