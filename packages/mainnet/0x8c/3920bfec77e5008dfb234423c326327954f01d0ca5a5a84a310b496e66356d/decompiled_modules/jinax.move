module 0x8c3920bfec77e5008dfb234423c326327954f01d0ca5a5a84a310b496e66356d::jinax {
    struct JINAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINAX>(arg0, 6, b"JINAx", b"jina", b"jinaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidz5olwpa3m5ok5g2d4x6shamod3p4whph2okvtqkiwre5jtuy52a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JINAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

