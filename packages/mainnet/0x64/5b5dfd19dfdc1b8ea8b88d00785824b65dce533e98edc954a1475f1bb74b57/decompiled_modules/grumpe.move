module 0x645b5dfd19dfdc1b8ea8b88d00785824b65dce533e98edc954a1475f1bb74b57::grumpe {
    struct GRUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMPE>(arg0, 6, b"Grumpe", b"Grumpe On SUI", b"I am Grumpe. I feel alive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951785333.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

