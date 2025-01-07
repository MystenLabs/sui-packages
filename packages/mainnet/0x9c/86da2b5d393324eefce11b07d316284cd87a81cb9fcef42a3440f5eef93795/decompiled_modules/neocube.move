module 0x9c86da2b5d393324eefce11b07d316284cd87a81cb9fcef42a3440f5eef93795::neocube {
    struct NEOCUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOCUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOCUBE>(arg0, 6, b"NEOCUBE", b"Neocube", b"NEOCUBE ....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb17ei6_Ty_Fz14_HS_Fgqj_X_Sf_Q6km_LN_4_Pxr_Kzvbtps_Eh_Qv_SX_87460a954d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOCUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEOCUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

