module 0x946b8352053e5771682dd5deaeab24dad2a813f341d9da09dc1797428f245d24::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERO>(arg0, 6, b"HERO", b"Ahmed Al Ahmed", b"An Aussie hero named Ahmed disarmed a Bondi shooter, risking his own life to save his fellow citizens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1765794688172.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HERO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

