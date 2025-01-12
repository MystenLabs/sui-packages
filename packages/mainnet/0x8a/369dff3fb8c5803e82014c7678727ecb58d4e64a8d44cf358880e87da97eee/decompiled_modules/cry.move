module 0x8a369dff3fb8c5803e82014c7678727ecb58d4e64a8d44cf358880e87da97eee::cry {
    struct CRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRY>(arg0, 6, b"CRY", b"cryptain", x"61692068656467652066756e642026207465726d696e616c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Thi8n6mcdk_Hr_Gk_B_Bg_U_Lxk_Yf_LZS_5_LR_8ec_Ee_Scu_Ve_DLM_Lw_1ef3860d60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

