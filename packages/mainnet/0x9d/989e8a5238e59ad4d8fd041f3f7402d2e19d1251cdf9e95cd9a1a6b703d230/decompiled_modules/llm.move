module 0x9d989e8a5238e59ad4d8fd041f3f7402d2e19d1251cdf9e95cd9a1a6b703d230::llm {
    struct LLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLM>(arg0, 6, b"LLM", b"Large Language Model", b"AI led mukbang club / let her eat movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736735647459.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

