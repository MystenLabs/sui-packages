module 0xc73c0d065bf03b4d79cd6551c18be6653e0de141735e636aa800c69e85a289e6::sola {
    struct SOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLA>(arg0, 6, b"SOLA", b"SOLA SUI", b"Our digital pals from the future have arrived on the SUI blockchain, bringing advanced tech, special powers, and a mischievous sense of humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3j_A_Tv_M_Mp_Tm_Mj_V_Cg2i_AEY_6_Mg2_Cu_TJ_Meb_Rpc_Uoov_J_Zpump_57c6a2183e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

