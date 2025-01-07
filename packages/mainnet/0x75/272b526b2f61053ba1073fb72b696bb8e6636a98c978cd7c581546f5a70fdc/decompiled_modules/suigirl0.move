module 0x75272b526b2f61053ba1073fb72b696bb8e6636a98c978cd7c581546f5a70fdc::suigirl0 {
    struct SUIGIRL0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIRL0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIRL0>(arg0, 6, b"SUIGIRL0", b"SUIGIRL", x"4669727374204769726c204865726f20696e205355492e2053555045524d414e204c6f76652053555045524749524c2e205355494d414e204c6f7665205355494749524c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_fe1b973221_138f17335e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIRL0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGIRL0>>(v1);
    }

    // decompiled from Move bytecode v6
}

