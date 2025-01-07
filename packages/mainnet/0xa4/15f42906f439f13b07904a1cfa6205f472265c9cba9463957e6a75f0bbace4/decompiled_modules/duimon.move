module 0xa415f42906f439f13b07904a1cfa6205f472265c9cba9463957e6a75f0bbace4::duimon {
    struct DUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUIMON>(arg0, 6, b"DUIMON", b"Duimon", b"Bringing That Heat To SUI! It's DUIMON TIME! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_04_at_10_52_03_PM_1ef8eb7464.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

