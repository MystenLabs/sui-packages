module 0x1408484c56c90904d82616f2f01e4f92bc2f4806fc22ac27618566f39e3de59e::sapa {
    struct SAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPA>(arg0, 6, b"SAPA", b"Satoshi Panda", b"The Happy Meme Coin With BTC Rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_01_10_22_51_17_e9f52bfd3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

