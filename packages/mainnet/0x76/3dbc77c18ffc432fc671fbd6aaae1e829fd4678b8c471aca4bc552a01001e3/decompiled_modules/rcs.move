module 0x763dbc77c18ffc432fc671fbd6aaae1e829fd4678b8c471aca4bc552a01001e3::rcs {
    struct RCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCS>(arg0, 6, b"RCS", b"RACCOON SUI", b"the first raccoon on ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_28_11_27_55_3ce729e5c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

