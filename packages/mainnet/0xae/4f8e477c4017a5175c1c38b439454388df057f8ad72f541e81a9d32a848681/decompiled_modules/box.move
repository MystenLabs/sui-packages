module 0xae4f8e477c4017a5175c1c38b439454388df057f8ad72f541e81a9d32a848681::box {
    struct BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOX>(arg0, 6, b"BOX", b"SUIBOX", b"Sui $BOX is the character symbol of the Sui blockchain, which appears simple and unique but is full of hidden potential and surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcnswxdoxmgfdmsz4xuwrfogmzwhmpxbzrufw7fbajuvrio6eyqi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

