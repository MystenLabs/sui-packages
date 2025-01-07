module 0xb3d0a446020a86c540fd3e3c0fbab331c9f7aefdb92bc945644117108bd0d93d::babymarvin {
    struct BABYMARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYMARVIN>(arg0, 6, b"BABYMARVIN", b"BABY MARVIN", b"BABY MARVIN, a Havanese, has Elon Musk as his emotional support. We adore the adorable Marvin just as much as Elon does.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/66f7a74c01f8f84cd4569fb9_1727506253_662ec604b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

