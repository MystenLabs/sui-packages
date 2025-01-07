module 0x538b2840152ae3b36cd79a2af1cb07f44f200e1f4f0a4ad8127bafbf99661c94::fcc {
    struct FCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCC>(arg0, 6, b"FCC", b"Fart Cat Coin", x"776174636820746869732063617420666172740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_V9_Mjz_Cbbrc_F_Xsi_V_Nxy_Z_Dvz_Ac_Xtjz_C_Wr_M2o_C_Pc2iep_E4y_5cfc7a033e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

