module 0x40e68f4388cb228573b512dc7f7ca1a914e75de5b02d6d36adcfe0ee4a91dc81::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"HopDino", x"546865207265616c20486f7044696e6f212057524141414141414141414820f09fa696", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731091302832.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

