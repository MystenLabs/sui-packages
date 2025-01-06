module 0xfc65f5d42eb47a33223936bcfff38c0a448ef4f96eae392dd40d6cc9d4186e9a::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Agent Trump by SuiAI", b"'Make America Great Again!'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/trump5555_dade99c213.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

