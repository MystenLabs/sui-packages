module 0x9e409c6c3109f377c3eedb64daf83500e1abd889c63f45f914cb42d26da6685a::mai {
    struct MAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAI>(arg0, 6, b"MAI", b"MAI? by SuiAI", b"Best dating AI agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_06_at_13_45_49_2496fce77a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

