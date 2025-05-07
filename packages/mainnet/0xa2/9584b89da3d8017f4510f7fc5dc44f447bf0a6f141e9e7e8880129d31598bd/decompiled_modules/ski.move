module 0xa29584b89da3d8017f4510f7fc5dc44f447bf0a6f141e9e7e8880129d31598bd::ski {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKI>(arg0, 6, b"Ski", b"Ski Chad", b"Ski Mask The Chad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicbgjkm5c5l6fuhkbe5iwvbaiovkz3lnlzcltjawdj6oegunjjrpa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

