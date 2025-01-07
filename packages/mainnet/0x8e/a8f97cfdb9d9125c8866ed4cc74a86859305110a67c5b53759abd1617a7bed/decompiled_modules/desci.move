module 0x8ea8f97cfdb9d9125c8866ed4cc74a86859305110a67c5b53759abd1617a7bed::desci {
    struct DESCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DESCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DESCI>(arg0, 6, b"DeSci", b"Decentralized science", b"Decentralized science refers to the use of blockchain technology, and its features such as tokens, NFTs, and decentralized autonomous organizations (DAOs), to make various aspects of scientific research and collaboration more open, incentivized, and community-driven. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9ed2e2f984554a159a0ee9344a564808_029d8a51f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DESCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DESCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

