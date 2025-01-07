module 0x36a3da314cb57b60aeda50fcc2d2db2a9c3e8f3f764f4cbbe8c36eb918a4ed6e::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"LON SUSMAN", b"THE REAL ONE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Bj_L_Bmy_A_Go_R2_PMYXA_Wz_CK_9_H_Guy_D_Lg_S_Lj2_Eu7q_QY_Bct_QY_1c6d3d8f3e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

