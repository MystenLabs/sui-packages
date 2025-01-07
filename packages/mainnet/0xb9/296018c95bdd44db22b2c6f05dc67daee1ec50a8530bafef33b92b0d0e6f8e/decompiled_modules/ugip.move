module 0xb9296018c95bdd44db22b2c6f05dc67daee1ec50a8530bafef33b92b0d0e6f8e::ugip {
    struct UGIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: UGIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGIP>(arg0, 6, b"UGIP", b"PIGU", b"Just pigu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pigu_Logo_915b0781f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UGIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UGIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

