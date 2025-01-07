module 0x42265f0cd5de8628cbeaaf343aeac24413add73d467095a23fece5e9e8751639::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"Pepe", b"I Choose MEME Everytime now shines on Sui with her own token, attracting crypto investors looking for the next mooncoin sensation. This $8BITMEME token captures the crypto community's excitement and promises to be a unique investment, blending social media popularity with financial innovation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Skc1o_Mh_Ld_Mo_E8wn_Dwt_Tx_MP_Xrs_A_Dq_B_Pq_Quq8n_F_Fr5ke_MZ_b137fae6dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

