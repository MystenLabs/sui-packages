module 0xb06a419b3a129406827a02a669598ee12bc3f6fe6ade3660d47c533ea3b9465b::BOB {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"Bob!", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/963/308/large/rock-d-20241015105712.jpg?1729015073")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOB>>(0x2::coin::mint<BOB>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOB>>(v2);
    }

    // decompiled from Move bytecode v6
}

