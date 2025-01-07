module 0x67810e50e3125afae155c88dafe2dbbadd1fed11be58da19073f6dc36f722272::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFY", b"GOOFYSUI", b"Gawrsh! Im Goofy, the clumsiest, goofiest dog! forever bring laughs & Joy to your doorsteps!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QW_Kz_Yg_Ravao_Mu_Zdp_A5_Kdobg_Ryrvs_SPT_3_Wak_YP_Qh_Yvmc_N_587d1d5f0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

