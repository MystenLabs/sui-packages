module 0xe9cac3f42daad2a9188be8bd9fc50d9c3511313609304a45165949608160bb3b::goki {
    struct GOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKI>(arg0, 6, b"GOKI", b"The Saiyan God", x"6c696c2073616979616e2c20736176696f7572206f6620756e69766572736520370a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_YK_Lr_KLT_5q_XNW_Ma_QAX_65e6ym_Lxkbp_Su2qsz1_J_Ay_Wn_E516_cd01fd09ed.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

