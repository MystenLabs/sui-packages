module 0x24a512e3b82c6e72fcd0fbdf3c5256a4f65ef1a5d6dbb6b72cce8e7c5b1d5173::trumpjoker {
    struct TRUMPJOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPJOKER>(arg0, 6, b"Trumpjoker", b"TRUMP JOKER", b"Surf the SUI wave with TRUMP JOKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241020_001359_765a91c767.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPJOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPJOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

