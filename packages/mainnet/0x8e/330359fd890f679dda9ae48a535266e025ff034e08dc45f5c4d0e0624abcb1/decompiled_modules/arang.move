module 0x8e330359fd890f679dda9ae48a535266e025ff034e08dc45f5c4d0e0624abcb1::arang {
    struct ARANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARANG>(arg0, 6, b"ARANG", b"dogwhosmile", b"The smiling dog hehehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/left_2_44b3afef89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

