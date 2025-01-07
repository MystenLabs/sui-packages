module 0x65f81363bcb3974d8cf919db001ffca3871398d7dd6e4491bf70d79abd9cd712::silly {
    struct SILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILLY>(arg0, 6, b"Silly", b"Silly Dragon", b"Be SILLY in the year of DRAGON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_13_at_19_26_16_8b1a03f69d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

