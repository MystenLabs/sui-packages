module 0xd267c6beebc83c0259d1e1368ac3e0116cf548149fbdbe38c95aace8bd365b77::lmao {
    struct LMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMAO>(arg0, 6, b"LMAO", b"Lost My Assets Overnight", b"ah shit, here we go again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_3xn_Yc_Xw_AAZ_Aj_A_4817714b42.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

