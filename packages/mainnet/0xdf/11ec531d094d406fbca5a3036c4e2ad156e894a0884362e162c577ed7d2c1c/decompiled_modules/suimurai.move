module 0xdf11ec531d094d406fbca5a3036c4e2ad156e894a0884362e162c577ed7d2c1c::suimurai {
    struct SUIMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMURAI>(arg0, 6, b"SUIMURAI", b"SAMURAI ON SUI", b"First Samurai on $SUI!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731553720385.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMURAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMURAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

