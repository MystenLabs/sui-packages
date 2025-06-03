module 0x284eebb32ddb11fafd6c8d445a0e0caef51785a9cc63641d2ab3f2cebcb7f852::tshirt {
    struct TSHIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSHIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSHIRT>(arg0, 6, b"TSHIRT", b"Aui Tshirt", x"45766572792063686164206e6565647320542d73686972742e0a4a6f696e20746865206d6f76656d656e740a535549207374796c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihupg7sv4uq7skwq2yt64grn5vtxyvsdxhzxii6zhohi5akj263ty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSHIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSHIRT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

