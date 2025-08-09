module 0xcbd39ace10f2f209b28c9ad95d2a4af639b346ea7ede4887501243331537c44::bwh {
    struct BWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWH>(arg0, 6, b"BWH", b"Bags Wif Hat", b"Bags On Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicgza4nr2pipfxolamh7pnfzjq3ssbi2lpjb3tjfksb62ju7ukwfe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

