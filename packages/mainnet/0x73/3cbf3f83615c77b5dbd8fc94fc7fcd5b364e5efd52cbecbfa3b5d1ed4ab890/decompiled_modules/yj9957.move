module 0x733cbf3f83615c77b5dbd8fc94fc7fcd5b364e5efd52cbecbfa3b5d1ed4ab890::yj9957 {
    struct YJ9957 has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJ9957, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJ9957>(arg0, 9, b"YJ9957", b"YJ9957", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJ9957>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJ9957>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<YJ9957>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YJ9957>>(0x2::coin::mint<YJ9957>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

