module 0xf70ad9bcb59be7d460edeab69ae99c3285034cb4d484893ec48448215668c3c4::lop {
    struct LOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LOP>(arg0, 6, 0x1::string::utf8(b"LOP"), 0x1::string::utf8(b"loplop"), 0x1::string::utf8(b"loplop"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/TKzhDnwK6rVsRm5rQgp8BTCLvo2kD4RwuqGI0dKuUIsBAQANAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LOP>>(0x2::coin_registry::finalize<LOP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

