module 0x43d4b7bc063a79bf93d117f34ec4b4038c99af12e907a249e74180fc306862d6::mba {
    struct MBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBA>(arg0, 6, b"MBA", b"MinibaseApp", b"Discover, Play, Compete, and Bet on your favourite games built on Sui and Base", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731076914879.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

