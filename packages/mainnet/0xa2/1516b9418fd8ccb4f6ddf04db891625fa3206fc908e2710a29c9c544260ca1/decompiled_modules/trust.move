module 0xa21516b9418fd8ccb4f6ddf04db891625fa3206fc908e2710a29c9c544260ca1::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUST>(arg0, 6, b"TRUST", b"Trust The Process", b"In a world that thrives on instant gratification, Project Trust is a reminder that true growth and success come from patience, resilience, and faith in the journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/plain_black_background_d9475b5bb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

