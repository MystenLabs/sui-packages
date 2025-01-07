module 0xbefe80a4907bacc3484fbe22f2b7515700825b33f300f2167e42d496757743ca::rockme {
    struct ROCKME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKME>(arg0, 6, b"ROCKME", b"rockme", b"Rock to the music,   ROCKME  ROCKME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rm_Pwi_Gnk8n_LJ_Qc_G5f_Vjw_RD_Vuzf_Zah_Q6zy9b_Gw_Koph_LUG_455126835c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKME>>(v1);
    }

    // decompiled from Move bytecode v6
}

