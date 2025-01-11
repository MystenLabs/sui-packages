module 0x406c4da770ca81dac767cae516cf76749f046ea2a4f50ee190fd555a77f8f790::empress {
    struct EMPRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMPRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMPRESS>(arg0, 6, b"Empress", b"Kolwaii", x"436865636b206f7572207820616e64206769746875620a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Tmk_By4do_Nxu_M_Dn9_Bkv62r6a2v5ga_J_Ni9_R_Rxkeo_Z_Jqzka_6bb1345435.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMPRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMPRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

