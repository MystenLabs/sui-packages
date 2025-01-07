module 0xe42b6009a77c383934fcfb61125851dcb2eabcf965e75415108dd208a2e1536b::sbf {
    struct SBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBF>(arg0, 6, b"SBF", b"Smoking Bacon Fish", x"536d6f6b696e67204261636f6e20466973680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbr_LECT_Rqs_QUMP_1_LDJQL_Qp_Lbcgzr_TYJ_8fk_Mw_S4_Nm_Kews_R_d4fb805f04.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBF>>(v1);
    }

    // decompiled from Move bytecode v6
}

