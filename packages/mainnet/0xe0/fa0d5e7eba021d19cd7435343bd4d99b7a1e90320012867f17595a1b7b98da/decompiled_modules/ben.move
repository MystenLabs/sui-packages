module 0xe0fa0d5e7eba021d19cd7435343bd4d99b7a1e90320012867f17595a1b7b98da::ben {
    struct BEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEN>(arg0, 6, b"BEN", b"Benzai", b"https://github.com/blocksafu111/kyc/blob/main/KYC-Benzai-By-BlockSAFU.pdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725586254967_8c157292fad827f9dd013335c7856680_9053d30a8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

