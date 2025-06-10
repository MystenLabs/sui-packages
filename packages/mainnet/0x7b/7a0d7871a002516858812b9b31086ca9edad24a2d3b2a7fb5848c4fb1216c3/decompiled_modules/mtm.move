module 0x7b7a0d7871a002516858812b9b31086ca9edad24a2d3b2a7fb5848c4fb1216c3::mtm {
    struct MTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTM>(arg0, 6, b"MTM", b"MetaMonster", b"A Sui NFT Marketplace featuring different Meta monsters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifv3tinwu3uyz7we4mqaxjcv4hoigq5xkzoyboajap5zwouzuvlei")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MTM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

