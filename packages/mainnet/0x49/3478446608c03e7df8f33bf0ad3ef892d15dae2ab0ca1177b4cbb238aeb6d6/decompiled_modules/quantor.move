module 0x493478446608c03e7df8f33bf0ad3ef892d15dae2ab0ca1177b4cbb238aeb6d6::quantor {
    struct QUANTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<QUANTOR>(arg0, 6, b"QUANTOR", b"The Quantor AI by SuiAI", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Artificial_Intelligence_Robot_Thinking_Brain_b0a6359b56.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUANTOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

