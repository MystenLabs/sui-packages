module 0xe5275ca345ec0bbcf1425c01d39ddf369681b58c541e35542f6f023a0f206508::hoot {
    struct HOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOT>(arg0, 6, b"HOOT", b"SuiHoot", b"This cute hoot is here to win heart and unite the strong sui community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_00_19_26_e678abf099.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

