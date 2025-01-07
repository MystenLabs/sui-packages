module 0x1d5e8cb19e34e66969e7eb52ded651cf70fca653143c9290abd8451859a8ab00::konasui {
    struct KONASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONASUI>(arg0, 6, b"KONASUI", b"KONA", b"Kona, my goofy Shiba, comes to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735211528994.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

