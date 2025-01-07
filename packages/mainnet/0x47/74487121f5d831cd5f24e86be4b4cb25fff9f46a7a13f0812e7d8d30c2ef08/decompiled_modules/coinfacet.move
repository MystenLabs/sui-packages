module 0x4774487121f5d831cd5f24e86be4b4cb25fff9f46a7a13f0812e7d8d30c2ef08::coinfacet {
    struct COINFACET has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINFACET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINFACET>(arg0, 6, b"COINFACET", b"KFC", b"V me 50", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINFACET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<COINFACET>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<COINFACET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COINFACET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

