module 0x9f50b4a44e886b5670c95834418668756f42fe35b03c80ec223a3aaac79cb2e6::naldoo {
    struct NALDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NALDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALDOO>(arg0, 6, b"NALDOO", b"naldo", b"NALDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cristiano_ronaldo_ai_voice_598efa39ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALDOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NALDOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

