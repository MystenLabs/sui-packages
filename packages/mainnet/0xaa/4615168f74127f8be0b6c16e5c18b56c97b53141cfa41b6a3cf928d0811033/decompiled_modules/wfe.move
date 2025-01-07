module 0xaa4615168f74127f8be0b6c16e5c18b56c97b53141cfa41b6a3cf928d0811033::wfe {
    struct WFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFE>(arg0, 6, b"WFE", b"Waiting For Entry", x"2241726520796f7520676f6e6e612067657420696e206d616e2074686973207468696e672069732070756d70696e672e2e2e3f2220224e6168206d616e2e2049276d2077616974696e6720666f7220616e20656e7472792e2049276d20737572652069742077696c6c20626520736f6d6574696d6520736f6f6e2e2e2e2e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SC_Kn_Kqu_P_Be_BJ_Jh_W_Rsj_TD_Wdwi_Mq_TMQSG_7v1_B_Zfg3bp18g_f87cbd54bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

