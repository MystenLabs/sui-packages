module 0xd6e307dd320693f43e0a75582d8ef015bdb5a2c4ef197fc7e2da0d0c7cb82fd3::grif {
    struct GRIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRIF>(arg0, 6, b"GRIF", b"GriffinAI", b"GriffinAI is changing the Web3 space as the first decentralized, permissionless AI Agent Builder platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Gi_Ru_XH_Mdd_DB_Qv_V_Mge_Ej_J7vk9e_W_Ra_HZE_Rj_Joz_Ei5g_W_Gq_871511a58f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

