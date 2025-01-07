module 0xddfacbcfdc0abe77504cc7b259f79a355f94020b8e1b4326b07514bd35428818::peep {
    struct PEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEP>(arg0, 6, b"PEEP", b"Peep", b"Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..Peep..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qv53o_WW_Vzt_MN_94ej_Br2me_Ybo_Cn_JEEKJ_Zokb_Qq3_QK_7_P_Em_fccb057fdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

