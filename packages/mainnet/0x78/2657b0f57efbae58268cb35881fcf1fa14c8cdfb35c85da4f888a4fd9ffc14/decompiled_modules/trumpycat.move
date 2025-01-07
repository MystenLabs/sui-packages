module 0x782657b0f57efbae58268cb35881fcf1fa14c8cdfb35c85da4f888a4fd9ffc14::trumpycat {
    struct TRUMPYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPYCAT>(arg0, 6, b"TRUMPYCAT", b"TRUMPY CAT", b"Imagine a curious TRUMPY CAT dreaming of the ocean, eager to paddle through waves and chase fish, longing for sea adventures and new discoveries!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baloon_2b0853e721.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

