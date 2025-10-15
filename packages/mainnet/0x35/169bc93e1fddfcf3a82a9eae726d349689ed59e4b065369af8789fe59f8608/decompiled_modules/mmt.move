module 0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt {
    struct MMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MMT>(arg0, 9, 0x1::string::utf8(b"MMT"), 0x1::string::utf8(b"MMT"), 0x1::string::utf8(x"4d4d542069732074686520676f7665726e616e636520746f6b656e20666f72204d6f6d656e74756d2c20746865204d6f76652065636f73797374656de2809973206c697175696469747920656e67696e65207468617420656e61626c65732076654d4d5420686f6c6465727320746f2073746565722070726f746f636f6c20676f7665726e616e63652c206c697175696469747920616c6c6f636174696f6e2c20616e642063726f73732d636861696e2065636f73797374656d2067726f7774682e"), 0x1::string::utf8(b"https://momentum-statics.s3.us-west-1.amazonaws.com/MMT.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MMT>>(0x2::coin_registry::finalize<MMT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

