module 0x18c1a1727ff0e242bfd133e705aaef4eeef5bdea3bf5724f5e951e5890f7fc53::boredv2 {
    struct BOREDV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOREDV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOREDV2>(arg0, 6, b"BOREDV2", b"BORED BOY lZ V2", b"Welcome to v2 bored", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigbqew2kdjs2pvrra5f5stjshpgvehzpetwwplxewal3rzwtn3sqi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOREDV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOREDV2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

