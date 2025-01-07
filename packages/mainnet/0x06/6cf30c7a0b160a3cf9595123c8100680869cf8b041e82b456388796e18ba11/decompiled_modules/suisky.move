module 0x66cf30c7a0b160a3cf9595123c8100680869cf8b041e82b456388796e18ba11::suisky {
    struct SUISKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISKY>(arg0, 6, b"SUISKY", b"Suisky", b"Suisky is a meme token inspired by the energetic and resilient husky dog. Short for Sui Husky, it operates on the Sui network, aiming to bring fun and community spirit to the crypto world. Combining meme culture with the power of community, Suisky represents loyalty, strength, and a shared adventure for husky and crypto enthusiasts alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Np_XB_Qr_Tz6_MBYP_Ttk_LG_7_N3y_Gu4_Hj_Ebv_TP_Yie_NPDT_Uw_Ph_V_b29907bcb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

