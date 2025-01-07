module 0xeceb9676ab145afa91156a3d0af716406306290e58db69d7727b1ff8eb49ef5c::sui_trading_bot_token_test {
    struct SUI_TRADING_BOT_TOKEN_TEST has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_TRADING_BOT_TOKEN_TEST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_TRADING_BOT_TOKEN_TEST>>(0x2::coin::mint<SUI_TRADING_BOT_TOKEN_TEST>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUI_TRADING_BOT_TOKEN_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TRADING_BOT_TOKEN_TEST>(arg0, 6, b"SUI_TRADING_BOT_TOKEN_TEST", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_TRADING_BOT_TOKEN_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TRADING_BOT_TOKEN_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

