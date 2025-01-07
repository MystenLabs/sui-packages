module 0x267d43f238dcd869487787f854508165667f938368c1592641091841a955816d::mdeep {
    struct MDEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDEEP>(arg0, 6, b"MDEEP", b"mockDEEP", x"44656570426f6f6b2050726f746f636f6c20686173206265656e206d6f636b65642121210a4d6f636b206974212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mockd_a12c610a58.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

