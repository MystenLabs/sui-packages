module 0x3f4c95e1e52cc47fd2eb23b2a418d8176e583645873c8171248a0e6fdeddc59d::pokesui {
    struct POKESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKESUI>(arg0, 6, b"POKESUI", b"BLUE POKESUI", b"Blue pokemon on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4079_d729165f9f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POKESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

