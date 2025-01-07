module 0xedf668fbd12d95bb0e61f5feb22ed296255a6c2817ed2a66a9e7b67e59dc4ff::floppy {
    struct FLOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPPY>(arg0, 6, b"FLOPPY", b"Floppy by matt furie", b"Floppy by matt furie on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3960_ab4b3f9028.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

