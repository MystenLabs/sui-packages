module 0x63e4f38d331cce6e78a68f9ec0af03f1c7b43271a2d0e500109cddf16258b31::cwh {
    struct CWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CWH>(arg0, 6, b"CWH", b"CAT WIF HAT by SuiAI", x"63617420776966206861743f3f3ff09fa4a3f09fa4a3f09fa4a3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3019_ec21a9466d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CWH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

