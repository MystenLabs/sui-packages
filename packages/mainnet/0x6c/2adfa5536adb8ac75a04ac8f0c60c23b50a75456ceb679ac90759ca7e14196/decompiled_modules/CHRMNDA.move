module 0x6c2adfa5536adb8ac75a04ac8f0c60c23b50a75456ceb679ac90759ca7e14196::CHRMNDA {
    struct CHRMNDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRMNDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHRMNDA>(arg0, 9, 0x1::string::utf8(b"CHRMNDA"), 0x1::string::utf8(b"Charmandah"), 0x1::string::utf8(b"A burn-only token named Charmandah with symbol CHRMNDA."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHRMNDA>>(0x2::coin_registry::finalize<CHRMNDA>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHRMNDA>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRMNDA>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRMNDA>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

