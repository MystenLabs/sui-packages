module 0x2cd9c755a2d7c1b6d50b90baf5cd9e60a8cd5d97d8327834c076a5c0be028481::pepebot {
    struct PEPEBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEBOT>(arg0, 6, b"PEPEBOT", b"Pepebot AI", x"7065706520726f626f742074686520636f6f6c657374206d6f737420706f77657266756c206169206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VS_6bwz_C45_Eu_Xq_Rs_Zegm_Q_Ug_V3_Bak_JV_Nyv2ag_V_Lz_Wtim_Hy_9ba6db8120.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

