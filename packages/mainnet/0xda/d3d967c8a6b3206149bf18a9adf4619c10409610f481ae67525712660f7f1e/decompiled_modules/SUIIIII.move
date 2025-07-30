module 0xdad3d967c8a6b3206149bf18a9adf4619c10409610f481ae67525712660f7f1e::SUIIIII {
    struct SUIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIII>(arg0, 6, b"Suiiiiii", b"SUIIIII", b"A meme coin inspired by Cristiano Ronaldo's iconic 'Siuuu' celebration. Perfect for fans who want to celebrate victories, big or small, on the blockchain. Every transaction is a reminder to scream 'SUIIIII' at the top of your lungs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/qqn5BT8q13bcOlVqx86MeIhtyEnCANCtQBASxZfjVFSghfLqA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIII>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

