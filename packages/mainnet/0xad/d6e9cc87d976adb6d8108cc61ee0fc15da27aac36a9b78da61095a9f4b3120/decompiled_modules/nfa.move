module 0xadd6e9cc87d976adb6d8108cc61ee0fc15da27aac36a9b78da61095a9f4b3120::nfa {
    struct NFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NFA>(arg0, 6, b"NFA", b"Not Financial Advice by SuiAI", b"Buy at your own risk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3075_f932eb0a9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NFA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

