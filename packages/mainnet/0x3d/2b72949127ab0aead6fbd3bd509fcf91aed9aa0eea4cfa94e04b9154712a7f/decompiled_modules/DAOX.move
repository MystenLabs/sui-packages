module 0x3d2b72949127ab0aead6fbd3bd509fcf91aed9aa0eea4cfa94e04b9154712a7f::DAOX {
    struct DAOX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DAOX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DAOX>>(0x2::coin::mint<DAOX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DAOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAOX>(arg0, 6, b"DAOX", b"DAOX", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

