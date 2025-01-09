module 0x536ff9cfacf1a1d1708bad689169f5fa4d098d55429c34807284ca63cbe443f1::airish {
    struct AIRISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIRISH>(arg0, 6, b"AIRISH", b"AGENT IRISH by SuiAI", b"'AI Irish' is a culturally inspired AI project that celebrates the rich heritage and traditions of Ireland through the lens of modern technology. This AI-driven platform offers a variety of features, from learning Irish (Gaeilge) and exploring Celtic mythology to discovering Irish music, poetry, and history. AI Irish also provides a virtual guide for Irish culture, perfect for travelers, educators, and enthusiasts alike", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000003441_c288af7869.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIRISH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRISH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

