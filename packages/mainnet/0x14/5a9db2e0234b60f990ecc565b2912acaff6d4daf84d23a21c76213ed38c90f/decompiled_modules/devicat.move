module 0x145a9db2e0234b60f990ecc565b2912acaff6d4daf84d23a21c76213ed38c90f::devicat {
    struct DEVICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVICAT>(arg0, 6, b"DEVICAT", b"Dev is cat", b"When the client asks for one last minute change, Just one more meow..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f1c1ec13c1b2f4b327586a970cbad5de_967bc22ebd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

