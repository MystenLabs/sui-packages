module 0xe600cb79cfbf2428516b9a0a9193ed98484ea2f2bc763faf8af699fe4adaa47a::voidai {
    struct VOIDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOIDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOIDAI>(arg0, 6, b"VOIDAI", b"VOID TERMINAL AI", b"Void Terminal AI is an AI powered terminal designed for simple interactions with TerminalChat and Terminal AI within the Binance Smart Chain Network. Void Terminal AI ensures private, secure, and reliable communication, making it ideal for Web3 Project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/twitter_dp_2_9ee71ff005.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOIDAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOIDAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

