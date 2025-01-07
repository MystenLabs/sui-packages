module 0xb210ab8b094dd29bb5f27cf2ed29d5c529e14c85e4e508abc644b716317991d1::bsc {
    struct BSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSC>(arg0, 6, b"BSC", b"breakdancingsimscat", b"breakdancing sims cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zy_Zeosd8_H1_Vn_Gj_BD_7_Fb_LM_Xg8_Tw_Pg3_LX_Eb_DP_Nz_W_Scsu_Bc_5b7f51f81b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

