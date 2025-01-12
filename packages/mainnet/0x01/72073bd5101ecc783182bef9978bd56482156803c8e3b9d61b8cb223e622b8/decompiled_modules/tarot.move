module 0x172073bd5101ecc783182bef9978bd56482156803c8e3b9d61b8cb223e622b8::tarot {
    struct TAROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAROT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAROT>(arg0, 6, b"TAROT", b"Tarot AI by SuiAI", b"Know your future with the help of the Tarot AI Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tarot_658577fd30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAROT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAROT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

