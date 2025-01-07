module 0xa70deb538f06790a31f25e537b0f0d474582ba6b58e039fd0bfcf5b6ce4e1db5::example_coin {
    struct EXAMPLE_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXAMPLE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<EXAMPLE_COIN>(arg0, 9, b"EXAMP2", b"Example continue", b"Random desc", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXAMPLE_COIN>>(v2);
        0x2::coin::mint_and_transfer<EXAMPLE_COIN>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EXAMPLE_COIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXAMPLE_COIN>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

