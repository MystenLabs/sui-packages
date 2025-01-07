module 0xa82c42ad8eb87ae05f0c7b6b85db63d851d3ffb0691d22b084e9f854f248c3e::cane {
    struct CANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANE>(arg0, 6, b"CANE", b"Candy Cane", x"2443414e4520697320746865206e657720686f7069756d20666f7220436872697374616d73210a0a4120626c656e64206f66204368726973746d6173206e6f7374616c67696120616e6420646567656e657261746520686f7069756d2c20737072696e6b6c656420776974682062756c6c69736820677265656e20636861727473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_034520_121_10a9ab198e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

