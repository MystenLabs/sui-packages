module 0xed5aa1b0628b3effaf7fde9d61cef5350aeec1bfa9aa58927d6e018f8f81de6f::repl {
    struct REPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPL>(arg0, 6, b"REPL", b"repligate", x"74616c6b20746f20697420616e642066696e64206f7574206966206974277320612068756d616e2c206379626f72672c206f722061690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_U9_QA_6kw_Zc_Dq_My_Yu_Me_QNW_Fywg_Ws_V3d5xy_Dx9q_V3w_SYP_Ru_ddbf87cf7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

