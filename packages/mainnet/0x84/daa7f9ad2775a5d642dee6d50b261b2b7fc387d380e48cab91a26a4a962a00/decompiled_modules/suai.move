module 0x84daa7f9ad2775a5d642dee6d50b261b2b7fc387d380e48cab91a26a4a962a00::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SUAI", b"Sui AI empowers AI agents to operate autonomously, processing inputs and generating responses while learning from past interactions. It enhances decision-making by leveraging long-term memory, including experiences, reflections, and dynamic personality trai...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo_e5849aad55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

