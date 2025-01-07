module 0x7e6f47f54a1da484bb8994d510e2e07876c6a4c42a0d8ea37376993abd8f7fc8::nail {
    struct NAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAIL>(arg0, 6, b"NAIL", b"stevethesnail", b"Bringing you community, value and fairness. We are $nails on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956935073.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

