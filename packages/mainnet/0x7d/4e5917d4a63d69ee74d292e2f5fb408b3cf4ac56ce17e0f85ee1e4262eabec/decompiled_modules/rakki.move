module 0x7d4e5917d4a63d69ee74d292e2f5fb408b3cf4ac56ce17e0f85ee1e4262eabec::rakki {
    struct RAKKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKKI>(arg0, 6, b"RAKKI", b"RAKKI CAT", x"52414b4b49206f6e20535549202d20546865206c75636b79206361742c206e6f77206d656f77696e67206f6e2053554920626c6f636b636861696e200a4c65747320646f206d656d657320746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036136_2b5c16104c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAKKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

