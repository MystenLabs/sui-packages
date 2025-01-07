module 0xf18e1fff6e294d43ca90dff84e29f046351b8503faafcc563e5fa5d47b9755b0::box {
    struct BOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOX>(arg0, 6, b"BOX", b"BOXIMAL SUI", b"BOXIMAL SUI is a meme token featuring a unique collection of box-shaped animals! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Co_T6_H16_Ld_XCK_4d_X9_J94io_VG_Mzi_KQ_Cemkar7_V6_H5qpump_4b0d28cafd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

