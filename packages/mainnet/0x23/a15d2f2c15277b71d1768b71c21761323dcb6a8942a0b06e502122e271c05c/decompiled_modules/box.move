module 0x23a15d2f2c15277b71d1768b71c21761323dcb6a8942a0b06e502122e271c05c::box {
    struct BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOX>(arg0, 6, b"BOX", b"SUI BOX", b"Sui $BOX is the character symbol of the Sui blockchain, which appears simple and unique but is full of hidden potential and surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241031_210109_549_0a7c6b2055.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

