module 0xce15d93aa098a6db75f7bea198408fd5d39bd8515f2011809ac9da1957e15b1a::lyb {
    struct LYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYB>(arg0, 6, b"LYB", b"LAST YEAR BROKE", b"THIS ONE IS FOR THE CULTURE THIS IS OUR LAST YEAR BEING BROKE LET'S BRING THE NEW YEAR IN WITH STYLE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nmg5m_Lbvgwnyr_We_WP_Yx4y3_R_Nn_KDV_33y_Kr_Gnx_L_Rk_CC_25s_0ffdb0dfb9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYB>>(v1);
    }

    // decompiled from Move bytecode v6
}

