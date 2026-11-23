module 0x219ec53074b7a8e16d5e4d4faa407ba720a0207271bfe00f790923b633ef26f2::mop {
    struct MOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOP>(arg0, 6, 0x1::string::utf8(b"MOP"), 0x1::string::utf8(b"MOP"), 0x1::string::utf8(x"536f6d65626f6479e280997320676f74746120636c65616e206974207570"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/b84qZzlBDaA058lhLtnYxMK97I-ATiIH2o7iYgTSpn4BAQCzAQ"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MOP>>(0x2::coin_registry::finalize<MOP>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

