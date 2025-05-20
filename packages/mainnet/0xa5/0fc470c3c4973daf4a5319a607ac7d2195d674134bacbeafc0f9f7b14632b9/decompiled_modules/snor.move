module 0xa50fc470c3c4973daf4a5319a607ac7d2195d674134bacbeafc0f9f7b14632b9::snor {
    struct SNOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOR>(arg0, 6, b"Snor", b"Snorlax", b"The biggest Pokemon on SUI just woke up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif67ms6263ah3qb5sjt43mafmjtxlz547ig7uya37u3fpmuikt2hm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

