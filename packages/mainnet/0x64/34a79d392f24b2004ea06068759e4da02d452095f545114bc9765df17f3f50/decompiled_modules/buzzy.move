module 0x6434a79d392f24b2004ea06068759e4da02d452095f545114bc9765df17f3f50::buzzy {
    struct BUZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZY>(arg0, 6, b"BUZZY", b"BUZZYONSUI", b"BUZZY CHARACTERS BY MATT FURIE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_07_07_at_20_04_35_6c7af4257c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

