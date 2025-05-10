module 0xc85dd4c5f2b633d1a411150fc4dfe1f93f4b392f1035c0367af703ec4d9c827::bluepikachu {
    struct BLUEPIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPIKACHU>(arg0, 6, b"BluePikachu", b"BluePikachu SUI", b"First Bluechu in Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidivlxchtyscnnvzcoh652ioogmthxsjjx7xtuthhd3fasrwgynlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEPIKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

