module 0xd16f4d83e73d6420e0a696c5426bf24154347148f5ccd58c1fa09b8686e05d81::nongsui {
    struct NONGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONGSUI>(arg0, 9, b"NONGSUI", b"Nongpoi", b"A beautifull girl that  is selling tickets to the moon in her innovative spaceship fueled by SUI Tokens. To get on the journey you have to fuel the rocket tanks. Buy Nongsui so she can fill her tanks with sui. Join us on this trip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4fb565a-9a05-4c9f-8b58-e7d34adbcba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

