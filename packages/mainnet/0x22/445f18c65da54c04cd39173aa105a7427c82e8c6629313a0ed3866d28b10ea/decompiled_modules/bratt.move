module 0x22445f18c65da54c04cd39173aa105a7427c82e8c6629313a0ed3866d28b10ea::bratt {
    struct BRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRATT>(arg0, 6, b"BRATT", b"BLUE BRATT", b"Bratt is baby brett on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3795_fdd6d27168.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

