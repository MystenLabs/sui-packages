module 0xa08f96ff2fbe01c8e1cc131c7e4c27dea2368292bfcf0bb810cac819e0837bcf::coinfacet {
    struct COINFACET has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<COINFACET>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<COINFACET>>(0x2::coin::mint<COINFACET>(arg0, 10000000, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: COINFACET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINFACET>(arg0, 6, b"COINFACET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINFACET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<COINFACET>>(v0);
    }

    // decompiled from Move bytecode v6
}

