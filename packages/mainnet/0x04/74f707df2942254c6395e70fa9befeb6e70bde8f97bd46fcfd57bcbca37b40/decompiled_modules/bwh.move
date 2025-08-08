module 0x474f707df2942254c6395e70fa9befeb6e70bde8f97bd46fcfd57bcbca37b40::bwh {
    struct BWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWH>(arg0, 6, b"BWH", b"Bags Wif Hat", b"BWH SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicgza4nr2pipfxolamh7pnfzjq3ssbi2lpjb3tjfksb62ju7ukwfe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

