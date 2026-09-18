module 0x7fe6ee55ca9966fac620b8b24754ec2d3de1c36b60e56e3fcbc79b56812c7042::scfpt {
    struct SCFPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCFPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SCFPT>(arg0, 6, 0x1::string::utf8(b"SCFPT"), 0x1::string::utf8(b"SuiCatFartPadTest"), 0x1::string::utf8(b"Testing fartpad"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCFPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SCFPT>>(0x2::coin_registry::finalize<SCFPT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

