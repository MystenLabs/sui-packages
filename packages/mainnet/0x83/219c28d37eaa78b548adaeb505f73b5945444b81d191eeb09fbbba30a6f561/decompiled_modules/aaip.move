module 0x83219c28d37eaa78b548adaeb505f73b5945444b81d191eeb09fbbba30a6f561::aaip {
    struct AAIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAIP>(arg0, 6, b"AAIP", b"AAIP by SuiAI", b"Developed under the AAIP, Protect is designed to ensure the safety, reliability, and ethical use of autonomous systems, particularly in high-stakes environments like healthcare, transportation, and cybersecurity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AIPRO_0e36cb4050.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAIP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAIP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

