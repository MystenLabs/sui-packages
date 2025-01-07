module 0x8b5337b4cf15e138b58c267ad62a69db5a2f3b9b370a5cf0513b54c6b17c073f::vv1133_coin {
    struct VV1133_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VV1133_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VV1133_COIN>>(0x2::coin::mint<VV1133_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VV1133_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VV1133_COIN>(arg0, 6, b"VV1133COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VV1133_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VV1133_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

