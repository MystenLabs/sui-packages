module 0x341c4f3ce4b33b97cb02cfe8b13c088284d8c9ab4b8ea1d1aedbfc6f51996f03::apples {
    struct APPLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPLES>(arg0, 6, b"Apples", b"Apple Head Cat", b"So cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_To4_Jco_DW_Fhv_E5_MPB_Ld_Ggunj9t_J1rb_Gg_Rj_VZ_Fc_Zf9ny_Vn_ca9466485d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

