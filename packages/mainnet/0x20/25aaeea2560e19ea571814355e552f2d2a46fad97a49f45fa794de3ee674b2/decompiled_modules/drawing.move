module 0x2025aaeea2560e19ea571814355e552f2d2a46fad97a49f45fa794de3ee674b2::drawing {
    struct DRAWING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAWING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAWING>(arg0, 6, b"DRAWING", b"THE DRAWING AI", x"574542203a2068747470733a2f2f6465762d656c6f7073747564696f2e636f6d2f74686564726177696e67200a5447203a2068747470733a2f2f742e6d652f74686564726177696e676169200a58203a2068747470733a2f2f782e636f6d2f74686564726177696e6761690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_En_JQ_En7t_Fwj_Fqe_Zxm_HN_Pwi_Jq_Ykp2td_WT_6_Db_Wys_Mwa_Zj_0d5d2fa0f5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAWING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAWING>>(v1);
    }

    // decompiled from Move bytecode v6
}

