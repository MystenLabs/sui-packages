module 0xb282abe1cd66c84ad3061afa0677ed2b7a5b91eb3ed79e11695e42b3c15f5c3e::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"WAVE", b"W.A.V.E. by SuiAI", b"W.A.V.E. (Web-3 Autonomous Virtual Ecosystem) is an ecosystem powered by a swarm of AI agents known as, 'The Pod,' designed to dominate the attention economy, entertain users and provide innovative services. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/flo_74346f0275.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAVE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

