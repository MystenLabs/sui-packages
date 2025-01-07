module 0x8df1a6915af384f6936c99d43d94bab738a789782e5b44c33f3a7a99017c9281::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 6, b"SEA", b"SUI Sea Color", x"4f6666696369616c205355492053656120636f6c6f722e0a0a4845583a20233444413246460a5247423a2037372f3136322f3235350a434d594b3a2036312f33302f3030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731549691965.15")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

