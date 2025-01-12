module 0x36a20d81c0575b8c7ceef687d8073ee2e1a1f97f161d593289f50d63910b2cb5::tarot {
    struct TAROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAROT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TAROT>(arg0, 6, b"TAROT", b"Tarot AI by SuiAI", b"Know your future with the help of the Tarot AI Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tarot_533714ed29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TAROT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAROT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

