module 0xd05824774d1f7f636dda7741645c43fd9f142e3f4cc5de8ca988fef09f557fb5::timo {
    struct TIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMO>(arg0, 6, b"TIMO", b"Timo", x"57656c636f6d6520746f2074686520776f726c64206f662054696d6f20206120756e69717565206d656d652063757272656e637920666561747572696e6720616e20656c657068616e74212054696d6f20656d626f6469657320667269656e647368697020616e64206a6f792c206f66666572696e67206f70706f7274756e697469657320666f7220636f6d6d756e69747920656e676167656d656e7420616e642070617274696369706174696f6e20696e206576656e74732e204a6f696e206f75722067726f77696e6720636f6d6d756e69747920616e6420737570706f72742054696d6f206f6e20697473206578636974696e67206a6f75726e6579210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TIMO_T_Ge3r_C_Pu_P_Rye622_Cd_I_463b67e2a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

