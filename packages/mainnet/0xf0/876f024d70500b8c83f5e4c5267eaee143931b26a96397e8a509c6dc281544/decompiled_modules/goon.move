module 0xf0876f024d70500b8c83f5e4c5267eaee143931b26a96397e8a509c6dc281544::goon {
    struct GOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOON>(arg0, 0, b"GOON", b"Goose Net", b"Goose Net is a culture-forward meme token channeling monkey mischief for YouTube shorts, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfKTDnBW1CDjiKMvheJzKq6cZpQXDgEuMLQggskzQ8BxV")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GOON>>(0x2::coin::mint<GOON>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

