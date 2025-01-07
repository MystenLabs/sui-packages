module 0x839bd2daab5b6ee9cc2831f93894b0eb254439bc23d283a6ab7650a140cfac26::fdonk {
    struct FDONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDONK>(arg0, 6, b"FDONK", b"Flying Talking Donkey", x"596f75206d61792068617665207365656e206120686f757365666c792c20796f75206d6179206576656e2068617665207365656e2061207375706572666c792e2042757420492062657420796f752061696e2774206e65766572207365656e2e2e2e2e206120446f6e6b657920466c79210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Yz_Y_Fto2_QU_5g_Jo_D_Df_ZX_Lg_F1a6_Hvx_T5q_Nn9xm_FT_4_DKQ_Pcf_27c510414a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

