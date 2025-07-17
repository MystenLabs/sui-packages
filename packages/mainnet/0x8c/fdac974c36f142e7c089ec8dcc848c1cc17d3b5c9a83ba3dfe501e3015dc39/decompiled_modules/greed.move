module 0x8cfdac974c36f142e7c089ec8dcc848c1cc17d3b5c9a83ba3dfe501e3015dc39::greed {
    struct GREED has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREED>(arg0, 6, b"Greed", b"Greedy", b"Greedy smurf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiep6s2h6dyqis7fghohqf4yozyw3cdygjztramekpkkb4o2a6rbey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GREED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

