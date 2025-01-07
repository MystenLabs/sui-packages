module 0xb4bcc324ca50d1f4708944ead4e3ed1d2daf009e5c53fc0dbf4594ceb342f048::stitchsui {
    struct STITCHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STITCHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STITCHSUI>(arg0, 6, b"STITCHSUI", b"stitch on sui", x"4d65656761206e616c61206b77656573746121205769746820245374697463682c207765206272696e67206368616f74696320746f207468652063727970746f20776f726c64210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_C_Vrk9_Yv_400x400_7513d66910.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STITCHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STITCHSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

