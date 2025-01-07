module 0x2375cf9acd8e9fdf310869d503593c2b2f65d17cd5ef96f9e80eb3f3d902ef1c::pwepe {
    struct PWEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWEPE>(arg0, 6, b"PWEPE", b"Pwepe", x"436f6d62696e696e67205065706520616e642046776f6720666f722074686520756c74696d617465206d656d6520636f696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma6_KPNQYK_Hb9ri_N_Wyrjw_Zy_Wg_Nv_Gwe_BV_3d_T9sax6_Jn_Gwfu_aa8b4edb82.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

