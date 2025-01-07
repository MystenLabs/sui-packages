module 0x61a034769d5af471607fad9970a920c4a7d6d9c4204789c49ecf3f09b34a0af5::suigpt {
    struct SUIGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGPT>(arg0, 6, b"SuiGPT", b"Sui GPT", b"Let Sui Gpt generate Sui Move smart contract code for you based on your instructions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736045225565.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

