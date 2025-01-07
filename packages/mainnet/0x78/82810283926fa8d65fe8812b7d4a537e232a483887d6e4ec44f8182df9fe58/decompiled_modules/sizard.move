module 0x7882810283926fa8d65fe8812b7d4a537e232a483887d6e4ec44f8182df9fe58::sizard {
    struct SIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZARD>(arg0, 6, b"SIZARD", b"Sui Lizard", x"53495a41524420697320746865206c697a61726420776974682061206d697373696f6e3a20746f2077616c6b20697473207761792066726f6d20746865206a756e676c6520666c6f6f7220746f20746865207468726f6e65206f662074686520617065732c20205468697320736e65616b79206c697a61726420697320666173742c20736d6172742c20616e6420726561647920746f2074616b65206f7665722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Spbj_C_Sqc_Dmu_Zk2wk_Kqbz_H4_B4_V_Pixo_TZ_Sb_BJ_Qs_Nt_Cg_B_Wf_c83acb105e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

