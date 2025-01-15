module 0xb89ae55a4c1ebecef24a8dc82365f74bd733a31b05dcb392c57413cff093e15c::sentriusai {
    struct SENTRIUSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENTRIUSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SENTRIUSAI>(arg0, 6, b"SENTRIUSAI", b"Sentrius AI by SuiAI", b"Trusted AI Security Solutions With SentriusAI With advanced AI-driven security and over 35 years of expertise in cybersecurity, SentriusAI is a trusted leader in safeguarding your digital world. Our intelligent agents provide customized.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2150_23d3fee9b3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SENTRIUSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENTRIUSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

