module 0xf17a968978814bb811165ccbaf79172f90b0d924c88713192e1c1fde220d9a45::orcie {
    struct ORCIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCIE>(arg0, 6, b"ORCIE", b"Hungry ORCIE", b"Hungry orcie is hungry for gold. Searching everywhere to find a way to the top !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730988845440.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

