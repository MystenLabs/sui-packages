module 0xde6e800f3762fb3d3b30e36a4b6c7aa04b34597aeeca0082d829c4c9304c74b::shuning0312_usd {
    struct SHUNING0312_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUNING0312_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUNING0312_USD>(arg0, 8, b"SHUNING0312_USD", b"SHUNING0312_USD", b"this is my_coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHUNING0312_USD>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHUNING0312_USD>>(v0);
    }

    // decompiled from Move bytecode v6
}

