module 0xff63a9fd723348097c0ef073e2a9235867d996768d89f5cb8e53e768413ee65e::gumbo {
    struct GUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBO>(arg0, 6, b"GUMBO", b"gumbo on sui", b"$GUMBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbo4_Yk_Yam9c_Xrga_Sur_GV_Jhd_X_Pw5q_Hd5_QCQ_Cx_H_Byb3_Tgt_W_6c00952c0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

