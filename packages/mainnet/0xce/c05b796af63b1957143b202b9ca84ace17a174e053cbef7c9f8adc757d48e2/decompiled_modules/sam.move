module 0xcec05b796af63b1957143b202b9ca84ace17a174e053cbef7c9f8adc757d48e2::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 6, b"SAM", b"Samtoshi", b"Your friendly Ai agent on all things Move Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736483001501.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

