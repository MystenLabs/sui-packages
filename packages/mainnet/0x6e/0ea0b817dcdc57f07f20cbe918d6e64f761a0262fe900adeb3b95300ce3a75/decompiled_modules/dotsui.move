module 0x6e0ea0b817dcdc57f07f20cbe918d6e64f761a0262fe900adeb3b95300ce3a75::dotsui {
    struct DOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTSUI>(arg0, 6, b"DOTSUI", b"DotSui", b"Easiest Domain Service for SUI addresses More information will be released during January 2025. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735985965581.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOTSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

