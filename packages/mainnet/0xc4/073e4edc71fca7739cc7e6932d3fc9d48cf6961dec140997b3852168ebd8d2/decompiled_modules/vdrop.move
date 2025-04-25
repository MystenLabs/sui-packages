module 0xc4073e4edc71fca7739cc7e6932d3fc9d48cf6961dec140997b3852168ebd8d2::vdrop {
    struct VDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDROP>(arg0, 6, b"VDROP", b"SUIPAD", x"5644524f502069732061205355492041697264726f7020506c6174666f726d2c20656e61626c6520757365727320746f20656173696c79206372616674206578636c757369766520636f6c6c656374696f6e73202620696d706c656d656e742063616d706169676e2074616374696320666f7220646973747269627574696e67204e4654732e20235355494e45540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_18_16_38_02_a045488079.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

