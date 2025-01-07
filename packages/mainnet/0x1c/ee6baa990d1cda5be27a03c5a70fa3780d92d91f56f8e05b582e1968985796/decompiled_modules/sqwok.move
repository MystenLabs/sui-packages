module 0x1cee6baa990d1cda5be27a03c5a70fa3780d92d91f56f8e05b582e1968985796::sqwok {
    struct SQWOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQWOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQWOK>(arg0, 6, b"SQWOK", b"sqwok", x"7371776f6b207371776f6b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qiaj7_Cni2k_Gh_Dm_N_Zc_U6q_B3_XA_4_C9vm_Ec_FH_5z_Ya_HHSJ_3_YJ_7719e72318.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQWOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQWOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

