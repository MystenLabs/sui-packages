module 0x7947b9c76de4669ef204d01d1566b99a7d62153a7e8c5d4393e665758212eeb1::adeniyi {
    struct ADENIYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYI>(arg0, 6, b"ADENIYI", b"The SUI Bull", b"He alone will revive the SUI trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1783410287393.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADENIYI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

