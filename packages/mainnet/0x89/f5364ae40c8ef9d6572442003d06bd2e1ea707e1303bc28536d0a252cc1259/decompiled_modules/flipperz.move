module 0x89f5364ae40c8ef9d6572442003d06bd2e1ea707e1303bc28536d0a252cc1259::flipperz {
    struct FLIPPERZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIPPERZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIPPERZ>(arg0, 6, b"Flipperz", b"Flipperz On Sui", b"Fipperz Sui: Dive deep into the crypto world with the power of a shark. Our token, symbolized by the iconic flipper, represents speed, adaptability, and the relentless pursuit of opportunities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7040_cb23a97041.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIPPERZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIPPERZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

