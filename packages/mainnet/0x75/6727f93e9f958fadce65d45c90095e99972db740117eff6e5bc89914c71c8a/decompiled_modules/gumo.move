module 0x756727f93e9f958fadce65d45c90095e99972db740117eff6e5bc89914c71c8a::gumo {
    struct GUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GUMO>(arg0, 6, b"GUMO", b"G.U.M.O by SuiAI", b"AI-driven game where players teach G.U.M.O to strategize and win. Learn how this AI evolves through your inputs and gameplay, offering unmatched innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sui_2_b704a0cfa9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GUMO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

