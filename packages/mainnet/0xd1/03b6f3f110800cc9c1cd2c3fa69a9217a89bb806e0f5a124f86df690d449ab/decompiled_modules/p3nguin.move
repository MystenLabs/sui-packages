module 0xd103b6f3f110800cc9c1cd2c3fa69a9217a89bb806e0f5a124f86df690d449ab::p3nguin {
    struct P3NGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: P3NGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P3NGUIN>(arg0, 6, b"P3NGUIN", b"Space P3nguin", b"Once upon a time, a colony of SpacePenguins lived in Antarctica, but now they don spacesuits and jump into spaceships in search of a new habitat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022026_c4c303018b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P3NGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<P3NGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

