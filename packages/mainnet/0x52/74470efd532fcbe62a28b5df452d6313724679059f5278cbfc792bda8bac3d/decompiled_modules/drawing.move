module 0x5274470efd532fcbe62a28b5df452d6313724679059f5278cbfc792bda8bac3d::drawing {
    struct DRAWING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAWING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAWING>(arg0, 6, b"DRAWING", b"THE DRAWING ARTIFICIAL INTELLIGENCE", b"Try Our Artificial intelligence to Turn your sketch into refine image WEB : https://dev-elopstudio.com/thedrawing TG : https://t.me/thedrawingai X : https://x.com/thedrawingai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_P_En_JQ_En7t_Fwj_Fqe_Zxm_HN_Pwi_Jq_Ykp2td_WT_6_Db_Wys_Mwa_Zj_de517d3ade.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAWING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAWING>>(v1);
    }

    // decompiled from Move bytecode v6
}

