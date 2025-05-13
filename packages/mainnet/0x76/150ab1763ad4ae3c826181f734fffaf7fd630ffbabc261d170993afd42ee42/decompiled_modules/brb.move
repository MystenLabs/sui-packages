module 0x76150ab1763ad4ae3c826181f734fffaf7fd630ffbabc261d170993afd42ee42::brb {
    struct BRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRB>(arg0, 6, b"BRB", b"BadRabbit", b"BadRabbit isn't just a memecoin now it's a style statement. Limited edition Tshirts featuring exclusive BadRabbit NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreift6ty4nrg325a226in3rfy23thog5iza45cy23jsrkr36zxzpica")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

