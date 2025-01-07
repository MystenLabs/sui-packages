module 0xf0db3bb58414241c48a44fbaeb33a1a82604732570a752470874a617fcae8ad::oreocat {
    struct OREOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OREOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OREOCAT>(arg0, 6, b"OREOCAT", b"OREO on SUI", b" Cat lovers must see this, the cutest cat on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241212_200815_096_ddd946b865.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OREOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OREOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

