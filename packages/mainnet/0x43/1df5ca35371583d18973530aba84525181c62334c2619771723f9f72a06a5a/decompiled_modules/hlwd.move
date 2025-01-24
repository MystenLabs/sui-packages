module 0x431df5ca35371583d18973530aba84525181c62334c2619771723f9f72a06a5a::hlwd {
    struct HLWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HLWD>(arg0, 6, b"HLWD", b"HELLO WORLD by SuiAI", b"HELLO WORLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/stocksbg_967df24d9b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HLWD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLWD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

