module 0x7324f880214b1eaf9213e85ef52cc976bbc803e83e170f1e1160253250338183::drops {
    struct DROPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPS>(arg0, 6, b"DROPS", b"DROPSUI", b"Trade illiquidity with $DROPS - The only locked liquidity marketplace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xa562912e1328eea987e04c2650efb5703757850c_fe5d48518c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

