module 0xac1048541438e397aef74abbaf6acd1b7e4a9dd148f70adafa8ab8f95efca48c::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE>(arg0, 9, b"VINE", b"Vine Coin", b"Do it for the Vine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRtFJu3ZospaS4EAk17iNXZGAJp7gMxzvsZckZxbqZa5r")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

