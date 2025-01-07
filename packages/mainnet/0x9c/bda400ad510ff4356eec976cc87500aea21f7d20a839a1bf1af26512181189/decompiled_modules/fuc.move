module 0x9cbda400ad510ff4356eec976cc87500aea21f7d20a839a1bf1af26512181189::fuc {
    struct FUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUC>(arg0, 6, b"FUC", b"Frog Under Cat", b"o que  um bla bla flying to the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zx_Z_Vk9_Cyg5k_U_Jfp_E_Yt_R4_ZJ_9bc_T4_MX_Aoi_GW_So_LHG_Rff_J7_7c3d9bacde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

