module 0x1c75a0efc4c2bbfe7b40f139f5e1fa957de5309244ba4bb99689e2e5a032e990::ronaldo {
    struct RONALDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONALDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONALDO>(arg0, 6, b"RONALDO", b"ROSUIALDO", b"Rosuialdo, the legendary meme hero of the crypto world, shouts his iconic \"SUUUUII!\" every time SUI soars to new heights. With his unstoppable energy and passion, Rosuialdo inspires the SUI community to aim for the moon and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731765571087.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RONALDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONALDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

