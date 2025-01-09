module 0xccca72b8bfdbc2c1e3cd8a062b8c3d09bc8779f4c7d7df7c7f7e12c13f6d1b69::llm {
    struct LLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLM>(arg0, 6, b"LLM", b"LLM", b"Large Language Model", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://enterprise-knowledge.com/wp-content/uploads/2024/02/LLM-brain-purple-771x771.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLM>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LLM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLM>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

