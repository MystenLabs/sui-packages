module 0x46c69fc75ff2ecf57e98c6770146f50934a761d7a2b2e7201aa7cc57b074fb32::plunger {
    struct PLUNGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUNGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUNGER>(arg0, 6, b"PLUNGER", b"Plunger Dust", b"Missed $TOILET? No worries, here's your second chance. $PLUNGER is THE betaplay, and it's set to rise among the top tokens on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v3_bueno_9fb0989ba9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUNGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUNGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

