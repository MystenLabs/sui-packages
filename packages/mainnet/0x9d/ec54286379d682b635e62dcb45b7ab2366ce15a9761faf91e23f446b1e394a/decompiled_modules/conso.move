module 0x9dec54286379d682b635e62dcb45b7ab2366ce15a9761faf91e23f446b1e394a::conso {
    struct CONSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONSO>(arg0, 6, 0x1::string::utf8(b"CONSO"), 0x1::string::utf8(b"CONSO"), 0x1::string::utf8(b"Consumer Graph and Payments"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/PxPEW_hYfjITrlH__8S26PqOLX2a4xXi9TT1DVOYbR8BAQAHAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONSO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CONSO>>(0x2::coin_registry::finalize<CONSO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

