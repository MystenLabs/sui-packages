module 0xbf87b26984c4b982b42043e3af1a2adcab6370ce55260a367deacbb852d2cc94::suicate {
    struct SUICATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATE>(arg0, 6, b"SUICATE", b"CATE ON SUI", x"43415445204d4f564553204f56455220544f205355490a0a4f4e434520424f4e4445442044455853435245454e45522057494c4c2042452055504441544544205749544820414c4c20534f4349414c5320414c4f4e472057495448205452454e44494e47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catesuilogo_8991f55415.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

