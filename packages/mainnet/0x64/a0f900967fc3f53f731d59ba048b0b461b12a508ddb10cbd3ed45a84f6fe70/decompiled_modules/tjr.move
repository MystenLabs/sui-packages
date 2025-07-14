module 0x64a0f900967fc3f53f731d59ba048b0b461b12a508ddb10cbd3ed45a84f6fe70::tjr {
    struct TJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TJR>(arg0, 6, b"TJR", b"Test", b"dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibphqtx6qncavgyebynpsz4zhrcs46iiikoq7yos3dy64iwowoaj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TJR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

