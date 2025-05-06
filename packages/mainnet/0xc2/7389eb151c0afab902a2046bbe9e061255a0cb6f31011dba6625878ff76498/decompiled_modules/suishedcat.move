module 0xc27389eb151c0afab902a2046bbe9e061255a0cb6f31011dba6625878ff76498::suishedcat {
    struct SUISHEDCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHEDCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHEDCAT>(arg0, 6, b"SUISHEDCAT", b"SUISHED", b"The cat that SUISHED with life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250505_180445_687_edit_132504716904780_5fed8ced67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHEDCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHEDCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

