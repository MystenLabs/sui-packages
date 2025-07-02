module 0xf2bd11fc9b2ce1a2e2d31c4404f2e59a11956f2b2fe0610bb7a850cfc6addfed::sniper {
    struct SNIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIPER>(arg0, 6, b"Sniper", b"Snip", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeievlivootxi4fsem5uuhigdj5i5o6oschkpkfnjlyj74mrocdclju")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNIPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

