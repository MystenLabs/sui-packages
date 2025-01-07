module 0x12d0398ef2f8e69afdfa909bd114ddad90bdb7b69065f94e423b0818a7c4f42b::toberfly {
    struct TOBERFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBERFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBERFLY>(arg0, 6, b"TOBERFLY", b"TOBERFLY SUI", b"TOBERFLY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_23_40_21_fae087eef4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBERFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBERFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

