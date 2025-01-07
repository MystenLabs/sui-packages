module 0x8349ba7effa009e027c2d0e9b278872eb52c9557312568f30146f8f733c9b94b::look {
    struct LOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOK>(arg0, 6, b"LOOK", b"Look", b"probably something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_01_37_52_49676a7de9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

