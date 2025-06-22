module 0xe9f13fccbe76264deb5647b21ea6de131692d71db850ca865b6da082697cd12d::ALEX {
    struct ALEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEX, arg1: &mut 0x2::tx_context::TxContext) {
        0x80720f8aa621edc4fb6fbc72069352d6d539bb8e74d36f43e85c5a3dfea2748d::connector_v3::new<ALEX>(arg0, 1000, b"s_sui", b"ALEX", x"414c45582062792073756966756e20f09f9887", b"u_sui", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

