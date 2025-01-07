module 0xd9564652d3a7c8ccb156aad5443e76758e8d62c4cf7aa9a6bfc88979b7e6ad42::bluev2 {
    struct BLUEV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEV2>(arg0, 6, b"BLUEV2", b"blue eyed dog", b"A blue-eyed-dog. Blue dog cto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4445_4e461648a7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEV2>>(v1);
    }

    // decompiled from Move bytecode v6
}

