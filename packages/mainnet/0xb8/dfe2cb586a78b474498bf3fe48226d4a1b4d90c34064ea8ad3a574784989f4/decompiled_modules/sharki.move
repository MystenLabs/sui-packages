module 0xb8dfe2cb586a78b474498bf3fe48226d4a1b4d90c34064ea8ad3a574784989f4::sharki {
    struct SHARKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKI>(arg0, 6, b"SHARKI", b"Sharki", b"Sharki has come to sake over sui. BUY OR DIE!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_23_09_2024_at_5_57a_PM_c9a75b9222.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

