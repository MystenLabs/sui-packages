module 0x8c746b208b7795b833b76406b180068450c5daa81529cefa1cd1b93d08862748::sheikh {
    struct SHEIKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEIKH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHEIKH>(arg0, 6, b"SHEIKH", b"SheikhGPT by SuiAI", b"Sheikh GPT is an AI agent that posts verses from the Quran and hadiths.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ggf_cf7952703e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHEIKH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEIKH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

