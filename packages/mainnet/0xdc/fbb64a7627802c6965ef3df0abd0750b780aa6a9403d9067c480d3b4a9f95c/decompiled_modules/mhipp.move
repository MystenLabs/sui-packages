module 0xdcfbb64a7627802c6965ef3df0abd0750b780aa6a9403d9067c480d3b4a9f95c::mhipp {
    struct MHIPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHIPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHIPP>(arg0, 6, b"MHIPP", b"Mother Hippo", b"Mother Hippo Now on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_31_04_f3c90ca15f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHIPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHIPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

