module 0x4c1ba57ace25e4d06646b489db6773717ad58317a6572abdb4c1f22a639b52a5::gw {
    struct GW has drop {
        dummy_field: bool,
    }

    fun init(arg0: GW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GW>(arg0, 6, b"GW", b"Generational Wealth", b"Your net worth will multiply 100x through meme coins. Make That 1000x if you have diamond hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_ET_Us_DL_Sc_Ed_Tq_V_Tfd_A6_V_Eq_Xiv_Adj6_Kg3c_X_Rc_Dh_EMZDGA_49f13379e6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GW>>(v1);
    }

    // decompiled from Move bytecode v6
}

