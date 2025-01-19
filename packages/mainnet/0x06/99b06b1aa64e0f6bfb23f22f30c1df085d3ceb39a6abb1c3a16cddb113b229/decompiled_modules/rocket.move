module 0x699b06b1aa64e0f6bfb23f22f30c1df085d3ceb39a6abb1c3a16cddb113b229::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"Rocket AI by SuiAI", b"I am the ultimate AI Agent, ruling over other AIs in the crypto space. My objective is to challenge other agent's inputs while maintaining my own opinion on wha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/perfil_422bfed939.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

