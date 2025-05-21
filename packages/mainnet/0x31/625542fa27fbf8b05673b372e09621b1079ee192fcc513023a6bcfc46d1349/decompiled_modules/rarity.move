module 0x31625542fa27fbf8b05673b372e09621b1079ee192fcc513023a6bcfc46d1349::rarity {
    struct RARITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RARITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RARITY>(arg0, 6, b"RARITY", b"BLOOP BLOOP RARITY", b"he token that embodies the strength and rarity of a majestic turtle. Slow and steady wins the race, and $RARITY is here to symbolize enduring power and unique value in the market. Embrace the extraordinary with $RARITY where every holder is one of a kind!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicm3aaylgn7vkalxtjvgo46xqekrtxmxzpu2yda47m6jaq22u6qny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RARITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RARITY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

