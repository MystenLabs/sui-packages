module 0xc97416dcc6b5566b6364c6f05f0ec4b5a7f03cb01542332e2ba5956c690111ba::janti {
    struct JANTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JANTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JANTI>(arg0, 6, b"Janti", x"4a414e54c4b02078", b"Are you ready to become a millionaire?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733010073381.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JANTI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JANTI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

