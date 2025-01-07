module 0xe8fcbf8b77fc7903234dd5d021465f29d5c420dc5b1806f8824b224f04e91f30::sks {
    struct SKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKS>(arg0, 6, b"SKS", b"Suicess Kid", b"Lets become suicessful with suicess kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_b61ed9a9_d6a7_4be0_abd9_c8194b446b27_0df44d81fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

