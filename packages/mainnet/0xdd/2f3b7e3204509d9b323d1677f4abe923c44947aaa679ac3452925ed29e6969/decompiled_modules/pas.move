module 0xdd2f3b7e3204509d9b323d1677f4abe923c44947aaa679ac3452925ed29e6969::pas {
    struct PAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAS>(arg0, 6, b"PAS", b"PUGAI ON SUI", x"507567204149206973206d6f7265207468616e206a7573742061206d656d6520636f696e3b206974277320610a6761746577617920746f206120776f726c64206f6620706f73736962696c69746965732e2057697468206974730a756e6971756520666561747572657320616e6420706172746e657273686970732c2050756720414920697320706f697365640a746f206265636f6d652061206d616a6f7220706c6179657220696e207468652063727970746f2073706163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Th_A_m_ti_A_u_Ae_a_1204_x_1204_px_1204_x_1204_px_1204_x_850_px_1215_x_1215_px_1230_x_1215_px_1230_x_1000_px_1230_x_1000_px_1250_x_1000_px_1300_x_1000_px_1350_x_1000_px_11_abbcda69b8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

