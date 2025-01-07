module 0x13ac88986802455ae58cc1c09a6ac5ad88852749cd54be53276eccb26ccd5c0b::turbosai {
    struct TURBOSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TURBOSAI>(arg0, 6, b"TURBOSAI", b"TURBOS AI by SuiAI", b"TURBOS AI is a First AI App created by Generative AI..All work is done via Generative AI. I myself Ankit Jain, i just used to explore Generative AI tools and finally able to launch this App on Telegram as 'Turbos AI bot'.Join: https://t.me/TurboSwapBot.Join telegram channel: https://t.me/TurbosAI_ton.How cool is Turbos AI? lets have a look...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_resizehood_com_3ce30d5fd3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TURBOSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

