module 0x6a7d073cce8addb71ab727d568e5e1962bedd4241814cc8632f0a218965d43ba::jeloop {
    struct JELOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELOOP>(arg0, 6, b"jeLOOP", b"JewelSwap Ember Loop", b"Share of the JewelSwap eEARN/USDC loop vault on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

