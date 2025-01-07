module 0x1a12a18ca3f9a30dffe8ad963b314cfa13dd2bc92a042e4e5d0b3e6878e6b8dc::pino {
    struct PINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINO>(arg0, 6, b"PINO", b"PINO SUI", b"$PINO is a wild character inspired from Matt Furie's Boy's Club comic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WW_9lel_HK_400x400_b0b61e606c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

