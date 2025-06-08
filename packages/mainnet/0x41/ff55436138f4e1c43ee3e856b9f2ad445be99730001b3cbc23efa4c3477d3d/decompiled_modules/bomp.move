module 0x41ff55436138f4e1c43ee3e856b9f2ad445be99730001b3cbc23efa4c3477d3d::bomp {
    struct BOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMP>(arg0, 6, b"Bomp", b"bompy", b"im a garf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhntucrbkbeiwjvczrwzvpbtsirupmurrtkv4ght2p7tckek7odm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

