module 0xc81ae082f6bd3bc61a043312138d0162f24311bb9dcb8d588c511cd160939dc0::pepeverses {
    struct PEPEVERSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEVERSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEVERSES>(arg0, 6, b"PEPEVERSES", b"PEPE MULTIVERSE", b"Pepe Multiverse is a revolutionary memecoin that transcends the boundaries of the digital world. Inspired by the iconic Pepe meme, our project takes you on a cosmic journey through infinite realities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e62d7e177784287_64dcadf1b5c8a_64cdc2d353.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEVERSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEVERSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

