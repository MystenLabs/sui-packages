module 0x35bcb27ddd7df71c510f49fe1e4b3a870b63643093442e910cb26f83460c05df::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"Pipi", b"pipi", x"50697070692046696e616e636520285049506c2920697320612063727970746f63757272656e637920616e646f70657261746573206f6e20746865204865636f20706c6174666f726d2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731082633344.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

