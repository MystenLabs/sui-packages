module 0xf727b3ad6eef4c0fff7fd6c94785778be014c976dfc92a0b9d513dd5dc60a4ab::surfcat {
    struct SURFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURFCAT>(arg0, 6, b"SURFCAT", b"SUIRFING CAT", b"LETS SURF...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SURFING_CAT_5ca5217f95.avif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

