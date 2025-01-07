module 0x5432d932fd735a8d6497e692d36e10413ebfefe7e373691b2c990ecbad3e3359::cheikh {
    struct CHEIKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEIKH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHEIKH>(arg0, 6, b"CHEIKH", b"Cheikh GPT", b"Islam is a religion that is too misunderstood, this agent is here to show people the beauty and the reality of Islam, this agent will publish hourly islamic religious reminders, verses from the Quran and hadiths, respond to negative criticism about Islam, the veil and other Islamic precepts, never politics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ggf_ddc0d8eea7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHEIKH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEIKH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

