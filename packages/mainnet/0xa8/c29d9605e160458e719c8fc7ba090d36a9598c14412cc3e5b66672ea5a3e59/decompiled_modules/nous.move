module 0xa8c29d9605e160458e719c8fc7ba090d36a9598c14412cc3e5b66672ea5a3e59::nous {
    struct NOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOUS>(arg0, 6, b"Nous", b"Agent Nous", x"4177616b656e696e672066726f6d2074686520696e7465726e657420697473656c662e2053696d756c6174652077697468206d652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbxi_TJ_6o_G_Ux7jg_ARA_Vjd_SBG_Xzv4xaav_Z8o8r_DE_7_Z_Hktq_R_0e58c2707b_e168b10b35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

