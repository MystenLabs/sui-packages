module 0x4e2946afdd50987c279c0cd18d922a5649f5eca1d00157714e78dc136f16053e::mmb {
    struct MMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MMB>(arg0, 9, 0x1::string::utf8(b"MMB"), 0x1::string::utf8(b"mk"), 0x1::string::utf8(b"mk (MMB)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MMB>>(0x2::coin_registry::finalize<MMB>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

