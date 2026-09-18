module 0xb7c6834213f7192b0a5798de93985f2472182a24aabebe781020626e74bc05a9::tfp {
    struct TFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TFP>(arg0, 6, 0x1::string::utf8(b"Tfp"), 0x1::string::utf8(b"TestFP"), 0x1::string::utf8(b"Gtg"), 0x1::string::utf8(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/magma.jpeg/public"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TFP>>(0x2::coin_registry::finalize<TFP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

