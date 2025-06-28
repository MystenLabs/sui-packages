module 0x1bab435b36b4bb7a24c153e57beeefb613048ce847b06e034f47c902e3bec1e0::key {
    struct KEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEY>(arg0, 6, b"KEY", b"KeyChain", b"Key Of the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidg3tlq3hglw2ldb2falll3siy36lpz6yrdgsayekrmdhxvx5ynzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

