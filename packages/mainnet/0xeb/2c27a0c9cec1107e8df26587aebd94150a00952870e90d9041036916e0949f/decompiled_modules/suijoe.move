module 0xeb2c27a0c9cec1107e8df26587aebd94150a00952870e90d9041036916e0949f::suijoe {
    struct SUIJOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJOE>(arg0, 6, b"SuiJoe", b"Joe", x"48656c6c6f206d79206e616d65206973204a6f652c20736f6d652063616c6c206d65206a6f650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/171_6dbb488365.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

