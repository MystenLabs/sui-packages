module 0xedd3ee2506cc27468a7e97b265f69ba407bb2dd8291b177d8559ae5d4434a701::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Andy Da Alien", b"jus da alien..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732219458549.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

