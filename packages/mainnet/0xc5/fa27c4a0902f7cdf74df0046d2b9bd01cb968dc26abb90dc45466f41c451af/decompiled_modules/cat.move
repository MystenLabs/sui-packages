module 0xc5fa27c4a0902f7cdf74df0046d2b9bd01cb968dc26abb90dc45466f41c451af::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0xc5fa27c4a0902f7cdf74df0046d2b9bd01cb968dc26abb90dc45466f41c451af::connector_v3::new<CAT>(arg0, 1000, b"s_sui", b"n_sui", b"d_sui", b"u_sui", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

