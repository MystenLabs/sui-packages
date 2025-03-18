module 0x8f5d61c47972ac1e8dcdbd9cea4251d4a55552784b45ae2822131eeb5a53cfe::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"Dog Meme Coin", b"Dog Meme Coin is a fun cryptocurrency featuring a cute dog face icon, perfect for meme enthusiasts and dog lovers alike! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/Kvy3Rr.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

