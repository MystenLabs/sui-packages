module 0x10669a4164ef3a8ea984e5290c287cdf30abcdbce6a0ffff3c1f5de9be3c637c::aica {
    struct AICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICA>(arg0, 6, b"AICA", b"AICA  by SuiAI", b"Highly autonomous, intelligent cyber-defense agent designed for active defense, response, and resilience strategies. Specializes in real-time threat detection, mitigation, and recovery in complex network environments. .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AICA_e54cdf958f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

