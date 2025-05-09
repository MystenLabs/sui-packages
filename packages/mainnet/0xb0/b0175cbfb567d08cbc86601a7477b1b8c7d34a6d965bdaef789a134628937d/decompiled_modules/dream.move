module 0xb0b0175cbfb567d08cbc86601a7477b1b8c7d34a6d965bdaef789a134628937d::dream {
    struct DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREAM>(arg0, 9, b"DREAM", b"$17 and a dream", b"Dream shilled by chatgpt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DSup1rQWvLi8ZXj82qpz4hXeA8HuwtNFeS7qrejYpump.png?size=xl&key=1df6bb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DREAM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

