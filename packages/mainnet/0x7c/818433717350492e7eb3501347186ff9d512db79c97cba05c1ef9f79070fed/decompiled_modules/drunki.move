module 0x7c818433717350492e7eb3501347186ff9d512db79c97cba05c1ef9f79070fed::drunki {
    struct DRUNKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRUNKI>(arg0, 6, b"DRUNKI", b"DRUNKI ON SUI", b"https://drunkisui.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_4_d2f686079a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRUNKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRUNKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

