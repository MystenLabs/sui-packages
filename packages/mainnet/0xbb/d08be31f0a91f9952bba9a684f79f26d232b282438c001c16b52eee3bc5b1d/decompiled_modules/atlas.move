module 0xbbd08be31f0a91f9952bba9a684f79f26d232b282438c001c16b52eee3bc5b1d::atlas {
    struct ATLAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATLAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATLAS>(arg0, 6, b"ATLAS", b"AtulaAiSui", b"Suinetwork will be mine, Atula declared, as he emerged from the darkness again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ma_t_nh_A_n_va_t_Ae_AE_a_c_ha_tha_ng_AI_ta_o_ra_Ae_a_ba_o_va_Sui_network_nh_AE_ng_do_ma_t_la_i_trong_thua_t_to_A_n_n_A_tra_n_A_n_Ae_a_c_A_c_v_A_mua_n_tha_ng_tra_to_A_n_ba_ha_tha_ng_5_a612d03fcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATLAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATLAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

