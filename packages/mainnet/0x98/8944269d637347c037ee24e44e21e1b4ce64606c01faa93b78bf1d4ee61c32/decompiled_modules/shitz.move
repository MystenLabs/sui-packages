module 0x988944269d637347c037ee24e44e21e1b4ce64606c01faa93b78bf1d4ee61c32::shitz {
    struct SHITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITZ>(arg0, 6, b"SHITZ", b"SHITZ on SUI", b"Lets get it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7xym4vzd7esvujgt46sjdwkw4uptmryzciulnyrevl3z5my4omi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHITZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

