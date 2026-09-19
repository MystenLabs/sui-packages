module 0x695491e43ccbd010a2f74b083a8c237e898ecc2fddbbed4c859c828f0aea554::fpt4 {
    struct FPT4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPT4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FPT4>(arg0, 6, 0x1::string::utf8(b"FPT4"), 0x1::string::utf8(b"FartPadT4"), 0x1::string::utf8(b"FPT4"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPT4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FPT4>>(0x2::coin_registry::finalize<FPT4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

