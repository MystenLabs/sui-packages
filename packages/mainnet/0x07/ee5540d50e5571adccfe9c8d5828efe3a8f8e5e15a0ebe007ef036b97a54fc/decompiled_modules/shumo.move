module 0x7ee5540d50e5571adccfe9c8d5828efe3a8f8e5e15a0ebe007ef036b97a54fc::shumo {
    struct SHUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUMO>(arg0, 6, b"SHUMO", b"SHUIMO on Sui", b"SHUIMO Frozen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif24vh56tn6g4uxpelsnoyyblrggrvwhhmowshvvzagsz5ytj25lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHUMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

