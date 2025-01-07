module 0x507352e6ec820890eb41625ace754572d01d19f945d180311287301ed0adf621::buzzy {
    struct BUZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZY>(arg0, 6, b"BUZZY", b"BUZZY ON SUI", b"buzzy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_08_20_at_20_20_42_70b88fa5f8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

