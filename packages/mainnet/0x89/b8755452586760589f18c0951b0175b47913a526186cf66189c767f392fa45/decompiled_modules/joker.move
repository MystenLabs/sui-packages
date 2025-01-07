module 0x89b8755452586760589f18c0951b0175b47913a526186cf66189c767f392fa45::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"Joker", b"Joker on Sui", b"rebellion, chaos, and a damn good joke ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3s_Cn_Wu_P3njqbu_FTB_56n_SV_7_TRZF_Xid_Wujm_Wz_Jur_N4p_T_Ro_016e0b0871.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

