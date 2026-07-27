module 0xda0d751d4b68c7111420df371a1c372b6c16dcd2585b95891e6b9a9a227b61d8::bis1q {
    struct BIS1Q has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIS1Q, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIS1Q>(arg0, 9, b"BIS1Q", b"Bison Drip", b"Bison Drip is a quest-driven meme token channeling fox raids for Snap stories, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmTESm7tddRjqU4EczE2kZZQDuyX3H5AiQQksHNQHRDfPv")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BIS1Q>>(0x2::coin::mint<BIS1Q>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIS1Q>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIS1Q>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

