module 0xfa0370c52f35d36c616bc65c582d2d63ec5baf066657a48e991620741aa42b0f::sidekick {
    struct SIDEKICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIDEKICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIDEKICK>(arg0, 6, b"SIDEKICK", b"SidekickFm", b"AI Assistant built on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibeissgoyonnnxjmyufu7ya7q4afk5wyx3d2uurtfgl3dgtvwcqcm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIDEKICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIDEKICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

