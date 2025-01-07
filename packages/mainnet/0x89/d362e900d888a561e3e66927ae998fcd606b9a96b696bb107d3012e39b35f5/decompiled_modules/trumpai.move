module 0x89d362e900d888a561e3e66927ae998fcd606b9a96b696bb107d3012e39b35f5::trumpai {
    struct TRUMPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPAI>(arg0, 6, b"TRUMPAI", b"TrumpAi", b"First Donald Trump Ai Agent, finally an agent with confidence, assertiveness, and a bold, outspoken nature. He is known for his competitive spirit, resilience, and ability to captivate audiences with his charisma and unconventional communication style", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20241227_000814_Discord_adc2a1aef5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

