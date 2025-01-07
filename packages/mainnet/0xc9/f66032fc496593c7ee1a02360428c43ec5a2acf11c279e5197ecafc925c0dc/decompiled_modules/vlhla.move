module 0xc9f66032fc496593c7ee1a02360428c43ec5a2acf11c279e5197ecafc925c0dc::vlhla {
    struct VLHLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLHLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLHLA>(arg0, 6, b"VLHLA", b"Valhalla", b"Valhalla Awaits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Y7_VTL_4_R_As_Uf_Cetp1_K_Fhf_V_Mxp_Bwc_Wes_WPN_Zpo_Rg_Zf6a_P_28fd5937a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLHLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VLHLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

