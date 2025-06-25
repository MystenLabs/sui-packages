module 0x9eb64924057d77b4b2092085f75965aa52a0ad02e845bd26ae831906da1f099f::neptune {
    struct NEPTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPTUNE>(arg0, 6, b"NEPTUNE", b"Neptune on sui", b"Building tools that makes trading and Interactions on Sui easier| Utility driven Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihljn6jstkyu66uoe4j5zau52uve72etoblcrhnp6hhxf5vd7rzyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPTUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEPTUNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

