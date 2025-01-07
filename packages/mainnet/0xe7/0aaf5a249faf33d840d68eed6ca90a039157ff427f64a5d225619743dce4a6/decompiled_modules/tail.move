module 0xe70aaf5a249faf33d840d68eed6ca90a039157ff427f64a5d225619743dce4a6::tail {
    struct TAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAIL>(arg0, 6, b"TAIL", b"Tail Hodler", x"5461696c20486f646c6572202054686520756c74696d617465206d656d652073686f77646f776e21202076732e2020616e64206265796f6e642e204265742c20726163652c20616e642077696e207769746820796f7572206661766f72697465206d656d65206c6567656e6473206173207468657920626174746c6520666f722063727970746f2073757072656d6163792e204d6f7265206d656d65732c206d6f72652066756e2c206d6f72652077696e732e2043686f6f736520796f7572207369646520616e64207261636520746f2074686520746f70210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmau_Ta_Fz_D_Ymocvx_E_Xcpyqp4_Wv_Td8t_Tuu2c_G2_EZ_7x_BYS_8_X1_9a46bef723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

