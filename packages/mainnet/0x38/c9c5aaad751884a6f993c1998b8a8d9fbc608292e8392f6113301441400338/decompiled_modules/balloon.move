module 0x38c9c5aaad751884a6f993c1998b8a8d9fbc608292e8392f6113301441400338::balloon {
    struct BALLOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLOON>(arg0, 6, b"Balloon", b"Balloon Sui", b" Always rising, always reaching  thats the Balloon way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3482_99bd647906.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

