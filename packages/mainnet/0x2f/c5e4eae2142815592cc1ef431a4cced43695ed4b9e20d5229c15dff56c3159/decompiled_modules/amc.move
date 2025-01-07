module 0x2fc5e4eae2142815592cc1ef431a4cced43695ed4b9e20d5229c15dff56c3159::amc {
    struct AMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMC>(arg0, 8, b"AMC", b"Wrapped Coin for AMC Inc.", b"Sudo Wrapped Coin for AMC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMC>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AMC>>(v0);
    }

    // decompiled from Move bytecode v6
}

