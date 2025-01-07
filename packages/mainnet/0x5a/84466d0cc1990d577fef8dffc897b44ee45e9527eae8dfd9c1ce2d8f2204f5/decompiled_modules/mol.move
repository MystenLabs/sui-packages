module 0x5a84466d0cc1990d577fef8dffc897b44ee45e9527eae8dfd9c1ce2d8f2204f5::mol {
    struct MOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOL>(arg0, 6, b"MOL", b"moleman", x"e2809c4d79206e616d652069732048616e732e204472696e6b696e6720686173207275696e6564206d79206c6966652e2049276d203331207965617273206f6c6421e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734855763068.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

