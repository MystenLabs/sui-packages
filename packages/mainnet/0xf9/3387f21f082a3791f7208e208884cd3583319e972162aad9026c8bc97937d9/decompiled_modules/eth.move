module 0xf93387f21f082a3791f7208e208884cd3583319e972162aad9026c8bc97937d9::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 6, b"ETH", b"Enjoying The Heat", b"Embrace the heat while cooking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qm_C_Vqoz_L_Jx_A_Sy_T3d8_EG_1_F_Nys_Aa_Acgug_Wc99o_KU_Md_J_Qma_a4a203c371.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

