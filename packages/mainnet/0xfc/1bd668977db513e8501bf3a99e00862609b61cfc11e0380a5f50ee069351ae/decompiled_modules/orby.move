module 0xfc1bd668977db513e8501bf3a99e00862609b61cfc11e0380a5f50ee069351ae::orby {
    struct ORBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBY>(arg0, 6, b"Orby", b"Norby", b"For the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956995421.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

