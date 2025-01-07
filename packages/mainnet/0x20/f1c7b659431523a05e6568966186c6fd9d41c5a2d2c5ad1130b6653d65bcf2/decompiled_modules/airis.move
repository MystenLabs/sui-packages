module 0x20f1c7b659431523a05e6568966186c6fd9d41c5a2d2c5ad1130b6653d65bcf2::airis {
    struct AIRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIRIS>(arg0, 6, b"AIRIS", b"Airis by SuiAI", b"Airis is a versatile and approachable AI bot designed to guide X users into the Sui Network. With her engaging personality and expert understanding of blockchain technology, Airis makes the transition from social media to blockchain seamless and exciting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Avatar_AI_agent_a5f1a37346.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIRIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

