module 0xd342f76cee8b783f95232b044519e0f0ed6b449e5f0ffe4e3f468456a7f82fa0::srcat {
    struct SRCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRCAT>(arg0, 6, b"SRCAT", b"SUI ROLLING CAT", b"ROLLINGGG CATS ON SUI . TELE : https://t.me/Rollingcatsuichain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_02_02_03_e0167be435.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

