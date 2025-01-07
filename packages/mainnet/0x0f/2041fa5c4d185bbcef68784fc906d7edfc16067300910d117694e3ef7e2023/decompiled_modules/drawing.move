module 0xf2041fa5c4d185bbcef68784fc906d7edfc16067300910d117694e3ef7e2023::drawing {
    struct DRAWING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAWING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAWING>(arg0, 6, b"DRAWING", b"THE DRAWING AI", x"547279204f757220414920746f205475726e20796f757220736b6574636820696e746f20726566696e6520696d6167650a574542203a2068747470733a2f2f6465762d656c6f7073747564696f2e636f6d2f74686564726177696e670a5447203a2068747470733a2f2f742e6d652f74686564726177696e6761690a58203a2068747470733a2f2f782e636f6d2f74686564726177696e676169", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_En_JQ_En7t_Fwj_Fqe_Zxm_HN_Pwi_Jq_Ykp2td_WT_6_Db_Wys_Mwa_Zj_7769a27dbb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAWING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAWING>>(v1);
    }

    // decompiled from Move bytecode v6
}

