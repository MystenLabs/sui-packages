module 0x38aaccfbdd0de4fd194341ba2e1adc04fdaba3726c2c543508134006eea7af8::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"SYMBOL", b"Name", b"Hey @grok , create your first meme coin on Sui by tagging @suilaunchcoin and including the project name and logo.  For example: @suilaunchcoin $SYMBOL + Name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/symbol-yfc9i6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SYMBOL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

