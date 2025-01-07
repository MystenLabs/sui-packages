module 0x378f7aad3156e942f961987823769f9b23488767e3d46aed63db20053555422a::babymarvin {
    struct BABYMARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMARVIN>(arg0, 9, b"BABYMARVIN", b"BABY MARVIN", b"BABY MARVIN, a Havanese, has Elon Musk as his emotional support. We adore the adorable Marvin just as much as Elon does.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F66f7a74c01f8f84cd4569fb9_1727506253_662ec604b4.png&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYMARVIN>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMARVIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

