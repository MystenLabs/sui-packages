module 0x4963576963559e0d869762bb737e87847ffab9fa538fa54a873c0d9a0b1ffd8a::sti {
    struct STI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STI>(arg0, 9, b"STI", b"Sui Trenches Index", b"The buyable Sui trenches basket: STI only enters circulation through on-chain liquidity paired with sub-$100k index constituents. Every rebalance is a public transaction.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

