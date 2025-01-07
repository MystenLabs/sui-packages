module 0x584c83317c0005796702a0375fcaafe3552304fd50330da5441c69076299abce::froggy {
    struct FROGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGY>(arg0, 6, b"FROGGY", b"Froggy On Sui ", x"6a75737420612068616e64736f6d652066726f6720696e20612062696720706f6e6420f09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731484297137.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

