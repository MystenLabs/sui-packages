module 0x3300a4be74aa75f5df8b47a51f865091ea3a02ac2568989eb076481a6c2c70c3::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 6, b"BOOP", b"Boop Coin", b"Just a little *BOOP* on the nose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731584507357.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

