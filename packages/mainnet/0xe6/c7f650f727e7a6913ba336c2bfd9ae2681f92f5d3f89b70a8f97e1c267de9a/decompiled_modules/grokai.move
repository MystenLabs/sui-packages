module 0xe6c7f650f727e7a6913ba336c2bfd9ae2681f92f5d3f89b70a8f97e1c267de9a::grokai {
    struct GROKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKAI>(arg0, 6, b"GROKAI", b"GrokAI", x"47726f6b4149202847726f6b4149290a2447726f6b414920697320616e2041492070726f6a656374206f6e2074686520536f6c616e6120626c6f636b636861696e2074686174206272696e67732074686520706f776572206f66206d656d657320746f2074686520776f726c64206f66206172746966696369616c20696e74656c6c6967656e63652e205769746820666f637573206f6e2068756d6f7220616e6420637265617469766974792c202447726f6b41492061696d7320746f207265766f6c7574696f6e697a65207468652077617920776520696e74657261637420776974682041492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XZ_18pk_P_Zc_V_Zsm_Ew_Wfko_EF_Yakgm_GU_5j8_B_Yw_K1vr_K87_Zck_49df6f1b55.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

