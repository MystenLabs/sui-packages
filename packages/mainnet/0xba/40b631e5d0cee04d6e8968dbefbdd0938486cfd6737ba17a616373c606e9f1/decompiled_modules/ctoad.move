module 0xba40b631e5d0cee04d6e8968dbefbdd0938486cfd6737ba17a616373c606e9f1::ctoad {
    struct CTOAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOAD>(arg0, 6, b"CTOAD", b"Chilling Toad", x"2443544f41442d20546865206d6f7374206368696c6c696e6720746f61642e204469646e2774206361726520706c7573206e6f742073656c6c696e672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mse6hcdx_M_Wg_Qg_EW_7_Acid_A_Yw2_G5uc_W5f_C8_XK_3_NW_Ypump_ac6b1fe487.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTOAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

