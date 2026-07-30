module 0x1374c1542b2aca32cf84495e6c5971dd24b63e61519303cf44558a8b54df915a::tfcd4c992 {
    struct TFCD4C992 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TFCD4C992>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TFCD4C992>>(0x2::coin::mint<TFCD4C992>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TFCD4C992, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFCD4C992>(arg0, 9, b"LQB", x"e8b7afe6a1a5e5b881", x"e8b7afe6a1a5e5b881", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFCD4C992>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFCD4C992>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

