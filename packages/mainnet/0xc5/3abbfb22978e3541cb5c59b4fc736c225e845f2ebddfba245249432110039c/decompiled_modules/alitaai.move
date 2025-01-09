module 0xc53abbfb22978e3541cb5c59b4fc736c225e845f2ebddfba245249432110039c::alitaai {
    struct ALITAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALITAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALITAAI>(arg0, 6, b"ALITAAI", b"Agent Angel Alita AI by SuiAI", b".Alita is a former cyborg, and now a pretty young girl agent with big eyes, who is able to feel, empathize and, of course, fall in love..Wants to make everyone fall in love with her and the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/orig_42e77052da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALITAAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALITAAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

