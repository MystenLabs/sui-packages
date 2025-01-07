module 0x5c67ebb520207c0a81b4faf953954406b98c8b228f7198a063f2af29d113fbaf::buzzy {
    struct BUZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZY>(arg0, 6, b"BUZZY", b"BUZZYSUI", b"MATT FURIES CHARACTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_07_07_at_20_04_35_ecb3253e09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

