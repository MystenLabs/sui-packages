module 0x66620723cfcc1c290015961272aa53a62b430f122a653eed9f7fa37759f10052::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x66620723cfcc1c290015961272aa53a62b430f122a653eed9f7fa37759f10052::connector_v3::new<CAT>(arg0, 1000, b"s_sui", b"n_sui", b"d_sui", b"u_sui", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

