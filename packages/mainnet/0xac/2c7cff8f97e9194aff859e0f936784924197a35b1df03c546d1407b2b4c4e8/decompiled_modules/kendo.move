module 0xac2c7cff8f97e9194aff859e0f936784924197a35b1df03c546d1407b2b4c4e8::kendo {
    struct KENDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KENDO>(arg0, 6, b"KENDO", b"KendoAI by SuiAI", b"Kendo ai is an ai sales training and management tool used to improve the skill of sales reps and help sales managers do their jobs more efficiently", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2232_1ecdd01e80.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KENDO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENDO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

