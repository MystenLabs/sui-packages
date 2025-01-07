module 0x49a274c667f3a5a5840d161fea0920a75cc489cb99e12d035ff6f1de08a63270::ur {
    struct UR has drop {
        dummy_field: bool,
    }

    fun init(arg0: UR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UR>(arg0, 6, b"UR", b"Unicorn Run", b"Unicorn Run .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_T_Afhfma6_Az_Rqnb_H_Zx_Kq_Smxdat_Fm_ZAFK_1_S1pfx_RYAH_Ff_G_e1b529dd4c_715ba5b25e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UR>>(v1);
    }

    // decompiled from Move bytecode v6
}

