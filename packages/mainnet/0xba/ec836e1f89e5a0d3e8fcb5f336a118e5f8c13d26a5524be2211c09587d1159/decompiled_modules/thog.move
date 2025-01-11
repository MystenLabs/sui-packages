module 0xbaec836e1f89e5a0d3e8fcb5f336a118e5f8c13d26a5524be2211c09587d1159::thog {
    struct THOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOG>(arg0, 6, b"THOG", b"Theory Of Gravity", x"5468656f7279204f66204772617669747920697320612066616972206c61756e6368206d656d65636f696e2c20776974682067616d65732c204e46547320616e64206d6f72650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcs_Dusxy3ye6_Bw_Y_Pt_R9pni3k_Smkcipc_Mj_Cqc_Kd_Zj_Cy_DTR_0e796e26ed.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

